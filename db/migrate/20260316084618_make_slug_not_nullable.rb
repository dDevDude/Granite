# frozen_string_literal: true

class MakeSlugNotNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :tasks, :slug, false
  end
end
