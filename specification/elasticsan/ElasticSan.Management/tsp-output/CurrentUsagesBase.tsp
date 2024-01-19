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

namespace Microsoft.Quota;
@doc("Resource usage.")
model CurrentUsagesBase is ExtensionResource<UsagesProperties> {
  @doc("""
Resource name for a given resource provider. For example:
- SKU name for Microsoft.Compute
- SKU or TotalLowPriorityCores for Microsoft.MachineLearningServices
 For Microsoft.Network PublicIPAddresses.
""")
  @path
  @key("resourceName")
  @segment("usages")
  name: string;
}

@armResourceOperations
interface CurrentUsagesBases {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the current usage of a resource.")
  @operationId("Usages_Get")
  get is ArmResourceRead<CurrentUsagesBase>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of current usage for all resources for the scope specified.")
  @operationId("Usages_List")
  list is ArmResourceListByParent<CurrentUsagesBase>;
}
