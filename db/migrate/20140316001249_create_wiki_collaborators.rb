class CreateWikiCollaborators < ActiveRecord::Migration
def self.up
    create_table :wiki_collaborators, :id => false do |t|
      t.column 'wiki_id', :integer
      t.column 'user_id', :integer
    end
  end

  def self.down
    drop_table :wiki_collaborators
  end
end