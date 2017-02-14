Doorkeeper::TokensController.class_eval do
  def strategy
    if (!params.has_key?(:scope) &&
        !Doorkeeper.configuration.flows_default_scopes.nil? &&
        Doorkeeper.configuration.flows_default_scopes.has_key?(params[:grant_type].to_sym))
      params[:scope] = Doorkeeper.configuration.flows_default_scopes[params[:grant_type].to_sym].join(" ")
      puts "WARNING: params[:scope] has been defaulted to #{params[:scope]}"
    end

    if !params.has_key?(:scope)
      @strategy = server.token_request params[:grant_type]
    else
      @strategy = server.token_request params[:grant_type], params[:scope]
    end
  end
end
