class TournamentQuery
  #attr_reader :relation

  #def initialize(relation = Book.all)
  #  @relation = relation
  #end

  #def sum_items_quantity(relation = @relation)
  #  relation.group(:id).select('books.*, sum(order_items.quantity) as quantity')
  #end

  #def with_associate_models
  #  relation.includes(:pictures, :authors).joins(:order_items)
  #end

  #def with_filter(filter)
  #  case filter
  #  when 'newest_first'
  #    relation.order(created_at: :desc)
  #  when 'popular_first'
  #    quantity_items = sum_items_quantity(relation.joins(:order_items))
  #    quantity_items.order('quantity desc')
  #  when 'price_low_to_hight'
  #    relation.order(price: :asc)
  #  when 'price_hight_to_low'
  #    relation.order(price: :desc)
  #  when 'title_z_a'
  #    relation.order(title: :desc)
  #  else relation.order(title: :asc)
  #  end
  #end
end
