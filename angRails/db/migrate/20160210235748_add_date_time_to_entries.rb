class AddDateTimeToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :createdAt, :string
  end
end
