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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "Backward compatibility"
        @path
        @segment("serverSites")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        siteName: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "Backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_Get")
  get is ArmResourceRead<ServerSiteResource>;

  /**
   * Create a ServerSiteResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ServerSiteResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ServerSiteResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a ServerSiteResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ServerSiteResource,
    PatchModel = ServerSiteResourceUpdate
  >;

  /**
   * Delete a ServerSiteResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_Delete")
  delete is ArmResourceDeleteSync<ServerSiteResource>;

  /**
   * List ServerSiteResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ServerSiteResource>;

  /**
   * List ServerSiteResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_ListBySubscription")
  listBySubscription is ArmListBySubscription<ServerSiteResource>;

  /**
   * Get the error summary for a server site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_ComputeErrorSummary")
  computeErrorSummary is ArmResourceActionSync<
    ServerSiteResource,
    unknown,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Get a serve site usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_Computeusage")
  computeusage is ArmResourceActionSync<
    ServerSiteResource,
    unknown,
    ArmResponse<ServerSiteUsageResponse>
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_ExportApplications")
  exportApplications is ArmResourceActionAsync<
    ServerSiteResource,
    unknown,
    ArmResponse<unknown>
  >;

  /**
   * Method to generate report containing
   *             machine and the errors encountered during guest discovery of the machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_ExportMachineErrors")
  exportMachineErrors is ArmResourceActionAsync<
    ServerSiteResource,
    ExportMachineErrorsRequest,
    ArmResponse<unknown>
  >;

  /**
   * Method to get site health summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_ListHealthSummary")
  @list
  listHealthSummary is ArmResourceActionSync<
    ServerSiteResource,
    void,
    ArmResponse<SiteHealthSummaryCollection>
  >;

  /**
   * Operation to refresh a site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_RefreshSite")
  refreshSite is ArmResourceActionAsync<
    ServerSiteResource,
    void,
    ArmResponse<unknown>
  >;

  /**
   * Method to get site usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_Summary")
  summary is ArmResourceActionSync<
    ServerSiteResource,
    void,
    ArmResponse<ServerSiteUsage>
  >;

  /**
   * Method to enable disable dependency map status for machines
   *             in a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_UpdateDependencyMapStatus")
  updateDependencyMapStatus is ArmResourceActionAsync<
    ServerSiteResource,
    UpdateMachineDepMapStatus,
    ArmResponse<unknown>
  >;

  /**
   * Operation to update custom properties for servers
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerSitesController")
  @operationId("ServerSitesController_UpdateProperties")
  updateProperties is ArmResourceActionAsync<
    ServerSiteResource,
    MachineMetadataCollection,
    ArmResponse<unknown>
  >;

  /**
   * API to list client group members for the selected client group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerDependencyMapController")
  @operationId("ServerDependencyMapController_ClientGroupMembers")
  clientGroupMembers is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsClientGroupMembersRequest,
    ArmResponse<unknown>
  >;

  /**
   * API to generate report containing agentless dependencies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerDependencyMapController")
  @operationId("ServerDependencyMapController_ExportDependencies")
  exportDependencies is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsExportDependenciesRequest,
    ArmResponse<unknown>
  >;

  /**
   * API to generate coarse map for the list of machines.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerDependencyMapController")
  @operationId("ServerDependencyMapController_GenerateCoarseMap")
  generateCoarseMap is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsScopeMapRequest,
    ArmResponse<unknown>
  >;

  /**
   * API to generate detailed map for a selected machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerDependencyMapController")
  @operationId("ServerDependencyMapController_GenerateDetailedMap")
  generateDetailedMap is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
    ArmResponse<unknown>
  >;

  /**
   * API to list server group members for the selected server group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerDependencyMapController")
  @operationId("ServerDependencyMapController_ServerGroupMembers")
  serverGroupMembers is ArmResourceActionAsync<
    ServerSiteResource,
    DependencyMapServiceMapextensionsServerGroupMembersRequest,
    ArmResponse<unknown>
  >;

  /**
   * A operation status resource belonging to a site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ServerOperationsStatusController")
  @operationId("ServerOperationsStatusController_GetServerSiteOperationsStatus")
  getServerSiteOperationsStatus is ServerSiteOperationsStatusOps.Read<
    OperationStatus,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(ServerSiteResource.name, "Site name");
@@doc(ServerSiteResource.properties,
  "The resource-specific properties for this resource."
);
