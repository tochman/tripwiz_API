class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :destination
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
