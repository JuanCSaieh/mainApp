class User < ApplicationRecord
	validates :docType, :docNum, :firstName, :secondName,
			:lastName, :dateBirth, :gender, :email,
			:phoneNumber, presence: true
	validates :docNum, :email, uniqueness: true
	validates :docNum, :phoneNumber, length: { maximum: 10 }
	validates :docNum, :phoneNumber, numericality: true
	validates :firstName, :secondName, length: { maximum: 30}
	validates :lastName, length: { maximum: 60}
	validates :firstName, :secondName, format: { with: /\A[a-zA-Z]+\z/,
		message: "only allows letters" }
	validates :lastName, format: { with: /\A[a-zA-Z]+(\s[a-zA-Z]+)?\z/,
		message: "only allows letters" }
	validates :email, format: URI::MailTo::EMAIL_REGEXP
	#add photos max 2 mb
	
	enum docType: { cedula: 0, identidad: 1 }
	enum gender: { masculino: 0, femenino: 1, noBinario: 2, noResponde: 3 }
end
