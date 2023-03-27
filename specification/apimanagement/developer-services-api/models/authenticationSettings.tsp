namespace DeveloperServicesApi.Models;

@doc("Authentication settings.")
model AuthenticationSettings {
  @doc("Collection of OAuth2 authentication settings included into this API.")
  oAuth2AuthenticationSettings: OAuth2AuthenticationSettings[];

  @doc("Collection of OpenID Connect authentication settings included into this API.")
  openidAuthenticationSettings: OpenidAuthenticationSettings[];

  @doc("Specifies whether subscription key is required during call to this API, true - API is included into closed products only, false - API is included into open products alone, null - there is a mix of products.")
  subscriptionKeyRequired?: boolean;
}

@doc("OAuth2 authentication settings.")
model OAuth2AuthenticationSettings {
  @doc("OAuth2 authorization server identifier.")
  authorizationServerId: string;

  @doc("Operations scope.")
  scope: string;

  @doc("OAuth2 authorization server.")
  authorizationServer?: OAuth2AuthorizationServer;
}

@doc("OAuth2 authorization server.")
model OAuth2AuthorizationServer {
  @doc("OAuth2 authorization server identifier.")
  id: string;

  @doc("OAuth2 authorization server name.")
  name: string;

  @doc("OAuth2 authorization server description.")
  description: string;

  @doc("OAuth2 authorization server client registration endpoint.")
  clientRegistrationEndpoint: string;

  @doc("OAuth2 authorization server authorization endpoint <see cref=\"http://tools.ietf.org/html/rfc6749#section-3.2\"/>.")
  authorizationEndpoint: string;

  @doc("Supported methods of authorization.")
  authorizationMethods: Method[];

  @doc("Supported methods of authentication.")
  clientAuthenticationMethod: ClientAuthenticationMethod[];

  @doc("Token request body parameters.")
  tokenBodyParameters: NameValuePair[];

  @doc("OAuth token endpoint. <see cref=\"http://tools.ietf.org/html/rfc6749#section-3.1\"/>.")
  tokenEndpoint: string;

  @doc("Authorization Server may be used in the test console.")
  useInTestConsole?: boolean;

  @doc("Authorization Server may be used in the API documentation.")
  useInApiDocumentation?: boolean;

  @doc("Authorization Server may support client credentials in body by spec. <see cref=\"http://tools.ietf.org/html/rfc6749#section-3.1\"/>.")
  supportState: boolean;

  @doc("Scope that is going to applied by default on the console page. <see cref=\"http://tools.ietf.org/html/rfc6749#section-3.3\"/>.")
  defaultScope: string;

  @doc("Form of an authorization grant, which the client uses to request the access token. <see cref=\"http://tools.ietf.org/html/rfc6749#section-4\"/>.")
  grantTypes: GrantType[];

  @doc("Form of an authorization grant, which the client uses to request the access token. <see cref=\"http://tools.ietf.org/html/rfc6749#section-4\"/>.")
  bearerTokenSendingMethods: BearerTokenSendingMethod[];

  @doc("Client ID of developer console which is the client application.")
  clientId: string;

  @doc("Username of the resource owner on behalf of whom developer console will make requests.")
  resourceOwnerUsername: string;

  @doc("Password of the resource owner on behalf of whom developer console will make requests.")
  resourceOwnerPassword: string;
}

@doc("OpenID Connect authentication settings.")
model OpenidAuthenticationSettings {
  @doc("OpenID Connect provider identifier.")
  openidProviderId: string;

  @doc("How to send token to the server.")
  bearerTokenSendingMethods: BearerTokenSendingMethod[];

  @doc("OpenID Connect provider.")
  openidConnectProvider?: OpenidConnectProvider;
}

@doc("OpenID Connect Provider settings.")
model OpenidConnectProvider {
  @doc("OpenID Connect Provider identifier.")
  id: string;

  @doc("OpenID Connect Provider name.")
  name: string;

  @doc("OpenID Connect Provider description.")
  description: string;

  @doc("OpenID Connect Provider metadata endpoint.")
  metadataEndpoint: string;

  @doc("Open Id Connect Provider may be used in the test console.")
  useInTestConsole?: boolean;

  @doc("Open Id Connect Provider may be used in the API documentation.")
  useInApiDocumentation?: boolean;

  @doc("Client ID of developer console which is the client application.")
  clientId: string;
}

@doc("Supported methods of authorization.")
enum ClientAuthenticationMethod {
  @doc("Client authentication information will be transmitted in the Authorization header using Basic schema.")
  Basic: "Basic",

  @doc("Client authentication information will be transmitted as www-url-form-encoded body parameter.")
  Body: "Body",
}

@doc("Form of an authorization grant, which the client uses to request the access token. <see cref=\"http://tools.ietf.org/html/rfc6749#section-4\"/>.")
enum GrantType {
  @doc("<see cref=\"http://tools.ietf.org/html/rfc6749#section-4.1\"/>")
  AuthorizationCode: "authorizationCode",

  @doc("<see cref=\"http://tools.ietf.org/html/rfc6749#section-4.2\"/>")
  Implicit: "implicit",

  @doc("<see cref=\"http://tools.ietf.org/html/rfc6749#section-4.3\"/>")
  ResourceOwnerPassword: "resourceOwnerPassword",

  @doc("<see cref=\"http://tools.ietf.org/html/rfc6749#section-4.4\"/>")
  ClientCredentials: "clientCredentials",

  @doc("<see cref=\"http://tools.ietf.org/html/rfc7636\"/>")
  AuthorizationCodeWithPkce: "authorizationCodeWithPkce",
}

@doc("Form of an authorization grant, which the client uses to request the access token.")
enum BearerTokenSendingMethod {
  @doc("Access token will be transmitted in the Authorization header using Bearer schema.")
  AuthorizationHeader: "authorizationHeader",

  @doc("Access token will be transmitted as query parameter.")
  Query: "query",
}

@doc("HTTP Method.")
enum Method {
  @doc("HTTP HEAD method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.4\"/>")
  Head: "HEAD",

  @doc("HTTP GET method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.3\"/>")
  Get: "GET",

  @doc("HTTP POST method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.5\"/>")
  Post: "POST",

  @doc("HTTP PUT method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.6\"/>")
  Put: "PUT",

  @doc("HTTP PATCH method.")
  Patch: "PATCH",

  @doc("HTTP DELETE method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.7\"/>")
  Delete: "DELETE",

  @doc("HTTP OPTIONS method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.2\"/>")
  Options: "OPTIONS",

  @doc("HTTP TRACE method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.8\"/>")
  Trace: "TRACE",

  @doc("HTTP CONNECT method. <see cref=\"http://tools.ietf.org/html/rfc2616#section-9.9\"/>")
  Connect: "CONNECT",
}
