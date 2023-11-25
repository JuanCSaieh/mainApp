class UsersController < ApplicationController
	require 'net/http'

	def index
		@users = User.all
	end
	def consultar
	end
	def log
	end 
	def create
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		
		response = conn.post('/users') do |req|
  			req.headers['Content-Type'] = 'application/json'
  			req.body = JSON.generate(user_params)
		end
		if response.status == 200
			# redirect to show
		else
			render status: 422
	end


	def new
		@user = User.new
	end

	def create 

	end
	
	def show
		response = Faraday.get('http://192.168.0.101:3001/users/'
								+ params[:docType] + '/' + params[:docNum])
		if response.status = 200
			render json: response.body
		else
			render status: :not_found
	end

	def update
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		response = conn.patch('users/' + params[:id]) do |req|
		  	req.headers['Content-Type'] = 'application/json'
		  	req.body = JSON.generate(user_params)
		end
		if response.status = 200
			# redirect to show
		else
			render status: 422
		end
	end

	def destroy
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		response = conn.delete('/users/' + params[:id])
		if response.status = 200
			# redirect to index or consult view
		else
			render status: :not_found
		end
	end

	def user_params
		params.require(:user).permit(:docType,
				:docNum, :firstName, :secondName, :lastName,
				:dateBirth, :gender, :email, :phoneNumber)
	end

end
