class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: false do |t|
      t.string :id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone

      # internal user can access Yuza admin panel
      t.boolean :is_internal, null: false, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
