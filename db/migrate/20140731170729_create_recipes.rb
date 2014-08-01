class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :yummly_id
      t.string :name
      t.string :source_url
      t.string :large_image_url

      t.belongs_to :user
      t.timestamps
    end
  end
end
