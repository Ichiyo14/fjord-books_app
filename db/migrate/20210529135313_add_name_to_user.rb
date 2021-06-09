# frozen_string_literal: true

class AddNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :postal_code, :string
    add_column :users, :address, :text
    add_column :users, :self_introduction, :text
    add_column :users, :name, :string
  end
end
