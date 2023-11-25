class AddIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, [:docType, :docNum], unique: true
  end
end
