class VotesController < ApplicationController
  # GET /votes
  # GET /votes.json
  def index
    type = params[:type]
    if type == "post"
      post_id = params[:post_id]
      users = Vote.where("post_id=#{post_id}")
    else
      comment_id = params[:comment_id]
      users = Vote.where("comment_id=#{comment_id}")
    end
    if users.length > 0
      users_arr = []
      users.each {|user| users_arr << user.user_id}
      @users_who_voted = User.find(users_arr)
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new(params[:vote])
    @vote.user_id = session[:user_id]
    if params[:type].eql? "post"
      @vote.post_id = params[:post_id]
    else
      @vote.comment_id = params[:comment_id]
    end
    @vote.save
    post = Post.find(session[:post].id)
    post.updated_at = @vote.updated_at
    post.save
   # temp = post_url(Post.find(params[:post_id]))
    redirect_to post_url(Post.find(params[:post_id]))
=begin
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
=end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(params[:vote])
    @vote.user_id = session[:user_id]
    if params[:type].eql? "post"
      @vote.post_id = params[:post_id]
    else
      @vote.comment_id = params[:comment_id]
    end
    @vote.save
    redirect_to post_url(Post.find(params[:post_id]))
=begin
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end
end
