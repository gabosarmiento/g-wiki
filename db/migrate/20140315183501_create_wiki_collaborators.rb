class CreateWikiCollaborators < ActiveRecord::Migration
  def self.up
    create_table :wiki_collaborators do |t|
      t.references :wiki
      t.references :user
    end
  end


  def self.down
    drop_table :wiki_collaborators
  end
end
