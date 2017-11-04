# Yuza

Yuza is a user service.

```
             Prefix Verb   URI Pattern                          Controller#Action
       users_signin GET    /users/signin(.:format)              users#signin
       users_signup GET    /users/signup(.:format)              users#signup
          api_users POST   /api/users(.:format)                 api/users#create
           api_user GET    /api/users/:id(.:format)             api/users#show
                    PATCH  /api/users/:id(.:format)             api/users#update
                    PUT    /api/users/:id(.:format)             api/users#update
 revoke_api_session DELETE /api/sessions/:code/revoke(.:format) api/sessions#revoke
       api_sessions POST   /api/sessions(.:format)              api/sessions#create
        api_session GET    /api/sessions/:code(.:format)        api/sessions#show
api_action_requests POST   /api/action_requests(.:format)       api/action_requests#create
```

Yuza is accessible through Netvice.

## Architecture in Nutshell

Yuza is created with high reusability in mind first, and extensibility second.
Basic premises:

- Yuza is a single-service that can be used by a lot of different apps with their
  own differing set of users (users are not sharing).
- Same user in different app can have different password.
- Yuza does not handle session of its client applications.
- Yuza does handle signup with Facebook.
- Some request needs to generate a request token before it can be made/executed

## Request that needs token

Yuza requires a token to be generated in advance before doing the following requests
through its user interface:

- Signup
- Signin
- Forget password

Netvice will internally handle generating such request behind the scene. However,
creating user, getting the user data, and changing password and also creating
session through API necessitate no token.
