import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MySqlDiscovery;
/**
 * The MySQLSite resource definition.
 */
model MySQLSite
  is Azure.ResourceManager.TrackedResource<MySQLSiteProperties, false> {
  ...ResourceNameParameter<
    Resource = MySQLSite,
    KeyName = "siteName",
    SegmentName = "MySQLSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * The extended location.
   */
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface MySQLSites {
  /**
   * Gets the MySQLSites resource.
   */
  get is ArmResourceRead<MySQLSite>;

  /**
   * Puts the MySQLSites resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MySQLSite>;

  /**
   * Patch the MySQLSites resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<
    MySQLSite,
    PatchModel = MySQLSitesResourcePatch
  >;

  /**
   * Deletes the MySQLSites resource.
   */
  delete is ArmResourceDeleteSync<MySQLSite>;

  /**
   * Lits the MySQLSites resource in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    MySQLSite,
    Response = ArmResponse<MySQLSiteList>
  >;

  /**
   * Lists the MySQLSites resource in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    MySQLSite,
    Response = ArmResponse<MySQLSiteList>
  >;

  /**
   * Trigger Refresh Refresh action
   */
  @action("refresh")
  triggerRefresh is ArmResourceActionAsync<MySQLSite, void, void>;
}

@@maxLength(MySQLSite.name, 63);
@@minLength(MySQLSite.name, 3);
@@doc(MySQLSite.name, "The name of Site");
@@doc(MySQLSite.properties, "Resource properties.");
@@doc(MySQLSites.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MySQLSites.update::parameters.properties, "Clouds patch payload.");
