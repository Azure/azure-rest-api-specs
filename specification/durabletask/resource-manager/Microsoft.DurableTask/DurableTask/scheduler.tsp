import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DurableTask;

model SchedulerPrivateLinkResource is PrivateLink;
alias PrivateLinkOperations = PrivateLinks<SchedulerPrivateLinkResource>;

model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@doc("A Durable Task Scheduler resource")
@added(Versions.v2024_10_01_Preview)
model Scheduler is Azure.ResourceManager.TrackedResource<SchedulerProperties> {
  ...ResourceNameParameter<
    Scheduler,
    "schedulerName",
    "schedulers",
    "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...ManagedServiceIdentityProperty;
}

@@added(Scheduler.identity, Versions.v2026_05_01_Preview);

@doc("Details of the Scheduler")
@added(Versions.v2024_10_01_Preview)
model SchedulerProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler")
  @visibility(Lifecycle.Read)
  endpoint?: string;

  @doc("IP allow list for durable task scheduler. Values can be IPv4, IPv6 or CIDR")
  ipAllowlist: string[];

  @doc("SKU of the durable task scheduler")
  sku: SchedulerSku;

  @added(Versions.v2026_02_01)
  @doc("Allow or disallow public network access to durable task scheduler")
  publicNetworkAccess?: PublicNetworkAccess;

  /** The private endpoints exposed by this resource */
  @added(Versions.v2026_02_01)
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("The SKU (Stock Keeping Unit) assigned to this durable task scheduler")
@added(Versions.v2024_10_01_Preview)
model SchedulerSku {
  @doc("The name of the SKU")
  @typeChangedFrom(Versions.v2025_11_01, string)
  name: SchedulerSkuName;

  @doc("The SKU capacity. This allows scale out/in for the resource and impacts zone redundancy")
  capacity?: int32;

  @doc("Indicates whether the current SKU configuration is zone redundant")
  @visibility(Lifecycle.Read)
  redundancyState?: RedundancyState;
}

@added(Versions.v2025_11_01)
@doc("The name of the Stock Keeping Unit (SKU) of a Durable Task Scheduler")
union SchedulerSkuName {
  string,

  @doc("Dedicated SKU")
  Dedicated: "Dedicated",

  @doc("Consumption SKU")
  @added(Versions.v2025_04_01_Preview)
  Consumption: "Consumption",
}

@doc("The state of the resource redundancy")
union RedundancyState {
  string,

  @doc("The resource is not redundant")
  None: "None",

  @doc("The resource is zone redundant")
  Zone: "Zone",
}

@doc("State of the public network access.")
@added(Versions.v2026_02_01)
union PublicNetworkAccess {
  string,

  @doc("The public network access is enabled")
  Enabled: "Enabled",

  @doc("The public network access is disabled")
  Disabled: "Disabled",
}

@doc("The update request model for the Scheduler resource")
model SchedulerUpdate
  is UpdateableProperties<Azure.ResourceManager.TrackedResource<SchedulerPropertiesUpdate>> {
  ...ManagedServiceIdentityProperty;
}

@@added(SchedulerUpdate.identity, Versions.v2026_05_01_Preview);

@doc("The Scheduler resource properties to be updated")
model SchedulerPropertiesUpdate {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler")
  @visibility(Lifecycle.Read)
  endpoint?: string;

  @doc("IP allow list for durable task scheduler. Values can be IPv4, IPv6 or CIDR")
  ipAllowlist?: string[];

  @doc("SKU of the durable task scheduler")
  sku?: SchedulerSkuUpdate;

  @added(Versions.v2026_02_01)
  @doc("Allow or disallow public network access to durable task scheduler")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("The SKU (Stock Keeping Unit) properties to be updated")
model SchedulerSkuUpdate {
  @doc("The name of the SKU")
  @typeChangedFrom(Versions.v2025_11_01, string)
  name?: SchedulerSkuName;

  @doc("The SKU capacity. This allows scale out/in for the resource and impacts zone redundancy")
  capacity?: int32;

  @doc("Indicates whether the current SKU configuration is zone redundant")
  @visibility(Lifecycle.Read)
  redundancyState?: RedundancyState;
}

@armResourceOperations(Scheduler)
interface Schedulers {
  @doc("Get a Scheduler")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<Scheduler>;
  @doc("Create or update a Scheduler")
  @errorsDoc("Validation error: required parameters are missing")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Scheduler>;
  @doc("Update a Scheduler")
  @errorsDoc("Validation error: required parameters are missing")
  update is ArmCustomPatchAsync<Scheduler, SchedulerUpdate>;
  @doc("Delete a Scheduler")
  delete is ArmResourceDeleteWithoutOkAsync<Scheduler>;
  @doc("List Schedulers by resource group")
  listByResourceGroup is ArmResourceListByParent<Scheduler>;
  @doc("List Schedulers by subscription")
  listBySubscription is ArmListBySubscription<Scheduler>;

  @added(Versions.v2026_02_01)
  @doc("Get a private link resource for the durable task scheduler")
  getPrivateLink is PrivateLinkOperations.Read<Scheduler>;
  @added(Versions.v2026_02_01)
  @doc("List private link resources for the durable task scheduler")
  listPrivateLinks is PrivateLinkOperations.ListByParent<Scheduler>;

  @added(Versions.v2026_02_01)
  @doc("Get a private endpoint connection for the durable task scheduler")
  getPrivateEndpointConnection is PrivateEndpointOperations.Read<Scheduler>;
  @added(Versions.v2026_02_01)
  @doc("Create or update a private endpoint connection for the durable task scheduler")
  createOrUpdatePrivateEndpointConnection is PrivateEndpointOperations.CreateOrUpdateAsync<Scheduler>;
  @added(Versions.v2026_02_01)
  @doc("Update a private endpoint connection for the durable task scheduler")
  updatePrivateEndpointConnection is PrivateEndpointOperations.CustomPatchAsync<Scheduler>;
  @added(Versions.v2026_02_01)
  @doc("Delete a private endpoint connection for the durable task scheduler")
  deletePrivateEndpointConnection is PrivateEndpointOperations.DeleteAsync<Scheduler>;
  @added(Versions.v2026_02_01)
  @doc("List private endpoint connections for the durable task scheduler")
  listPrivateEndpointConnections is PrivateEndpointOperations.ListByParent<Scheduler>;

  @added(Versions.v2026_05_01_Preview)
  @doc("Restart a Scheduler")
  restart is ArmResourceActionSync<Scheduler, void, void>;
}
