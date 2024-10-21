import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using Azure.ClientGenerator.Core;

namespace Easm;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;
@tag("Assets")
@doc("Provides access to inventory assets.")
interface Assets {
  @doc("Retrieve a list of assets for the provided search parameters.")
  listAssetResource is Operations.ResourceList<AssetResource, AssetsListTrait>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update labels on assets matching the provided filter.")
  @route("/assets")
  @updatesResource(AssetResource)
  @post
  updateAssets is Foundations.Operation<
    AssetsUpdateParameter & BodyParameter<AssetUpdateData>,
    Task
  >;
  @doc("Retrieve an asset by assetId.")
  getAssetResource is Operations.ResourceRead<AssetResource>;

  @doc("Export a list of assets for the provided search parameters.")
  @action("export")
  @Versioning.added(Versions.v2024_03_01_preview)
  getAssetsExport is Operations.ResourceCollectionAction<
    AssetResource,
    BodyParameter<AssetsExportRequest>,
    Task,
    AssetsExportTrait
  >;

  @doc("Retrieve observations on an asset")
  @action("getObservations")
  @Versioning.added(Versions.v2024_03_01_preview)
  getObservations is Operations.ResourceAction<
    AssetResource,
    {},
    ObservationPageResult,
    ObservationsParameters
  >;

  @doc("Retrieve a list of deltas for the provided time range.")
  @action("getDeltaDetails")
  @Versioning.added(Versions.v2024_03_01_preview)
  getDeltaDetails is Operations.ResourceCollectionAction<
    AssetResource,
    BodyParameter<DeltaDetailsRequest>,
    DeltaPageResult,
    DeltaDetailsTrait
  >;

  @doc("Retrieve a list of deltas with overall summary changes for the provided time range.")
  @action("getDeltaSummary")
  @Versioning.added(Versions.v2024_03_01_preview)
  getDeltaSummary is Operations.ResourceCollectionAction<
    AssetResource,
    BodyParameter<DeltaSummaryRequest>,
    DeltaSummaryResult,
    {}
  >;
}

@tag("Data Connections")
@doc("Provides access to data connection resources.")
interface DataConnections {
  @doc("Retrieve a list of data connections.")
  listDataConnection is Operations.ResourceList<
    DataConnection,
    DataConnectionsListTrait
  >;

  @doc("Validate a data connection with a given dataConnectionName.")
  @action("validate")
  validateDataConnection is Operations.ResourceCollectionAction<
    DataConnection,
    BodyParameter<DataConnectionData>,
    ValidateResult
  >;
  @doc("Retrieve a data connection with a given dataConnectionName.")
  getDataConnection is Operations.ResourceRead<DataConnection>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or replace a data connection with a given dataConnectionName.")
  @createsOrReplacesResource(DataConnection)
  @put
  createOrReplaceDataConnection is Foundations.ResourceOperation<
    DataConnection,
    BodyParameter<DataConnectionData>,
    DataConnection
  >;

  @doc("Delete a data connection with a given dataConnectionName.")
  deleteDataConnection is Operations.ResourceDelete<DataConnection>;
}

@tag("Discovery Groups")
@doc("Provides access to discovery resources.")
interface DiscoveryGroups {
  @doc("Retrieve a list of discovery group for the provided search parameters.")
  @clientName("GetDiscoveryGroups", "csharp")
  listDiscoGroup is Operations.ResourceList<DiscoGroup, DiscoGroupsListTrait>;

  @doc("Validate a discovery group with a given groupName.")
  @action("validate")
  @clientName("ValidateDiscoveryGroup", "csharp")
  validateDiscoGroup is Operations.ResourceCollectionAction<
    DiscoGroup,
    BodyParameter<DiscoGroupData>,
    ValidateResult
  >;
  @doc("Retrieve a discovery group with a given groupName.")
  @clientName("GetDiscoveryGroup", "csharp")
  getDiscoGroup is Operations.ResourceRead<DiscoGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create a discovery group with a given groupName.")
  @createsOrReplacesResource(DiscoGroup)
  @put
  @clientName("CreateOrReplaceDiscoveryGroup", "csharp")
  createOrReplaceDiscoGroup is Foundations.ResourceOperation<
    DiscoGroup,
    BodyParameter<DiscoGroupData>,
    DiscoGroup
  >;
  @doc("Run a discovery group with a given groupName.")
  @action("run")
  @clientName("RunDiscoveryGroup", "csharp")
  runDiscoGroup is Operations.ResourceAction<DiscoGroup, {}, NoContentResponse>;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Retrieve a collection of discovery run results for a discovery group with a given groupName.")
  @route("/discoGroups/{groupName}/runs")
  @get
  @clientName("GetDiscoveryGroupRuns", "csharp")
  listRuns is Foundations.Operation<
    DiscoGroupsListRunsParameter,
    DiscoRunPageResult
  >;

