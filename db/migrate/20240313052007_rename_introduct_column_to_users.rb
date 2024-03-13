class RenameIntroductColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :introduct, :introduction
  end
end
