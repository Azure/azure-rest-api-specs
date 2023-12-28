import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SimGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("SIM resource.")
@parentResource(SimGroup)
model Sim is ProxyResource<SimPropertiesFormat> {
  @doc("The name of the SIM.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("simName")
  @segment("sims")
  name: string;
}

@armResourceOperations
interface Sims {
  @doc("Gets information about the specified SIM.")
  get is ArmResourceRead<Sim>;
  @doc("Creates or updates a SIM.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Sim>;
  @doc("Deletes the specified SIM.")
  delete is ArmResourceDeleteAsync<Sim>;
  @doc("Gets all the SIMs in a SIM group.")
  listByGroup is ArmResourceListByParent<Sim>;
}
