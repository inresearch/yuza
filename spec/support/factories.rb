def user_attributes
  {
    name: 'Adam',
    email: 'adam@netinmax.com'
  }
end

def password_attributes
  {
    app: 'pageok',
    password: 'Password01'
  }
end

def build_user
  User.new(user_attributes)
end

def create_user
  u = build_user; u.save!; u
end

def create_password(u, attributes={})
  u.init_new_password(attributes).save!
end

def create_session(u, app='pageok')
  Session.create!(
    user: u,
    app: app,
    expiry_time: 30.minutes.from_now,
    ip: '127.0.0.1'
  )
end

def create_host
  Host.create!(
    domain: 'pageok.com',
    name: 'pageok',
    color: '#dfdfdf'
  ) 
end

def parsed_body
  JSON.parse(response.body).deep_symbolize_keys
end
