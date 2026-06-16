class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.string  :title,       null: false
      t.text    :description
      t.integer :priority,    null: false, default: 1
      t.integer :status,      null: false, default: 0
      t.references :agent,    null: false, foreign_key: true

      t.timestamps
    end

    add_index :tickets, :status
    add_index :tickets, :priority
  end
end
