class PostsController < ApplicationController

  before_action :find_post, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order("created_at desc").paginate(page: params[:page], per_page: 3)

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to @post, notice: "Heya, Mohit! Your article was saved succesfully!!!"
    else
      render 'new', notice: "Oh no, Mohit! I was unable to save your artice!!!"
    end
  end

  def show
  end

  def edit

  end

  def update
    if @post.update post_params
      redirect_to @post, notice: "Hurray!! Your post got updated Mohit!!!"
    else
      render 'edit', notice: "Oops! Your post didn't update Mohit!!!"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:content, :slug)
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end
end
