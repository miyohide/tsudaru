# coding: utf-8
require 'spec_helper'

describe Tweet do
  describe 'Validations' do
    it { should ensure_length_of(:message).is_at_most(140) }
  end
end
