class Item < ActiveRecord::Base
  validates :summary, :presence => true

  scope :active, where(:archive => false)
  #scope :active, limit(200).reverse_order

  def self.inbox
    active.where(:kind => 'inbox').reverse_order
  end

  def self.projects
    active.where(:kind => 'project')
  end

  def self.actions
    active.where(:kind => 'action')
  end

  def self.waiting
    active.where(:kind => 'waiting')
  end

  def self.maybe
    active.where(:kind => 'maybe')
  end

  def self.trivia
    active.where(:kind => 'trivia')
  end

  def self.calendar
    active.where(:kind => 'calendar')
  end

end
