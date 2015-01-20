class AddFileToPapers < ActiveRecord::Migration
  def change
    add_attachment :papers, :file
  end
end
