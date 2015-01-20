class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title, :null => false
      t.string :author_name, :null => false
      t.integer :year
      t.json :metadata
      t.text :text, :null => false

      t.timestamps
    end

    add_index :papers, :author_name
  end
end
