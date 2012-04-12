class Item < ActiveRecord::Base
  validates :summary, :presence => true

  belongs_to :user
  validates_presence_of :user

  def self.active(user)
    where(:user_id => user, :archive => false).reverse_order
  end

  def self.inbox(user)
    active(user).where(:kind => 'inbox')
  end

  def self.projects(user)
    active(user).where(:kind => 'project')
  end

  def self.actions(user)
    active(user).where(:kind => 'action')
  end

  def self.waiting(user)
    active(user).where(:kind => 'waiting')
  end

  def self.maybe(user)
    active(user).where(:kind => 'maybe')
  end

  def self.trivia(user)
    active(user).where(:kind => 'trivia')
  end

  def self.calendar(user)
    active(user).where(:kind => 'calendar')
  end

end
