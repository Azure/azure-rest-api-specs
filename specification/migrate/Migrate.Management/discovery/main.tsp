import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@azure-tools/typespec-providerhub";

import "./operationsOverload.tsp";
import "../operationsTemp.tsp";
import "../operationsCore.tsp";

import "./webmodels/common/common.tsp";
import "./webmodels/common/jobProperties.tsp";
import "./webmodels/common/siteErrorSummaryCollection.tsp";
import "./webmodels/common/runAsAccountProperties.tsp";
import "./webmodels/common/operationStatusProperties.tsp";

import "./webmodels/vmware/vmwareSiteProperties.tsp";
import "./webmodels/vmware/vmwareMachineProperties.tsp";
import "./webmodels/vmware/vmwareVcenterProperties.tsp";
import "./webmodels/vmware/vmwareHostProperties.tsp";

import "./webmodels/hyperv/hyperVSiteProperties.tsp";
import "./webmodels/hyperv/hypervClusterProperties.tsp";
import "./webmodels/hyperv/hypervHostProperties.tsp";
import "./webmodels/hyperv/hypervMachineProperties.tsp";

import "./webmodels/server/serverSiteProperties.tsp";
import "./webmodels/server/serverSiteUsageResponse.tsp";
import "./webmodels/server/serverProperties.tsp";
import "./webmodels/server/serverOperationStatusProperties.tsp";

import "./webmodels/import/importSiteProperties.tsp";
import "./webmodels/import/importJobProperties.tsp";
import "./webmodels/import/importMachineProperties.tsp";
import "./webmodels/import/importCommon.tsp";

import "./webmodels/sql/sqlmodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

@armProviderNamespace
@service({
  title: "Azure Migrate Discovery Service",
})

@doc("Azure OffAzure Resource Provider management API.")
namespace Microsoft.OffAzure;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("service api versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2018_05_01_preview: "2018-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2019_05_01_preview: "2019-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_01_01: "2020-01-01",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_01_01_preview: "2020-01-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_02_01: "2020-02-01",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_07_07: "2020-07-07",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_07_10: "2020-07-10",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_08_01_preview: "2020-08-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_11_11_preview: "2020-11-11-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_10_27: "2022-10-27",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_06_06: "2023-06-06",
}


@doc("A VmwareSite")
@resource("vmwareSites")
model VmwareSite is TrackedResource<SitesProperties> {

  @key("siteName")
  @segment("vmwareSites")
  @doc("Site name")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  ...EntityTag;
}



@armResourceOperations
@added(Versions.v2018_05_01_preview)
interface HypervClusterController {
  @doc("Method to get a Hyper-V cluster.")  
  getCluster is ArmResourceRead<HypervCluster>;

  @doc("Method to put a Hyper-V cluster.")  
  createCluster is ArmResourceCreateOrUpdateAsyncCustom<HypervCluster>;

  //added in Swagger
  @added(Versions.v2022_10_27)  
  delete is ArmResourceDeleteSync<HypervCluster>;
  
  GetAllClustersInSite is ArmResourceListByParent<
    HypervCluster,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      @doc("filter query")
      @query
      filter?: string;
    }
  >;
}

@armResourceOperations
interface Sites {
  @added(Versions.v2018_05_01_preview)
  
  get is ArmResourceRead<VmwareSite>;

  @added(Versions.v2018_05_01_preview)
  delete is ArmResourceDeleteSync<VmwareSite>;
  
  @added(Versions.v2018_05_01_preview)  
  create is ArmResourceCreateOrUpdateSyncCustom<VmwareSite>;

  // @armResourceUpdate(InnerError)
  // @patch
  // @added(Versions.v2018_05_01_preview)
  // 
  // @doc("Update a VmwareSite")
  // updateVmwareSite(
  //   ...ResourceInstanceParameters<VmwareSite>,

  @added(Versions.v2018_05_01_preview)
  
  @doc("Update a VmwareSite")
  update is ArmResourcePatchSync<
  VmwareSite,
  SiteProperties
  >;

  //   @doc(" body with updated properties.")
  //   @body
  //   body: VmwareSite
  // ): ArmResponse<VmwareSite>;

  @added(Versions.v2022_10_27)
  @summary("Get all vmware sites.")
  @doc("Get all the vmware sites in the subscription.")
  
  listBySubscription is ArmListBySubscription<VmwareSite>;

  @added(Versions.v2020_01_01)
  @summary("Get all vmware sites.")
  @doc("Get all the vmware sites in the resource group.")
  listByParent is ArmResourceListByParent<VmwareSite>;

  @doc("Method to get site health summary.")
  @armResourceAction(InnerError)
  @added(Versions.v2018_05_01_preview)
  @post
  
  listHealthSummary(
    ...ResourceInstanceParameters<VmwareSite>
  ): ArmResponse<SiteHealthSummaryCollection> |ErrorResponse;

  @doc("Method to refresh a site.")
  @added(Versions.v2018_05_01_preview)
  
  refresh is ArmResourceActionAsyncNoRequestBody<VmwareSite, {}>;

  @doc("Method to get site usage/summary.")
  @added(Versions.v2020_01_01)
  
  summary is ArmResourceActionSyncNoRequestBody<VmwareSite, VmwareSiteUsage>;


  // @doc("Method to get site error summary.")
  // @armResourceRead(InnerError)
  // @segment("errorSummary")
  // @added(Versions.v2018_05_01_preview)
  // @get  
  // getErrorSummary(
  //   ...ResourceInstanceParameters<VmwareSite>,

  //   @doc("Appliance Name")
  //   @query
  //   applianceName: string
  // ): ArmResponse<SiteErrorSummary> | ErrorResponse;

  @doc("Method to get site error summary.")
  @added(Versions.v2023_06_06)
  errorSummary is ArmResourceActionSync<
  VmwareSite,
    {},
    SiteErrorSummary
  >;

  // @doc("Method to get site error summary.")
  // @armResourceRead(InnerError)
  // @segment("usage")
  // @added(Versions.v2018_05_01_preview)
  // @get
  
  // getUsage(
  //   ...ResourceInstanceParameters<VmwareSite>
  // ): ArmResponse<VmwareSiteUsage> | ErrorResponse;

  @doc("Method to get site error summary.")
  @added(Versions.v2023_06_06)
  usage is ArmResourceActionSync<
  VmwareSite,
    {},
    VmwareSiteUsage
  >;


  // @doc("Method to generate report containing \r\n            machine and the deep discovery of the application installed in the machine.")
  // @armResourceAction(InnerError)
  // @added(Versions.v2020_01_01)
  // @post
  
  // @extension("x-ms-long-running-operation", true)
  // @extension(
  //   "x-ms-long-running-operation-options",
  //   {
  //     "final-state-via": "location",
  //   }
  // )
  // exportMachines(
  //   ...ResourceInstanceParameters<VmwareSite>,

  //   @doc("filter query")
  //   @query
  //   filter?: string
  // ): ArmAcceptedResponseWithLocationHeader | ErrorResponse;

  @doc("Method to generate report containing \r\n            machine and the deep discovery of the application installed in the machine.")
  @added(Versions.v2023_06_06)  
  exportMachines is ArmResourceActionAsync<
    VmwareSite,
    ExportMachinesRequest,
    {}
  >;

  @doc("Method to generate report containing \r\n            machine and the errors encountered during guest discovery of the machine.")
  @added(Versions.v2020_01_01)  
  exportMachineErrors is ArmResourceActionAsync<
    VmwareSite,
    VersionedV202001ExportMachineErrorsRequest,
    {}
  >;

