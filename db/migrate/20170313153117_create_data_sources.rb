# frozen_string_literal: true
class CreateDataSources < ActiveRecord::Migration[5.0]
  def up
    create_table :data_sources do |t|
      t.integer :hcrm_data_source_id, null: false, unique: true
      t.string :name, null: false, unique: true
      t.string :provider_type

      t.timestamps
    end
  end

  def down
    drop_table :data_sources
  end
end
