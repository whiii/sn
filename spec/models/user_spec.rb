require 'spec_helper'

describe User do

  describe 'validation' do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should allow_value('John').for(:firstname) }
    it { should_not allow_value('too_big_firstname!').for(:firstname) }
    it { should allow_value('Johnson').for(:lastname) }
    it { should_not allow_value('too_big_lastname!').for(:lastname) }
  end

  describe 'references' do
    it { should have_one(:profile) }
    it { should have_many(:friends) }
    it { should have_many(:potential_friends) }
    it { should have_many(:wall_messages) }
    it { should have_many(:sent_wall_messages) }
    it { should have_many(:albums) }
  end

  it 'should build profile after created' do
    user = Factory(:user)
    user.profile.should_not be_nil
  end

  it 'should spam friends walls' do
    user = Factory.build(:user)
    friend = Factory.build(:user)
    message = 'test message'
    user.friends << friend
    WallMessage.should_receive('create').once.with(:user => friend, :sender => user, :text => message)
    user.spam_friends_walls_with message
  end

  it 'should provide daily stats' do
    from = Date.yesterday
    to = Date.today
    3.times{ Factory.create(:user) } 
    stats = User.get_daily_stats(from, to)
    stats.should == {
      Date.yesterday.strftime("%d/%m/%Y") => 0,
      Date.today.strftime("%d/%m/%Y") => 3
    }
  end

end
