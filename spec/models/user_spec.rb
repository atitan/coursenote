require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many :votes }
  it { should have_many :comments }

  it { should have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
  it { should have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
  it { should have_db_column(:reset_password_token).of_type(:string) }
  it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
  it { should have_db_column(:remember_created_at).of_type(:datetime) }
  it { should have_db_column(:sign_in_count).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
  it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
  it { should have_db_column(:current_sign_in_ip).of_type(:string) }
  it { should have_db_column(:last_sign_in_ip).of_type(:string) }
  it { should have_db_column(:confirmation_token).of_type(:string) }
  it { should have_db_column(:confirmed_at).of_type(:datetime) }
  it { should have_db_column(:confirmation_sent_at).of_type(:datetime) }
  it { should have_db_column(:failed_attempts).of_type(:integer).with_options(default: 0, null: false) }
  it { should have_db_column(:unlock_token).of_type(:string) }
  it { should have_db_column(:locked_at).of_type(:datetime) }
  it { should have_db_column(:time_filter).of_type(:jsonb).with_options(default: {}, null: false) }
  it { should have_db_column(:passed_courses).of_type(:string).with_options(default: [], null: false, array: true) }
  it { should have_db_column(:favorite_courses).of_type(:string).with_options(default: [], null: false, array: true) }
  it { should have_db_column(:is_student).of_type(:boolean).with_options(null: false) }
  it { should have_db_column(:student_id).of_type(:string) }
  it { should have_db_column(:secure_random).of_type(:string).with_options(null: false) }
  it { should have_db_column(:banned_until).of_type(:datetime) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }

  it { should have_db_index(:confirmation_token) }
  it { should have_db_index(:email) }
  it { should have_db_index(:reset_password_token) }
  it { should have_db_index(:secure_random) }
  it { should have_db_index(:student_id) }
  it { should have_db_index(:unlock_token) }
end