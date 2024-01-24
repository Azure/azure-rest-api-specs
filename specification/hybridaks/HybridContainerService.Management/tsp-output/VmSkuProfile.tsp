import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The list of supported VM SKUs.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@Azure.ResourceManager.Private.armResourceInternal(VmSkuProfileProperties)
@includeInapplicableMetadataInPayload(false)
model VmSkuProfile extends ExtensionResourceBase {
  @key("skus")
  @segment("skus")
  name: string;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  extendedLocation?: ExtendedLocation;

  @extension("x-ms-client-flatten", true)
  properties?: VmSkuProfileProperties;
}

@armResourceOperations
interface VmSkuProfiles {
  /**
   * Lists the supported VM skus for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GetVMSkus")
  getVMSkus is ArmResourceRead<VmSkuProfile>;

  /**
   * Puts the default VM skus resource type (one time operation, before listing the VM skus)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PutVMSkus")
  putVMSkus is ArmResourceCreateOrReplaceAsync<
    VmSkuProfile,
    BaseParameters<VmSkuProfile>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the default VM skus resource type
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeleteVMSkus")
  deleteVMSkus is ArmResourceDeleteWithoutOkAsync<
    VmSkuProfile,
    BaseParameters<VmSkuProfile>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the supported VM skus for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VMSkus_List")
  list is ArmResourceListByParent<VmSkuProfile>;
}

@@projectedName(VmSkuProfiles.putVMSkus::parameters.resource, "json", "skus");
@@extension(VmSkuProfiles.putVMSkus::parameters.resource,
  "x-ms-client-name",
  "skus"
);
@@doc(VmSkuProfiles.putVMSkus::parameters.resource,
  "VM SKUs resource definition"
);
