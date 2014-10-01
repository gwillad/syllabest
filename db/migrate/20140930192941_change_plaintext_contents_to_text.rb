class ChangePlaintextContentsToText < ActiveRecord::Migration
  def change
    change_column :plaintexts, :contents, :text
  end
end
