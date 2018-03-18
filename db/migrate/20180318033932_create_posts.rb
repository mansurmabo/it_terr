class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.inet :ip_address, null: false

      t.timestamps
    end
  end
end
