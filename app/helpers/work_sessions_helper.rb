module WorkSessionsHelper
  def color(work_session)
    work_session.in_preferred_hour? ? 'danger': 'success'
  end
end
