class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :name
      t.string :record_type
      t.string :type
      t.integer :type_code
      t.string :tag
      t.string :message_stream
      t.string :description
      t.string :email
      t.string :from
      t.datetime :bounced_at

      t.timestamps
    end
  end
end