  @added(Versions.v2018_05_01_preview)
  @doc("Method to generate report containing\r\n            machine and the deep discovery of the application installed in the machine.")
  
  exportApplications is ArmResourceActionNoBodyAsync<VmwareSite>;
}

@armResourceOperations
interface VmwareOperationsStatus {
  @doc("A operation status resource belonging to a site resource.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2018_05_01_preview)
  
  getVmwareOperationStatus(
    ...ResourceInstanceParameters<VmwareSite>,

    @doc("Operation status  Arm Name.")
    @path
    @segment("operationsStatus")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    operationStatusName: string
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

@armResourceOperations
interface VmwarePropertiesController {
  @added(Versions.v2019_05_01_preview)
  @doc("""
Method to enable disable dependency map status for machines
            in a
site.
""")
  
  updateDependencyMapStatus is ArmResourceActionNoContentAsyncCustomUpdateMachineDepMapStatus<
    VmwareSite,
    UpdateMachineDepMapStatus,
    {}
  >;

  // @added(Versions.v2019_05_01_preview)
  // @doc("Method to associate Run as account to machine\r\n            in a site.")
  // UpdateRunAsAccount is ArmResourceActionNoContentAsyncCustomUpdateRunAsAccount<
  //   VmwareSite,
  //   UpdateMachineRunAsAccount
  // >;

  // @added(Versions.v2019_05_01_preview)
  // @doc("Method to associate Run as account to machine\r\n            in a site.")
  // UpdateTags is ArmResourceActionNoContentAsyncCustomUpdateMachineTags<
  //   VmwareSite,
  //   UpdateMachineTags
  // >;

  @added(Versions.v2019_05_01_preview)
  @doc("Method to update properties for machines   in a site.")
  updateProperties is ArmResourceActionNoContentAsyncMetaDataBody<
    VmwareSite,
    MachineMetadataList,
    {}
  >;
}

@armResourceOperations
interface WebAppPropertiesController {
  @added(Versions.v2020_11_11_preview)
  @doc("""
Method to update properties for web applications.
            in a site.
""")
  
  updateProperties is ArmResourceActionAsync<
    WebAppSite,
    WebAppPropertiesCollection,
    {}
  >;
}

@armResourceOperations
interface DependencyMapController {
  @doc("API to generate coarse map for the list of machines.")
  @added(Versions.v2020_01_01_preview)
  
  generateCoarseMap is ArmResourceActionAsyncCustomMapRequest<
    VmwareSite,
    VmwareSite,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest
  >;

  @doc("API to generate detailed map for a selected machine.")
  
  @added(Versions.v2020_01_01_preview)
  generateDetailedMap is ArmResourceActionAsyncCustomMapRequest<
    VmwareSite,
    VmwareSite,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest
  >;

  @doc("API to list client group members for the selected client group.")
  @added(Versions.v2020_01_01_preview)
  
  clientGroupMembers is ArmResourceActionAsyncCustomMapRequest<
    VmwareSite,
    VmwareSite,
    DependencyMapServiceMapextensionsClientGroupMembersRequest
  >;

  @doc("API to list server group members for the selected server group.")
  
  @added(Versions.v2020_01_01_preview)
  serverGroupMembers is ArmResourceActionAsyncCustomMapRequest<
    VmwareSite,
    VmwareSite,
    DependencyMapServiceMapextensionsServerGroupMembersRequest
  >;

  @doc("API to generate report containing agentless dependencies.")
  @added(Versions.v2020_01_01_preview)
  
  exportDependencies is ArmResourceActionAsyncCustomMapRequest<
    VmwareSite,
    VmwareSite,
    DependencyMapServiceMapextensionsExportDependenciesRequest
  >;
}

//#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("An machine resource belonging to a site resource.")
@parentResource(VmwareSite)
model MachineResource is ProxyResource<VmwareMachineProperties> {
  @doc("Machine name")
  @key("machineName")
  @segment("machines")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  // @doc("Gets tags that can be used with ODATA")
  // @added(Versions.v2020_07_10)
  // tags?: Record<Object>;
}

@armResourceOperations
interface MachinesController {
  @added(Versions.v2018_05_01_preview)
  
  get is ArmResourceRead<MachineResource>;

  @added(Versions.v2022_10_27)
  
  update is ArmResourcePatchSync<
  MachineResource,
  VmwareMachineProperties
  >;


  @added(Versions.v2018_05_01_preview)
  
  listByParent is ArmResourceListByParent<
    MachineResource,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: int32;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;


  @doc("Method to stop a machine.")
  @added(Versions.v2018_05_01_preview)
  
  stop is ArmResourceActionAsyncNoRequestBody<MachineResource, {}>;

  @doc("Method to start a machine.")
  @added(Versions.v2018_05_01_preview)
  
  start is ArmResourceActionAsyncNoRequestBody<MachineResource, {}>;

  // @doc("Method to get a machines software inventory like applications and roles.")
  // @armResourceRead(InnerError)
  // @get
  // @added(Versions.v2020_07_10)
  // @segment("softwareInventory/default")
  
  // getMachineSoftwareInventory(
  //   ...ResourceInstanceParameters<MachineResource>
  // ): ArmResponse<VmwareMachineSoftwareInventory> | ErrorResponse;

  @doc("Method to get a machines software inventory like applications and roles.")
  @added(Versions.v2023_06_06)
  @action("softwareInventory/default")
  getMachineSoftwareInventory is ArmResourceActionSync<
  MachineResource,
    {},
    VmwareMachineSoftwareInventory
  >;
}
@armResourceOperations
interface VmwareMachinesController {
  // @doc("Method to get machine with application and roles present in it.")
  // @segment("applications")
  // @armResourceRead(InnerError)
  // @added(Versions.v2018_05_01_preview)
  // @get
  
  // getApplications(
  //   ...ResourceInstanceParameters<MachineResource>
  // ): ArmResponse<MachineResource> | ErrorResponse ;

  @doc("Method to get machine with application and roles present in it.")
  @added(Versions.v2023_06_06)
  applications is ArmResourceActionSync<
  MachineResource,
    {},
    MachineResource
  >;
}
@doc("A vcenter resource belonging to a site resource.")
@parentResource(VmwareSite)
model Vcenter is ProxyResource<VcenterProperties> {
  @doc(" VCenters name")
  @key("vcenterName")
  @segment("vCenters")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
@added(Versions.v2018_05_01_preview)
interface VcenterController {
  
  get is ArmResourceRead<Vcenter>;
  
  create is ArmResourceCreateOrUpdateAsyncCustom<Vcenter>;
  
  delete is ArmResourceDeleteSync<Vcenter>;
  
  listByParent is ArmResourceListByParent<
    Vcenter,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;
    }
  >;
}

@doc("A runasaccount resource belonging to a site resource.")
@parentResource(VmwareSite)
model VmwareRunAsAccountResource
  is ProxyResource<RunAsAccountRunAsAccountProperties> {
  @doc(" RunAsAccounts name")
  @key("accountName")
  @segment("runAsAccounts")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
@added(Versions.v2018_05_01_preview)
interface RunAsAccountsController {
  
  get is ArmResourceRead<VmwareRunAsAccountResource>;
  
  listByParent is ArmResourceListByParent<VmwareRunAsAccountResource>;
}

@doc("A host resource belonging to a site resource.")
@parentResource(VmwareSite)
model VmwareHostResource is ProxyResource<VmwareHostProperties> {
  @doc(" Hosts name")
  @key("hostName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("hosts")

  @path
  name: string;
}

@armResourceOperations
interface VmwareHostController {
  @added(Versions.v2020_01_01_preview)
  get is ArmResourceRead<VmwareHostResource>;

  @added(Versions.v2020_01_01_preview)
  listByParent is ArmResourceListByParent<VmwareHostResource>;
}

@doc("A host resource belonging to a site resource.")
@parentResource(VmwareSite)
model VmwareJobResource is ProxyResource<JobProperties> {
  @doc(" Jobs name")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("jobName")
  @segment("jobs")
  @path
  name: string;
}

@armResourceOperations
@added(Versions.v2018_05_01_preview)
interface HypervJobsController {
  
  get is ArmResourceRead<VmwareJobResource>;
  
  listByParent is ArmResourceListByParent<VmwareJobResource>;
}

 #suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("A HyperV SiteResource")
model HypervSite is TrackedResource<SiteProperties> {

  @key("siteName")
  @segment("hypervSites")
  @doc("Site name")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface HypervDependencyMapController {
  @doc("API to generate coarse map for the list of machines.")
  @added(Versions.v2020_08_01_preview)
  
  generateCoarseMap is ArmResourceActionAsyncCustomMapRequest<
    HypervSite,
    HypervSite,
    DependencyMapServiceMapextensionsScopeMapRequest
  >;

  @doc("API to generate detailed map for a selected machine.")
  @added(Versions.v2020_08_01_preview)
  
  generateDetailedMap is ArmResourceActionAsyncCustomMapRequest<
    HypervSite,
    HypervSite,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest
  >;

  @doc("API to list client group members for the selected client group.")
  @added(Versions.v2020_08_01_preview)
  
  clientGroupMembers is ArmResourceActionAsyncCustomMapRequest<
    HypervSite,
    HypervSite,
    DependencyMapServiceMapextensionsClientGroupMembersRequest
  >;

  @doc("API to list server group members for the selected server group.")
  @added(Versions.v2020_08_01_preview)
  
  serverGroupMembers is ArmResourceActionAsyncCustomMapRequest<
    HypervSite,
    HypervSite,
    DependencyMapServiceMapextensionsServerGroupMembersRequest
  >;

  @doc("API to generate report containing agentless dependencies.")
  @added(Versions.v2020_08_01_preview)
  
  exportDependencies is ArmResourceActionAsyncCustomMapRequest<
    HypervSite,
    HypervSite,
    DependencyMapServiceMapextensionsExportDependenciesRequest
  >;

  @doc("Method to enable disable dependency map status for machines\r\n            in a site.")
  @added(Versions.v2020_08_01_preview)
  
  updateDependencyMapStatus is ArmResourceActionAsyncCustomMapRequest<
    HypervSite,
    HypervSite,
    UpdateMachineDepMapStatus
  >;
}

@armResourceOperations
interface HypervSitesController {
  @added(Versions.v2018_05_01_preview)  
  get is ArmResourceRead<HypervSite>;

  
  @added(Versions.v2018_05_01_preview)
  create is ArmResourceCreateOrUpdateSyncCustom<HypervSite>;

  @added(Versions.v2018_05_01_preview)  
  @doc("Update a HypervSite")
  update is ArmResourcePatchSync<
  HypervSite,
  SiteProperties
  >;

  @added(Versions.v2018_05_01_preview)  
  delete is ArmResourceDeleteSync<HypervSite>;

  @doc("Method to get site health summary.")
  @armResourceAction(InnerError)
  @added(Versions.v2018_05_01_preview)
  @post  
  listHealthSummary(
    ...ResourceInstanceParameters<HypervSite>
  ): ArmResponse<SiteHealthSummaryCollection> |ErrorResponse;

  // @doc("Method to get site error summary.")
  // @armResourceRead(InnerError)
  // @added(Versions.v2018_05_01_preview)
  // @segment("errorSummary")
  // @get  
  // getErrorSummary(
  //   ...ResourceInstanceParameters<HypervSite>,

  //   @doc("Appliance Name")
  //   @query
  //   applianceName: string
  // ): ArmResponse<SiteErrorSummary> | ErrorResponse;

  @doc("Method to get site error summary.")
  @added(Versions.v2023_06_06)
  errorSummary is ArmResourceActionSync<
  HypervSite,
    {},
    SiteErrorSummary
  >;

  @doc("Method to get site error summary.")
  @armResourceRead(InnerError)
  @segment("usage")
  @added(Versions.v2018_05_01_preview)
  @get  
  getUsage(
    ...ResourceInstanceParameters<HypervSite>
  ): ArmResponse<SiteUsageResponse> | ErrorResponse;

  @doc("Method to refresh a site.")
  @added(Versions.v2018_05_01_preview)  
  refresh is ArmResourceActionAsyncNoRequestBody<HypervSite, {}>;

  @doc("Method to get site usage.")
  @added(Versions.v2020_01_01)  
  summary is ArmResourceActionSyncNoRequestBody<HypervSite, HypervSiteUsage>;

  @doc("Method to generate report containing \r\n            machine and the errors encountered during guest discovery of the machine.")
  @added(Versions.v2020_08_01_preview)  
  exportMachineErrors is ArmResourceActionAsync<
    HypervSite,
    VersionedV202001ExportMachineErrorsRequest,
    {}
  >;
}

@armResourceOperations
interface HypervSites {
  @added(Versions.v2022_10_27)
  @summary("Get all hyperv  sites.")
  @doc("Get all the hyperv  sites in the subscription.")
  
  listBySubscription is ArmListBySubscription<HypervSite>;

  @added(Versions.v2022_10_27)
  @summary("Get all hyperv sites.")
  @doc("Get all the hyperv sites in the subscription.")
  listByParent is ArmResourceListByParent<HypervSite>;

  @doc("A operation status resource belonging to a site resource.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2018_05_01_preview)
  
  getHypervOperationsStatus(
    ...ResourceInstanceParameters<HypervSite>,

    @doc("Operation status  Arm Name.")
    @path
    //@pattern("^[a-zA-Z0-9-]{3,24}$")
    @segment("operationsStatus")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    operationStatusName: string
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

@doc("A job resource belonging to a site resource.")
@parentResource(HypervSite)
model HypervJob is ProxyResource<JobProperties> {
  @doc(" Job name")
  @key("jobName")
  @segment("jobs")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@doc("A cluster resource belonging to a site resource.")
@parentResource(HypervSite)
model HypervOperationsStatusResource is ProxyResource<HypervClusterProperties> {
  @doc(" Cluster name")
  @key("clusterName")
  @segment("clusters")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@doc("A cluster resource belonging to a site resource.")
@parentResource(HypervSite)
model HypervCluster is ProxyResource<HypervClusterProperties> {
  @doc(" Cluster ARM name")
  @key("clusterName")
  @segment("clusters")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@added(Versions.v2018_05_01_preview)
@armResourceOperations
interface HypervJobs {
  
  get is ArmResourceRead<HypervJob>;
  
  listByParent is ArmResourceListByParent<HypervJob>;
}


@doc("A host resource belonging to a site resource.")
@parentResource(HypervSite)
model HypervHost is ProxyResource<HypervHostProperties> {
  @doc(" Host name")
  @key("hostName")
  @segment("hosts")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}


@armResourceOperations
interface HypervHostController {
  @added(Versions.v2018_05_01_preview)
  
  get is ArmResourceRead<HypervHost>;

  @added(Versions.v2018_05_01_preview)
  
  create is ArmResourceCreateOrUpdateAsyncCustom<HypervHost>;

  // added in swagger
  @added(Versions.v2022_10_27)
  delete is ArmResourceDeleteSync<HypervHost>;

  @segment("hosts")
  @added(Versions.v2018_05_01_preview)
  
  listByParent is ArmResourceListByParent<
    HypervHost,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;
    }
  >;
}

@doc("A machine resource belonging to a site resource.")
@parentResource(HypervSite)
model HypervMachine is ProxyResource<HypervMachineProperties> {
  @doc(" HypervMachine name")
  @key("machineName")
  @segment("machines")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;  
}

@armResourceOperations
interface HypervMachinesController {
  // not in swashbuckle generated swagger
  @added(Versions.v2018_05_01_preview)
  
  get is ArmResourceRead<HypervMachine>;

  @added(Versions.v2022_10_27)
  
  // update machine properties is there not this 
  update is ArmResourcePatchSync<
  HypervMachine,
  HypervMachineProperties
  >;

  @added(Versions.v2018_05_01_preview)
  
  listByParent is ArmResourceListByParent<
    HypervMachine,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: int32;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;

  // @doc("Method to get machine with application and roles present in it.")
  // @segment("applications")
  // @armResourceRead(InnerError)
  // @added(Versions.v2020_08_01_preview)
  
  //Not there
  // @get
  // getApplications(
  //   ...ResourceInstanceParameters<HypervMachine>
  // ): ArmResponse<HypervMachine> | ErrorResponse;


  @doc("Method to get machine with application and roles present in it.")
  @added(Versions.v2023_06_06)
  applications is ArmResourceActionSync<
  HypervMachine,
    {},
    HypervMachine
  >;

  // @doc("Method to get a machines software inventory like applications and roles.")
  // @armResourceRead(InnerError)
  // @get
  // @added(Versions.v2022_10_27)
  // @segment("softwareInventory/default")
  // getMachineSoftwareInventory(
  //   ...ResourceInstanceParameters<HypervMachine>
  // ): ArmResponse<HypervVmSoftwareInventory> | ErrorResponse;


  @doc("Method to get a machines software inventory like applications and roles.")
  @added(Versions.v2023_06_06)
  @action("softwareInventory/default")
  getMachineSoftwareInventory is ArmResourceActionSync<
  HypervMachine,
    {},
    HypervVmSoftwareInventory
  >;

  @added(Versions.v2018_05_01_preview)
  @doc("Method to update custom properties for HYPERV machines\r\n            in a site.")
  updateProperties is ArmResourceActionNoContentAsyncMetaDataBody<
    HypervSite,
    MachineMetadataList,
    {}
  >;
}

@doc("A machine resource belonging to a site resource.")
@parentResource(HypervSite)
model HypervRunAsAccountResource
  is ProxyResource<RunAsAccountRunAsAccountProperties> {
  @doc(" RunAsAccounts name")
  @key("accountName")
  @segment("runAsAccounts")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@added(Versions.v2018_05_01_preview)
@armResourceOperations
interface HypervRunAsAccountsController {
  
  get is ArmResourceRead<HypervRunAsAccountResource>;

  
  listByParent is ArmResourceListByParent<HypervRunAsAccountResource>;
}

model Patch<T> {
  @header contentType: "application/merge-patch+json";
  ...T;
}

@doc("A ServerSiteResource")
model ServerSiteResource is TrackedResource<SitesProperties> {
  @key("siteName")
  @segment("serverSites")
  @doc("Site name")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

//*** Server sites tracked resource ***/
@armResourceOperations
@added(Versions.v2019_05_01_preview)
interface ServersController {

  // @doc("Method to get machine with application and roles present in it.")
  // @segment("applications")
  // @armResourceRead(InnerError)
  // @added(Versions.v2020_08_01_preview)  
  // @get
  // getApplications(
  //   ...ResourceInstanceParameters<ServerMachineResource>
  // ): ArmResponse<ServerMachineResource> | ErrorResponse ;

  
  @doc("Method to get machine with application and roles present in it.")
  @added(Versions.v2023_06_06)
  applications is ArmResourceActionSync<
  ServerMachineResource,
    {},
    ServerMachineResource
  >;
  
  
  getMachine is ArmResourceRead<ServerMachineResource>;
  createMachine is ArmResourceCreateOrUpdateAsyncCustom<ServerMachineResource>;
  deleteMachine is ArmResourceDeleteSync<ServerMachineResource>;
  @doc("Get all machines in a site.")
  
  listByParent is ArmResourceListByParent<ServerMachineResource>;

}

@armResourceOperations
interface ServerSitesController {

  
  get is ArmResourceRead<ServerSiteResource>;
  create is ArmResourceCreateOrUpdateAsyncCustom<ServerSiteResource>;
  update is ArmResourcePatchSync<ServerSiteResource, SitesProperties>;
  delete is ArmResourceDeleteSync<ServerSiteResource>;
  listByParent is ArmResourceListByParent<ServerSiteResource>;

  @added(Versions.v2019_05_01_preview)
  
  listBySubscription is ArmListBySubscription<ServerSiteResource>;
  
  @doc("Operation to refresh a site")
  refreshSite is ArmResourceActionAsyncNoRequestBody<ServerSiteResource, {}>;

  @doc("Operation to update custom properties for servers")
  updateProperties is ArmResourceActionNoContentAsyncMetaDataBody<
    ServerSiteResource,
    MachineMetadataList,
    {}
  >;

  @doc("A operation status resource belonging to a site resource.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2019_05_01_preview)
  
  getServerSiteOperationsStatus(
    ...ResourceInstanceParameters<ServerSiteResource>,

    @doc("Operation status  Arm Name.")
    @path
    @segment("operationsStatus")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    operationStatusName: string
  ): ArmResponse<OperationStatus> | ErrorResponse;

  // @get
  // @doc("Get a serve site usage.")
  // @segment("usage")
  // @armResourceRead(InnerError)
  
  // getUsage(
  //   ...ResourceInstanceParameters<ServerSiteResource>
  // ): ArmResponse<ServerSiteUsageResponse> | ErrorResponse;

  @doc("Get a serve site usage.")
  @added(Versions.v2023_06_06)
  usage is ArmResourceActionSync<
  ServerSiteResource,
    {},
    ServerSiteUsageResponse
  >;

  // @get
  // @doc("Get the error summary for a server site.")
  // @segment("errorSummary")
  // @armResourceRead(InnerError)
  
  // getErrorSummary(
  //   ...ResourceInstanceParameters<ServerSiteResource>,

  //   @doc("Appliance Name")
  //   @query
  //   applianceName: string
  // ): ArmResponse<SiteErrorSummary> | ErrorResponse;

  @doc("Get the error summary for a server site.")
  @added(Versions.v2023_06_06)
  errorSummary is ArmResourceActionSync<
  ServerSiteResource,
    {},
    SiteErrorSummary
  >;

  // @doc("Method to get a machines software inventory like applications and roles.")
  // @armResourceRead(InnerError)
  // @get
  // @added(Versions.v2022_10_27)
  // @segment("softwareInventory/default")
  // GetServerSoftwareInventory(
  //   ...ResourceInstanceParameters<ServerMachineResource>
  // ): ArmResponse<ServerSoftwareInventory>;

  @doc("Method to enable disable dependency map status for machines\r\n            in a site.")
  @added(Versions.v2020_08_01_preview)
  
  updateDependencyMapStatus is ArmResourceActionAsyncCustomMapRequest<
    ServerSiteResource,
    ServerSiteResource,
    UpdateMachineDepMapStatus
  >;
  
  @doc("Method to generate report containing\r\n            machine and the deep discovery of the application installed in the machine.")
  @added(Versions.v2020_08_01_preview)
  
  exportApplications is ArmResourceActionNoContentNoBodyAsync<ServerSiteResource>;

  @doc("Method to generate report containing \r\n            machine and the errors encountered during guest discovery of the machine.")
  @added(Versions.v2020_08_01_preview)
  
  exportMachineErrors is ArmResourceActionAsync<
    ServerSiteResource,
    VersionedV202001ExportMachineErrorsRequest,
    {}
  >;

  @doc("Method to get site usage.")
  @added(Versions.v2020_01_01_preview)
  
  summary is ArmResourceActionSyncNoRequestBody<
    ServerSiteResource,
    ServerSiteUsage
  >;

  @doc("Method to get site health summary.")
  @armResourceAction(InnerError)
  @added(Versions.v2020_01_01_preview)
  @post
  
  listHealthSummary(
    ...ResourceInstanceParameters<ServerSiteResource>
  ): ArmResponse<SiteHealthSummaryCollection> |ErrorResponse;
}
@armResourceOperations
interface ServerDependencyMapController {
  @doc("API to list client group members for the selected client group.")
  @added(Versions.v2020_08_01_preview)
  
  clientGroupMembers is ArmResourceActionAsyncCustomMapRequest<
    ServerSiteResource,
    ServerSiteResource,
    DependencyMapServiceMapextensionsClientGroupMembersRequest
  >;

  @doc("API to list server group members for the selected server group.")
  @added(Versions.v2020_08_01_preview)
  
  serverGroupMembers is ArmResourceActionAsyncCustomMapRequest<
    ServerSiteResource,
    ServerSiteResource,
    DependencyMapServiceMapextensionsServerGroupMembersRequest
  >;

  @doc("API to generate coarse map for the list of machines.")
  @added(Versions.v2020_08_01_preview)
  
  generateCoarseMap is ArmResourceActionAsyncCustomMapRequest<
    ServerSiteResource,
    ServerSiteResource,
    DependencyMapServiceMapextensionsScopeMapRequest
  >;

  @doc("API to generate detailed map for a selected machine.")
  @added(Versions.v2020_08_01_preview)
  
  generateDetailedMap is ArmResourceActionAsyncCustomMapRequest<
    ServerSiteResource,    
    ServerSiteResource,
    DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest
  >;

  @doc("API to generate report containing agentless dependencies.")
  @added(Versions.v2020_08_01_preview)
  
  exportDependencies is ArmResourceActionAsyncCustomMapRequest<
    ServerSiteResource,
    ServerSiteResource,
    DependencyMapServiceMapextensionsExportDependenciesRequest
  >;
}
//*** Server Machine Proxy Resource ***/
@doc("A machine resource belonging to a site resource.")
@parentResource(ServerSiteResource)
model ServerMachineResource is ProxyResource<ServerProperties> {
  @doc(" A server machine name")
  @key("machineName")
  @segment("machines")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
  
  // @doc("Gets tags that can be used with ODATA")
  // @visibility("read")
  // @added(Versions.v2020_07_10)
  // tags?: Record<Object>;
}

//*** Server RunAsAccount Proxy Resource ***/

@doc("A run as account resource belonging to a site resource.")
@parentResource(ServerSiteResource)
model ServerRunAsAccountResource
  is ProxyResource<RunAsAccountRunAsAccountProperties> {
  @doc(" RunAsAccounts name")
  @key("accountName")
  @segment("runAsAccounts")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
@added(Versions.v2019_05_01_preview)
interface ServerRunAsAccounts {
  get is ArmResourceRead<ServerRunAsAccountResource>;
  listByParent is ArmResourceListByParent<ServerRunAsAccountResource>;
}

//*** Server Jobs Proxy Resource ***/

@doc("A host resource belonging to a site resource.")
@parentResource(ServerSiteResource)
model ServerJobResource is ProxyResource<JobProperties> {
  @doc(" Jobs name")
  @key("jobName")
  @segment("jobs")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
@added(Versions.v2019_05_01_preview)
interface ServerJobsController {
  get is ArmResourceRead<ServerJobResource>;
  listByParent is ArmResourceListByParent<ServerJobResource>;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("A ImportSiteResource")
model ImportSiteResource is TrackedResource<ImportSitesProperties> {

  @key("siteName")
  @segment("importSites")
  @doc("Site name")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @visibility("read")
  name: string;
}

@doc("A host resource belonging to a site resource.")
@parentResource(ImportSiteResource)
model ImportJobResource is ProxyResource<JobProperties> {
  @doc(" Jobs name")
  @key("jobName")
  @segment("jobs")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
@added(Versions.v2019_05_01_preview)
interface ImportJobsController {
  get is ArmResourceRead<ImportJobResource>;
  listByParent is ArmResourceListByParent<ImportJobResource>;

  @doc("Method to get all delete import machines job for the given site.")
  @armResourceRead(InnerError)
  @segment("deletejobs")
  @get
  @added(Versions.v2020_02_01)
  
  listDeletejobs(
    ...ResourceInstanceParameters<ImportSiteResource>
  ): ArmResponse<Azure.Core.PageUpdated<V20200201DeleteImportMachinesJobDeleteImportMachinesJobCollection>> | ErrorResponse;

  @doc("Gets the delete imported machines job with the given job name.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2020_02_01)  
  getDeletejob(
    ...ResourceInstanceParameters<ImportSiteResource>,

    @doc("Job Arm Name.")
    @path
    @segment("deleteJobs")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    jobName: string
  ): ArmResponse<V20200201DeleteImportMachinesJob>| ErrorResponse;

  @doc("Method to get all export import machines job for the given site.")
  @armResourceRead(InnerError)
  @segment("exportjobs")
  @get
  @added(Versions.v2020_02_01)
  
  listExportjobs(
    ...ResourceInstanceParameters<ImportSiteResource>
  ): ArmResponse<Azure.Core.PageUpdated<V20200201ExportImportedMachinesJobExportImportedMachinesJobCollection>> | ErrorResponse;

  @doc("Gets the export imported machines job with the given job name.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2020_02_01)
  
  getExportjob(
    ...ResourceInstanceParameters<ImportSiteResource>,

    @doc("Job Arm Name.")
    @path
    @segment("exportJobs")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    jobName: string
  ): ArmResponse<V20200201ExportImportedMachinesJob> | ErrorResponse;

  @doc("Method to get all import machines job for the given site.")
  @armResourceRead(InnerError)
  @segment("importjobs")
  @get
  @added(Versions.v2020_02_01)
  
  listImportjobs(
    ...ResourceInstanceParameters<ImportSiteResource>
  ): ArmResponse<Azure.Core.PageUpdated<V20200201ImportMachinesJobImportMachinesJobCollection>> | ErrorResponse;

  @doc("Gets the import job with the given job name.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2020_02_01)
  
  getImportjob(
    ...ResourceInstanceParameters<ImportSiteResource>,

    @doc("Job Arm Name.")
    @path
    @segment("importJob")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    jobName: string
  ): ArmResponse<V20200201ImportMachinesJob> | ErrorResponse;

//updating swagger in advance  
  @doc("Patch the delete imported machines job object.")
  @armResourceUpdate(InnerError)
  @patch
  @added(Versions.v2020_02_01)
  
  updateDeleteMachinesJob(
    ...ResourceInstanceParameters<ImportSiteResource>,

    @doc("Job Arm Name.")
    @path
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @segment("deleteJobs")
    jobName: string,

    @doc("Job body with updated properties.")
    @body
    body: V20200201DeleteImportMachinesJob
  ): ArmResponse<V20200201DeleteImportMachinesJob> | ErrorResponse;
 }

// #suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("An machine resource belonging to a site resource.")
@parentResource(ImportSiteResource)
model ImportMachineResource is ProxyResource<ImportMachineProperties> {
  
  @doc("Machine name")
  @key("machineName")
  @segment("machines")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
@added(Versions.v2019_05_01_preview)
interface ImportMachinesController {
  get is ArmResourceRead<ImportMachineResource>;
  listByParent is ArmResourceListByParent<
    ImportMachineResource,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
  delete is ArmResourceDeleteSync<ImportMachineResource>;
}

@armResourceOperations
interface ImportSitesController {
  @added(Versions.v2019_05_01_preview)
  get is ArmResourceRead<ImportSiteResource>;

  @added(Versions.v2019_05_01_preview)
  create is ArmResourceCreateOrUpdateSyncCustom<ImportSiteResource>;

  @added(Versions.v2019_05_01_preview)
  update is ArmResourcePatchSync<
    ImportSiteResource,
    ImportSitesProperties
  >;

  @added(Versions.v2019_05_01_preview)
  delete is ArmResourceDeleteSync<ImportSiteResource>;

  @added(Versions.v2019_05_01_preview)
  @doc("Get all import sites.")
  listByParent is ArmResourceListByParent<ImportSiteResource>;

  @added(Versions.v2019_05_01_preview)
  
  listBySubscription is ArmListBySubscription<ImportSiteResource>;

  @doc("Method to refresh a site.")
  @added(Versions.v2019_05_01_preview)
  importUri is ArmResourceActionSync<
    ImportSiteResource,
    SasUriResponse,
    SasUriResponse
  >;

  @doc("Deletes the imported machines for site.")
  @added(Versions.v2020_02_01)
  deleteImportedMachines is ArmResourceActionSync<
    ImportSiteResource,
    V20190501PreviewSasUriResponse,
    {}
  >;
}


#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("A MasterSite")
model MasterSite is TrackedResource<MasterSiteProperties> {

  @key("siteName")
  @segment("masterSites")
  @doc("Site name")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface MasterSitesController {
  @added(Versions.v2020_07_07)
  
  @summary("Method to get a master site.")
  get is ArmResourceRead<MasterSite>;

  @added(Versions.v2020_07_07)
  
  @doc("Method to create or update a site.")
  create is ArmResourceCreateOrUpdateAsyncCustom<MasterSite>;

  @added(Versions.v2020_07_07)
  
  @doc("Method to delete a site.")
  delete is ArmResourceDeleteSync<MasterSite>;

  @added(Versions.v2020_07_07)
  @summary("Get all the sites in the subscription.")
  
  listBySubscription is ArmListBySubscription<MasterSite>;

  @added(Versions.v2020_07_07)
  @summary("Get all sites.")
  @doc("Get all the sites in the resource group.")
  
  listByParent is ArmResourceListByParent<MasterSite>;

  @added(Versions.v2020_07_07)
  @doc("Method to update an existing site.")
  
  update is ArmResourcePatchAsync<MasterSite, MasterSiteProperties>;

  // @doc("Method to get error summary from master site for an appliance.")
  // @armResourceAction(InnerError)
  // @added(Versions.v2020_07_07)
  // @post  
  // getErrorSummary(
  //   ...ResourceInstanceParameters<MasterSite>,

  //   @doc("Appliance name.")
  //   @query
  //   applianceName: string
  // ): ArmResponse<SiteErrorSummary> | ErrorResponse;


  @doc("Method to get error summary from master site for an appliance.")
  @added(Versions.v2023_06_06)
  getErrorSummary is ArmResourceActionSync<
  MasterSite,
  ErrorSummaryRequest,
    SiteErrorSummary
  >;
}

@armResourceOperations
interface ApplianceNonceController {
  @added(Versions.v2020_11_11_preview)
  @doc("Method to create and get Nonce.")
  
  applianceRegistrationInfo is ArmResourceActionSync<
    MasterSite,
    NonceRequest,
    ApplianceNonce
  >;
}

@armResourceOperations
interface MasterSitesOperationsStatusController {
  @doc("A operation status resource belonging to a master site resource.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2020_07_07)
  
  getVmwareOperationStatus(
    ...ResourceInstanceParameters<MasterSite>,

    @doc("Operation status  Arm Name.")
    @path
    @segment("operationsStatus")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    operationStatusName: string
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

@doc("REST model used to encapsulate Private Link properties for tracked resources.")
@parentResource(MasterSite)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionPropertiesV2> {
  @doc(" Private link resource name.")
  @key("peConnectionName")
  @segment("privateEndpointConnections")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnectionController {
  @doc("Gets the private link resource.")
  @added(Versions.v2020_07_07)
  
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Deletes the private link resource.")
  @added(Versions.v2020_07_07)
  
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  @doc("Gets the private link resource.")
  @added(Versions.v2020_07_07)
  
  create is ArmResourceCreateOrUpdateSync201<PrivateEndpointConnection>;

  @added(Versions.v2020_07_07)
  @doc("Gets the private link resource.")
  
  listByParent is ArmResourceListByParent<PrivateEndpointConnection>;
}

// @doc("A vcenter resource belonging to a site resource.")
// @parentResource(MasterSite)
// model PrivateEndpointConnectionProxy
//   is ProxyResource<MicrosoftAzureMigratePrivateEndpointModelsPrivateEndpointDetails> {
//   @doc(" Private endpoint connection proxy name.")
//   @key("pecProxyName")
//   @segment("privateEndpointConnectionProxies")
//   @pattern("^[a-zA-Z0-9-]{3,24}$")
//   @path
//   name: string;
// }

// @armResourceOperations
// interface PrivateEndpointConnectionProxyController {
//   @doc("Gets the private endpoint connection proxy.")
//   @added(Versions.v2020_07_07)
//   
//   get is ArmResourceRead<PrivateEndpointConnectionProxy>;

//   @doc("Deletes the private endpoint connection proxy.")
//   @added(Versions.v2020_07_07)
//   
//   delete is ArmResourceDeleteAsync<PrivateEndpointConnectionProxy>;

//   @doc("Creates  the private endpoint connection proxy.")
//   @added(Versions.v2020_07_07)
//   
//   create is ArmResourceCreateOrUpdateSync201<PrivateEndpointConnectionProxy>;

//   @added(Versions.v2020_07_07)
//   @doc("Gets the private endpoint connection proxy resource.")
//   
//   listByParent is ArmResourceListByParent<PrivateEndpointConnectionProxy>;

//   @doc("Gets the private endpoint connection proxy.")
//   @armResourceRead(InnerError)
//   @get
//   @added(Versions.v2020_07_07)
//   
//   @segment("operationsStatus")
//   PecOperationStatus(
//     ...ResourceInstanceParameters<PrivateEndpointConnectionProxy>
//   ): ArmResponse<IarmAsyncOperationStatus>;

//   @doc("Gets the private endpoint connection proxy.")
//   @added(Versions.v2020_07_07)
//   @armResourceAction(InnerError)
//   @post
//   
//   Validate(
//     ...ResourceInstanceParameters<PrivateEndpointConnectionProxy>,

//     @doc("Request body.")
//     @body
//     body: MicrosoftAzureMigratePrivateEndpointBodyPrivateEndpointConnectionProxyRequestBody
//   ): ArmResponse<MicrosoftAzureMigratePrivateEndpointBodyPrivateEndpointConnectionProxyRequestBody>;
// }

@doc("REST model used to encapsulate Private Link properties for tracked resources.")
@parentResource(MasterSite)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("Private link resource name.")
  @key("privateLinkResourceName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("privateLinkResources")
  @path
  name: string;
}

@armResourceOperations
interface PrivateLinkResourcesController {
  @doc("Gets the private link resource.")
  @added(Versions.v2020_07_07)
  
  get is ArmResourceRead<PrivateLinkResource>;

  @added(Versions.v2020_07_07)
  @doc("Gets the private link resource.")
  
  listByParent is ArmResourceListByParent<PrivateLinkResource>;
}

@doc("SQL site web model.")
@parentResource(MasterSite)
model SqlSite is ProxyResource<SqlSiteProperties> {
  @doc("SQL site name.")
  @key("sqlSiteName")
  @segment("sqlSites")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}
@armResourceOperations
interface SqlSitesController {
  @doc("Method to get a site.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<SqlSite>;

  @doc("Deletes the SQL site.")
  @added(Versions.v2020_11_11_preview)
  
  delete is ArmResourceDeleteAsync<SqlSite>;

  @doc("Method to create a SQL site.")
  @added(Versions.v2020_11_11_preview)
  
  create is ArmResourceCreateOrUpdateSync201<SqlSite>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to update an existing site.")
  
  update is ArmResourcePatchAsync<SqlSite, SqlSiteProperties>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all sites.")
  
  listByParent is ArmResourceListByParent<SqlSite>;

  @doc("Method to generate report containing SQL servers.")
  @armResourceAction(InnerError)
  @added(Versions.v2020_11_11_preview)
  
  exportSqlServers is ArmResourceActionAsync<
    SqlSite,
    ExportSqlServersRequest,
    {}
  >;

  // @doc("Method to get error summary from SQL site.")
  // @armResourceAction(InnerError)
  // @added(Versions.v2020_11_11_preview)
  // @post
  
  // getErrorSummary(
  //   ...ResourceInstanceParameters<SqlSite>,

  //   @doc("Appliance name.")
  //   @query
  //   applianceName: string
  // ): ArmResponse<SiteErrorSummary> | ErrorResponse;
  
  @doc("MMethod to get error summary from SQL site.")
  @added(Versions.v2023_06_06)
  getErrorSummary is ArmResourceActionSync<
  SqlSite,
  ErrorSummaryRequest,
    SiteErrorSummary
  >;

  @doc("Method to get site usage/summary.")
  @added(Versions.v2020_11_11_preview)
  
  summary is ArmResourceActionSyncNoRequestBody<SqlSite, SqlSiteUsage>;

  @doc("Method to refresh a site.")
  @added(Versions.v2020_11_11_preview)
  
  refresh is ArmResourceActionAsync<SqlSite, SqlSiteRefreshBody, {}>;
}

@doc("Class representing the web model of SQL Availability Group.")
@parentResource(SqlSite)
model SqlAvailabilityGroup is ProxyResource<SqlAvailabilityGroupProperties> {
  @doc("SQL availability group name.")
  @key("sqlAvailabilityGroupName")
  @segment("sqlAvailabilityGroups")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("WebApp site web model.")
@parentResource(MasterSite)
model WebAppSite is ProxyResource<WebAppSiteProperties> {
  @doc("Web app site name.")
  @key("webAppSiteName")
  @segment("webAppSites")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface WebAppSitesController {
  @doc("Method to get a site.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<WebAppSite>;

  @doc("Deletes the WebApp site.")
  @added(Versions.v2020_11_11_preview)
  
  delete is ArmResourceDeleteAsync<WebAppSite>;

  @doc("Method to create a WebApp site.")
  @added(Versions.v2020_11_11_preview)
  
  create is ArmResourceCreateOrUpdateSync201<WebAppSite>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to update an existing site.")
  
  update is ArmResourcePatchAsync<WebAppSite, WebAppSiteProperties>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all sites.")
  
  listByParent is ArmResourceListByParent<WebAppSite>;

  @doc("Method to generate report containing web app inventory.")
  @added(Versions.v2020_11_11_preview)
  
  exportInventory is ArmResourceActionAsync<
    WebAppSite,
    ExportWebAppsRequest,
    {}
  >;

  // @doc("Method to get error summary from web app site.")
  // @armResourceAction(InnerError)
  // @added(Versions.v2020_11_11_preview)
  // @post
  
  // getErrorSummary(
  //   ...ResourceInstanceParameters<WebAppSite>,

  //   @doc("Appliance name.")
  //   @query
  //   applianceName: string
  // ): ArmResponse<SiteErrorSummary> | ErrorResponse;

  @doc("MMethod to get error summary from web app  site.")
  @added(Versions.v2023_06_06)
  getErrorSummary is ArmResourceActionSync<
  WebAppSite,
  ErrorSummaryRequest,
    SiteErrorSummary
  >;
  

  @doc("Method to get site usage/summary.")
  @added(Versions.v2020_11_11_preview)
  
  summary is ArmResourceActionSyncNoRequestBody<WebAppSite, WebAppSiteUsage>;

  @doc("Method to refresh a site.")
  @added(Versions.v2020_11_11_preview)
  
  refresh is ArmResourceActionAsync<
    WebAppSite,
    ProxySiteRefreshBody,
    {}>;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("Web application REST Resource.")
@parentResource(WebAppSite)
model TomcatWebApplications is ProxyResource<TomcatWebApplicationProperties> {
  @doc("Web application name.")
  @key("webApplicationName")
  @segment("tomcatWebApplications")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface TomcatWebApplicationsController {
  @doc("Method to get an Tomcat web application.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<TomcatWebApplications>;

  @doc("Updates the Tomcat web application tags.")
  @added(Versions.v2022_10_27)
  
  update is ArmResourcePatchSync<
  TomcatWebApplications,
  TomcatWebApplicationProperties
  >;

  // #suppress "order is different"
  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all Tomcat web application.")
  
  listByParent is ArmResourceListByParent<
    TomcatWebApplications,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("Web server REST Resource.")
@parentResource(WebAppSite)
model TomcatWebServers is ProxyResource<TomcatWebServerProperties> {
  @doc("Web server name.")
  @key("webServerName")
  @segment("tomcatWebServers")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface TomcatWebServersController {
  @doc("Method to get an Tomcat web server.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<TomcatWebServers>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all Tomcat web servers.")
  
  listByParent is ArmResourceListByParent<
    TomcatWebServers,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("Web application REST Resource.")
@parentResource(WebAppSite)
model IisWebApplications is ProxyResource<IisWebApplicationProperties> {
  @doc("Web application name.")
  @key("webApplicationName")
  @segment("iisWebApplications")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface IisWebApplicationsController {
  @doc("Method to get an IIS web application.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<IisWebApplications>;

  @doc("Method to update tags on IIS web application.")
  @added(Versions.v2022_10_27)
  
  update is ArmResourcePatchSync<IisWebApplications, IisWebApplicationProperties>;

  // #suppress "order is different"
  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all IIS web application.")
  
  listByParent is ArmResourceListByParent<
    IisWebApplications,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("Web server REST Resource.")
@parentResource(WebAppSite)
model IisWebServers is ProxyResource<IisWebServerProperties> {
  @doc("Web server name.")
  @key("webServerName")
  @segment("iisWebServers")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface IisWebServersController {
  @doc("Method to get an IIS web server.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<IisWebServers>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all IIS web servers.")
  
  listByParent is ArmResourceListByParent<
    IisWebServers,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("Web app data source web model.")
@parentResource(WebAppSite)
model DiscoverySiteDataSource
  is ProxyResource<DiscoverySiteDataSourceProperties> {
  @doc("Data Source ARM name.")
  @key("discoverySiteDataSourceName")
  @segment("discoverySiteDataSources")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface WebAppDiscoverySiteDataSourcesController {
  @doc("Method to get a Web app data source in site.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<DiscoverySiteDataSource>;

  @doc("Method to delete a Web app data source in site.")
  @added(Versions.v2020_11_11_preview)
  
  delete is ArmResourceDeleteAsync<DiscoverySiteDataSource>;

  @doc("Method to create or update a Web app data source in site.")
  @added(Versions.v2020_11_11_preview)
  
  create is ArmResourceCreateOrUpdateAsyncCustom<DiscoverySiteDataSource>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all Web app data sources in site.")
  
  listByParent is ArmResourceListByParent<DiscoverySiteDataSource>;
}

@doc("Web app extended machine REST Resource.")
@parentResource(WebAppSite)
model WebAppExtendedMachine is ProxyResource<WebAppExtendedMachineProperties> {
  @doc("Extended machine name.")
  @key("extendedMachineName")
  @segment("extendedMachines")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface WebAppExtendedMachinesController {
  @doc("Method to get a extended machine.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<WebAppExtendedMachine>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all extended machines.")
  
  listByParent is ArmResourceListByParent<
    WebAppExtendedMachine,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("Web application REST Resource.")
@parentResource(WebAppSite)
model WebRoleV202011PreviewWebApplication
  is ProxyResource<WebRoleV202011PreviewWebApplicationProperties> {
  @doc("Web application name.")
  @key("webApplicationsName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("webApplications")
  @path
  name: string;
}

@armResourceOperations
interface WebApplicationsController {
  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all IIS web applications.")
  
  listByParent is ArmResourceListByParent<
    WebRoleV202011PreviewWebApplication,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

@doc("Run as account REST Resource.")
@parentResource(WebAppSite)
model WebAppRunAsAccount is ProxyResource<RunAsAccountProperties> {
  @doc("Run as account ARM name.")
  @key("accountName")
  @segment("runasaccounts")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
interface WebAppRunAsAccountsController {
  @doc(("Method to get run as account."))
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<WebAppRunAsAccount>;

  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all run as accounts.")
  
  listByParent is ArmResourceListByParent<WebAppRunAsAccount>;
}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars"
@doc("Web application REST Resource.")
@parentResource(WebAppSite)
model WebServer is ProxyResource<WebServerProperties> {
  @doc("Web server name.")
  @key("webServerApplicationsName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("webServers")
  @path
  name: string;
}

@armResourceOperations
interface WebServersController {
  @added(Versions.v2020_11_11_preview)
  @doc("Method to get all web servers.")
  
  listByParent is ArmResourceListByParent<
    WebServer,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

@armResourceOperations
interface SqlAvailabilityGroupController {
  @doc("Gets the sql availability group.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<SqlAvailabilityGroup>;

  @added(Versions.v2020_11_11_preview)
  @doc("Gets the sql availability groups.")
  
  listByParent is ArmResourceListByParent<
    SqlAvailabilityGroup,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

@doc("Class representing the web model of SQL Server.")
@parentResource(SqlSite)
model SqlServer is ProxyResource<SqlServerProperties> {
  @doc("SQL server name.")
  @key("sqlServerName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("sqlServers")
  @path
  name: string;
}

@armResourceOperations
interface SqlServersController {
  @doc("Gets the sql server.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<SqlServer>;

  @doc("Updates the sql server tags.")
  @added(Versions.v2022_10_27)
  
  update is ArmResourcePatchSync<SqlServer, SqlServerProperties>;

  @added(Versions.v2020_11_11_preview)
  @doc("Gets the sql servers.")
  
  listByParent is ArmResourceListByParent<
    SqlServer,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;

}

@doc("Class representing the web model of SQL Database.")
@parentResource(SqlSite)
model SqlDatabase is ProxyResource<SqlDatabaseProperties> {
  @doc("SQL Database name.")
  @key("sqlDatabaseName")
  @segment("sqlDatabases")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@armResourceOperations
interface SqlDatabasesController {
  @doc("Gets the sql Database.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<SqlDatabase>;

  @added(Versions.v2020_11_11_preview)
  @doc("Gets the sql Databases.")
  
  listByParent is ArmResourceListByParent<
    SqlDatabase,
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...ApiVersionParameter;

      @doc("filter query")
      @query
      filter?: string;

      @doc("page size  query")
      @query
      top?: string;

      @query
      @doc("Optional parameter for continuation token.")
      continuationToken?: string;

      @query
      @doc("Total count of machines in the given site.")
      totalRecordCount?: int32;
    }
  >;
}

@doc("Class representing the web model of SQL Database.")
@parentResource(SqlSite)
model SqlJob is ProxyResource<JobProperties> {
  @doc("SQL Job name.")
  @key("sqlJobName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("sqlJobs")
  @path
  name: string;
}

@armResourceOperations
interface SqlJobsController {
  @summary("Gets the sql Job.")
  @added(Versions.v2020_11_11_preview)
  
  get is ArmResourceRead<SqlJob>;

  @added(Versions.v2020_11_11_preview)
  @summary("Gets the sql Jobs.")
  
  listByParent is ArmResourceListByParent<SqlJob>;
}

@doc("A runasaccount resource belonging to a site resource.")
@parentResource(SqlSite)
model SqlRunAsAccountResource
  is ProxyResource<RunAsAccountRunAsAccountProperties> {
  @doc("SQL RunAsAccounts name")
  @key("accountName")
  @segment("runAsAccounts")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
@added(Versions.v2020_11_11_preview)
interface SqlRunAsAccountsController {
  
  get is ArmResourceRead<SqlRunAsAccountResource>;
  
  listByParent is ArmResourceListByParent<SqlRunAsAccountResource>;
}

@doc("A SQL discovery site data source resource.")
@parentResource(SqlSite)
model SqlDiscoverySiteDataSourceResource
  is ProxyResource<SqlDiscoverySiteDataSourceProperties> {
  @doc("SQL Discovery site data source name.")
  @key("discoverySiteDataSourceName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("discoverySiteDataSources")
  @path
  name: string;
}

@armResourceOperations
@added(Versions.v2020_11_11_preview)
interface SqlDiscoverySiteDataSourceController {
  
  get is ArmResourceRead<SqlDiscoverySiteDataSourceResource>;

  
  create is ArmResourceCreateOrUpdateAsyncCustom<SqlDiscoverySiteDataSourceResource>;

  
  delete is ArmResourceDeleteSync<SqlDiscoverySiteDataSourceResource>;

  
  listByParent is ArmResourceListByParent<SqlDiscoverySiteDataSourceResource>;
}

// #suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-operation-missing-api-version"
// #suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-operation-missing-decorator"
// @armResourceOperations
// interface SubscriptionController {
//   @doc("Method to delete all sites under a subscription.")
//   @route("/subscriptions/{subscriptionId}")
//   @delete
//   DeleteSubscription is OperationCustom<
//     {
//       ...SubscriptionIdParameter;
//     },
//     void
//   >;
// }

@armResourceOperations
interface SqlOperationsStatusController {
  @doc("Method to get operation status.")
  @armResourceRead(InnerError)
  @get
  @added(Versions.v2020_11_11_preview)
  
  getSqlOperationStatus(
    ...ResourceInstanceParameters<SqlSite>,

    @doc("Operation status  Arm Name.")
    @path
    @segment("operationsStatus")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    operationStatusName: string
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
