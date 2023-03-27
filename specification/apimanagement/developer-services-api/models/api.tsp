import "./authenticationSettings.tsp";

namespace DeveloperServicesApi.Models;

@doc("API contract")
model Api {
  @doc("API identifier.")
  id: string;

  @doc("API name. Must be 1 to 300 characters long.")
  name: string;

  @doc("API description.")
  description: string;

  @doc("Specifies whether an API subscription is required for accessing the API.")
  subscriptionRequired?: boolean;

  @doc("Path for API requests.")
  path: string;

  @doc("Protocols over which API is made available.")
  protocols: ApiProtocol[];

  @doc("Collection of Tag Descriptions included into this API.")
  tagDescriptions?: TagDescription[];

  @doc("Collection of authentication settings included into this API.")
  authenticationSettings: AuthenticationSettings;

  @doc("Names of Subscription key parameters used by the API.")
  subscriptionKeyParameterNames: SubscriptionKeyParameterNames;

  @doc("A URL to the Terms of Service for the API. MUST be in the format of a URL.")
  termsOfServiceUrl?: string;

  @doc("Contact information for the exposed API.")
  contact?: ApiContact;

  @doc("License information for the exposed API.")
  license?: ApiLicense;

  @doc("Type of API.")
  type?: ApiType;

  @doc("API version name")
  apiVersion?: string;

  @doc("Api version description")
  apiVersionDescription?: string;

  @doc("Api version Set Identifier")
  apiVersionSetId: string;
}

@doc("API protocol information")
enum ApiProtocol {
  @doc("HTTP scheme will be supported for API")
  Http: "http",

  @doc("HTTPS scheme will be supported for API")
  Https: "https",

  @doc("WebSocket scheme will be supported for API")
  Ws: "ws",

  @doc("WebSocket Secure scheme will be supported for API")
  Wss: "wss",
}

@doc("Type of API")
enum ApiType {
  @doc("API is a REST API")
  Http: "http",

  @doc("API is a SOAP API")
  Soap: "soap",

  @doc("API is a WebSocket API")
  WebSocket: "websocket",

  @doc("API is a GraphQL API")
  GraphQL: "graphql",
}

@doc("API contact information")
model ApiContact {
  @doc("The identifying name of the contact person/organization.")
  @maxLength(128)
  name: string;

  @doc("The URL pointing to the contact information. MUST be in the format of a URL.")
  @maxLength(128)
  url: string;

  @doc("The email address of the contact person/organization. MUST be in the format of an email address.")
  @maxLength(128)
  email: string;
}

@doc("API license information")
model ApiLicense {
  @doc("The license name used for the API.")
  @maxLength(128)
  name: string;

  @doc("A URL to the license used for the API. MUST be in the format of a URL.")
  @maxLength(128)
  url: string;
}

@doc("Tag with description.")
model TagDescription {
  @doc("Tag description identifier.")
  id: string;

  @doc("Tag identifier.")
  tagId: string;

  @doc("Tag name. Must be 1 to 160 characters long.")
  name: string;

  @doc("Tag description. Must be 1 to 1000 characters long.")
  description: string;

  @doc("Tag external documentation description.")
  externalDocsDescription: string;

  @doc("Tag external documentation URL.")
  externalDocsUrl: string;
}

@doc("Subscription key parameter names.")
model SubscriptionKeyParameterNames {
  @doc("Subscription key header name.")
  header: string;

  @doc("Subscription key query string parameter name.")
  query: string;
}

@doc("A Schema used by an API.")
model ApiSchema {
  @doc("API schema identifier.")
  id: string;

  @doc("Media type of the schema document (e.g. application/json, application/xml).")
  contentType: string;

  @doc("The document representing the Schema.")
  document?: string;
}

@doc("API release information")
model ApiRelease {
  @doc("API release identifier.")
  id: string;

  @doc("Release creation date and time.")
  createdDateTime: zonedDateTime;

  @doc("Release update date and time.")
  updatedDateTime: zonedDateTime;

  @doc("Release notes.")
  notes: string;
}

@doc("API hostname information")
model ApiHostname {
  @doc("API hostname identifier.")
  id: string;

  @doc("Hostname value.")
  value: string;
}
