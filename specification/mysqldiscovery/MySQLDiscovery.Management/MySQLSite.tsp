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
 * The MySQLSite resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" " MySQL is a technical term and cannot follow pascal case rule."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For Backward compatibility"
  extendedLocation: ExtendedLocation;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" " MySQL is a technical term and cannot follow pascal case rule."
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
  triggerRefresh is ArmResourceActionAsync<MySQLSite, void, OkResponse>;
}

@@maxLength(MySQLSite.name, 63);
@@minLength(MySQLSite.name, 3);
@@doc(MySQLSite.name, "The name of Site");
@@doc(MySQLSite.properties, "Resource properties.");
@@doc(MySQLSites.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MySQLSites.update::parameters.properties, "Clouds patch payload.");
