import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Peering.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
/**
 * The customer's prefix that is registered by the peering service provider.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Peering)
@Azure.ResourceManager.Private.armResourceInternal(
  PeeringRegisteredPrefixProperties
)
@includeInapplicableMetadataInPayload(false)
model PeeringRegisteredPrefix extends Resource {
  /**
   * The name of the registered prefix.
   */
  @path
  @key("registeredPrefixName")
  @segment("registeredPrefixes")
  name: string;

  /**
   * The properties that define a registered prefix.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PeeringRegisteredPrefixProperties;
}

@armResourceOperations
interface PeeringRegisteredPrefixes {
  /**
   * Gets an existing registered prefix with the specified name under the given subscription, resource group and peering.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegisteredPrefixes_Get")
  get is ArmResourceRead<PeeringRegisteredPrefix>;

  /**
   * Creates a new registered prefix with the specified name under the given subscription, resource group and peering.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegisteredPrefixes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringRegisteredPrefix>;

  /**
   * Deletes an existing registered prefix with the specified name under the given subscription, resource group and peering.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegisteredPrefixes_Delete")
  delete is ArmResourceDeleteSync<PeeringRegisteredPrefix>;

  /**
   * Lists all registered prefixes under the given subscription, resource group and peering.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegisteredPrefixes_ListByPeering")
  listByPeering is ArmResourceListByParent<PeeringRegisteredPrefix>;

  /**
   * Validates an existing registered prefix with the specified name under the given subscription, resource group and peering.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegisteredPrefixes_Validate")
  validate is ArmResourceActionSync<
    PeeringRegisteredPrefix,
    void,
    PeeringRegisteredPrefix
  >;
}

@@projectedName(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "json",
  "registeredPrefix"
);
@@extension(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "registeredPrefix"
);
@@doc(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "The properties needed to create a registered prefix."
);
