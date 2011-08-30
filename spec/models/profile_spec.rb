require 'spec_helper'

describe Profile do

  describe 'validation' do
    before :all do
      Factory(:profile)
    end
    it { should validate_presence_of(:user) }
    it { should validate_uniqueness_of(:user_id) }
    it { should validate_format_of(:icq_number).with(/^[1-9][0-9]{4,8}$/) }
    it { should allow_value('Male').for(:gender) }
    it { should allow_value('Female').for(:gender) }
    it { should_not allow_value('other').for(:gender) }
    it { should allow_value(10.years.ago).for(:birth_date) }
    it { should_not allow_value(1.days.from_now).for(:birth_date) }
    it { should ensure_length_of(:status).is_at_most(64) }
    it_should_ensure_length_at_most(16, :country, :city, :school, :phone_number, :skype_id)
  end

  describe 'references' do
    it { should belong_to(:user) }
  end

  it 'should update status' do
    profile = Factory(:profile, :status => 'Old status')
    profile.update_status('New status')
    profile.status.should == 'New status'
  end

  it 'should return correct age' do
    profile = Factory.build(:profile, :birth_date => 1000.days.ago)
    profile.age.should == 2
  end

end