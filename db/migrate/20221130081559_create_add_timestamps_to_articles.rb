class CreateAddTimestampsToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :time_to_read, :string
  end
end
