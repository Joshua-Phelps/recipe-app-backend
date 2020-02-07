class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :img
      t.string :directions
      t.string :area
      t.string :category
      t.integer :rating, default: 0 
  

      t.timestamps
    end
  end
end
