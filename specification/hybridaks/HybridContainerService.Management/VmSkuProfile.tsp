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
@doc("The list of supported VM SKUs.")
@singleton("default")
model VmSkuProfile is ExtensionResource<VmSkuProfileProperties> {
  @key("skus")
  @segment("skus")
  name: string;

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VmSkuProfiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the supported VM skus for the specified custom location")
  @operationId("GetVMSkus")
  getVMSkus is ArmResourceRead<VmSkuProfile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Puts the default VM skus resource type (one time operation, before listing the VM skus)")
  @operationId("PutVMSkus")
  putVMSkus is ArmResourceCreateOrUpdateAsync<
    VmSkuProfile,
    BaseParameters<VmSkuProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the default VM skus resource type")
  @operationId("DeleteVMSkus")
  deleteVMSkus is ArmResourceDeleteWithoutOkAsync<
    VmSkuProfile,
    BaseParameters<VmSkuProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the supported VM skus for the specified custom location")
  @operationId("VMSkus_List")
  list is ArmResourceListByParent<VmSkuProfile>;
}
