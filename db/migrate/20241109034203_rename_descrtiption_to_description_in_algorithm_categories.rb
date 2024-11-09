class RenameDescrtiptionToDescriptionInAlgorithmCategories < ActiveRecord::Migration[7.1]
  def change
    rename_column :algorithm_categories, :descrtiption, :description
  end
end
