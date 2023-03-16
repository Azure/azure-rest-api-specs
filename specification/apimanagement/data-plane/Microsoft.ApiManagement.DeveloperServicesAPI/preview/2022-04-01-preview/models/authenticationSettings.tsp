namespace DeveloperServicesAPI.Models;

@doc("Authentication settings.")
model AuthenticationSettings {
  oAuth2AuthenticationSettings: OAuth2AuthenticationSettings;
  openidAuthenticationSettings: OpenidAuthenticationSettings;
  subscriptionKeyRequired?: boolean;
}

model OAuth2AuthenticationSettings {
  authorizationServerId: string;
  scope: string;
  authorizationServer?: OAuth2AuthorizationServer;
}

model OAuth2AuthorizationServer {
  id: string;
  name: string;
  description: string;
  clientRegistrationEndpoint: string;
  authorizationEndpoint: string;
  authorizationMethods: Method[];
  clientAuthenticationMethod: ClientAuthenticationMethod[];
  tokenBodyParameters: NameValuePair[];
  tokenEndpoint: string;
  useInTestConsole?: boolean;
  useInApiDocumentation?: boolean;
  supportState: boolean;
  defaultScope: string;
  grantTypes: GrantType[];
  bearerTokenSendingMethods: BearerTokenSendingMethod[];
  clientId: string;
  resourceOwnerUsername: string;
  resourceOwnerPassword: string;
}

model OpenidAuthenticationSettings {
  openidProviderId: string;
  bearerTokenSendingMethods: BearerTokenSendingMethod[];
  openidConnectProvider?: OpenidConnectProvider;
}

model OpenidConnectProvider {
  id: string;
  name: string;
  description: string;
  metadataEndpoint: string;
  useInTestConsole?: boolean;
  useInApiDocumentation?: boolean;
  clientId: string;
}

enum ClientAuthenticationMethod {
  Basic: "Basic",
  Body: "Body",
}

enum GrantType {
  AuthorizationCode: "authorizationCode",
  Implicit: "implicit",
  ResourceOwnerPassword: "resourceOwnerPassword",
  ClientCredentials: "clientCredentials",
  AuthorizationCodeWithPkce: "authorizationCodeWithPkce",
}

enum BearerTokenSendingMethod {
  AuthorizationHeader: "authorizationHeader",
  Query: "query",
}

enum Method {
  Head: "HEAD",
  Get: "GET",
  Post: "POST",
  Put: "PUT",
  Patch: "PATCH",
  Delete: "DELETE",
  Options: "OPTIONS",
  Trace: "TRACE",
  Connect: "CONNECT",
}
