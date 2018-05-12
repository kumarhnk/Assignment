class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name, null: false, unqiue: true
      t.timestamps null: false
    end
  end
end
