import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Reservations;
@doc("Quota properties.")
@locationResource
model CurrentQuotaLimitBase is ProxyResource<QuotaProperties> {
  @doc("The resource name for a resource provider, such as SKU name for Microsoft.Compute, Sku or TotalLowPriorityCores for Microsoft.MachineLearningServices")
  @key("resourceName")
  @segment("serviceLimits")
  name: string;
}

@armResourceOperations
interface Quota {
  @doc("Get the current quota (service limit) and usage of a resource. You can use the response from the GET operation to submit quota update request.")
  get is ArmResourceRead<CurrentQuotaLimitBase>;
  @doc("""
Create or update the quota (service limits) of a resource to the requested value.
 Steps:
  1. Make the Get request to get the quota information for specific resource.
  2. To increase the quota, update the limit field in the response from Get request to new value.
  3. Submit the JSON to the quota request API to update the quota.
  The Create quota request may be constructed as follows. The PUT operation can be used to update the quota.
""")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CurrentQuotaLimitBase>;
  @doc("""
Update the quota (service limits) of this resource to the requested value.
  • To get the quota information for specific resource, send a GET request.
  • To increase the quota, update the limit field from the GET response to a new value.
  • To update the quota value, submit the JSON response to the quota request API to update the quota.
  • To update the quota. use the PATCH operation.
""")
  update is ArmCustomPatchAsync<CurrentQuotaLimitBase, CurrentQuotaLimitBase>;
  @doc("Gets a list of current quotas (service limits) and usage for all resources. The response from the list quota operation can be leveraged to request quota updates.")
  list is ArmResourceListByParent<CurrentQuotaLimitBase>;
}
