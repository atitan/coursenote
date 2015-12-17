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
  it { should have_db_column(:received_vote).of_type(:boolean).with_options(default: false, null: false) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }

  it { should have_db_index(:available) }
  it { should have_db_index(:category) }
  it { should have_db_index(:instructor) }
  it { should have_db_index(:score) }
  it { should have_db_index(:title) }
  it { should have_db_index(:received_vote) }
  it { should have_db_index(:votes_count) }

  describe "scopes" do
    before do
      @course1 = create(:course, available: true, title: '宗教哲學', instructor: '老皮', category: '天')
      @course2 = create(:course, available: false, title: '自然科學導論', instructor: '歐趴雄', category: '天')
      @course3 = create(:course, available: true, title: '宗教哲學', instructor: '歐趴雄', category: '物')

      create(:entry, course: @course1, code: 'AB', department: '通識', timetable: {'1': ['3','4']}, cross_department: false)
      create(:entry, course: @course2, code: 'CD', department: '企管', timetable: {'3': ['3','4']}, cross_department: true)
      create(:entry, course: @course3, code: 'EF', department: '語言', timetable: {'5': ['3','4']}, cross_department: false)
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
      expect(Course.by_department('通識')).to include(@course1)
    end

    it ".by_category" do
      expect(Course.by_category('天')).to all(have_attributes(category: '天'))
    end

    it ".by_code" do
      expect(Course.by_code('CD')).to include(@course2)
    end

    it ".by_time" do
      expect(Course.by_time({'5': ['1','2','3','4']})).to include(@course3)
    end

    it ".hide_by_title" do
      expect(Course.hide_by_title('自然科學導論')).not_to include(@course2)
    end

    it ".cross_department" do
      expect(Course.cross_department).to include(@course2)
    end
  end 
end