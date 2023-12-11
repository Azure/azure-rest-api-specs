import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AzureTrafficCollector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkFunction;
@doc("Collector policy resource.")
@parentResource(AzureTrafficCollector)
model CollectorPolicy is TrackedResource<CollectorPolicyPropertiesFormat> {
  @doc("Collector Policy Name")
  @path
  @key("collectorPolicyName")
  @segment("collectorPolicies")
  name: string;
}

@armResourceOperations
interface CollectorPolicies {
  @doc("Gets the collector policy in a specified Traffic Collector")
  get is ArmResourceRead<CollectorPolicy>;
  @doc("Creates or updates a Collector Policy resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CollectorPolicy>;
  @doc("Updates the specified Collector Policy tags.")
  updateTags is ArmTagsPatchSync<CollectorPolicy>;
  @doc("Deletes a specified Collector Policy resource.")
  delete is ArmResourceDeleteAsync<CollectorPolicy>;
  @doc("Return list of Collector policies in a Azure Traffic Collector")
  list is ArmResourceListByParent<CollectorPolicy>;
}
