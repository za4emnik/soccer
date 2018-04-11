require 'rails_helper'

describe ApplicationHelper do
  describe '#show_errors' do
    it 'should return fields errors separated by \',\'' do
      obj = Tournament.new
      obj.errors.add(:name, %w[message1 message2])
      expect(helper.show_errors(obj, 'name')).to eq('message1, message2')
    end
  end

  describe '#add_error_class' do
    it 'should return error class if there is an error' do
      obj = Tournament.new
      obj.errors['name'] << 'some error'
      expect(helper.add_error_class(obj, 'name')).to eq('has-error')
    end
  end
end
