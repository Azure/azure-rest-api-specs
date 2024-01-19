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

  @doc("Extended Location definition")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VmSkuProfiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the supported VM skus from the underlying custom location")
  @operationId("GetVMSkus")
  getVMSkus is ArmResourceRead<VmSkuProfile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Puts the VM SKUs resource type")
  @operationId("PutVMSkus")
  putVMSkus is ArmResourceCreateOrUpdateAsync<
    VmSkuProfile,
    BaseParameters<VmSkuProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the Vm Sku resource type")
  @operationId("DeleteVMSkus")
  deleteVMSkus is ArmResourceDeleteWithoutOkAsync<
    VmSkuProfile,
    BaseParameters<VmSkuProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the supported VM SKUs from the underlying custom location")
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
