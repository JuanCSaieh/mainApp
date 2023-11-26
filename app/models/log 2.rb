class Log < ApplicationRecord
		enum opType: { crear: 0, modif: 1, elim: 2 }
end
