class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login, index: true, null: false, unique: true
    end
  end
end
