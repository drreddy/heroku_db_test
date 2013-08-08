class CreateScrapeData < ActiveRecord::Migration
  def change
    create_table :scrape_data do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
