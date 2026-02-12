class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # Display all published posts
  def index
    @posts = Post.published.recent
  end

  # GET /posts/:id
  # Display a single post
  def show
  end

  # GET /posts/new
  # Display form for creating a new post
  def new
    @post = Post.new
  end

  # POST /posts
  # Create a new post
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /posts/:id/edit
  # Display form for editing an existing post
  def edit
  end

  # PATCH/PUT /posts/:id
  # Update an existing post
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  # Delete a post
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private

  # Find post by ID
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow trusted parameters through
  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
