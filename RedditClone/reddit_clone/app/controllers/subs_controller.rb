class SubsController < ApplicationController
    before_action :is_mod?, only: [:update, :edit]

    def edit
        render :edit
    end

    def update
        @sub = current_user.subs.find(params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub) # ??
        else
            flash.now[:errors] = @sub.errors.full_messages
               render :edit
        end
    end

     private
    def is_mod?
       return if current_user.subs.find_by(id: params[:id])
       render json:"Forbidden", status: 404
    end

    def sub_params
        params.require(:sub).permit.(:title, :description)
    end

end
