class CreateHostRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :host_records do |t|
      t.references :host, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps
    end
  end
end
