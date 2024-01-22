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
/**
 * Ground Stations available to schedule Contacts.
 */
@subscriptionResource
model AvailableGroundStation
  is ProxyResource<AvailableGroundStationProperties> {
  /**
   * Ground Station name.
   */
  @path
  @key("groundStationName")
  @segment("availableGroundStations")
  name: string;
}

@armResourceOperations
interface AvailableGroundStations {
  /**
   * Gets the specified available ground station.
   */
  get is ArmResourceRead<AvailableGroundStation>;

  /**
   * Returns list of available ground stations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AvailableGroundStations_ListByCapability")
  listByCapability is ArmResourceListByParent<
    AvailableGroundStation,
    {
      ...BaseParameters<AvailableGroundStation>;

      /**
       * Ground Station Capability.
       */
      @query("capability")
      capability: CapabilityParameter = CapabilityParameter.EarthObservation;
    }
  >;
}
