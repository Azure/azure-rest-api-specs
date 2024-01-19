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

namespace Microsoft.Orbital;
@doc("Ground Stations available to schedule Contacts.")
@subscriptionResource
model AvailableGroundStation
  is ProxyResource<AvailableGroundStationProperties> {
  @doc("Ground Station name.")
  @path
  @key("groundStationName")
  @segment("availableGroundStations")
  name: string;
}

@armResourceOperations
interface AvailableGroundStations {
  @doc("Gets the specified available ground station.")
  get is ArmResourceRead<AvailableGroundStation>;

  @doc("Returns list of available ground stations.")
  listByCapability is ArmResourceListByParent<
    AvailableGroundStation,
    {
      ...BaseParameters<AvailableGroundStation>;

      @doc("Ground Station Capability.")
      @query("capability")
      capability: CapabilityParameter = CapabilityParameter.EarthObservation;
    }
  >;
}
