class CreateJoinTableGroupsMembers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :groups, :users, table_name: 'groups_members' do |t|
    end
  end
end
