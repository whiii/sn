require 'spec_helper'

describe Photo do

  describe 'validation' do
    it { should validate_presence_of(:album) }
    it { should ensure_length_of(:comment).is_at_most(64) }
    it { should validate_attachment_presence(:image) }
    it { should validate_attachment_content_type(:image).
      allowing('image/png', 'image/gif').
      rejecting('text/plain', 'text/xml') }
    #it { should validate_attachment_size(:image).less_than(5.megabytes) }
  end

  describe 'references' do
    it { should belong_to(:album) }
  end

  it { should have_attached_file(:image) }

end
