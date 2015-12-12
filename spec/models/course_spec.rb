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
  it { should have_db_column(:available).of_type(:boolean).with_options(default: true, null: false) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }

  it { should have_db_index(:available) }
  it { should have_db_index(:category) }
  it { should have_db_index(:instructor) }
  it { should have_db_index(:score) }
  it { should have_db_index(:title) }

  it "has a valid factory" do
    # Using the shortened version of FactoryGirl syntax.
    # Add:  "config.include FactoryGirl::Syntax::Methods" (no quotes) to your spec_helper.rb
    expect(FactoryGirl.build(:course)).to be_valid
  end

  # Lazily loaded to ensure it's only used when it's needed
  # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
  let(:course) { FactoryGirl.build(:course) }

  describe "scopes" do
    before do
      FactoryGirl.create(:course, available: true, title: '宗教哲學', instructor: '歐趴雄', category: '天')
      FactoryGirl.create(:course, available: false, title: '自然科學導論', instructor: '老皮', category: '人')
      FactoryGirl.create(:course, available: true, title: '宗教哲學', instructor: '歐趴雄', category: '物')
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

    #it ".by_department" do
    #  expect(model.scope_name(conditions)).to eq(result_expected)
    #end

    it ".by_category" do
      expect(Course.by_category('人')).to all(have_attributes(category: '人'))
    end

    #it ".hide_passed_courses" do
    #  expect(model.scope_name(conditions)).to eq(result_expected)
    #end
  end 
end