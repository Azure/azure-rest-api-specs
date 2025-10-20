import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FleetspaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB Fleetspace Account
 */
@parentResource(FleetspaceResource)
model FleetspaceAccountResource
  is Azure.ResourceManager.ProxyResource<FleetspaceAccountProperties> {
  ...ResourceNameParameter<
    Resource = FleetspaceAccountResource,
    KeyName = "fleetspaceAccountName",
    SegmentName = "fleetspaceAccounts",
    NamePattern = "^[a-z0-9]+(-[a-z0-9]+)*"
  >;
}

@armResourceOperations
interface FleetspaceAccountResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB fleetspace account under a fleetspace
   */
  get is ArmResourceRead<FleetspaceAccountResource>;

  /**
   * Creates an Azure Cosmos DB fleetspace account under a fleetspace.
   */
  create is ArmResourceCreateOrReplaceAsync<FleetspaceAccountResource>;

  /**
   * Removes an existing Azure Cosmos DB fleetspace account from a fleetspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    FleetspaceAccountResource,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all the fleetspaces accounts  under a fleetspace.
   */
  list is ArmResourceListByParent<FleetspaceAccountResource>;
}

@@maxLength(FleetspaceAccountResource.name, 50);
@@minLength(FleetspaceAccountResource.name, 3);
@@doc(FleetspaceAccountResource.name, "Cosmos DB fleetspace account name.");
@@doc(FleetspaceAccountResource.properties,
  "An Azure Cosmos DB Global Database Account which is part of a Fleetspace Account."
);
@@doc(FleetspaceAccountResources.create::parameters.resource,
  "The parameters to provide for the current fleetspace account."
);
