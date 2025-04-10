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
 * The IP Prefix resource definition.
 */
model IpPrefix
  is Azure.ResourceManager.TrackedResource<IpPrefixProperties, false> {
  ...ResourceNameParameter<
    Resource = IpPrefix,
    KeyName = "ipPrefixName",
    SegmentName = "ipPrefixes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IpPrefixes {
  /**
   * Implements IP Prefix GET method.
   */
  get is ArmResourceRead<IpPrefix>;

  /**
   * Implements IP Prefix PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<IpPrefix>;

  /**
   * API to update certain properties of the IP Prefix resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<IpPrefix, PatchModel = IpPrefixPatch>;

  /**
   * Implements IP Prefix DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IpPrefix>;

  /**
   * Implements IpPrefixes list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<IpPrefix>;

  /**
   * Implements IpPrefixes list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpPrefix>;
}

@@doc(IpPrefix.name, "Name of the IP Prefix.");
@@doc(IpPrefix.properties, "Resource properties.");
@@doc(IpPrefixes.create::parameters.resource, "Request payload.");
@@doc(IpPrefixes.update::parameters.properties,
  "IP Prefix properties to update."
);
