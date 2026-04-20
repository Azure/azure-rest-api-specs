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
 * A HyperV SiteResource
 */
model HypervSite is Azure.ResourceManager.TrackedResource<SiteProperties> {
  ...ResourceNameParameter<
    Resource = HypervSite,
    KeyName = "siteName",
    SegmentName = "hypervSites"
  >;
}

@armResourceOperations
interface HypervSites {
  /**
   * Get a HypervSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_Get")
  get is ArmResourceRead<HypervSite>;

  /**
   * Create a HypervSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_Create")
  create is ArmResourceCreateOrReplaceSync<HypervSite>;

  /**
   * Update a HypervSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<HypervSite, PatchModel = HypervSiteUpdate>;

  /**
   * Delete a HypervSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_Delete")
  delete is ArmResourceDeleteSync<HypervSite>;

  /**
   * Get all the hyperv sites in the subscription.
   */
  listByResourceGroup is ArmResourceListByParent<HypervSite>;

  /**
   * Get all the hyperv  sites in the subscription.
   */
  listBySubscription is ArmListBySubscription<HypervSite>;

  /**
   * Method to get site error summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_ComputeErrorSummary")
  computeErrorSummary is ArmResourceActionSync<
    HypervSite,
    unknown,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Get a hyperv site usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_Computeusage")
  computeusage is ArmResourceActionSync<
    HypervSite,
    unknown,
    ArmResponse<HypervSiteUsage>
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_ExportApplications")
  exportApplications is ArmResourceActionAsync<
    HypervSite,
    unknown,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to generate report containing
   *             machine and the errors encountered during guest discovery of the machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_ExportMachineErrors")
  exportMachineErrors is ArmResourceActionAsync<
    HypervSite,
    ExportMachineErrorsRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to get site health summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_ListHealthSummary")
  @list
  listHealthSummary is ArmResourceActionSync<
    HypervSite,
    void,
    ArmResponse<SiteHealthSummaryCollection>
  >;

  /**
   * Method to get site usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervSitesController_Summary")
  summary is ArmResourceActionSync<
    HypervSite,
    void,
    ArmResponse<HypervSiteUsage>
  >;

  /**
   * API to list client group members for the selected client group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervDependencyMapController_ClientGroupMembers")
  clientGroupMembers is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsClientGroupMembersRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to generate report containing agentless dependencies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervDependencyMapController_ExportDependencies")
  exportDependencies is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsExportDependenciesRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to generate coarse map for the list of machines.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervDependencyMapController_GenerateCoarseMap")
  generateCoarseMap is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsScopeMapRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to generate detailed map for a selected machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervDependencyMapController_GenerateDetailedMap")
  generateDetailedMap is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to list server group members for the selected server group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervDependencyMapController_ServerGroupMembers")
  serverGroupMembers is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsServerGroupMembersRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to enable disable dependency map status for machines
   *             in a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervDependencyMapController_UpdateDependencyMapStatus")
  updateDependencyMapStatus is ArmResourceActionAsync<
    HypervSite,
    UpdateMachineDepMapStatus,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to update custom properties for HYPERV machines
   *             in a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervMachinesController_UpdateProperties")
  updateProperties is ArmResourceActionAsync<
    HypervSite,
    MachineMetadataCollection,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to get operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervOperationsStatusController_GetHypervOperationsStatus")
  @get
  @action("{operationStatusName}")
  getHypervOperationsStatus is ArmResourceActionSync<
    HypervSite,
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

@@doc(HypervSite.name, "Site name");
@@doc(HypervSite.properties,
  "The resource-specific properties for this resource."
);
