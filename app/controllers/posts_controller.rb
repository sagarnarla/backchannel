  class PostsController < ApplicationController
    # GET /posts
    # GET /posts.json
    def index
      @posts = Post.order("updated_at desc")

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @posts }
      end
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      @can_user_vote_for_post = true
      @can_user_vote_for_comment = true
      @post = Post.find(params[:id])
      session[:post] = @post
      @comments = []
      comments = Comment.find_all_by_post_id(params[:id])
      comments.each do |comment|
        comments_hash = {}
        comments_hash['content'] = comment.content
        comments_hash['comment_obj'] = comment
        comments_hash['nickname'] = User.find(comment.user_id).nickname
        comments_hash['user_id'] = comment.user_id
        comments_hash['created_date'] = comment.created_at
        comments_hash['comment_id'] = comment.id
        comments_hash['votes_for_comment'] = Vote.find_all_by_comment_id(comment.id).length
        comments_hash['can_user_vote_for_comment'] = true
        has_user_voted_for_this_comment = Vote.where("user_id=#{session[:user_id]} and comment_id=#{comment.id}").length >0
        comments_hash['has_user_voted_for_this_comment'] = has_user_voted_for_this_comment
        flag = ((session[:user_id] == comment.user_id) || (has_user_voted_for_this_comment))
        if flag
            comments_hash['can_user_vote_for_comment'] = false
        end
        @comments<<comments_hash
      end
        @votes_for_post = Vote.find_all_by_post_id(params[:id]).length
        @has_user_voted_for_this_post = Vote.where("user_id=#{session[:user_id]} and post_id=#{@post.id}").length >0
        flag = ((session[:user_id] == @post.user_id) || (@has_user_voted_for_this_post))
        if flag
            @can_user_vote_for_post = false
        end
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    end

    # GET /posts/new
    # GET /posts/new.json
    def new
      @post = Post.new
      @categories = get_categories_for_select
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @post }
      end
    end

    # GET /posts/1/edit
    def edit
      @post = Post.find(params[:id])
      @categories = get_categories_for_select
    end

    # POST /posts
    # POST /posts.json
    def create
      @post = Post.new(params[:post])
      @post.user_id=session[:user_id]
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render json: @post, status: :created, location: @post }
        else
          format.html { render action: "new" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /posts/1
    # PUT /posts/1.json
    def update
      @post = Post.find(params[:id])

      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
      @post = Post.find(params[:id])
      @post.destroy

      respond_to do |format|
        format.html { redirect_to posts_url }
        format.json { head :no_content }
      end
    end

    def get_categories_for_select
      cats = []
      categories = Category.all
      categories.each {|category| cats<<[category.name, category.id]}
      return cats
    end

    def searchPost

    end
  end
