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
#suppress "@azure-tools/typespec-azure-core/casing-style" "MySQL is a technical term cannot follow pascal case"
model MySQLSite
  is Azure.ResourceManager.TrackedResource<MySQLSiteProperties, true> {
  ...ResourceNameParameter<
    Resource = MySQLSite,
    KeyName = "siteName",
    SegmentName = "MySQLSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * The extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "MySQL is a technical term cannot follow pascal case"
@armResourceOperations
interface MySQLSites {
  /**
   * Gets the MySQLSites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("MySQLSites_Get")
  get is ArmResourceRead<MySQLSite>;

  /**
   * Puts the MySQLSites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("MySQLSites_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MySQLSite>;

  /**
   * Patch the MySQLSites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("MySQLSites_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    MySQLSite,
    PatchModel = MySQLSitesResourcePatch
  >;

  /**
   * Deletes the MySQLSites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("MySQLSites_Delete")
  delete is ArmResourceDeleteSync<MySQLSite>;

  /**
   * Lits the MySQLSites resource in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("MySQLSites_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    MySQLSite,
    Response = ArmResponse<MySQLSiteList>
  >;

  /**
   * Lists the MySQLSites resource in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("MySQLSites_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    MySQLSite,
    Response = ArmResponse<MySQLSiteList>
  >;

  /**
   * Trigger Refresh Refresh action
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("MySQLSites_TriggerRefresh")
  @action("refresh")
  triggerRefresh is ArmResourceActionNoResponseContentAsync<MySQLSite, void>;
}

@@maxLength(MySQLSite.name, 63);
@@minLength(MySQLSite.name, 3);
@@doc(MySQLSite.name, "The name of Site");
@@doc(MySQLSite.properties, "Resource properties.");
@@doc(MySQLSites.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MySQLSites.update::parameters.properties, "Clouds patch payload.");
