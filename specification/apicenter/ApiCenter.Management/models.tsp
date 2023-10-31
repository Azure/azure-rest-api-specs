import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum MetadataAssignmentEntity {
  api,
  environment,
  deployment,
}

enum MetadataSchemaExportFormat {
  @doc("The inlined content of a schema document.") inline,
  @doc("The link to a schema document. The URL is valid for 5 minutes.") link,
}

enum ApiKind {
  rest,
  graphql,
  grpc,
  soap,
  webhook,
  websocket,
}

enum LifecycleStage {
  design,
  development,
  testing,
  preview,
  production,
  deprecated,
  retired,
}

enum ApiSpecImportSourceFormat {
  @doc("The inlined content of a specification document.") inline,
  @doc("""
The link to a specification document hosted on a publicly accessible internet
address.
""")
  link,
}

enum ApiSpecExportResultFormat {
  @doc("The inlined content of a specification document.") inline,
  @doc("The link to the result of the export operation. The URL is valid for 5 minutes.")
  link,
}

enum DeploymentState {
  active,
  inactive,
}

enum EnvironmentKind {
  development,
  testing,
  staging,
  production,
}

enum EnvironmentServerType {
  `Azure API Management`,
  `Azure compute service`,
  `Apigee API Management`,
  `AWS API Gateway`,
  `Kong API Gateway`,
  Kubernetes,
  `MuleSoft API Management`,
}

@doc("The properties of the service.")
model ServiceProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("The metadata schema export request.")
model MetadataSchemaExportRequest {
  @doc("An entity the metadata schema is requested for.")
  assignedTo?: MetadataAssignmentEntity;
}

@doc("The metadata schema export result.")
model MetadataSchemaExportResult {
  format?: MetadataSchemaExportFormat;

  @doc("The result of the export operation.")
  value?: string;
}

@doc("Metadata schema properties.")
model MetadataSchemaProperties {
  @doc("The schema defining the type.")
  schema: string;

  assignedTo?: MetadataAssignment[];
}

model MetadataAssignment {
  @doc("The entities this metadata schema component gets applied to.")
  entity?: MetadataAssignmentEntity;

  required?: boolean;
  deprecated?: boolean;
}

@doc("Workspace properties.")
model WorkspaceProperties {
  @doc("Workspace title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("Workspace description.")
  description?: string;
}

@doc("API properties.")
model ApiProperties {
  @doc("API title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("Kind of API. For example, REST or GraphQL.")
  kind: ApiKind;

  @doc("Description of the API.")
  @maxLength(1000)
  description?: string;

  @doc("Short description of the API.")
  @maxLength(200)
  summary?: string;

  @doc("Current lifecycle stage of the API.")
  @visibility("read")
  lifecycleStage?: LifecycleStage;

  @doc("Terms of service for the API.")
  termsOfService?: TermsOfService;

  externalDocumentation?: ExternalDocumentation[];
  contacts?: Contact[];

  @doc("The license information for the API.")
  license?: License;

  @doc("The custom metadata defined for API catalog entities.")
  customProperties?: Record<unknown>;
}

@doc("Terms of service for the API.")
model TermsOfService {
  @doc("URL pointing to the terms of service.")
  url: string;
}

@doc("Additional, external documentation for the API.")
model ExternalDocumentation {
  @doc("Title of the documentation.")
  @maxLength(50)
  title?: string;

  @doc("Description of the documentation.")
  @maxLength(500)
  description?: string;

  @doc("URL pointing to the documentation.")
  url: string;
}

model Contact {
  @doc("Name of the contact.")
  @maxLength(100)
  name?: string;

  @doc("URL for the contact.")
  url?: string;

  @doc("Email address of the contact.")
  @maxLength(100)
  email?: string;
}

@doc("The license information for the API.")
model License {
  @doc("Name of the license.")
  @maxLength(100)
  name?: string;

  @doc("""
URL pointing to the license details. The URL field is mutually exclusive of the
identifier field.
""")
  url?: string;

  @doc("""
SPDX license information for the API. The identifier field is mutually
exclusive of the URL field.
""")
  identifier?: string;
}

@doc("API version properties entity.")
model ApiVersionProperties {
  @doc("API version title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("Current lifecycle stage of the API.")
  lifecycleStage: LifecycleStage;
}

@doc("API definition properties entity.")
model ApiDefinitionProperties {
  @doc("API definition title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("API definition description.")
  description?: string;

  @doc("API specification details.")
  @visibility("read")
  specification?: ApiDefinitionPropertiesSpecification;
}

@doc("API specification details.")
model ApiDefinitionPropertiesSpecification {
  @doc("Specification name.")
  name?: string;

  @doc("Specification version.")
  version?: string;
}

@doc("The API specification source entity properties.")
model ApiSpecImportRequest {
  @doc("Value of the API specification source.")
  value?: string;

  @doc("Format of the API specification source.")
  format?: ApiSpecImportSourceFormat;

  @doc("API specification details.")
  specification?: ApiSpecImportRequestSpecification;
}

@doc("API specification details.")
model ApiSpecImportRequestSpecification {
  @doc("Specification name.")
  name?: string;

  @doc("Specification version.")
  version?: string;
}

@doc("The API specification export result.")
model ApiSpecExportResult {
  format?: ApiSpecExportResultFormat;

  @doc("The result of the export operation.")
  value?: string;
}

@doc("API deployment entity properties.")
model DeploymentProperties {
  @doc("API deployment title")
  @maxLength(50)
  @minLength(1)
  title?: string;

  @doc("Description of the deployment.")
  @maxLength(500)
  description?: string;

  @doc("API center-scoped environment resource ID.")
  environmentId?: string;

  @doc("API center-scoped definition resource ID.")
  definitionId?: string;

  @doc("State of API deployment.")
  state?: DeploymentState;

  @doc("Server")
  server?: DeploymentServer;

  @doc("The custom metadata defined for API catalog entities.")
  customProperties?: Record<unknown>;
}

@doc("Server")
model DeploymentServer {
  @doc("Base runtime URLs for this deployment.")
  runtimeUri?: string[];
}

@doc("Environment properties entity.")
model EnvironmentProperties {
  @doc("Environment title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("Description.")
  description?: string;

  @doc("Environment kind.")
  kind: EnvironmentKind;

  @doc("Server information of the environment.")
  server?: EnvironmentServer;

  onboarding?: Onboarding;

  @doc("The custom metadata defined for API catalog entities.")
  customProperties?: Record<unknown>;
}

@doc("Server information of the environment.")
model EnvironmentServer {
  @doc("Type of the server that represents the environment.")
  type?: EnvironmentServerType;

  managementPortalUri?: string[];
}

model Onboarding {
  @doc("Onboarding guide.")
  instructions?: string;

  developerPortalUri?: string[];
}
