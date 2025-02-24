import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fleetspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DatabaseFleetManager;
/**
 * A fleet database.
 */
@parentResource(Fleetspace)
model FleetDatabase
  is Azure.ResourceManager.ProxyResource<FleetDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = FleetDatabase,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = "^.+$"
  >;
}

@armResourceOperations
interface FleetDatabases {
  /**
   * Gets a fleet database.
   */
  get is ArmResourceRead<FleetDatabase>;

  /**
   * Creates or updates a fleet database.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FleetDatabase>;

  /**
   * Updates a fleet database.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<FleetDatabase, FleetDatabase>;

  /**
   * Deletes a fleet database.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FleetDatabase>;

  /**
   * Gets all fleet databases in a fleetspace.
   */
  listByFleetspace is ArmResourceListByParent<
    FleetDatabase,
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
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Moves database to a different tier.
   */
  changeTier is ArmResourceActionNoResponseContentAsync<
    FleetDatabase,
    DatabaseChangeTierDefinition
  >;

  /**
   * Renames a database.
   */
  rename is ArmResourceActionNoResponseContentAsync<
    FleetDatabase,
    DatabaseRenameDefinition
  >;

  /**
   * Revert a database transparent data encryption (TDE).
   */
  revert is ArmResourceActionNoResponseContentAsync<FleetDatabase, void>;
}

@@doc(FleetDatabase.name, "Name of the database.");
@@doc(FleetDatabase.properties, "Fleet database properties.");
@@doc(FleetDatabases.createOrUpdate::parameters.resource,
  "The database object to create or update."
);
@@doc(FleetDatabases.update::parameters.properties,
  "The database object to patch."
);
@@doc(FleetDatabases.changeTier::parameters.body,
  "The details of the change tier operation."
);
@@doc(FleetDatabases.rename::parameters.body,
  "The details of the rename operation."
);
