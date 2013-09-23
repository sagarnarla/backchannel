class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.user_type = "user"
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def homepage

  end

  def login
    username = params[:username]
    password = params[:password]
    @user = User.where("username='#{username}' and password='#{password}'")


    if @user[0]
      session[:user_id] = @user[0].id
      session[:user] = @user[0]
      if @user[0].user_type == "admin"
        redirect_to users_url
      else
        redirect_to posts_url
      end

    else
      redirect_to "/"
      flash[:user_login_err] = "User Authentication Failed"
    end
  end

  def assignOrRevokeAdminRole
    type = params[:type]
    user = User.find(params[:users_id])
    if type == "assign"
      user.user_type="admin"
    else
      user.user_type="user"
    end
    user.save
    redirect_to users_url
  end

  def reports
    @posts = []
    posts = Post.all
    posts.each do |post|
      post_hash = {}
      post_hash['content'] = post.content
      post_hash['no_of_votes'] = Vote.find_all_by_post_id(post.id).length
      post_hash['no_of_comments'] = Comment.find_all_by_post_id(post.id).length
      @posts << post_hash
    end
  end

  def search
      @keyword = params[:keyword]
      @type = params[:type]
      @results = []
      if @type == "user"
           @results = User.where("nickname like '%#{@keyword}%'").map {|result| result.nickname}
      elsif @type == "category"
        @results = Category.where("name like '%#{@keyword}%'").map {|result| result.name}
      else
        @results = Post.where("content like '%#{@keyword}%'").map {|result| result.content}
      end
  end

  def logout
    reset_session
    redirect_to "/"
  end
end
