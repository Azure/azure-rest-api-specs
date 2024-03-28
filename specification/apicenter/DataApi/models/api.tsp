import "./workspace.tsp";

namespace ApiCenter.DataApi.Models;

using TypeSpec.Rest;

@doc("API resource model.")
@resource("apis")
model Api {
  @doc("Api identifier.")
  @maxLength(50)
  @key("apiName")
  @visibility
  name: string;

  @doc("The name of the API.")
  @maxLength(50)
  title: string;

  @doc("Short description of the API.")
  @maxLength(200)
  summary?: string;

  @doc("The description of the API")
  @maxLength(1000)
  description?: string;

  @doc("Kind of API. For example, REST or GraphQL.")
  kind: ApiKind;

  @doc("Current lifecycle stage of the API.")
  @visibility("read")
  lifecycleStage?: ApiLifecycleStage;

  @doc("Terms of service for the API.")
  termsOfService?: ApiTermsOfService;

  @doc("The license information for the API.")
  license?: ApiLicenseModel;

  @doc("External documentation")
  externalDocumentation?: ApiExternalDocumentation[];

  @doc("Points of contact for the API.")
  contacts?: Array<Contact>;

  @doc("The custom metadata defined for API entities.")
  customProperties?: {};

  @doc("Last updated date and time.")
  @visibility("read")
  lastUpdated?: utcDateTime;
}

@doc("API resource model (with full workspace route).")
@parentResource(Workspace)
model ApiWithWorkspace is Api;

@doc("Api External Documentation Model")
model ApiExternalDocumentation {
  @doc("Title of the documentation.")
  @maxLength(50)
  title: string;

  @doc("Description of the documentation.")
  @maxLength(1000)
  description: string;

  @doc("URL pointing to the documentation.")
  url: url;
}

@doc("API kind")
enum ApiKind {
  @doc("REST API")
  Rest: "rest",

  @doc("GraphQL API")
  Graphql: "graphql",

  @doc("GRPC API")
  Grpc: "grpc",

  @doc("SOAP API")
  Soap: "soap",

  @doc("Webhook API")
  Webhook: "webhook",

  @doc("Websocket API")
  Websocket: "websocket",
}

@doc("API Lifecycle Stage")
enum ApiLifecycleStage {
  @doc("API is in the design stage")
  Design: "design",

  @doc("API is in the development stage")
  Development: "development",

  @doc("API is in the testing stage")
  Testing: "testing",

  @doc("API is in the preview stage")
  Preview: "preview",

  @doc("API is in the production stage")
  Production: "production",

  @doc("API is in the deprecated stage")
  Deprecated: "deprecated",

  @doc("API is in the retired stage")
  Retired: "retired",
}

@doc("API contact information")
model Contact {
  @doc("Name of the contact.")
  @maxLength(100)
  name: string;

  @doc("URL for the contact.")
  url?: url;

  @doc("Email address for the contact.")
  @maxLength(100)
  email?: string;
}

@doc("API Terms of Service")
model ApiTermsOfService {
  @doc("URL pointing to the terms of service.")
  url: url;
}

@doc("API License Model")
model ApiLicenseModel {
  @doc("Name of the license.")
  @maxLength(50)
  name: string;

  @doc("URL pointing to the license details. The URL field is mutually exclusive of the identifier field.")
  url?: url;

  @doc("SPDX license information for the API. The identifier field is mutually exclusive of the URL field.")
  @maxLength(200)
  identifier?: string;
}
