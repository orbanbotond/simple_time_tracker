class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.time :start_time
      t.time :end_time
      t.date :date
      t.references :user, index: true

      t.timestamps null: false
    end

    add_foreign_key :tasks, :users
  end
end