  @Versioning.added(Versions.v2024_03_01_preview)
  @doc("Delete a discovery group with a given discovery group name.")
  deleteDiscoGroup is Operations.ResourceDelete<DiscoGroup>;

  @doc("Retrieve an asset chain summary.")
  @action("getAssetChainSummary")
  @Versioning.added(Versions.v2024_03_01_preview)
  getAssetChainSummary is Operations.ResourceCollectionAction<
    DiscoGroup,
    BodyParameter<AssetChainRequest>,
    AssetChainSummaryResult
  >;

  @doc("Dismiss discovery chain for a given asset chain source")
  @action("dismissAssetChain")
  @Versioning.added(Versions.v2024_03_01_preview)
  dismissAssetChain is Operations.ResourceCollectionAction<
    DiscoGroup,
    BodyParameter<AssetChainRequest>,
    Task
  >;
}

@tag("Discovery Templates")
@doc("Provides access to disco template resources.")
interface DiscoveryTemplates {
  @doc("Retrieve a list of disco templates for the provided search parameters.")
  @clientName("GetDiscoveryTemplates", "csharp")
  listDiscoTemplate is Operations.ResourceList<
    DiscoTemplate,
    DiscoTemplatesListTrait
  >;
  @doc("Retrieve a disco template with a given templateId.")
  @clientName("GetDiscoveryTemplate", "csharp")
  getDiscoTemplate is Operations.ResourceRead<DiscoTemplate>;
}

@tag("Reports")
@doc("Provides access to reporting data.")
interface Reports {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get billable assets summary for the workspace.")
  @route("/reports/assets:getBillable")
  @post
  getBillable is Foundations.Operation<{}, ReportBillableAssetSummaryResult>;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the most recent snapshot of asset summary values for the snapshot request.")
  @route("/reports/assets:getSnapshot")
  @post
  getSnapshot is Foundations.Operation<
    BodyParameter<ReportAssetSnapshotRequest>,
    ReportAssetSnapshotResult
  >;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get asset summary details for the summary request.")
  @route("/reports/assets:getSummary")
  @post
  getSummary is Foundations.Operation<
    BodyParameter<ReportAssetSummaryRequest>,
    ReportAssetSummaryResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the most recent snapshot of asset summary values for the snapshot request exported to a file.")
  @Versioning.added(Versions.v2024_03_01_preview)
  @route("/reports/assets:getSnapshotExport")
  @post
  getSnapshotExport is Foundations.Operation<
    BodyParameter<ReportAssetSnapshotExportRequest>,
    Task
  >;
}

@tag("Saved Filters")
@doc("Provides access to saved filter resources.")
interface SavedFilters {
  @doc("Retrieve a list of saved filters for the provided search parameters.")
  listSavedFilter is Operations.ResourceList<
    SavedFilter,
    SavedFiltersListTrait
  >;
  @doc("Retrieve a saved filter by filterName.")
  getSavedFilter is Operations.ResourceRead<SavedFilter>;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or replace a saved filter with a given filterName.")
  @createsOrReplacesResource(SavedFilter)
  @put
  createOrReplaceSavedFilter is Foundations.ResourceOperation<
    SavedFilter,
    BodyParameter<SavedFilterData>,
    SavedFilter
  >;
  @doc("Delete a saved filter with a given filterName.")
  deleteSavedFilter is Operations.ResourceDelete<SavedFilter>;
}

@tag("Tasks")
@doc("Provides access to task resources.")
interface Tasks {
  @doc("Retrieve a list of tasks for the provided search parameters.")
  listTask is Operations.ResourceList<Task, TasksListTrait>;
  @doc("Retrieve a task by taskId.")
  getTask is Operations.ResourceRead<Task>;
  @doc("Cancel a task by taskId.")
  @action("cancel")
  cancelTask is Operations.ResourceAction<Task, {}, Task>;

  @doc("Run a task by taskId.")
  @Versioning.added(Versions.v2024_03_01_preview)
  @action("run")
  runTask is Operations.ResourceAction<Task, {}, Task>;

  @doc("Download a task.")
  @Versioning.added(Versions.v2024_03_01_preview)
  @action("download")
  downloadTask is Operations.ResourceAction<Task, {}, Task>;
}

@tag("CisaCves")
@doc("Provides access to cisa cves.")
interface CisaCves {
  @doc("Retrieve a list of CisaCves for the provided search parameters.")
  @Versioning.added(Versions.v2024_03_01_preview)
  getCisaCves is Operations.ResourceList<CisaCveResult, CisaCveListTrait>;

  @doc("Retrieve details of CisaCve by cveId")
  @Versioning.added(Versions.v2024_03_01_preview)
  getCisaCve is Operations.ResourceRead<CisaCveResult>;
}
