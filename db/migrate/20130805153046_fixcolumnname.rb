class Fixcolumnname < ActiveRecord::Migration
  def up
  end

  def change
    rename_column :scrape_data, :type, :data_type
  end

  def down
  end
end
