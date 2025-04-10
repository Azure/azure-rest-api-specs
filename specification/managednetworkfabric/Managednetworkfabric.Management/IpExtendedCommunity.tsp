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
 * The IP Extended Community resource definition.
 */
model IpExtendedCommunity
  is Azure.ResourceManager.TrackedResource<
    IpExtendedCommunityProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = IpExtendedCommunity,
    KeyName = "ipExtendedCommunityName",
    SegmentName = "ipExtendedCommunities",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IpExtendedCommunities {
  /**
   * Implements IP Extended Community GET method.
   */
  get is ArmResourceRead<IpExtendedCommunity>;

  /**
   * Implements IP Extended Community PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<IpExtendedCommunity>;

  /**
   * API to update certain properties of the IP Extended Community resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    IpExtendedCommunity,
    PatchModel = IpExtendedCommunityPatch
  >;

  /**
   * Implements IP Extended Community DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IpExtendedCommunity>;

  /**
   * Implements IpExtendedCommunities list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<IpExtendedCommunity>;

  /**
   * Implements IpExtendedCommunities list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpExtendedCommunity>;
}

@@doc(IpExtendedCommunity.name, "Name of the IP Extended Community.");
@@doc(IpExtendedCommunity.properties, "Resource properties.");
@@doc(IpExtendedCommunities.create::parameters.resource, "Request payload.");
@@doc(IpExtendedCommunities.update::parameters.properties,
  "IP Extended Community properties to update."
);
