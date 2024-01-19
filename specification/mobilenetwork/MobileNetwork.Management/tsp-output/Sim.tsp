import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SimGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
@doc("SIM resource.")
@parentResource(SimGroup)
model Sim is ProxyResource<SimPropertiesFormat> {
  @doc("The name of the SIM.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simName")
  @segment("sims")
  name: string;
}

@armResourceOperations
interface Sims {
  @doc("Gets information about the specified SIM.")
  get is ArmResourceRead<Sim>;

  @doc("Creates or updates a SIM.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Sim,
    BaseParameters<Sim>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes the specified SIM.")
  delete is ArmResourceDeleteAsync<
    Sim,
    BaseParameters<Sim>,
    ArmLroLocationHeader
  >;

  @doc("Gets all the SIMs in a SIM group.")
  listByGroup is ArmResourceListByParent<Sim>;
}

@@projectedName(Sims.createOrUpdate::parameters.resource, "json", "parameters");
@@extension(Sims.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sims.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM operation."
);
