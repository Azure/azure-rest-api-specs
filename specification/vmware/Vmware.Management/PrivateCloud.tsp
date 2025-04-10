import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A private cloud resource
 */
model PrivateCloud
  is Azure.ResourceManager.TrackedResource<PrivateCloudProperties> {
  ...ResourceNameParameter<
    Resource = PrivateCloud,
    KeyName = "privateCloudName",
    SegmentName = "privateClouds",
    NamePattern = "^[-\\w\\._]+$"
  >;

  /**
   * The SKU (Stock Keeping Unit) assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: Sku;

  /**
   * The managed service identities assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: SystemAssignedServiceIdentity;
}

@armResourceOperations
interface PrivateClouds {
  /**
   * Get a PrivateCloud
   */
  get is ArmResourceRead<PrivateCloud>;

  /**
   * Create a PrivateCloud
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateCloud>;

  /**
   * Update a PrivateCloud
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PrivateCloud,
    PatchModel = PrivateCloudUpdate,
    Response = ArmResponse<PrivateCloud> | ArmResourceCreatedResponse<PrivateCloud>
  >;

  /**
   * Delete a PrivateCloud
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateCloud,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List PrivateCloud resources by resource group
   */
  list is ArmResourceListByParent<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  /**
   * List PrivateCloud resources by subscription ID
   */
  listInSubscription is ArmListBySubscription<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  /**
   * List the admin credentials for the private cloud
   */
  listAdminCredentials is ArmResourceActionSync<
    PrivateCloud,
    void,
    ArmResponse<AdminCredentials>
  >;

  /**
   * Rotate the NSX-T Manager password
   */
  rotateNsxtPassword is ArmResourceActionAsync<
    PrivateCloud,
    void,
    NoContentResponse
  >;

  /**
   * Rotate the vCenter password
   */
  rotateVcenterPassword is ArmResourceActionAsync<
    PrivateCloud,
    void,
    NoContentResponse
  >;
}

@@doc(PrivateCloud.name, "Name of the private cloud");
@@doc(PrivateCloud.properties,
  "The resource-specific properties for this resource."
);
@@doc(PrivateClouds.update::parameters.properties,
  "The private cloud properties to be updated."
);
