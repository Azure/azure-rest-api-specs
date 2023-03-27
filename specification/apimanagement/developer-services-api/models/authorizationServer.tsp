namespace DeveloperServicesApi.Models;

@doc("External OAuth authorization server settings.")
model AuthorizationServer {
  @doc("The unique identifier of the authorization server.")
  name: string;

  @doc("The human-readable name of the authorization server.")
  description: string;

  @doc("The client ID of the authorization server.")
  clientId: string;

  @doc("OAuth authorization endpoint <see cref=\"http://tools.ietf.org/html/rfc6749#section-3.2\"/>.")
  authorizationEndpoint: string;

  @doc("OAuth token endpoint. <see cref=\"http://tools.ietf.org/html/rfc6749#section-3.1\"/>.")
  tokenEndpoint: string;

  @doc("Scope applied by default on the console page. <see cref=\"http://tools.ietf.org/html/rfc6749#section-3.3\"/>.")
  defaultScope: string;

  @doc("Form of an authorization grant, which the client uses to request the access token. <see cref=\"http://tools.ietf.org/html/rfc6749#section-4\"/>.")
  grantTypes: GrantType[];

  @doc("Authorization Server may be used in the test console.")
  useInTestConsole: boolean;

  @doc("Authorization Server may be used in the API documentation.")
  useInApiDocumentation: boolean;
}
