class Item < ActiveRecord::Base
  validates :summary, :presence => true

  scope :active, where(:archive => false).reverse_order

  def self.inbox
    active.where(:project => false, :action => false, :waiting => false)
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
end
