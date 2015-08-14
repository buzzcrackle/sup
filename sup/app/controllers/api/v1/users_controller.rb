module Api
	module V1
		class UsersController < ApplicationController
			def create
				@user = User.create(user_params)
				if @user.save
					render json: @user
				else
					render json: "bad request", status: 422
				end
			end
			def show
				@user = User.find(params[:id])
				render json: @user
			end
			def update
				@user = User.find(params[:id])
				if @user.update_attributes(update_params)
					render json: @user
				else
					render json: "bad request", status: 422
				end
			end
			def index
				@users = User.all
				render json: @users
			end
			def destroy
				@user = User.find(params[:id])
				@user.destroy
				render json: "yay", status: 200
			end
			def following
				@user = User.find(params[:id])
				@users = @user.following
				render json: @users
			end
			private
			def update_params
				params.require(:user).permit(:password)
			end
			def user_params
				params.require(:user).permit(:username,:email,:password)
			end
		end
	end
end
