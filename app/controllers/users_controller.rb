class UsersController < ApplicationController
	require 'net/http'

	def index
		@users = User.all
	end
	def consultar

	end
	def log
		
	end


	def new
		@user = User.new
	end

	def create 

	end
	
	def show
		
	end

	def update

	end

	def delete

	end

end
