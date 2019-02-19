module Ewallet
  class App < Sinatra::Base
    helpers Sinatra::Param
    helpers Sinatra::Ewallet::ApplicationHelpers

    PUBLIC_KEY_PATH  = File.read(ENV.fetch('PUBLIC_KEY_PATH'))
    PRIVATE_KEY_PATH = File.read(ENV.fetch('PRIVATE_KEY_PATH'))

    set :public_key, OpenSSL::PKey.read(PUBLIC_KEY_PATH)
    set :private_key, OpenSSL::PKey.read(PRIVATE_KEY_PATH)
    set :show_exceptions, false
    set :raise_errors, true
    set :dump_errors, false

    before do
      content_type :json
    end

    error Sequel::NoMatchingRow do
      status 404
      json({ success: false, message: 'Resource not found.' })
    end

    error Sequel::ValidationFailed do |validation|
      status 400
      json({ success: false, message: 'Validation has failed.' })
    end

    error NotEnoughtBalanceError do |exception|
      status 403
      json({ success: false, message: exception.message })
    end

    get '/accounts' do
      json current_user.accounts
    end

    post '/accounts' do
      param :account, Hash, required: true

      if @account = current_user.add_account(params[:account])
        json @account
      else
        response = { success: false, message: "Wasnt't possible to create the account at this moment." }.to_json
        halt 400, { 'Content-Type' => 'application/json' }, response
      end
    end
  
    get '/accounts/:id' do
      @account = current_user.accounts_dataset.first!(id: params[:id])

      json @account.values.merge({ balance: '%.2f' % @account.balance.to_f })
    end

    put '/accounts/:id' do
      @account = current_user.accounts_dataset.first(id: params[:id])
      @account.update(params[:account])

      json @account
    end

    post '/accounts/:id/deposit' do
      param :deposit, Hash, required: true

      @account = current_user.accounts_dataset.first(id: params[:id])

      if @deposit = @account.deposit(params[:deposit][:amount])
        json @deposit
      else
        response = { success: false, message: "Wasnt't possible complete the deposit at this moment." }.to_json
        halt 400, { 'Content-Type' => 'application/json' }, response
      end
    end

    post '/accounts/:id/withdraw' do
      param :withdrawal, Hash, required: true

      @account = current_user.accounts_dataset.first(id: params[:id])
      @withdraw = @account.withdraw(params[:withdrawal][:amount])

      json @withdraw
    end

    post '/accounts/:id/transfer/:destination_id' do
      param :transference, Hash, required: true

      @transferor = current_user.accounts_dataset.first(id: params[:id])
      @transferee = Account.first(id: params[:destination_id])

      DB.transaction do
        @transferor.withdraw(params[:transference][:amount])
        @transferee.deposit(params[:transference][:amount])
      end

      message = "The transference of %.2f from account %d to account %d was successfully finished."
      json({ success: true, message: message % [params[:transference][:amount], @transferor.id, @transferee.id] })
    end

    post '/users' do
      param :user, Hash, required: true

      if @user = User.create(params[:user])
        json @user
      else
        halt 400
      end
    end

    post '/users/sign_in' do
      @user = User.first(Sequel.lit("username = :username OR email = :username", username: params[:username]))

      if @user && @user.authenticate(params[:password])
        token = issue_token(settings.private_key, { id: @user.id })
        json({ token: token })
      else
        halt 401, { 'Content-Type' => 'text/plain' }, { success: false, message: 'Access denied!' }.to_json
      end
    end
  end
end