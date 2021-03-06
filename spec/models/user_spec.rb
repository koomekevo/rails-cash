require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Kevin Koome', email: 'koomekevo@gmail.com', password: '1234321', confirmed_at: Time.now) }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be present' do
    subject.name = 'Kevin Koome'
    expect(subject).to be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
