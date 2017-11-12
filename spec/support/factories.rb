def user_attributes
  {
    name: 'Adam',
    email: 'adam@netinmax.com',
    password: 'Password01'
  }
end

def build_user(host: create_host)
  user = User.new(user_attributes)
  user.host = host
  user
end

def create_user(host: create_host)
  u = build_user(host: host); u.save!; u
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
