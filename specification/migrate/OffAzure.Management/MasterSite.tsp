import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A MasterSite
 */
model MasterSite
  is Azure.ResourceManager.TrackedResource<MasterSiteProperties> {
  ...ResourceNameParameter<
    Resource = MasterSite,
    KeyName = "siteName",
    SegmentName = "masterSites"
  >;
}

@armResourceOperations
interface MasterSites {
  /**
   * Get a MasterSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_Get")
  get is ArmResourceRead<MasterSite>;

  /**
   * Method to create or update a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_Create")
  create is ArmResourceCreateOrReplaceAsync<
    MasterSite,
    LroHeaders = ArmLroLocationHeader<FinalResult = MasterSite> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to update an existing site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<MasterSite, PatchModel = MasterSiteUpdate>;

  /**
   * Method to delete a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_Delete")
  delete is ArmResourceDeleteSync<MasterSite>;

  /**
   * Get all the sites in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MasterSite>;

  /**
   * List MasterSite resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_ListBySubscription")
  listBySubscription is ArmListBySubscription<MasterSite>;

  /**
   * Method to get error summary from master site for an appliance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_ErrorSummary")
  errorSummary is ArmResourceActionSync<
    MasterSite,
    ErrorSummaryRequest,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to refresh arc status from master site for an appliance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesController_RefreshArcStatus")
  refreshArcStatus is ArmResourceActionAsync<
    MasterSite,
    void,
    ArmResponse<AnyObject>
  >;

  /**
   * A operation status resource belonging to a master site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MasterSitesOperationsStatusController_GetVmwareOperationStatus")
  @get
  @action("{operationStatusName}")
  getVmwareOperationStatus is ArmResourceActionSync<
    MasterSite,
    void,
    ArmResponse<OperationStatus>,
    Parameters = {
      /**
       * Operation status  Arm Name.
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      operationStatusName: string;
    }
  >;
}

@@doc(MasterSite.name, "Site name");
@@doc(MasterSite.properties,
  "The resource-specific properties for this resource."
);
