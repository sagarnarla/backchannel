class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
