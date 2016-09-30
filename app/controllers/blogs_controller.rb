class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :collect_user, only: [:edit, :destroy]

  def index
    @blogs = Blog.all
  end

  def show
    @favorite = Favorite.where(user_id: current_user.id, blog_id: params[:id]).first
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog)
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :content)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end

    def collect_user
      @blog = Blog.find(params[:id])
      @user = @blog.user
      unless @user==current_user
        redirect_to blogs_path
      end
    end
end
