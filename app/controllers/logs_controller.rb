class LogsController < ApplicationController

	def index
		whichLogs = params[:g]
		if whichLogs
			@logs = Log.where(id: whichLogs.pluck(:id))
		else
			@logs = Log.all
		end
	end

	def query
		conn = Faraday.new(url: ':3002')
		response = conn.post('/logs') do |req|
		  req.headers['Content-Type'] = 'application/json'
		  req.body = log_params
		end
		if response.status == 200
			@logs = []
			JSON.parse(response.body).each do |log|
				@logs.append(log)
			end
			redirect_to controller: :logs, action: :index, g: @logs
		end
	end

	protected

	def log_params
		params.permit(:docType, :docNum, :created_at).to_json
	end

	def set_logs
		#@logs = Log.where(id: @logs.)
	end


end
