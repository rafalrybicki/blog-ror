class ChangeArticleIdToBeIntegerInComments < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :article_id, :integer
  end
end
