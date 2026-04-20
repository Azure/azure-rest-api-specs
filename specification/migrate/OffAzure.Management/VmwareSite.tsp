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
 * A VmwareSite
 */
model VmwareSite is Azure.ResourceManager.TrackedResource<SitesProperties> {
  ...ResourceNameParameter<
    Resource = VmwareSite,
    KeyName = "siteName",
    SegmentName = "vmwareSites"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface VmwareSites {
  /**
   * Get a VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_Get")
  get is ArmResourceRead<VmwareSite>;

  /**
   * Create a VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_Create")
  create is ArmResourceCreateOrReplaceSync<VmwareSite>;

  /**
   * Update a VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<VmwareSite, PatchModel = VmwareSiteUpdate>;

  /**
   * Delete a VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_Delete")
  delete is ArmResourceDeleteSync<VmwareSite>;

  /**
   * Get all the vmware sites in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VmwareSite>;

  /**
   * Get all the vmware sites in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_ListBySubscription")
  listBySubscription is ArmListBySubscription<VmwareSite>;

  /**
   * Method to get site error summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_ComputeErrorSummary")
  computeErrorSummary is ArmResourceActionSync<
    VmwareSite,
    unknown,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to get site error summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_Computeusage")
  computeusage is ArmResourceActionSync<
    VmwareSite,
    unknown,
    ArmResponse<VmwareSiteUsage>
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_ExportApplications")
  exportApplications is ArmResourceActionAsync<
    VmwareSite,
    unknown,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to generate report containing
   *             machine and the errors encountered during guest discovery of the machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_ExportMachineErrors")
  exportMachineErrors is ArmResourceActionAsync<
    VmwareSite,
    ExportMachineErrorsRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_ExportMachines")
  exportMachines is ArmResourceActionAsync<
    VmwareSite,
    ExportMachinesRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to get site health summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_ListHealthSummary")
  @list
  listHealthSummary is ArmResourceActionSync<
    VmwareSite,
    void,
    ArmResponse<SiteHealthSummaryCollection>
  >;

  /**
   * Method to get site usage/summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SitesController_Summary")
  summary is ArmResourceActionSync<
    VmwareSite,
    void,
    ArmResponse<VmwareSiteUsage>
  >;

  /**
   * API to list client group members for the selected client group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DependencyMapController_ClientGroupMembers")
  clientGroupMembers is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsClientGroupMembersRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to generate report containing agentless dependencies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DependencyMapController_ExportDependencies")
  exportDependencies is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsExportDependenciesRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to generate coarse map for the list of machines.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DependencyMapController_GenerateCoarseMap")
  generateCoarseMap is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsScopeMapRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to generate detailed map for a selected machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DependencyMapController_GenerateDetailedMap")
  generateDetailedMap is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * API to list server group members for the selected server group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DependencyMapController_ServerGroupMembers")
  serverGroupMembers is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsServerGroupMembersRequest,
    ArmResponse<AnyObject>
  >;

  /**
   * A operation status resource belonging to a site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VmwareOperationsStatus_GetVmwareOperationStatus")
  @get
  @action("{operationStatusName}")
  getVmwareOperationStatus is ArmResourceActionSync<
    VmwareSite,
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

  /**
   * Method to enable disable dependency map status for machines
   *             in a
   * site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VmwarePropertiesController_UpdateDependencyMapStatus")
  updateDependencyMapStatus is ArmResourceActionAsync<
    VmwareSite,
    UpdateMachineDepMapStatus,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to update properties for machines   in a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VmwarePropertiesController_UpdateProperties")
  updateProperties is ArmResourceActionAsync<
    VmwareSite,
    MachineMetadataCollection,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to associate Run as account to machine
   *             in a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VmwarePropertiesController_UpdateRunAsAccount")
  updateRunAsAccount is ArmResourceActionAsync<
    VmwareSite,
    UpdateMachineRunAsAccount,
    ArmResponse<AnyObject>
  >;

  /**
   * Method to associate Run as account to machine
   *             in a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VmwarePropertiesController_UpdateTags")
  updateTags is ArmResourceActionAsync<
    VmwareSite,
    UpdateMachineTags,
    ArmResponse<AnyObject>
  >;
}

@@doc(VmwareSite.name, "Site name");
@@doc(VmwareSite.properties,
  "The resource-specific properties for this resource."
);
