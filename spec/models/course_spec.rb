require "rails_helper"

RSpec.describe Course, type: :model do
  it { should have_many :comments }
  it { should have_many :votes }
  it { should have_many :entries }

  it { should validate_presence_of :title }
  it { should validate_presence_of :category }

  it { should have_db_column(:title).of_type(:string).with_options(null: false) }
  it { should have_db_column(:category).of_type(:string).with_options(null: false) }
  it { should have_db_column(:instructor).of_type(:string).with_options(null: false) }
  it { should have_db_column(:score).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:votes_count).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:available).of_type(:boolean).with_options(default: false, null: false) }
  it { should have_db_column(:engaged).of_type(:boolean).with_options(default: false, null: false) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }

  it { should have_db_index(:available) }
  it { should have_db_index(:category) }
  it { should have_db_index(:instructor) }
  it { should have_db_index(:score) }
  it { should have_db_index(:title) }
  it { should have_db_index(:engaged) }
  it { should have_db_index(:votes_count) }

  context "callbacks" do
    let(:course) { create(:course) }

    it { expect(course).to callback(:check_engagement).after(:touch) }
  end

  describe "scopes" do
    before do
      @course1 = create(:course, available: true, title: '宗教哲學', instructor: '老皮', category: '天', engaged: false, score: 0)
      @course2 = create(:course, available: false, title: '自然科學導論', instructor: '歐趴雄', category: '天', engaged: true, score: 0)
      @course3 = create(:course, available: true, title: '宗教哲學', instructor: '歐趴雄', category: '物', engaged: true, score: -1)

      create(:entry, course: @course1, code: 'AB', department: '通識', timetable: {'1': ['3','4']}, cross_department: false, required: true)
      create(:entry, course: @course2, code: 'CD', department: '企管', timetable: {'3': ['3','4']}, cross_department: true, required: true)
      create(:entry, course: @course3, code: 'EF', department: '語言', timetable: {'5': ['3','4']}, cross_department: false, required: false)
    end

    # It's a good idea to create specs that test a failing result for each scope, but that's up to you
    it ".available_only" do
      expect(Course.available_only).to all(have_attributes(available: true))
    end

    it ".by_title" do
      expect(Course.by_title('宗教哲學')).to all(have_attributes(title: '宗教哲學'))
    end

    it ".by_instructor" do
      expect(Course.by_instructor('歐趴雄')).to all(have_attributes(instructor: '歐趴雄'))
    end

    it ".by_department" do
      expect(Course.by_department('通識')).to contain_exactly(@course1)
    end

    it ".by_category" do
      expect(Course.by_category('天')).to all(have_attributes(category: '天'))
    end

    it ".by_code" do
      expect(Course.by_code('CD')).to contain_exactly(@course2)
    end

    it ".by_time" do
      expect(Course.by_time({'5': ['1','2','3','4']})).to contain_exactly(@course3)
    end

    it ".hide_by_title" do
      expect(Course.hide_by_title('自然科學導論')).not_to include(@course2)
    end

    it ".cross_department" do
      expect(Course.cross_department).to contain_exactly(@course2)
    end

    it ".optional" do
      expect(Course.optional).to contain_exactly(@course3)
    end

    it ".order_by_rating" do
      expect(Course.order_by_rating.to_a).to eql([@course2, @course3, @course1])
    end
  end

  describe ".check_engagement" do
    it "does nothing and return nil if already engaged" do
      course = create(:course, engaged: true)

      expect(course.check_engagement).to be nil
      expect(course.engaged).to be true
    end

    it "does nothing and return nil if no comments and votes" do
      course = create(:course, engaged: false)

      expect(course.check_engagement).to be nil
      expect(course.engaged).to be false
    end

    it "change state if have new comments" do
      course = create(:course, engaged: false)
      comment = create(:comment, course: course)

      expect(course.engaged).to be true
    end

    it "change state if have new votes" do
      course = create(:course, engaged: false)
      vote = create(:course_vote, votable: course)

      expect(course.engaged).to be true
    end
  end
end