get '/' do
  # render home page
  @users = User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do

  user = User.find_by_email(params[:email])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    erb :index
  else
    @error = "Please try again"
    erb :sign_in
  end

end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  session.clear
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up a new user
  p '-----'
  p params
  p '-----'
  p params[:user][":name"]
  @user = User.create(params[:user])
  if @user
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :sign_up
  end
end
