class Log < ApplicationRecord
	validates :docType, :docNum, :date, :opType, presence: true
	validates :docType, uniqueness: { scope: :docNum }
	validates :docNum, length: { maximum: 10 }
	validates :docNum, numericality: true

	enum docType: { cedula: 0, identidad: 1 }
	enum opType: { crear: 0, modif: 1, elim: 2 }

end
