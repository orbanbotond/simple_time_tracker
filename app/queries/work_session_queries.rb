class WorkSessionQueries
  attr_reader :user, :filter

  def initialize(user, filter)
    @user = user
    @filter = filter
  end

  def execute
    relation = WorkSession.joins(:work_day).includes(:work_day).where{work_day.user_id == my{user.id}}.order{work_day.date}
    if filter.filtering?
      relation = relation.where{ (work_day.date >= my{ filter.from }) & (work_day.date <= my{ filter.to }) }
    end
    relation
  end
end