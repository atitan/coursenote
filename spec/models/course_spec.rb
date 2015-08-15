require "rails_helper"

RSpec.describe Course, type: :model do
  it "has a valid factory" do
    # Using the shortened version of FactoryGirl syntax.
    # Add:  "config.include FactoryGirl::Syntax::Methods" (no quotes) to your spec_helper.rb
    expect(FactoryGirl.build(:course)).to be_valid
  end

  # Lazily loaded to ensure it's only used when it's needed
  # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
  let(:course) { FactoryGirl.build(:course) }

  describe "ActiveRecord associations" do
    # http://guides.rubyonrails.org/association_basics.html
    # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/frames 
    # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/Shoulda/Matchers/ActiveRecord

    # Performance tip: stub out as many on create methods as you can when you're testing validations 
    # since the test suite will slow down due to having to run them all for each validation check.
    #
    # For example, assume a User has three methods that fire after one is created, stub them like this:
    #
    # before(:each) do
    #   User.any_instance.stub(:send_welcome_email)
    #   User.any_instance.stub(:track_new_user_signup)
    #   User.any_instance.stub(:method_that_takes_ten_seconds_to_complete)
    # end
    #
    # If you performed 5-10 validation checks against a User, that would save a ton of time.

    # Associations
    it { expect(course).to have_many(:comments).order(score: :desc, created_at: :desc) }
    it { expect(course).to have_many(:votes) }
    it { expect(course).to have_many(:entries) }
    it { expect(course).to have_many(:passed_courses) }
  end
    
  describe "Databse columns/indexes" do
    # using shoulda-matcher
    it { expect(course).to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { expect(course).to have_db_column(:category).of_type(:string).with_options(null: false) }
    it { expect(course).to have_db_column(:instructor).of_type(:string).with_options(null: false) }
    it { expect(course).to have_db_column(:score).of_type(:integer).with_options(default: 0, null: false) }
    it { expect(course).to have_db_column(:available).of_type(:boolean).with_options(default: true, null: false) }
    it { expect(course).to have_db_column(:created_at).of_type(:datetime) }
    it { expect(course).to have_db_column(:updated_at).of_type(:datetime) }

    it { expect(course).to have_db_index(:available) }
    it { expect(course).to have_db_index(:category) }
    it { expect(course).to have_db_index(:instructor) }
    it { expect(course).to have_db_index(:score) }
    it { expect(course).to have_db_index(:title) }
  end

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