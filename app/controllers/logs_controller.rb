class LogsController < ApplicationController
	def create
		conn = Faraday.new(url: 'http://192.168.0.101:3001')
		response = conn.post('/logs') do |req|
		  req.headers['Content-Type'] = 'application/json'
		  req.body = JSON.generate(log_params)
		end
		if response.status == 200
			log_ids = []
			JSON.parse(response.body).each do |log|
				log_ids << log["id"]
			end
			@logs = Log.where(id: log_ids)
			render json: @logs
			# TODO redirect to show view
	end

	protected

	def log_params
		params.require(:log).permit(:docType, :docNum,
									:created_at)
	end
end
