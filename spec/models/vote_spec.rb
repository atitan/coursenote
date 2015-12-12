require "rails_helper"

RSpec.describe Vote, type: :model do
  it { should belong_to :votable }
  it { should belong_to :user }

  it { should validate_presence_of :votable }
  it { should validate_presence_of :user }
  #it do
  #  FactoryGirl.create(:vote)
  #  should validate_uniqueness_of(:user_id)
  #end
  #it { should validate_uniqueness_of :user_id }

  it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:votable_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:votable_type).of_type(:string).with_options(null: false) }
  it { should have_db_column(:upvote).of_type(:boolean) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }

  it { should have_db_index(:votable_id) }
  it { should have_db_index([:votable_id, :votable_type, :user_id]) }
end