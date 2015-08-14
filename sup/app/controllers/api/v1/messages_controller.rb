module Api
	module V1
		class MessagesController < ApplicationController
			before_action :authenticate # you need auth token to see this
			def create
				@message = Message.create(message_params)
				@message.read = false
				if @message.save
					render json: "message sent to #{User.find(@message.recipient_id)}"
				else
					render json: "bad request", status: 422
				end
			end
			def update
				@message = Message.find(params[:id])
				if @message.update_attribute(read: true)
					render json: "yay"
				else
					render json: "bad request", status: 422
				end
			end
			private
			def message_params
				params.require(:message).permit(:user_id,:recipient_id)
			end
		end
	end
end