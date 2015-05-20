class CreateWorkingDays < ActiveRecord::Migration
  def change
    create_table :working_days do |t|
      t.references :user
      t.integer :duration, default: 0

      t.timestamps null: false
    end
  end
end
