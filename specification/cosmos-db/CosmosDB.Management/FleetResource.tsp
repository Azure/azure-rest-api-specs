import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB FleetResource.
 */
model FleetResource
  is Azure.ResourceManager.TrackedResource<FleetResourceProperties> {
  ...ResourceNameParameter<
    Resource = FleetResource,
    KeyName = "fleetName",
    SegmentName = "fleets",
    NamePattern = "^[a-z0-9]+(-[a-z0-9]+)*"
  >;
}

@armResourceOperations
interface FleetResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB fleet under a subscription
   */
  get is ArmResourceRead<FleetResource>;

  /**
   * Creates an Azure Cosmos DB fleet under a subscription.
   */
  create is ArmResourceCreateOrReplaceSync<FleetResource>;

  /**
   * Updates the properties of an existing Azure Cosmos DB Fleet.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    FleetResource,
    PatchModel = FleetResourceUpdate,
    OptionalRequestBody = true
  >;

  /**
   * Deletes an existing Azure Cosmos DB Fleet.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    FleetResource,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all the fleets under the specified subscription and resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    FleetResource,
    Response = FleetListResult
  >;

  /**
   * Lists all the fleets under the subscription.
   */
  list is ArmListBySubscription<FleetResource, Response = FleetListResult>;
}

@@maxLength(FleetResource.name, 50);
@@minLength(FleetResource.name, 3);
@@doc(FleetResource.name,
  "Cosmos DB fleet name. Needs to be unique under a subscription."
);
@@doc(FleetResource.properties,
  "Properties to update Azure Cosmos DB fleet resource."
);
@@doc(FleetResources.create::parameters.resource,
  "The parameters to provide for the current fleet."
);
@@doc(FleetResources.update::parameters.properties,
  "The parameters to provide for the current fleet."
);
