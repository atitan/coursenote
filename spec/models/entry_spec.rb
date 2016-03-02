require "rails_helper"

RSpec.describe Entry, type: :model do
  it { should belong_to :course }

  it { should validate_presence_of :course }
  it { should validate_presence_of :department }

  it { should have_db_column(:course_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:code).of_type(:string).with_options(null: false) }
  it { should have_db_column(:credit).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:department).of_type(:string).with_options(null: false) }
  it { should have_db_column(:timetable).of_type(:jsonb).with_options(null: false) }
  it { should have_db_column(:timestring).of_type(:string).with_options(null: false) }
  it { should have_db_column(:cross_department).of_type(:boolean).with_options(null: false) }
  it { should have_db_column(:cross_graduate).of_type(:boolean).with_options(null: false) }
  it { should have_db_column(:quittable).of_type(:boolean).with_options(null: false) }
  it { should have_db_column(:required).of_type(:boolean).with_options(null: false) }
  it { should have_db_column(:note).of_type(:string).with_options(default: '', null: false) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }
  it { should have_db_column(:capacity).of_type(:integer).with_options(default: 0, null: false) }

  it { should have_db_index(:course_id) }
  it { should have_db_index(:code) }
  it { should have_db_index(:department) }
  it { should have_db_index(:cross_department) }
  it { should have_db_index(:timetable) }

  describe "self.time_str_to_table" do
    it "converts time to table 1" do
      time = ["1-34", "", ""]
      output = Entry.time_str_to_table(time)

      expect(output).to eql({"1"=>["3","4"]})
    end

    it "converts time to table 2" do
      time = ["1-34", "4-3456", ""]
      output = Entry.time_str_to_table(time)

      expect(output).to eql({"1"=>["3","4"],"4"=>["3","4","5","6"]})
    end

    it "converts time to table 3" do
      time = ["1-34", "4-3456", "2-12"]
      output = Entry.time_str_to_table(time)

      expect(output).to eql({"1"=>["3","4"],"2"=>["1","2"],"4"=>["3","4","5","6"]})
    end

    it "outputs nothing if input is invalid" do
      time = ["i r winner", "This is a cat", "how do you turn this on"]
      output = Entry.time_str_to_table(time)

      expect(output).to eql({})
    end
  end
end