class ChageTiteName < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :tite, :title
  end
end
