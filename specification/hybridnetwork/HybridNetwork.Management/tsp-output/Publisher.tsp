import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("publisher resource.")
model Publisher is TrackedResource<PublisherPropertiesFormat> {
  @doc("The name of the publisher.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("publisherName")
  @segment("publishers")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Publishers {
  @doc("Gets information about the specified publisher.")
  get is ArmResourceRead<Publisher>;
  @doc("Creates or updates a publisher.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Publisher>;
  @doc("Update a publisher resource.")
  update is ArmCustomPatchSync<Publisher, TagsObject>;
  @doc("Deletes the specified publisher.")
  delete is ArmResourceDeleteWithoutOkAsync<Publisher>;
  @doc("Lists all the publishers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Publisher>;
  @doc("Lists all the publishers in a subscription.")
  listBySubscription is ArmListBySubscription<Publisher>;
}
