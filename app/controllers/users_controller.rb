class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:index, :show, :edit, :update]}
  before_action :login_user,{only: [:new, :create, :login_form, :login]}
  before_action :correct_user, {only: [:edit, :update]}
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email], password: params[:password], image_name: "default_user.jpg")
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}", notice: "ユーザー登録が完了しました"
    else
      render "users/new" 
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      redirect_to "/users/#{@user.id}", notice: "ユーザー情報を編集しました"
    else
      render "users/edit"
    end
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
      session[:user_id] = @user.id
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  def correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
end
