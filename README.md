# Yuza

Yuza is a user service.

```
         Prefix Verb   URI Pattern                Controller#Action
          users POST   /users(.:format)           users#create
           user GET    /users/:id(.:format)       users#show
                PATCH  /users/:id(.:format)       users#update
                PUT    /users/:id(.:format)       users#update
revoke_sessions DELETE /sessions/revoke(.:format) sessions#revoke
       sessions POST   /sessions(.:format)        sessions#create
        session GET    /sessions/:code(.:format)  sessions#show
```

Yuza is accessible through Netvice.
