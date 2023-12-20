import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("An Azure Monitor PrivateLinkScope definition.")
model MonitorPrivateLinkScope
  is TrackedResource<AzureMonitorPrivateLinkScopeProperties> {
  @doc("The name of the Azure Monitor PrivateLinkScope resource.")
  @path
  @key("scopeName")
  @segment("privateLinkScopes")
  name: string;
}

@armResourceOperations
interface MonitorPrivateLinkScopes {
  @doc("Returns a Azure Monitor PrivateLinkScope.")
  get is ArmResourceRead<MonitorPrivateLinkScope>;
  @doc("Creates (or updates) a Azure Monitor PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MonitorPrivateLinkScope>;
  @doc("Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.")
  updateTags is ArmTagsPatchSync<MonitorPrivateLinkScope>;
  @doc("Deletes a Azure Monitor PrivateLinkScope.")
  delete is ArmResourceDeleteAsync<MonitorPrivateLinkScope>;
  @doc("Gets a list of Azure Monitor PrivateLinkScopes within a resource group.")
  listByResourceGroup is ArmResourceListByParent<MonitorPrivateLinkScope>;
  @doc("Gets a list of all Azure Monitor PrivateLinkScopes within a subscription.")
  list is ArmListBySubscription<MonitorPrivateLinkScope>;
}
