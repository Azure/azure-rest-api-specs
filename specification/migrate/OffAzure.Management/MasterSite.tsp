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

@armResourceOperations(#{ omitTags: true })
interface MasterSitesOperationsStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("masterSites")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        siteName: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("operationsStatus")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        operationStatusName: string,
      }
    > {}

@armResourceOperations(#{ omitTags: true })
interface MasterSites {
  /**
   * Get a MasterSite
   */
  @summary("Method to get a master site.")
  @tag("MasterSitesController")
  get is ArmResourceRead<MasterSite>;

  /**
   * Method to create or update a site.
   */
  @tag("MasterSitesController")
  create is ArmResourceCreateOrReplaceAsync<
    MasterSite,
    LroHeaders = ArmLroLocationHeader<FinalResult = MasterSite> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to update an existing site.
   */
  @tag("MasterSitesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<MasterSite, PatchModel = MasterSiteUpdate>;

  /**
   * Method to delete a site.
   */
  @tag("MasterSitesController")
  delete is ArmResourceDeleteSync<MasterSite>;

  /**
   * Get all the sites in the resource group.
   */
  @summary("Get all sites.")
  @tag("MasterSitesController")
  listByResourceGroup is ArmResourceListByParent<MasterSite>;

  /**
   * List MasterSite resources by subscription ID
   */
  @summary("Get all the sites in the subscription.")
  @tag("MasterSitesController")
  listBySubscription is ArmListBySubscription<MasterSite>;

  /**
   * Method to get error summary from master site for an appliance.
   */
  @tag("MasterSitesController")
  errorSummary is ArmResourceActionSync<
    MasterSite,
    ErrorSummaryRequest,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to refresh arc status from master site for an appliance.
   */
  @tag("MasterSitesController")
  refreshArcStatus is ArmResourceActionAsync<
    MasterSite,
    void,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * A operation status resource belonging to a master site resource.
   */
  @tag("MasterSitesOperationsStatusController")
  getVmwareOperationStatus is MasterSitesOperationsStatusOps.Read<
    OperationStatus,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(MasterSite.name, "Site name");
@@doc(MasterSite.properties,
  "The resource-specific properties for this resource."
);
