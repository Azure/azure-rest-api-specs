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
 * An Azure Cosmos DB Fleetspace.
 */
@parentResource(FleetResource)
model FleetspaceResource
  is Azure.ResourceManager.ProxyResource<FleetspaceProperties> {
  ...ResourceNameParameter<
    Resource = FleetspaceResource,
    KeyName = "fleetspaceName",
    SegmentName = "fleetspaces",
    NamePattern = "^[a-z0-9]+(-[a-z0-9]+)*"
  >;
}

@armResourceOperations
interface FleetspaceResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB fleetspace under a fleet
   */
  get is ArmResourceRead<FleetspaceResource>;

  /**
   * Creates an Azure Cosmos DB fleetspace under a fleet.
   */
  create is ArmResourceCreateOrReplaceAsync<FleetspaceResource>;

  /**
   * Update the properties of an existing Azure Cosmos DB fleetspace under a fleet.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    FleetspaceResource,
    PatchModel = FleetspaceUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = FleetspaceResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Deletes an existing Azure Cosmos DB Fleetspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    FleetspaceResource,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all the fleetspaces under a fleet.
   */
  list is ArmResourceListByParent<FleetspaceResource>;
}

@@maxLength(FleetspaceResource.name, 50);
@@minLength(FleetspaceResource.name, 3);
@@doc(FleetspaceResource.name,
  "Cosmos DB fleetspace name. Needs to be unique under a fleet."
);
@@doc(FleetspaceResource.properties,
  "Properties to update Azure Cosmos DB Fleetspace."
);
@@doc(FleetspaceResources.create::parameters.resource,
  "The parameters to provide for the current fleetspace."
);
@@doc(FleetspaceResources.update::parameters.properties,
  "The parameters to provide for the current fleetspace."
);
