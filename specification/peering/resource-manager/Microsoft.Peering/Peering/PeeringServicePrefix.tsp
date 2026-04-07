import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PeeringService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Peering;
/**
 * The peering service prefix class.
 */
@parentResource(PeeringService)
model PeeringServicePrefix
  is Azure.ResourceManager.ProxyResource<PeeringServicePrefixProperties> {
  ...ResourceNameParameter<
    Resource = PeeringServicePrefix,
    KeyName = "prefixName",
    SegmentName = "prefixes",
    NamePattern = "[A-Za-z0-9_.-]{1,63}"
  >;
}

@armResourceOperations
interface PeeringServicePrefixes {
  /**
   * Gets an existing prefix with the specified name under the given subscription, resource group and peering service.
   */
  get is ArmResourceRead<
    PeeringServicePrefix,
    Parameters = {
      /**
       * The properties to be expanded.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates a new prefix with the specified name under the given subscription, resource group and peering service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringServicePrefix>;

  /**
   * Deletes an existing prefix with the specified name under the given subscription, resource group and peering service.
   */
  delete is ArmResourceDeleteSync<PeeringServicePrefix>;

  /**
   * Lists all prefixes under the given subscription, resource group and peering service.
   */
  listByPeeringService is ArmResourceListByParent<
    PeeringServicePrefix,
    Parameters = {
      /**
       * The properties to be expanded.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@doc(PeeringServicePrefix.name, "The name of the prefix.");
@@doc(PeeringServicePrefix.properties,
  "Gets or sets the peering prefix properties."
);
@@doc(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "The properties needed to create a prefix."
);
