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

@armResourceOperations(#{ omitTags: true })
interface VmwareSiteOperationsStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("vmwareSites")
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
interface VmwareSites {
  /**
   * Get a VmwareSite
   */
  @tag("SitesController")
  get is ArmResourceRead<VmwareSite>;

  /**
   * Create a VmwareSite
   */
  @tag("SitesController")
  create is ArmResourceCreateOrReplaceSync<VmwareSite>;

  /**
   * Update a VmwareSite
   */
  @tag("SitesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<VmwareSite, PatchModel = VmwareSiteUpdate>;

  /**
   * Delete a VmwareSite
   */
  @tag("SitesController")
  delete is ArmResourceDeleteSync<VmwareSite>;

  /**
   * Get all the vmware sites in the resource group.
   */
  @summary("Get all vmware sites.")
  @tag("SitesController")
  listByResourceGroup is ArmResourceListByParent<VmwareSite>;

  /**
   * Get all the vmware sites in the subscription.
   */
  @summary("Get all vmware sites.")
  @tag("SitesController")
  listBySubscription is ArmListBySubscription<VmwareSite>;

  /**
   * Method to get site error summary.
   */
  @tag("SitesController")
  computeErrorSummary is ArmResourceActionSync<
    VmwareSite,
    unknown,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to get site error summary.
   */
  @tag("SitesController")
  computeusage is ArmResourceActionSync<
    VmwareSite,
    unknown,
    ArmResponse<VmwareSiteUsage>
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  @tag("SitesController")
  exportApplications is ArmResourceActionAsync<VmwareSite, unknown, unknown>;

  /**
   * Method to generate report containing
   *             machine and the errors encountered during guest discovery of the machine.
   */
  @tag("SitesController")
  exportMachineErrors is ArmResourceActionAsync<
    VmwareSite,
    ExportMachineErrorsRequest,
    unknown
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  @tag("SitesController")
  exportMachines is ArmResourceActionAsync<
    VmwareSite,
    ExportMachinesRequest,
    unknown
  >;

  /**
   * Method to get site health summary.
   */
  @tag("SitesController")
  listHealthSummary is ArmResourceActionSync<
    VmwareSite,
    void,
    ArmResponse<SiteHealthSummaryCollection>
  >;

  /**
   * Method to get site usage/summary.
   */
  @tag("SitesController")
  summary is ArmResourceActionSync<
    VmwareSite,
    void,
    ArmResponse<VmwareSiteUsage>
  >;

  /**
   * API to list client group members for the selected client group.
   */
  @tag("DependencyMapController")
  clientGroupMembers is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsClientGroupMembersRequest,
    unknown
  >;

  /**
   * API to generate report containing agentless dependencies.
   */
  @tag("DependencyMapController")
  exportDependencies is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsExportDependenciesRequest,
    unknown
  >;

  /**
   * API to generate coarse map for the list of machines.
   */
  @tag("DependencyMapController")
  generateCoarseMap is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsScopeMapRequest,
    unknown
  >;

  /**
   * API to generate detailed map for a selected machine.
   */
  @tag("DependencyMapController")
  generateDetailedMap is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
    unknown
  >;

  /**
   * API to list server group members for the selected server group.
   */
  @tag("DependencyMapController")
  serverGroupMembers is ArmResourceActionAsync<
    VmwareSite,
    DependencyMapServiceMapextensionsServerGroupMembersRequest,
    unknown
  >;

  /**
   * A operation status resource belonging to a site resource.
   */
  @tag("VmwareOperationsStatus")
  getVmwareOperationStatus is VmwareSiteOperationsStatusOps.Read<
    OperationStatus,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Method to enable disable dependency map status for machines
   *             in a
   * site.
   */
  @tag("VmwarePropertiesController")
  updateDependencyMapStatus is ArmResourceActionAsync<
    VmwareSite,
    UpdateMachineDepMapStatus,
    unknown
  >;

  /**
   * Method to update properties for machines   in a site.
   */
  @tag("VmwarePropertiesController")
  updateProperties is ArmResourceActionAsync<
    VmwareSite,
    MachineMetadataCollection,
    unknown
  >;

  /**
   * Method to associate Run as account to machine
   *             in a site.
   */
  @tag("VmwarePropertiesController")
  updateRunAsAccount is ArmResourceActionAsync<
    VmwareSite,
    UpdateMachineRunAsAccount,
    unknown
  >;

  /**
   * Method to associate Run as account to machine
   *             in a site.
   */
  @tag("VmwarePropertiesController")
  updateTags is ArmResourceActionAsync<VmwareSite, UpdateMachineTags, unknown>;
}

@@doc(VmwareSite.name, "Site name");
@@doc(VmwareSite.properties,
  "The resource-specific properties for this resource."
);
