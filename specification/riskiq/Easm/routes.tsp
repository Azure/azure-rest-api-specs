import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Easm;

@tag("Assets")
@doc("Provides access to inventory assets.")
interface Assets {
    @doc("Retrieve a list of assets for the provided search parameters.")
    listAssetResource is Operations.ResourceList<
        AssetResource,
        AssetsListTrait
    >;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Update labels on assets matching the provided filter.")
    @route("/assets")
    @post
    updateAssets is Foundations.Operation<
        {
            ...AssetsUpdateParameter;
            ...AssetUpdateData;
        },
        Task,
        {},
        ErrorResponse
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
        ValidateResponse
    >;
    @doc("Retrieve a data connection with a given dataConnectionName.")
    getDataConnection is Operations.ResourceRead<DataConnection>;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Create or update a data connection with a given dataConnectionName.")
    @put
    putDataConnection is Foundations.ResourceOperation<
        DataConnection,
        DataConnectionData,
        DataConnection,
        {},
        ErrorResponse
    >;
    @doc("Delete a data connection with a given dataConnectionName.")
    deleteDataConnection is Operations.ResourceDelete<DataConnection>;
}

@tag("Discovery Groups")
@doc("Provides access to discovery resources.")
interface DiscoveryGroups {
    @doc("Retrieve a list of discovery group for the provided search parameters.")
    listDiscoGroup is Operations.ResourceList<
        DiscoGroup,
        DiscoveryGroupsListTrait
    >;
    @doc("Validate a discovery group with a given groupName.")
    @action("validate")
    validateDiscoGroup is Operations.ResourceCollectionAction<
        DiscoGroup,
        DiscoGroupData,
        ValidateResponse
    >;
    @doc("Retrieve a discovery group with a given groupName.")
    getDiscoGroup is Operations.ResourceRead<DiscoGroup>;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Create a discovery group with a given groupName.")
    @put
    putDiscoGroup is Foundations.ResourceOperation<
        DiscoGroup,
        DiscoGroupData,
        DiscoGroup,
        {},
        ErrorResponse
    >;
    @doc("Run a discovery group with a given groupName.")
    @action("run")
    runDiscoGroup is Operations.ResourceAction<
        DiscoGroup,
        {},
        NoContentResponse
    >;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Retrieve a collection of discovery run results for a discovery group with a given groupName.")
    @route("/discoGroups/{groupName}/runs")
    @get
    listRuns is Foundations.Operation<
        DiscoveryGroupsListRunsParameter,
        DiscoRunPageResponse,
        {},
        ErrorResponse
    >;
}

@tag("Discovery Templates")
@doc("Provides access to disco template resources.")
interface DiscoveryTemplates {
    @doc("Retrieve a list of disco templates for the provided search parameters.")
    listDiscoTemplate is Operations.ResourceList<
        DiscoTemplate,
        DiscoveryTemplatesListTrait
    >;
    @doc("Retrieve a disco template with a given templateId.")
    getDiscoTemplate is Operations.ResourceRead<DiscoTemplate>;
}

@tag("Reports")
@doc("Provides access to reporting data.")
interface Reports {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Get billable assets summary for the workspace.")
    @route("/reports/assets:getBillable")
    @post
    getBillableReports is Foundations.Operation<
        {},
        ReportBillableAssetSummaryResponse,
        {},
        ErrorResponse
    >;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Get the most recent snapshot of asset summary values for the snapshot request.")
    @route("/reports/assets:getSnapshot")
    @post
    getSnapshotReports is Foundations.Operation<
        ReportAssetSnapshotRequest,
        ReportAssetSnapshotResponse,
        {},
        ErrorResponse
    >;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Get asset summary details for the summary request.")
    @route("/reports/assets:getSummary")
    @post
    getSummaryReports is Foundations.Operation<
        ReportAssetSummaryRequest,
        ReportAssetSummaryResponse,
        {},
        ErrorResponse
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
    @doc("Create or update a saved filter with a given filterName.")
    @put
    putSavedFilter is Foundations.ResourceOperation<
        SavedFilter,
        SavedFilterData,
        SavedFilter,
        {},
        ErrorResponse
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
