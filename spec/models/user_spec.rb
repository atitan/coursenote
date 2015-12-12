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

  describe ".student?" do
    it "returns true if user is a student" do
      user = build(:user, is_student: true)

      expect(user.student?).to be true
    end

    it "returns false if user is not a student" do
      user = build(:user, is_student: false)

      expect(user.student?).to be false
    end
  end

  describe ".generate_secure_random" do
    it "generates 32 digits string" do
      user = build(:user)
      user.generate_secure_random

      expect(user.secure_random).to match(/\A[a-f0-9]{32}\z/)
    end

    it "does not generate duplicates" do
      user = build(:user)
      user2 = build(:user)

      user.generate_secure_random
      user2.generate_secure_random

      expect(user.secure_random).not_to eq(user2.secure_random)
    end
  end

  describe ".check_identity" do
    context "valid student email" do
      it "checks case 1" do
        user = build(:user, email: 's1234567@cycu.edu.tw')
        user.check_identity

        expect(user.student?).to be true
        expect(user.student_id).to match('1234567')
      end

      it "checks student email case 2" do
        user = build(:user, email: 's12345678@cycu.edu.tw')
        user.check_identity

        expect(user.student?).to be true
        expect(user.student_id).to match('12345678')
      end

      it "checks student email case 3" do
        user = build(:user, email: 'g1234567@cycu.edu.tw')
        user.check_identity

        expect(user.student?).to be true
        expect(user.student_id).to match('1234567')
      end

      it "checks student email case 4" do
        user = build(:user, email: 'g12345678@cycu.edu.tw')
        user.check_identity

        expect(user.student?).to be true
        expect(user.student_id).to match('12345678')
      end
    end

    context "invalid student email" do
      it "checks non student email" do
        user = build(:user, email: 'teacher@cycu.edu.tw')
        user.check_identity

        expect(user.student?).to be false
        expect(user.student_id).to be nil
      end
    end
  end

  describe ".sanitize_array_column" do
    it "cleans duplicates" do
      user = build(:user, passed_courses: ['課程1', '課程1', '課程2'], favorite_courses: ['ABC', 'EFG', 'EFG'])
      user.sanitize_array_column

      expect(user.passed_courses).to match(['課程1', '課程2'])
      expect(user.favorite_courses).to match(['ABC', 'EFG'])
    end
  end

  describe ".active_for_authentication?" do
    it "prevents unconfirmed user from logging in" do
      user = build(:user)

      expect(!!user.active_for_authentication?).to be false
    end

    it "prevents confirmed but banned user from logging in" do
      user = build(:user, confirmed_at: DateTime.now - 1.weeks, banned_until: DateTime.now + 1.weeks)

      expect(!!user.active_for_authentication?).to be false
    end

    it "allows confirmed and unbanned user to login" do
      user = build(:user, confirmed_at: DateTime.now - 1.weeks, banned_until: DateTime.now - 1.days)

      expect(!!user.active_for_authentication?).to be true
    end

    it "allows normal user to login" do
      user = build(:user, confirmed_at: DateTime.now - 1.weeks)

      expect(!!user.active_for_authentication?).to be true
    end
  end
end