class Item < ActiveRecord::Base
  validates :summary, :presence => true

  scope :active, where(:archive => false).reverse_order

  def self.projects
    active.where(:project => true)
  end

  def self.inbox
    active.where(:project => false)
  end

  def self.actions
    active.where(:project => false)
  end

  def self.waiting
    active.where(:project => false)
  end
end
