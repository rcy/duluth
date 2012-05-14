class Item < ActiveRecord::Base
  validates :summary, :presence => true

  belongs_to :user
  validates_presence_of :user

  after_create :set_sort

  def set_sort
    unless sort.to_f > 0
      self.sort = id
      save!
    end
  end

  def self.contexts(user)
    contexts = []
    actions(user).each do |item|
      item.summary.scan(/@\w+/).each {|c| contexts << c}
    end
    contexts.uniq.sort
  end

  def self.all(user)
    where(:user_id => user)
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

  def self.note(user)
    active(user).where(:kind => 'note')
  end

  def self.calendar(user)
    active(user).where(:kind => 'calendar')
  end

  # TODO this go somewhere else
  def self.csv items
    CSV.generate do |csv|
      csv << ['id', 'kind', 'created_at', 'updated_at', 'archive', 'user_id', 'sort', 'summary', 'body']
      items.each do |i|
        csv << [i.id, i.kind, i.created_at, i.updated_at, i.archive, i.user_id, i.sort, i.summary, i.body]
      end
    end
  end

end
