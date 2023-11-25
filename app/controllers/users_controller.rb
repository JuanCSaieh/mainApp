class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def consult
	end

	def new
		@user = User.new
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

			redirect_to controller: :users, action: :show, id:@user.id

		else
			render "new"
		end
	end

	def foo
		response = Faraday.get('http://192.168.0.101:3001/users/'.concat(
								params[:docType].to_s,"/", params[:docNum].to_s))
		if response.status == 200
			@user = User.find(response.body.to_i)
			redirect_to controller: :users, action: :show, id:@user.id
		else
			redirect_to controller: :users, action: :consult
		end
	end

	def show
		set_user
	end

	def edit
		set_user
	end

	def update
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		response = conn.patch('users/'.concat(params[:id].to_s)) do |req|
		  	req.headers['Content-Type'] = 'application/json'
		  	req.body = user_params.to_json
		end

		if response.status == 200
			@user = User.find(params[:id])
			redirect_to controller: :users, action: :show, id:@user.id
		else
			render status: 422
		end
	end

	def destroy
		@users = User.all
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		response = conn.delete('/users/'.concat(params[:id].to_s))
		if response.status == 200
			redirect_to controller: :users, action: :index
		else
			redirect_to controller: :users, action: :index
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
