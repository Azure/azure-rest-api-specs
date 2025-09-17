import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The list of supported VM SKUs.
 */
@singleton("default")
model VmSkuProfile
  is Azure.ResourceManager.ExtensionResource<VmSkuProfileProperties> {
  ...ResourceNameParameter<
    Resource = VmSkuProfile,
    KeyName = "skus",
    SegmentName = "skus",
    NamePattern = ""
  >;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VmSkuProfiles {
  /**
   * Lists the supported VM skus for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetVMSkus")
  getVMSkus is ArmResourceRead<
    VmSkuProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;

  /**
   * Puts the default VM skus resource type (one time operation, before listing the VM skus)
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PutVMSkus")
  putVMSkus is ArmResourceCreateOrReplaceAsync<
    VmSkuProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;

  /**
   * Deletes the default VM skus resource type
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("DeleteVMSkus")
  deleteVMSkus is ArmResourceDeleteWithoutOkAsync<
    VmSkuProfile,
    BaseParameters = CustomLocationResourceUriParameters,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  /**
   * Lists the supported VM skus for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VMSkus_List")
  list is ArmResourceListByParent<
    VmSkuProfile,
    BaseParameters = CustomLocationResourceUriParameters,
    Response = ArmResponse<VmSkuProfileList>
  >;
}

@@doc(VmSkuProfile.name, "");
@@doc(VmSkuProfile.properties, "");
@@doc(VmSkuProfiles.putVMSkus::parameters.resource,
  "VM SKUs resource definition"
);
