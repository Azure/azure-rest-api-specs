import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PeeringService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
    NamePattern = ""
  >;
}

@armResourceOperations
interface PeeringServicePrefixes {
  /**
   * Gets an existing prefix with the specified name under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Prefixes_Get")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Prefixes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringServicePrefix>;

  /**
   * Deletes an existing prefix with the specified name under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Prefixes_Delete")
  delete is ArmResourceDeleteSync<PeeringServicePrefix>;

  /**
   * Lists all prefixes under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Prefixes_ListByPeeringService")
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
