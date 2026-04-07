import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MessagingCatalog;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The available API versions.
 */
enum Versions {
  @doc("The 2024-06-01-preview API version.")
  v2024_06_01_preview: "2024-06-01-preview",

  @doc("The 2024-10-01-preview API version.")
  v2024_10_01_preview: "2024-10-01-preview",

  @doc("The 2025-11-01-preview API version.")
  v2025_11_01_preview: "2025-11-01-preview",
}

@doc("Provisioning State")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is updating.")
  Updating: "Updating",

  @doc("Resource is deleting.")
  Deleting: "Deleting",
}

@doc("Fabric Private Links Actions")
@added(Versions.v2025_11_01_preview)
union FabricPrivateLinksAction {
  string,

  @doc("Enable private link.")
  Enable: "Enable",

  @doc("Disable private link.")
  Disable: "Disable",
}

/** State of the public network access. */
@added(Versions.v2025_11_01_preview)
union PublicNetworkAccess {
  string,

  /** The public network access is enabled. */
  Enabled: "Enabled",

  /** The public network access is disabled. */
  Disabled: "Disabled",
}

@doc("Details of the Message Catalog.")
model MessagingCatalogProperties {
  @doc("A unique absolute URL for an catalog.")
  @visibility(Lifecycle.Read)
  self?: string;

  @doc("A summary of the purpose of the catalog.")
  description?: string;

  @doc("A URL to additional information about this catalog.")
  documentation?: string;

  @doc("An array of additional metadata about the catalog.")
  @identifiers(#["name"])
  labels?: ResourceLabel[];

  @doc("A unique absolute URL for the list of endpoints for this catalog.")
  @visibility(Lifecycle.Read)
  endpointsUrl?: string;

  @doc("A count of the amount of endpoints in this catalog.")
  @visibility(Lifecycle.Read)
  endpointsCount?: int32;

  @doc("A unique absolute URL for the list of message groups for this catalog.")
  @visibility(Lifecycle.Read)
  messageGroupsUrl?: string;

  @doc("A count of the amount of message groups in this catalog.")
  @visibility(Lifecycle.Read)
  messageGroupsCount?: int32;

  @doc("A unique absolute URL for the list of schema groups for this catalog.")
  @visibility(Lifecycle.Read)
  schemaGroupsUrl?: string;

  @doc("A count of the amount of schema groups in this catalog.")
  @visibility(Lifecycle.Read)
  schemaGroupsCount?: int32;

  @doc("The provisioning state of the application rule collection resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** List of private endpoint connections. */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_11_01_preview)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /** Gets or sets allow or disallow public network access to resource. */
  @added(Versions.v2025_11_01_preview)
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Additional metadata about the entity.")
model ResourceLabel {
  @doc("The name of the metadata label.")
  name?: string;

  @doc("The value of the metadata label.")
  value?: string;
}

@doc("The type used for update operations of the Messaging Catalog.")
model MessagingCatalogUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The updatable properties of the Messaging Catalog.")
  properties?: MessagingCatalogUpdateProperties;
}

@doc("The updatable properties of the Messaging Catalog.")
model MessagingCatalogUpdateProperties {
  @doc("A summary of the purpose of the catalog.")
  description?: string;

  @doc("A URL to additional information about this catalog.")
  documentation?: string;

  @doc("An array of additional metadata about the catalog.")
  @identifiers(#["name"])
  labels?: ResourceLabel[];
}

@doc("Details about the error result.")
model ProblemDetails {
  @doc("Type of issue encountered.")
  type?: string;

  @doc("Title of issue encountered.")
  title?: string;

  @doc("Status code of issue encountered.")
  status?: int32;

  @doc("Brief description of issue encountered.")
  detail?: string;

  @doc("Details about the error result.")
  instance?: string;
}

@doc("An association between external entities and catalog resources.")
@added(Versions.v2024_10_01_preview)
model Association {
  @doc("Id of the association.")
  id?: string;

  @doc("Type of association.")
  associationType: string;

  @doc("Details about the Association.")
  definition: AssociationDefinition;
}

@doc("Details about the catalog association.")
@added(Versions.v2024_10_01_preview)
model AssociationDefinition {
  @doc("The tenant id to associate.")
  tenantId?: string;

  @doc("The workspace id to associate.")
  workspaceId?: string;

  @doc("The artifact id to associate.")
  artifactId?: string;

  @doc("The message group id to associate.")
  messageGroupId?: string;

  @doc("The schema group id to associate.")
  schemaGroupId?: string;
}

@doc("An request to remove an association.")
@added(Versions.v2024_10_01_preview)
model AssociationRemoveRequest {
  @doc("Id of the association, which by default is a guid.")
  associationId: string;
}

@doc("An request to paginate a list of result.")
@added(Versions.v2024_10_01_preview)
model AssociationListRequest {
  @doc("Controls how many results to skip.")
  skip?: int32;

  @doc("Controls how many results to retrieve.")
  top?: int32;
}

@doc("An response of paginated associations.")
@added(Versions.v2024_10_01_preview)
model AssociationListResponse {
  @doc("List of associations.")
  associations: Association[];
}

@doc("An response of a association deletion.")
@added(Versions.v2024_10_01_preview)
model AssociationDeleteResponse {
  @doc("A string detailing the result of the operation.")
  status: ProvisioningState;
}

@doc("A request to update Fabric Private Links on a Catalog.")
@added(Versions.v2025_11_01_preview)
model FabricPrivateLinksRequest {
  @doc("The action to perform on the Fabric Private Links.")
  action: FabricPrivateLinksAction;

  @doc("The fully qualified domain name of the fabric dataplane endpoint.")
  fabricFqdn: string;
}

@doc("An response of a Fabric Private Links request.")
@added(Versions.v2025_11_01_preview)
model FabricPrivateLinksResponse {
  @doc("The status of the Fabric Private Links request.")
  status: string;

  @doc("The private FQDN of the messaging catalog is redirecting to.")
  privateFqdn: string;
}
