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
    AssetsUpdateParameter & AssetUpdateData,
    Task
  >;
  @doc("Retrieve an asset by assetId.")
  getAssetResource is Operations.ResourceRead<AssetResource>;
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
    DataConnectionData,
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
    DataConnectionData,
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
    DiscoGroupData,
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
    DiscoGroupData,
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
    ReportAssetSnapshotRequest,
    ReportAssetSnapshotResult
  >;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get asset summary details for the summary request.")
  @route("/reports/assets:getSummary")
  @post
  getSummary is Foundations.Operation<
    ReportAssetSummaryRequest,
    ReportAssetSummaryResult
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
    SavedFilterData,
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
}
