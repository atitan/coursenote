require "rails_helper"

RSpec.describe Comment, type: :model do
  it { should have_many :votes }
  it { should have_many(:replies).order(:created_at) }
  it { should belong_to :parent }
  it { should belong_to :user }
  it { should belong_to(:course).touch(true) }

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

  context "callbacks" do
    let(:comment) { create(:comment) }

    it { expect(comment).to callback(:generate_avatar).before(:create) }
  end

  describe ".generate_avatar" do
    it "fills column avatar" do
      user = create(:user, secure_random: '123')
      comment = build(:comment, course_id: 10)
      comment.generate_avatar

      expect(comment.avatar.nil?).to be false
    end
  end

  describe ".check_parent_course_id" do
    it "add errors if parent's course_id doesn't equal to course_id" do
      parent = create(:comment)
      comment = build(:comment, parent: parent, course: create(:course))

      expect{comment.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end