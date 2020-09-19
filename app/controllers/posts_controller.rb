class PostsController < ApplicationController
    before_action :authenticate_user
    before_action :correct_user,{only: [:edit,:update,:destroy]}

    
    def index
        @posts = Post.all.order(created_at: :desc)
    end
    
    def show
       @post = Post.find(params[:id])
       @post_liked = Like.where(post_id: @post.id).count
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(
            content: params[:content],
            user_id: @current_user.id
        )
        if @post.save
            @post.user_id = @current_user.id
            redirect_to "/posts/index", notice: "投稿を作成しました"
        else
            render "posts/new" 
        end
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        @post.content=params[:content]
        if @post.save
            redirect_to "/posts/index", notice: "投稿を編集しました"
        else
            render "posts/edit"
            # redirect_to "/posts/#{@post.id}/edit"
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to "/posts/index", notice: "投稿を削除しました"
    end
    
    def correct_user
        @post = Post.find_by(id: params[:id])
        if @post.user_id != @current_user.id
        flash[:notice] = "権限がありません"
        redirect_to("/posts/index")
        end
    end
end