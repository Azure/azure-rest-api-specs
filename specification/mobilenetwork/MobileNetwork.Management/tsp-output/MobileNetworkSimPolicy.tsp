import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("SIM policy resource.")
@parentResource(MobileNetwork)
model MobileNetworkSimPolicy is TrackedResource<SimPolicyPropertiesFormat> {
  @doc("The name of the SIM policy.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simPolicyName")
  @segment("simPolicies")
  name: string;
}

@armResourceOperations
interface MobileNetworkSimPolicies {
  @doc("Gets information about the specified SIM policy.")
  get is ArmResourceRead<MobileNetworkSimPolicy>;
  @doc("Creates or updates a SIM policy. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MobileNetworkSimPolicy>;
  @doc("Updates SIM policy tags.")
  updateTags is ArmTagsPatchSync<MobileNetworkSimPolicy>;
  @doc("Deletes the specified SIM policy.")
  delete is ArmResourceDeleteAsync<MobileNetworkSimPolicy>;
  @doc("Gets all the SIM policies in a mobile network.")
  listByMobileNetwork is ArmResourceListByParent<MobileNetworkSimPolicy>;
}
