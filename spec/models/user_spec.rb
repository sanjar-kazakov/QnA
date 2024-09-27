require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence of email' do
      user = described_class.new(email: '')
      expect(user).not_to be_valid
    end

    it 'validates presence of password' do
      user = described_class.new(password: '')
      expect(user).not_to be_valid
    end
  end
end
