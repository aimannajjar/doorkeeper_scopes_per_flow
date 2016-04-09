# Doorkeeper Scopes per Flow

This extension enables you to specify what scopes are available for each grant_type (flow). For example, suppose you want "client_credentials" flow to only be able to request "public" scope, whereas "password" authentication should be able to request "write" scope. Additionally, this extension allows you to specify the default scope for each grant_type (flow).


## Usage

Simply add the following gem to your Gemfile:
```ruby
gem "doorkeeper_scopes_per_flow"
```
And then run `bundle` (note: `doorkeeper` should already be in your Gemfile)

Next specify default scopes and allowed flows per scope in `config/initializers/doorkeeper.rb`:

```ruby
default_scopes  :public
optional_scopes :write

scopes_flows_whitelist :public => [:all], :write => [:password, :assertion]
flows_default_scopes :password => [:public, :write], :assertion => [:public, :write], :client_credentials => [:public]
```

1. `default_scopes` and `optional_scopes` are the standard Doorkeeper configurations, you should define all valid scopes first using those two settings. However, `default_scope` will ultimately be overridden based on your configuration of this extension

2. `scopes_flows_whitelist` is scope => [flows] map. The key should be a valid scope specified as explained in step 1. The values are arrays of grant_types that are allowed to access this scope. In our example, `public` scope is accessible to all flows, whereas `write` is only accessible to `password` and `assertion` flows. (NOTE: `assertion` flow is not a standard Doorkeeper flow but I'm using it here as an example only)

3. `flows_default_scopes` is flow => [scopes] map. The key is a grant_type/flow whereas values are the default scopes  granted by default in that flow when no specific scopes are requested.


