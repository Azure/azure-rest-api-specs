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

@armResourceOperations(#{ omitTags: true })
interface HypervOperationsStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("hypervSites")
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
interface HypervSites {
  /**
   * Get a HypervSite
   */
  @tag("HypervSitesController")
  get is ArmResourceRead<HypervSite>;

  /**
   * Create a HypervSite
   */
  @tag("HypervSitesController")
  create is ArmResourceCreateOrReplaceSync<HypervSite>;

  /**
   * Update a HypervSite
   */
  @tag("HypervSitesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<HypervSite, PatchModel = HypervSiteUpdate>;

  /**
   * Delete a HypervSite
   */
  @tag("HypervSitesController")
  delete is ArmResourceDeleteSync<HypervSite>;

  /**
   * Get all the hyperv sites in the subscription.
   */
  @summary("Get all hyperv sites.")
  @tag("HypervSites")
  listByResourceGroup is ArmResourceListByParent<HypervSite>;

  /**
   * Get all the hyperv  sites in the subscription.
   */
  @summary("Get all hyperv  sites.")
  @tag("HypervSites")
  listBySubscription is ArmListBySubscription<HypervSite>;

  /**
   * Method to get site error summary.
   */
  @tag("HypervSitesController")
  computeErrorSummary is ArmResourceActionSync<
    HypervSite,
    unknown,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Get a hyperv site usage.
   */
  @tag("HypervSitesController")
  computeusage is ArmResourceActionSync<
    HypervSite,
    unknown,
    ArmResponse<HypervSiteUsage>
  >;

  /**
   * Method to generate report containing
   *             machine and the deep discovery of the application installed in the machine.
   */
  @tag("HypervSitesController")
  exportApplications is ArmResourceActionAsync<HypervSite, unknown, unknown>;

  /**
   * Method to generate report containing
   *             machine and the errors encountered during guest discovery of the machine.
   */
  @tag("HypervSitesController")
  exportMachineErrors is ArmResourceActionAsync<
    HypervSite,
    ExportMachineErrorsRequest,
    unknown
  >;

  /**
   * Method to get site health summary.
   */
  @tag("HypervSitesController")
  listHealthSummary is ArmResourceActionSync<
    HypervSite,
    void,
    ArmResponse<SiteHealthSummaryCollection>
  >;

  /**
   * Method to get site usage.
   */
  @tag("HypervSitesController")
  summary is ArmResourceActionSync<
    HypervSite,
    void,
    ArmResponse<HypervSiteUsage>
  >;

  /**
   * API to list client group members for the selected client group.
   */
  @tag("HypervDependencyMapController")
  clientGroupMembers is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsClientGroupMembersRequest,
    unknown
  >;

  /**
   * API to generate report containing agentless dependencies.
   */
  @tag("HypervDependencyMapController")
  exportDependencies is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsExportDependenciesRequest,
    unknown
  >;

  /**
   * API to generate coarse map for the list of machines.
   */
  @tag("HypervDependencyMapController")
  generateCoarseMap is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsScopeMapRequest,
    unknown
  >;

  /**
   * API to generate detailed map for a selected machine.
   */
  @tag("HypervDependencyMapController")
  generateDetailedMap is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
    unknown
  >;

  /**
   * API to list server group members for the selected server group.
   */
  @tag("HypervDependencyMapController")
  serverGroupMembers is ArmResourceActionAsync<
    HypervSite,
    DependencyMapServiceMapextensionsServerGroupMembersRequest,
    unknown
  >;

  /**
   * Method to enable disable dependency map status for machines
   *             in a site.
   */
  @tag("HypervDependencyMapController")
  updateDependencyMapStatus is ArmResourceActionAsync<
    HypervSite,
    UpdateMachineDepMapStatus,
    unknown
  >;

  /**
   * Method to update custom properties for HYPERV machines
   *             in a site.
   */
  @tag("HypervMachinesController")
  updateProperties is ArmResourceActionAsync<
    HypervSite,
    MachineMetadataCollection,
    unknown
  >;

  /**
   * Method to get operation status.
   */
  @tag("HypervOperationsStatusController")
  getHypervOperationsStatus is HypervOperationsStatusOps.Read<
    OperationStatus,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(HypervSite.name, "Site name");
@@doc(HypervSite.properties,
  "The resource-specific properties for this resource."
);
