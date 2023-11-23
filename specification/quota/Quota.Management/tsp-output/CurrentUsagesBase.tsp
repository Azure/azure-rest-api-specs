import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
  @doc("Get the current usage of a resource.")
  get is ArmResourceRead<CurrentUsagesBase>;
  @doc("Get a list of current usage for all resources for the scope specified.")
  list is ArmResourceListByParent<CurrentUsagesBase>;
}
