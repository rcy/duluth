class Item < ActiveRecord::Base
  validates :summary, :presence => true

  scope :active, where(:archive => false).reverse_order

  def self.archive
    where(:archive => true).order(:updated_at).reverse_order
  end

  def self.inbox
    active.where(:kind => 'inbox')
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
