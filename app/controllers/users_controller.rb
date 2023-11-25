class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end
	def consultar

	end
	def log
	end 
	def create
		req_params = {}
		9.times { |i| req_params[user_params.keys[i]] = user_params.values[i] }
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		
		response = conn.post('/users') do |req|
  			req.headers['Content-Type'] = 'application/json'
  			req.body = user_params.to_json
		end
		if response.status == 200
			@user = User.find(JSON.parse(response.body)["id"])

			render json: @user

		else
			render "new"
		end
	end


	def new
		@user = User.new
	end

	def create 

	end
	
	def show
		response = Faraday.get('http://192.168.0.101:3001/users/'.concat(
								params[:docType].to_s,"/", params[:docNum].to_s))
		if response.status == 200
			@user = User.find(JSON.parse(response.body)["id"])
			render json: @user
		else
			render status: :not_found
		end
	end

	def edit
		set_user	
	end

	def update
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		response = conn.patch('users/'.concat(params[:id].to_s)) do |req|
		  	req.headers['Content-Type'] = 'application/json'
		  	req.body = JSON.generate(user_params)
		end
		if response.status == 200
			@user = User.find(params[:id])
			# redirect to show
		else
			render status: 422
		end
	end

	def destroy
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		response = conn.delete('/users/'.concat(params[:id].to_s))
		if response.status == 200
			# redirect to index or consult view
		else
			render status: :not_found
		end
	end

	private

	def user_params
		params.require(:user).permit(:docType,
				:docNum, :firstName, :secondName, :lastName,
				:dateBirth, :gender, :email, :phoneNumber)
	end

	def set_user
		@user = User.find(params[:id])
	end

end
