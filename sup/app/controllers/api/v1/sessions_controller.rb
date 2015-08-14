module Api
	module V1
		class SessionsController < ApplicationController
			def create
				email = params[:email]
				password = params[:password]
				@user = User.find_by(email: email)
				if @user && @user.authenticate(password)
					render json: @user.auth_token, status: 200
				else
					self.headers['WWW-Authenticate'] = 'Token realm="Application"'
					render json: 'Bad credentials', status: 401
				end
			end
			def destroy
				token = params[:token]
				@user = User.find_by(auth_token: token)
				if @user
					@user.reset_auth_token
					render json: 'Logged out'
				else
					render json: 'Invalid token', status: 401
				end
			end
		end
	end
end