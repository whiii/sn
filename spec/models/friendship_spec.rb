require 'spec_helper'

describe Friendship do

  describe 'validation' do
    before :all do
      Factory(:friendship)
    end
    after :all do
      User.destroy_all
    end
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:target) }
    it { should validate_uniqueness_of(:target_id).scoped_to(:user_id) }
  end

  describe 'references' do
    it { should belong_to(:user) }
    it { should belong_to(:target) }
  end

  it 'should create inverse friendship when accepted' do
    friendship = Factory(:friendship, :accepted => false)
    Friendship.should_receive(:create).once.
      with(:user => friendship.target, :target => friendship.user, :accepted => true)
    friendship.accept
    friendship.accepted?.should be_true
  end

  it 'should delete inverse friendship when destroyed' do
    friendship = Factory(:friendship, :accepted => true)
    inverse = Factory(:friendship, :user => friendship.target, 
      :target => friendship.user, :accepted => true)
    friendship.destroy
    Friendship.find_by_id(inverse.id).should be_nil
  end

end
