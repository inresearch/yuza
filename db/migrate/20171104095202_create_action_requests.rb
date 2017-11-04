class CreateActionRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :action_requests, id: false do |t|
      t.string :id, null: false
      t.string :host_id, null: false
      t.string :request, null: false

      t.timestamps
    end

    execute "ALTER TABLE action_requests ADD PRIMARY KEY (id);"
  end
end
