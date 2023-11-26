class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.integer :docType
      t.string :docNum
      t.string :firstName
      t.string :secondName
      t.string :lastName
      t.date :dateBirth
      t.integer :gender
      t.string :email
      t.string :phoneNumber
      t.integer :opType

      t.timestamps
    end
  end
end
