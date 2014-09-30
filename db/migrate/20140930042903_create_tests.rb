class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :control_samples
      t.integer :control_conversions
      t.integer :var1_samples
      t.integer :var1_conversions

      t.timestamps
    end
  end
end
