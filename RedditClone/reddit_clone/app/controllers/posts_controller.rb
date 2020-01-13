class PostsController < ApplicationController
      before_action :is_author?, only: [:edit, :update]

    def new
        @post = User.new
    end
    
    def create
        @post = current_user.posts(post_params)
        unless @post.save
            flash[:errors] = @post.errors.full_messages
        end 
    end

    def show
        @post = Post.find(params[:id])
        render :show
    end    

     def update
        @post = current_user.posts.find(params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub) # ??
        else
            flash.now[:errors] = @sub.errors.full_messages
               render :edit
        end
    end

    def edit
        render :edit
    end

    def destroy 
    end
   
    private
    def is_author?
       return if current_user.posts.find_by(id: params[:id])
       render json:"Forbidden", status: 404
    end

    def post_params
        params.require(:post).permit(:title, :)
end
