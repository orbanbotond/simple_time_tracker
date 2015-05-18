class CreatePreferredWorkingHours < ActiveRecord::Migration
  def change
    create_table :preferred_working_hours do |t|
      t.references :user, index: true
      t.integer :hour

      t.timestamps null: false
    end
    add_foreign_key :preferred_working_hours, :users
  end
end
