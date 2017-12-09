class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :location
      t.integer :site
      t.date :date
      t.string :summary
      t.integer :user_id
    end
  end
end
