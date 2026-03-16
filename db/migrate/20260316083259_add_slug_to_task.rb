# frozen_string_literal: true

class AddSlugToTask < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :slug, :string
  end
end
