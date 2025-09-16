import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Mobile network resource.
 */
model MobileNetwork
  is Azure.ResourceManager.TrackedResource<
    MobileNetworkPropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = MobileNetwork,
    KeyName = "mobileNetworkName",
    SegmentName = "mobileNetworks",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;

  /**
   * The identity used to retrieve any private keys used for SUPI concealment from Azure key vault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface MobileNetworks {
  /**
   * Gets information about the specified mobile network.
   */
  get is ArmResourceRead<MobileNetwork>;

  /**
   * Creates or updates a mobile network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MobileNetwork>;

  /**
   * Updates mobile network tags and managed identity.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    MobileNetwork,
    PatchModel = IdentityAndTagsObject
  >;

  /**
   * Deletes the specified mobile network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    MobileNetwork,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the mobile networks in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<MobileNetwork>;

  /**
   * Lists all the mobile networks in a subscription.
   */
  listBySubscription is ArmListBySubscription<MobileNetwork>;

  /**
   * Gets all the SIM groups assigned to a mobile network.
   */
  @list
  listSimGroups is ArmResourceActionSync<
    MobileNetwork,
    void,
    ArmResponse<ResourceListResult<SimGroup>>
  >;
}

@@maxLength(MobileNetwork.name, 64);
@@doc(MobileNetwork.name, "The name of the mobile network.");
@@doc(MobileNetwork.properties, "Mobile network properties.");
@@doc(MobileNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update mobile network operation."
);
@@doc(MobileNetworks.updateTags::parameters.properties,
  "Parameters supplied to update mobile network tags and/or identity."
);
