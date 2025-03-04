import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MySQLDiscovery;
/**
 * The MysqlSite resource definition.
 */
model MysqlSite
  is Azure.ResourceManager.TrackedResource<MysqlSiteProperties, false> {
  ...ResourceNameParameter<
    Resource = MysqlSite,
    KeyName = "siteName",
    SegmentName = "MySQLSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * The extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface MysqlSites {
  /**
   * Gets the MysqlSites resource.
   */
  get is ArmResourceRead<MysqlSite>;

  /**
   * Puts the MysqlSites resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MysqlSite>;

  /**
   * Patch the MysqlSites resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<
    MysqlSite,
    PatchModel = MysqlSitesResourcePatch
  >;

  /**
   * Deletes the MysqlSites resource.
   */
  delete is ArmResourceDeleteSync<MysqlSite>;

  /**
   * Lits the MysqlSites resource in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    MysqlSite,
    Response = ArmResponse<MysqlSiteList>
  >;

  /**
   * Lists the MysqlSites resource in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    MysqlSite,
    Response = ArmResponse<MysqlSiteList>
  >;

  /**
   * Trigger Refresh Refresh action
   */
  @action("refresh")
  triggerRefresh is ArmResourceActionAsync<MysqlSite, void, OkResponse>;
}

@@maxLength(MysqlSite.name, 63);
@@minLength(MysqlSite.name, 3);
@@doc(MysqlSite.name, "The name of Site");
@@doc(MysqlSite.properties, "Resource properties.");
@@doc(MysqlSites.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MysqlSites.update::parameters.properties, "Clouds patch payload.");
