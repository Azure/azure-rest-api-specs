import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The list of supported VM SKUs.")
@singleton("default")
model VmSkuProfile is ExtensionResource<VmSkuProfileProperties> {
  @key("sku")
  @segment("skus")
  name: string;

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VmSkuProfiles {
  @doc("Lists the supported VM skus for the specified custom location")
  getVMSkus is ArmResourceRead<VmSkuProfile>;
  @doc("Puts the default VM skus resource type (one time operation, before listing the VM skus)")
  putVMSkus is ArmResourceCreateOrUpdateAsync<VmSkuProfile>;
  @doc("Deletes the default VM skus resource type")
  deleteVMSkus is ArmResourceDeleteWithoutOkAsync<VmSkuProfile>;
  @doc("Lists the supported VM skus for the specified custom location")
  listByArm is ArmResourceListByParent<VmSkuProfile>;
}
