import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.EventHubs;
@doc("The Application Group object")
@parentResource(EventHubsNamespace)
model EventHubsApplicationGroup is ProxyResource<ApplicationGroupProperties> {
  @doc("The Application Group name ")
  @maxLength(256)
  @minLength(1)
  @path
  @key("applicationGroupName")
  @segment("applicationGroups")
  name: string;
}

@armResourceOperations
interface ApplicationGroup {
  @doc("Gets an ApplicationGroup for a Namespace.")
  get is ArmResourceRead<EventHubsApplicationGroup>;
  @doc("Creates or updates an ApplicationGroup for a Namespace.")
  createOrUpdateApplicationGroup is ArmResourceCreateOrReplaceSync<EventHubsApplicationGroup>;
  @doc("Deletes an ApplicationGroup for a Namespace.")
  delete is ArmResourceDeleteSync<EventHubsApplicationGroup>;
  @doc("Gets a list of application groups for a Namespace.")
  listByNamespace is ArmResourceListByParent<EventHubsApplicationGroup>;
}
