import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DatabaseFleetManager;
/**
 * A Database Fleet.
 */
model Fleet is Azure.ResourceManager.TrackedResource<FleetProperties> {
  ...ResourceNameParameter<
    Resource = Fleet,
    KeyName = "fleetName",
    SegmentName = "fleets",
    NamePattern = "^.+$"
  >;
}

@armResourceOperations
interface Fleets {
  /**
   * Gets a fleet resource.
   */
  get is ArmResourceRead<Fleet>;

  /**
   * Creates or updates a fleet resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Fleet>;

  /**
   * Modifies a fleet resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Fleet, FleetUpdate>;

  /**
   * Deletes a fleet.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Fleet>;

  /**
   * Gets all fleets in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Fleet,
    Parameters = {
      /**
       * The number of elements in the collection to skip.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.$skip retains the $skip query parameter; preserve wire compatibility."
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.$top retains the $top query parameter; preserve wire compatibility."
      @query("$top")
      $top?: int64;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.$skiptoken retains the $skiptoken query parameter; preserve wire compatibility."
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Gets all fleets in a subscription.
   */
  list is ArmListBySubscription<Fleet>;
}

@@doc(Fleet.name, "Name of the database fleet.");
@@doc(Fleet.properties, "The fleet properties.");
@@doc(
  Fleets.createOrUpdate::parameters.resource,
  "The fleet object to create or update."
);
@@doc(Fleets.update::parameters.properties, "The fleet object to patch.");
