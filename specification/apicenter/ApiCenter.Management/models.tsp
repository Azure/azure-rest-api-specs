import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ApiCenter;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The odata filter")
model OdataFilterParameter {
  @doc("OData filter parameter.")
  @query("$filter")
  filter?: string;
}

/** The expected types of origin */
union Origin {
  string,

  /** Origin with User */
  "user",

  /** Origin with System */
  "system",

  /** Origin with user and system */
  "user,system",
}

/** The type of action */
union ActionType {
  string,

  /** an internal action */
  "Internal",
}

/** The provisioning state of the resource */
union ProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,
}

/** The type of managed service identity */
union ManagedServiceIdentityType {
  string,

  /** No identity */
  "None",

  /** Assigned by the system */
  "SystemAssigned",

  /** assigned by the user */
  "UserAssigned",

  /** Both system-assigned and user-assigned identities */
  "SystemAssigned,UserAssigned",
}

/** How the resource was created */
union CreatedByType {
  string,

  /** Created by user */
  "User",

  /** Created by Application */
  "Application",

  /** Created by Managed Identity */
  "ManagedIdentity",

  /** Created By Key */
  "Key",
}

/** Assignment entity for Metadata */
union MetadataAssignmentEntity {
  string,

  /** Assigned to API */
  "api",

  /** Assigned to Environment */
  "environment",

  /** Assigned to Deployment */
  "deployment",
}

/** The format for schema export */
union MetadataSchemaExportFormat {
  string,

  @doc("The inlined content of a schema document.")
  "inline",

  @doc("The link to a schema document. The URL is valid for 5 minutes.")
  "link",
}

/** The kind of the API */
union ApiKind {
  string,

  /** A Representational State Transfer Api */
  "rest",

  /** A Graph query language Api */
  "graphql",

  /** A gRPC Api */
  "grpc",

  /** A SOAP Api */
  "soap",

  /** Web Hook */
  "webhook",

  /** Web Socket */
  "websocket",
}

/** The stage of the Api development lifecycle */
union LifecycleStage {
  string,

  /** design stage */
  "design",

  /** development stage */
  "development",

  /** testing stage */
  "testing",

  /** In preview */
  "preview",

  /** In production */
  "production",

  /** deprecated stage */
  "deprecated",

  /** Retired stage */
  "retired",
}

/** Source format for imported Api spec */
union ApiSpecImportSourceFormat {
  string,
  @doc("The inlined content of a specification document.") "inline",

  @doc("""
The link to a specification document hosted on a publicly accessible internet
address.
""")
  "link",
}

/** Result format for exported Api spec */
union ApiSpecExportResultFormat {
  string,
  @doc("The inlined content of a specification document.") "inline",

  @doc("The link to the result of the export operation. The URL is valid for 5 minutes.")
  "link",
}

/** State of the Deployment */
union DeploymentState {
  string,

  /** Active State */
  "active",

  /** Inactive State */
  "inactive",
}

/** The kind of environment */
union EnvironmentKind {
  string,

  /** Development environment */
  "development",

  /** Testing environment */
  "testing",

  /** Staging environment */
  "staging",

  /** Production environment */
  "production",
}

/** The type of environment server */
union EnvironmentServerType {
  string,

  /** Api Management Server */
  "Azure API Management",

  /** Compute server */
  "Azure compute service",

  /** Apigee server */
  "Apigee API Management",

  /** AWS Api Gateway server */
  "AWS API Gateway",

  /** Kong API Gateway server */
  "Kong API Gateway",

  /** Kubernetes server */
  "Kubernetes",

  /** Mulesoft Api Management server */
  "MuleSoft API Management",
}

@doc("The properties of the service.")
model ServiceProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @added(Versions.v2024_03_15_preview)
  @doc("Flag used to restore soft-deleted API Center service. If specified and set to 'true' all other properties will be ignored.")
  restore?: boolean = false;
}

@doc("The metadata schema export request.")
model MetadataSchemaExportRequest {
  @doc("An entity the metadata schema is requested for.")
  assignedTo?: MetadataAssignmentEntity;
}

