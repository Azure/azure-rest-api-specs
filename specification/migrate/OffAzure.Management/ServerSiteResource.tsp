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
 * A ServerSiteResource
 */
model ServerSiteResource
  is Azure.ResourceManager.TrackedResource<ServerSitesProperties> {
  ...ResourceNameParameter<
    Resource = ServerSiteResource,
    KeyName = "siteName",
    SegmentName = "serverSites"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ServerSiteOperationsStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("serverSites")
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
interface ServerSiteResources {
  /**
   * Get a ServerSiteResource
   */
  @tag("ServerSitesController")
  get is ArmResourceRead<ServerSiteResource>;

  /**
   * Create a ServerSiteResource
   */
  @tag("ServerSitesController")
  create is ArmResourceCreateOrReplaceAsync<
    ServerSiteResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ServerSiteResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a ServerSiteResource
   */
  @tag("ServerSitesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ServerSiteResource,
    PatchModel = ServerSiteResourceUpdate
  >;

  /**
   * Delete a ServerSiteResource
   */
  @tag("ServerSitesController")
  delete is ArmResourceDeleteSync<ServerSiteResource>;

  /**
   * List ServerSiteResource resources by resource group
   */
  @tag("ServerSitesController")
  listByResourceGroup is ArmResourceListByParent<ServerSiteResource>;

  /**
   * List ServerSiteResource resources by subscription ID
   */
  @tag("ServerSitesController")
  listBySubscription is ArmListBySubscription<ServerSiteResource>;

  /**
   * Get the error summary for a server site.
   */
  @tag("ServerSitesController")
  computeErrorSummary is ArmResourceActionSync<
    ServerSiteResource,
    unknown,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Get a serve site usage.
   */
  @tag("ServerSitesController")
  computeusage is ArmResourceActionSync<
    ServerSiteResource,
    unknown,
    ArmResponse<ServerSiteUsageResponse>
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  @tag("ServerSitesController")
  exportApplications is ArmResourceActionAsync<
    ServerSiteResource,
    unknown,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to generate report containing
   *             machine and the errors encountered during guest discovery of the machine.
   */
  @tag("ServerSitesController")
  exportMachineErrors is ArmResourceActionAsync<
    ServerSiteResource,
    ExportMachineErrorsRequest,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to get site health summary.
   */
  @tag("ServerSitesController")
  listHealthSummary is ArmResourceActionSync<
    ServerSiteResource,
    void,
    ArmResponse<SiteHealthSummaryCollection>
  >;

  /**
   * Operation to refresh a site
   */
  @tag("ServerSitesController")
  refreshSite is ArmResourceActionAsync<
    ServerSiteResource,
    void,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to get site usage.
   */
  @tag("ServerSitesController")
  summary is ArmResourceActionSync<
    ServerSiteResource,
    void,
    ArmResponse<ServerSiteUsage>
  >;

  /**
   * Method to enable disable dependency map status for machines
   *             in a site.
   */
  @tag("ServerSitesController")
  updateDependencyMapStatus is ArmResourceActionAsync<
    ServerSiteResource,
    UpdateMachineDepMapStatus,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to update custom properties for servers
   */
  @tag("ServerSitesController")
  updateProperties is ArmResourceActionAsync<
    ServerSiteResource,
    MachineMetadataCollection,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * API to list client group members for the selected client group.
   */
  @tag("ServerDependencyMapController")
  clientGroupMembers is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsClientGroupMembersRequest,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * API to generate report containing agentless dependencies.
   */
  @tag("ServerDependencyMapController")
  exportDependencies is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsExportDependenciesRequest,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * API to generate coarse map for the list of machines.
   */
  @tag("ServerDependencyMapController")
  generateCoarseMap is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsScopeMapRequest,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * API to generate detailed map for a selected machine.
   */
  @tag("ServerDependencyMapController")
  generateDetailedMap is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * API to list server group members for the selected server group.
   */
  @tag("ServerDependencyMapController")
  serverGroupMembers is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsServerGroupMembersRequest,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * A operation status resource belonging to a site resource.
   */
  @tag("ServerOperationsStatusController")
  getServerSiteOperationsStatus is ServerSiteOperationsStatusOps.Read<
    OperationStatus,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(ServerSiteResource.name, "Site name");
@@doc(ServerSiteResource.properties,
  "The resource-specific properties for this resource."
);
