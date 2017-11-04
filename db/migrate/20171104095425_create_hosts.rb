class CreateHosts < ActiveRecord::Migration[5.1]
  def change
    create_table :hosts, id: false do |t|
      t.string :id, null: false
      t.string :domain, null: false
      t.string :name, null: false
      t.string :color, null: false

      t.timestamps
    end

    add_index :hosts, :domain, unique: true
    execute "ALTER TABLE hosts ADD PRIMARY KEY (id);"
  end
end
