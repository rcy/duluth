class Item < ActiveRecord::Base
  validates :summary, :presence => true

  scope :active, where(:archive => false).reverse_order
  #scope :active, limit(200).reverse_order

  def self.inbox
    active.where(:project => false, :action => false, :waiting => false, :maybe => false)
  end

  def self.projects
    active.where(:project => true)
  end

  def self.actions
    active.where(:action => true)
  end

  def self.waiting
    active.where(:waiting => true)
  end

  def self.maybe
    active.where(:maybe => true)
  end

end
