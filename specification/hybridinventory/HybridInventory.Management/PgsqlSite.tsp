import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridInventory;
/**
 * The PGSQLSite resource definition.
 */
model PgsqlSite
  is Azure.ResourceManager.TrackedResource<PgsqlSiteProperties, false> {
  ...ResourceNameParameter<
    Resource = PgsqlSite,
    KeyName = "siteName",
    SegmentName = "PGSQLSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * The extended location.
   */
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface PgsqlSites {
  /**
   * Gets the PGSQLSites resource.
   */
  get is ArmResourceRead<PgsqlSite>;

  /**
   * Puts the PGSQLSites resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PgsqlSite>;

  /**
   * Patch the PGSQLSites resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<
    PgsqlSite,
    PatchModel = PgsqlSitesResourcePatch
  >;

  /**
   * Deletes the PGSQLSites resource.
   */
  delete is ArmResourceDeleteSync<PgsqlSite>;

  /**
   * Lits the PGSQLSites resource in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    PgsqlSite,
    Response = ArmResponse<PgsqlSiteList>
  >;

  /**
   * Lists the PGSQLSites resource in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    PgsqlSite,
    Response = ArmResponse<PgsqlSiteList>
  >;

  /**
   * Trigger Refresh Refresh action
   */
  @action("refresh")
  triggerRefresh is ArmResourceActionAsync<PgsqlSite, void, void>;
}

@@maxLength(PgsqlSite.name, 63);
@@minLength(PgsqlSite.name, 3);
@@doc(PgsqlSite.name, "The name of Site");
@@doc(PgsqlSite.properties, "Resource properties.");
@@doc(PgsqlSites.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(PgsqlSites.update::parameters.properties, "Clouds patch payload.");
