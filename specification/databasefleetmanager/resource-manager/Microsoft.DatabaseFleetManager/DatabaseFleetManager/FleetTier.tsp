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
 * A SQL Database Fleet tier.
 */
@parentResource(Fleet)
model FleetTier is Azure.ResourceManager.ProxyResource<FleetTierProperties> {
  ...ResourceNameParameter<
    Resource = FleetTier,
    KeyName = "tierName",
    SegmentName = "tiers",
    NamePattern = "^.+$"
  >;
}

@armResourceOperations
interface FleetTiers {
  /**
   * Gets a tier resource.
   */
  get is ArmResourceRead<FleetTier>;

  /**
   * Creates or updates a tier.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FleetTier>;

  /**
   * Updates a tier.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<FleetTier, FleetTier>;

  /**
   * Deletes a tier.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FleetTier>;

  /**
   * List tiers in a fleet.
   */
  listByFleet is ArmResourceListByParent<
    FleetTier,
    Parameters = {
      /**
       * The number of elements in the collection to skip.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByFleet.$skip retains the $skip query parameter; preserve wire compatibility."
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByFleet.$top retains the $top query parameter; preserve wire compatibility."
      @query("$top")
      $top?: int64;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByFleet.$skiptoken retains the $skiptoken query parameter; preserve wire compatibility."
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Disables a tier.
   */
  disable is ArmResourceActionSync<FleetTier, void, FleetTier>;
}

@@doc(FleetTier.name, "Name of the tier.");
@@doc(FleetTier.properties, "A Fleet tier properties.");
@@doc(
  FleetTiers.createOrUpdate::parameters.resource,
  "The tier object to create or update."
);