@doc("The metadata schema export result.")
model MetadataSchemaExportResult {
  @doc("The export format for the schema")
  format?: MetadataSchemaExportFormat;

  @doc("The result of the export operation.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
@doc("Metadata schema properties.")
model MetadataSchemaProperties {
  @doc("The schema defining the type.")
  schema: string;

  @doc("The assignees")
  @extension("x-ms-identifiers", [])
  assignedTo?: MetadataAssignment[];
}

@doc("Assignment metadata")
model MetadataAssignment {
  @doc("The entities this metadata schema component gets applied to.")
  entity?: MetadataAssignmentEntity;

  @doc("Required assignment")
  required?: boolean;

  @doc("Deprecated assignment")
  deprecated?: boolean;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
@doc("Workspace properties.")
model WorkspaceProperties {
  @doc("Workspace title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("Workspace description.")
  description?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
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

  @doc("The set of external documentation")
  @maxItems(20)
  @extension("x-ms-identifiers", [])
  externalDocumentation?: ExternalDocumentation[];

  @doc("The set of contacts")
  @extension("x-ms-identifiers", [])
  contacts?: Contact[];

  @doc("The license information for the API.")
  license?: License;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing spec"
  @doc("The custom metadata defined for API catalog entities.")
  customProperties?: CustomProperties;
}

@doc("Terms of service for the API.")
model TermsOfService {
  @doc("URL pointing to the terms of service.")
  @maxLength(200)
  url: url;
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
  @maxLength(200)
  url: url;
}

@doc("Contact information")
model Contact {
  @doc("Name of the contact.")
  @maxLength(100)
  name?: string;

  @doc("URL for the contact.")
  @maxLength(200)
  url?: url;

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
  @maxLength(200)
  url?: url;

  @doc("""
SPDX license information for the API. The identifier field is mutually
exclusive of the URL field.
""")
  @maxLength(50)
  identifier?: url;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
@doc("API version properties entity.")
model ApiVersionProperties {
  @doc("API version title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("Current lifecycle stage of the API.")
  lifecycleStage: LifecycleStage;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
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
  @doc("The format of exported result")
  format?: ApiSpecExportResultFormat;

  @doc("The result of the export operation.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
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

  @doc("The deployment server")
  server?: DeploymentServer;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing spec"
  @doc("The custom metadata defined for API catalog entities.")
  customProperties?: CustomProperties;
}

@summary("Custom Properties")
@doc("The custom metadata defined for API catalog entities.")
model CustomProperties {}

@doc("Server")
model DeploymentServer {
  @doc("Base runtime URLs for this deployment.")
  runtimeUri?: SmallString[];
}

/** Used for restricted length uris */
@maxLength(200)
scalar SmallString extends url;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
@doc("Environment properties entity.")
model EnvironmentProperties {
  @doc("Environment title.")
  @maxLength(50)
  @minLength(1)
  title: string;

  @doc("The environment description.")
  description?: string;

  @doc("Environment kind.")
  kind: EnvironmentKind;

  @doc("Server information of the environment.")
  server?: EnvironmentServer;

  @doc("Environment onboarding information")
  onboarding?: Onboarding;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing spec"
  @doc("The custom metadata defined for API catalog entities.")
  customProperties?: CustomProperties;
}

@doc("Server information of the environment.")
model EnvironmentServer {
  @doc("Type of the server that represents the environment.")
  type?: EnvironmentServerType;

  @maxItems(1)
  @doc("The location of the management portal")
  managementPortalUri?: string[];
}

@doc("Onboarding information")
model Onboarding {
  @doc("Onboarding guide.")
  instructions?: string;

  @maxItems(1)
  @doc("The location of the development portal")
  developerPortalUri?: string[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
@added(Versions.v2024_03_15_preview)
@doc("Deleted service properties.")
model DeletedServiceProperties {
  @doc("UTC date and time when the service will be automatically purged. The date conforms to the following format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.")
  scheduledPurgeDate?: utcDateTime;

  @doc("UTC date and time when the service was soft-deleted. The date conforms to the following format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.")
  softDeletionDate?: utcDateTime;
}
