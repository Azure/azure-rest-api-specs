import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fleet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DatabaseFleetManager;
/**
 * A fleetspace.
 */
@parentResource(Fleet)
model Fleetspace is Azure.ResourceManager.ProxyResource<FleetspaceProperties> {
  ...ResourceNameParameter<
    Resource = Fleetspace,
    KeyName = "fleetspaceName",
    SegmentName = "fleetspaces",
    NamePattern = "^.+$"
  >;
}

@armResourceOperations
interface Fleetspaces {
  /**
   * Gets fleetspace resource.
   */
  get is ArmResourceRead<Fleetspace>;

  /**
   * Creates or updates a fleetspace resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Fleetspace>;

  /**
   * Modifies a fleetspace resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<Fleetspace, Fleetspace>;

  /**
   * Deletes a fleetspace.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Fleetspace>;

  /**
   * Lists fleetspaces in a fleet.
   */
  listByFleet is ArmResourceListByParent<
    Fleetspace,
    Parameters = {
      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Migrates an existing logical server into fleet.
   */
  registerServer is ArmResourceActionNoResponseContentAsync<
    Fleetspace,
    RegisterServerDefinition
  >;

  /**
   * Unregisters all databases from a fleetspace
   */
  unregister is ArmResourceActionNoResponseContentAsync<Fleetspace, void>;
}

@@doc(Fleetspace.name, "Name of the fleetspace.");
@@doc(Fleetspace.properties, "A Fleetspace properties.");
@@doc(Fleetspaces.createOrUpdate::parameters.resource,
  "The fleet object to create or update."
);
@@doc(Fleetspaces.registerServer::parameters.body,
  "The details of the register server operation."
);
