import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FleetResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB FleetAnalytics.
 */
@parentResource(FleetResource)
model FleetAnalyticsResource
  is Azure.ResourceManager.ProxyResource<FleetAnalyticsProperties> {
  ...ResourceNameParameter<
    Resource = FleetAnalyticsResource,
    KeyName = "fleetAnalyticsName",
    SegmentName = "fleetAnalytics",
    NamePattern = "^[a-z0-9]+(-[a-z0-9]+)*"
  >;
}

@armResourceOperations
interface FleetAnalyticsResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB FleetAnalytics under a fleet
   */
  get is ArmResourceRead<FleetAnalyticsResource>;

  /**
   * Creates an Azure Cosmos DB FleetAnalytics under a fleet.
   */
  create is ArmResourceCreateOrReplaceSync<FleetAnalyticsResource>;

  /**
   * Deletes an existing Azure Cosmos DB FleetAnalytics.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    FleetAnalyticsResource,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all the FleetAnalytics under a fleet.
   */
  list is ArmResourceListByParent<
    FleetAnalyticsResource,
    Response = FleetAnalyticsListResult
  >;
}

@@maxLength(FleetAnalyticsResource.name, 50);
@@minLength(FleetAnalyticsResource.name, 3);
@@doc(FleetAnalyticsResource.name, "Cosmos DB fleetAnalytics name.");
@@doc(FleetAnalyticsResource.properties, "");
@@doc(FleetAnalyticsResources.create::parameters.resource,
  "The parameters to provide for the current FleetAnalytics."
);
