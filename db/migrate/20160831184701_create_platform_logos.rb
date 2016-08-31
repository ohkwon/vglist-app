class CreatePlatformLogos < ActiveRecord::Migration[5.0]
  def change
    create_table :platform_logos do |t|
      t.integer :platform_id
      t.string :cloudinary_id
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
