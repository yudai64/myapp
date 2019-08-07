class PostsController < ApplicationController
  before_action :post_find, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.order(updated_at: "DESC")
  end

  def show
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to profile_path, success: "投稿を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to profile_path, success: "投稿を削除しました"
  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def post_find
      @post = Post.find(params[:id])
    end
end
