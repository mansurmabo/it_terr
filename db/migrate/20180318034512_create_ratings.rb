class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.belongs_to :post, foreign_key: true
      t.integer :mark, null: false
    end
  end
end
