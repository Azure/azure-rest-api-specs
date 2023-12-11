import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Peering;
@doc("Peering Service")
model PeeringService is TrackedResource<PeeringServiceProperties> {
  @doc("The name of the peering.")
  @path
  @key("peeringServiceName")
  @segment("peeringServices")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface PeeringServices {
  @doc("Gets an existing peering service with the specified name under the given subscription and resource group.")
  get is ArmResourceRead<PeeringService>;
  @doc("Creates a new peering service or updates an existing peering with the specified name under the given subscription and resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringService>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Updates tags for a peering service with the specified name under the given subscription and resource group.")
  update is ArmCustomPatchSync<
    PeeringService,
    Paths3702DwSubscriptionsSubscriptionidResourcegroupsResourcegroupnameProvidersMicrosoftPeeringPeeringservicesPeeringservicenamePatchRequestbodyContentApplicationJsonSchema
  >;
  @doc("Deletes an existing peering service with the specified name under the given subscription and resource group.")
  delete is ArmResourceDeleteSync<PeeringService>;
  @doc("Lists all of the peering services under the given subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<PeeringService>;
  @doc("Lists all of the peerings under the given subscription.")
  listBySubscription is ArmListBySubscription<PeeringService>;
}
