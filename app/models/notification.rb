class Notification < ApplicationRecord
  default_scope -> {order(created_at: :desc)} #デフォルトで作成日時が新しい物順になる
  belongs_to :post, optional: true #「optional: true」はnilを許可するもの
  belongs_to :post_comment, optional: true

  belongs_to :visitor, class_name: 'EndUser', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'EndUser', foreign_key: 'visited_id', optional: true

  enum action:{like:0, comment:1}
end
