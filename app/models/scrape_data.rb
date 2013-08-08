class ScrapeData < ActiveRecord::Base
  attr_accessible :name, :data_type
  validates :name, uniqueness: true
end
