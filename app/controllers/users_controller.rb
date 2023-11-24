class UsersController < ApplicationController
	require 'net/http'

	def index
		@user = User.all
	end

	def new
		#@user = User.new
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
