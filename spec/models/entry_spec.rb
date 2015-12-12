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

  it { should have_db_index(:course_id) }
  it { should have_db_index(:code) }
  it { should have_db_index(:department) }
  it { should have_db_index(:timetable) }
end