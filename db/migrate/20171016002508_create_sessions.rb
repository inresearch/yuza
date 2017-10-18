class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions, id: false do |t|
      t.string :id, null: false
      t.string :user_id, null: false
      t.string :code, null: false
      t.string :app, null: false
      t.datetime :expiry_time, null: false
      t.string :ip

      t.timestamps
    end

    add_index :sessions, :app
    add_index :sessions, [:user_id, :code], unique: true
    execute "ALTER TABLE sessions ADD PRIMARY KEY (id);"
  end
end
