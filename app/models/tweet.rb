# coding: utf-8
class Tweet < ActiveRecord::Base
  attr_accessible :message
  validates :message, length: { maximum: 140 }
end
