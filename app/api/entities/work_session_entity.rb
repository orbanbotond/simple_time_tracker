module Entities
  class WorkSessionEntity < Grape::Entity
    expose :duration
    expose :end_time
    expose :start_time
  end
end
