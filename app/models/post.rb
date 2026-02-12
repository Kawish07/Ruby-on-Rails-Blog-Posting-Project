class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true, length: { minimum: 10 }

  scope :recent, -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }
end