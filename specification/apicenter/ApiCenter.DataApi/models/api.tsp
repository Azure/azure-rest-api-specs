import "./workspace.tsp";

namespace ApiCenter.DataApi;

using TypeSpec.Rest;

@doc("Paged collection of API items across workspaces.")
model PagedApiAll {
  ...Azure.Core.Page<Api>;
}

@doc("API resource model.")
@parentResource(Workspace)
@resource("apis")
model Api {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "FIXME: misused @visibility to get around this warning"
  @doc("Api identifier.")
  @maxLength(50)
  @key("apiName")
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
  @visibility(Lifecycle.Read)
  lifecycleStage?: LifecycleStage;

  @doc("Terms of service for the API.")
  termsOfService?: TermsOfService;

  @doc("The license information for the API.")
  license?: License;

  @doc("External documentation")
  externalDocumentation?: ExternalDocumentation[];

  @doc("Points of contact for the API.")
  contacts?: Contact[];

  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with existing swagger."
  @doc("The custom metadata defined for API entities.")
  customProperties?: {};

  @doc("Last updated date and time.")
  @visibility(Lifecycle.Read)
  lastUpdated?: utcDateTime;
}

@doc("Api External Documentation Model")
model ExternalDocumentation {
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
union ApiKind {
  string,

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
union LifecycleStage {
  string,

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
model TermsOfService {
  @doc("URL pointing to the terms of service.")
  url: url;
}

@doc("API License Model")
model License {
  @doc("Name of the license.")
  @maxLength(50)
  name: string;

  @doc("URL pointing to the license details. The URL field is mutually exclusive of the identifier field.")
  url?: url;

  @doc("SPDX license information for the API. The identifier field is mutually exclusive of the URL field.")
  @maxLength(200)
  identifier?: string;
}
