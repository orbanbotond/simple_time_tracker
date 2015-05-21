module Entities
  class UserEntity < Grape::Entity
    expose :email
    expose :name
  end
end
