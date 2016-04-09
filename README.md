# Doorkeeper Scopes per Flow

This extension enables you to specify what scopes are available for each grant_type (flow). For example, suppose you want "client_credentials" flow to only be able to request "public" scope, whereas "password" authentication should be able to request "write" scope. Additionally, this extension allows you to specify the default scope for each grant_type (flow).


## Usage

Simply add the following gem to your Gemfile:
```ruby
gem "doorkeeper_scopes_per_flow"
```
And then run `bundle` (note: `doorkeeper` should already be in your Gemfile)

Next, add the field as follows in your `config/initializers/doorkeeper.rb`

```ruby
default_scopes  :public
optional_scopes :write

scopes_flows_whitelist :public => [:all], :write => [:password, :assertion]
flows_default_scopes :password => [:public, :write], :assertion => [:public, :write], :client_credentials => [:public]
```



