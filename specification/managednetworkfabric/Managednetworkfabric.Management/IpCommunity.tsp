import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The IP Community resource definition.
 */
model IpCommunity
  is Azure.ResourceManager.TrackedResource<IpCommunityProperties, false> {
  ...ResourceNameParameter<
    Resource = IpCommunity,
    KeyName = "ipCommunityName",
    SegmentName = "ipCommunities",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IpCommunities {
  /**
   * Implements an IP Community GET method.
   */
  get is ArmResourceRead<IpCommunity>;

  /**
   * Implements an IP Community PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<IpCommunity>;

  /**
   * API to update certain properties of the IP Community resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<IpCommunity, PatchModel = IpCommunityPatch>;

  /**
   * Implements IP Community DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IpCommunity>;

  /**
   * Implements IP Communities list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<IpCommunity>;

  /**
   * Implements IP Communities list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpCommunity>;
}

@@doc(IpCommunity.name, "Name of the IP Community.");
@@doc(IpCommunity.properties, "Resource properties.");
@@doc(IpCommunities.create::parameters.resource, "Request payload.");
@@doc(IpCommunities.update::parameters.properties,
  "IP Community properties to update."
);
