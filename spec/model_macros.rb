module ModelMacros
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def it_should_ensure_length_at_most(length, *attributes)
      attributes.each do |attribute|
        it { should ensure_length_of(attribute).is_at_most(length) }
      end
    end
  end

end