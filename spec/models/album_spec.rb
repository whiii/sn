require 'spec_helper'

describe Album do

  describe 'validation' do
    before :all do
      Factory(:album)
    end
    after :all do
      Album.destroy_all
      User.destroy_all
    end
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(32) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe 'references' do
    it { should belong_to(:user) }
    it { should have_many(:photos).dependent(:destroy) }
  end

end
