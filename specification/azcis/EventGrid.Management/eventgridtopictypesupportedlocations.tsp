import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("EventGridTopicTypeSupportedLocations properties")
model EventGridTopicTypeSupportedLocationsResourceProperties {
  @doc("Name of the Topic Type. Required.")
  topicTypeName: string;

  @doc("List of supported locations for the Topic Type. Required.")
  supportedLocations: Array<string>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: EventGridProvisioningState;
}

@doc("EventGridTopicTypeSupportedLocations Resource")
model EventGridTopicTypeSupportedLocationsResource
  is ProxyResource<EventGridTopicTypeSupportedLocationsResourceProperties> {
  @doc("The name of the resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("eventGridTopicTypeSupportedLocations") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface EventGridTopicTypeSupportedLocations {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EventGridTopicTypeSupportedLocationsResource>;
  get is ArmResourceRead<EventGridTopicTypeSupportedLocationsResource>;
  listByResourceGroup is ArmResourceListByParent<EventGridTopicTypeSupportedLocationsResource>;
  listBySubscription is ArmListBySubscription<EventGridTopicTypeSupportedLocationsResource>;
}
