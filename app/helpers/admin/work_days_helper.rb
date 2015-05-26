module Admin
  module WorkDaysHelper
    def task_title(work_session)
      title =  if work_session.persisted?
        "Task: #{work_session.description}"
      else
        'New Task'
      end
    end
  end
end