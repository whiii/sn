require 'spec_helper'

describe WallMessage do

  describe 'validation' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:sender) }
    it { should validate_presence_of(:text) }
    it { should ensure_length_of(:text).is_at_most(64) }
  end

  describe 'references' do
    it { should belong_to(:user) }
    it { should belong_to(:sender) }
  end

end
