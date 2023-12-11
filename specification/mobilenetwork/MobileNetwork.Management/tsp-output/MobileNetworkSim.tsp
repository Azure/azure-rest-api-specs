import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetworkSimGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("SIM resource.")
@parentResource(MobileNetworkSimGroup)
model MobileNetworkSim is ProxyResource<SimPropertiesFormat> {
  @doc("The name of the SIM.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simName")
  @segment("sims")
  name: string;
}

@armResourceOperations
interface MobileNetworkSims {
  @doc("Gets information about the specified SIM.")
  get is ArmResourceRead<MobileNetworkSim>;
  @doc("Creates or updates a SIM.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MobileNetworkSim>;
  @doc("Deletes the specified SIM.")
  delete is ArmResourceDeleteAsync<MobileNetworkSim>;
  @doc("Gets all the SIMs in a SIM group.")
  listByGroup is ArmResourceListByParent<MobileNetworkSim>;
}
