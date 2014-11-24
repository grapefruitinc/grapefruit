module AuthHelpers
  def set_headers
    { 'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
  end

  def auth_with_user(user)
    { "user-email" => "#{user.email}", "authentication-token" => "#{user.authentication_token}" }
  end

  def clear_token
    request.env["user-email"] = nil
    request.env["authentication-token"] = nil
  end
end
