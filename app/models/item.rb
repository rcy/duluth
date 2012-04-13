class Item < ActiveRecord::Base
  validates :summary, :presence => true

  belongs_to :user
  validates_presence_of :user

  after_create :set_sort

  def set_sort
    self.sort = self.id
    save!
  end

  def self.archive(user)
    where(:user_id => user, :archive => true).order(:sort).reverse_order
  end

  def self.active(user)
    where(:user_id => user, :archive => false).order(:sort).reverse_order
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
