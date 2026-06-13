using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("ARM model of AKS Cost Detail.")
@parentResource(AKSAssessment)
model AKSCostDetail is ProxyResource<AKSCostDetailProperties> {
  @doc("AKS Cost Detail Name.")
  @segment("costDetails")
  @key("costDetailName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("ARM model of AKS Cost Detail Properties.")
model AKSCostDetailProperties is NodePool;
