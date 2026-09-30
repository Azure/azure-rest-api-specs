import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.DatabaseWatcher;

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;

@armResourceOperations
interface SharedPrivateLinkResources {
  get is ArmResourceRead<SharedPrivateLinkResource>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    SharedPrivateLinkResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SharedPrivateLinkResource>;
  listByWatcher is ArmResourceListByParent<SharedPrivateLinkResource>;
}

@parentResource(Watcher)
model SharedPrivateLinkResource
  is ProxyResource<SharedPrivateLinkResourceProperties> {
  @doc("The Shared Private Link resource name.")
  @key("sharedPrivateLinkResourceName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_.]{0,62}[a-zA-Z0-9_]{1}$")
  @segment("sharedPrivateLinkResources")
  @path
  name: string;
}

@doc("The generic properties of a Shared Private Link resource.")
model SharedPrivateLinkResourceProperties {
  @doc("The resource ID of the resource the shared private link resource is for.")
  privateLinkResourceId: Azure.Core.armResourceIdentifier;

  @doc("The group id from the provider of resource the shared private link resource is for.")
  groupId: string;

  @doc("The request message for requesting approval of the shared private link resource.")
  requestMessage: string;

  @doc("The DNS zone segment to be included in the DNS name of the shared private link. Value is required for Azure Data Explorer clusters and SQL managed instances, and must be omitted for SQL logical servers and key vaults. The value is the second segment of the host FQDN name of the resource that the shared private link resource is for. For example: if the host name is 'adx-cluster-21187695.eastus.kusto.windows.net', then the value is 'eastus'; if the host name is 'sql-mi-23961134.767d5869f605.database.windows.net', then the value is '767d5869f605'.")
  dnsZone?: string;

  @visibility(Lifecycle.Read)
  @doc("Status of the shared private link resource. Can be Pending, Approved, Rejected or Disconnected.")
  status?: SharedPrivateLinkResourceStatus;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ResourceProvisioningState;
}

@doc("Status of the shared private link resource. Can be Pending, Approved, Rejected or Disconnected.")
union SharedPrivateLinkResourceStatus {
  string,

  @doc("The shared private link connection request was not yet authorized by the resource owner.")
  Pending: "Pending",

  @doc("The shared private link connection request was approved by the resource owner.")
  Approved: "Approved",

  @doc("The shared private link connection request was rejected by the resource owner.")
  Rejected: "Rejected",

  @doc("The shared private link connection request was disconnected by the resource owner.")
  Disconnected: "Disconnected",
}
