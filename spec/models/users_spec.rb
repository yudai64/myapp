require "rails_helper"

RSpec.describe User, type: :model do
  describe "#create" do
    it "is valid with a name, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "is invalid a name that has more than 13 characers" do
      user = build(:user, name: "aaaaaaaaaaaaa")
      expect(user).not_to be_valid
    end

    it "is invalid without a password" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is invalid duplicate email address" do
      user = create(:user)
      user2 = build(:user, name: "user2", email: "test@example.com", password: "password2", password: "password2")
      user2.valid?
      expect(user2.valid?).to eq(false)
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "is invalid without a password_confirmation" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "is invalid with password_confirmation that do not match password" do
      user = build(:user, password_confirmation: "password2")
      user.valid?
      expect(user.valid?).to eq(false)
    end
  end

  describe "Association" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "post" do
      let(:target) { :posts }

      it { expect(association.macro).to eq :has_many }

      it { expect(association.class_name).to eq "Post"}
    end

    context "comment" do
      let(:target) { :comments }

      it { expect(association.macro).to eq :has_many }

      it { expect(association.class_name).to eq "Comment"}
    end
  end
end