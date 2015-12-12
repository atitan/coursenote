require "rails_helper"

RSpec.describe Comment, type: :model do
  it { should have_many :votes }
  it { should belong_to :user }
  it { should belong_to :course }

  it { should validate_presence_of :content }
  it { should validate_presence_of :course }
  it { should validate_presence_of :user }
  it { should validate_length_of :content }

  it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:course_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:parent_id).of_type(:integer) }
  it { should have_db_column(:avatar).of_type(:string).with_options(null: false) }
  it { should have_db_column(:score).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:votes_count).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:content).of_type(:text).with_options(null: false) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }

  it { should have_db_index(:course_id) }
  it { should have_db_index(:parent_id) }
  it { should have_db_index(:user_id) }
  it { should have_db_index(:score) }
end