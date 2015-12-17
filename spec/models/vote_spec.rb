require "rails_helper"

RSpec.describe Vote, type: :model do
  it { should belong_to(:votable).counter_cache(true).touch(true) }
  it { should belong_to :user }

  it { should validate_presence_of :votable }
  it { should validate_presence_of :user }
  it do
    create(:course_vote)
    should validate_uniqueness_of(:user_id).scoped_to([:votable_id, :votable_type])
  end

  it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:votable_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:votable_type).of_type(:string).with_options(null: false) }
  it { should have_db_column(:upvote).of_type(:boolean) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }

  it { should have_db_index(:votable_id) }
  it { should have_db_index([:votable_id, :votable_type, :user_id]) }

  describe ".update_score" do
    it "case 1+1" do
      course = create(:course, score: 1)
      vote = create(:course_vote, votable: course, upvote: true)

      expect(course.score).to eq 2
    end

    it "case 1-1" do
      course = create(:course, score: 1)
      vote = create(:course_vote, votable: course, upvote: false)

      expect(course.score).to eq 0
    end

    it "case -1+1" do
      course = create(:course, score: -1)
      vote = create(:course_vote, votable: course, upvote: true)

      expect(course.score).to eq 0
    end

    it "case -1-1" do
      course = create(:course, score: -1)
      vote = create(:course_vote, votable: course, upvote: false)

      expect(course.score).to eq -2
    end
  end

  describe ".course_received_vote" do
    it "changes course vote status upon vote creation" do
      course = create(:course)
      vote = create(:course_vote, votable: course)

      expect(course.received_vote).to be true
    end
  end
end