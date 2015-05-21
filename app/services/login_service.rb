LoginService = Struct.new(:email, :password)

class LoginService
  def execute
    user = User.find_by_email email
    return nil unless user.present?
    return nil unless user.valid_password? password
    user.authentication_tokens.valid.first || AuthenticationToken.generate(user)
  end
end
