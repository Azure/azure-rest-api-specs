import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
/**
 * Peering Service
 */
model PeeringService
  is Azure.ResourceManager.TrackedResource<PeeringServiceProperties> {
  ...ResourceNameParameter<
    Resource = PeeringService,
    KeyName = "peeringServiceName",
    SegmentName = "peeringServices",
    NamePattern = "[A-Za-z0-9_.-]{1,63}"
  >;

  /**
   * The SKU that defines the type of the peering service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: PeeringServiceSku;
}

@armResourceOperations
interface PeeringServices {
  /**
   * Gets an existing peering service with the specified name under the given subscription and resource group.
   */
  get is ArmResourceRead<PeeringService>;

  /**
   * Creates a new peering service or updates an existing peering with the specified name under the given subscription and resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringService>;

  /**
   * Updates tags for a peering service with the specified name under the given subscription and resource group.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<PeeringService, PatchModel = ResourceTags>;

  /**
   * Deletes an existing peering service with the specified name under the given subscription and resource group.
   */
  delete is ArmResourceDeleteSync<PeeringService>;

  /**
   * Lists all of the peering services under the given subscription and resource group.
   */
  listByResourceGroup is ArmResourceListByParent<PeeringService>;

  /**
   * Lists all of the peerings under the given subscription.
   */
  listBySubscription is ArmListBySubscription<PeeringService>;
}

@@doc(PeeringService.name, "The name of the peering.");
@@doc(PeeringService.properties,
  "The properties that define a peering service."
);
@@doc(PeeringServices.createOrUpdate::parameters.resource,
  "The properties needed to create or update a peering service."
);
@@doc(PeeringServices.update::parameters.properties, "The resource tags.");
