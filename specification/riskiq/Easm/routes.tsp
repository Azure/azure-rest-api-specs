import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace Easm;

alias ServiceTraits = NoRepeatableRequests &
    NoConditionalRequests &
    NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits, ErrorResponse>;
@tag("Assets")
@doc("Provides access to inventory assets.")
interface Assets {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Retrieve a list of assets for the provided search parameters.")
    list is Foundations.ResourceList<
        AssetResource,
        AssetsListParameter,
        AssetPageResponse,
        {},
        ErrorResponse
    >;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Update labels on assets matching the provided filter.")
    @route("/assets")
    @post
    update is Foundations.Operation<
        {
            ...AssetsUpdateParameter;
            ...AssetUpdateData;
        },
        Task,
        {},
        ErrorResponse
    >;
    @doc("Retrieve an asset by assetId.")
    get is Operations.ResourceRead<AssetResource>;
}

@tag("Data Connections")
@doc("Provides access to data connection resources.")
interface DataConnections {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Retrieve a list of data connections.")
    list is Foundations.ResourceList<
        DataConnection,
        DataConnectionsListParameter,
        DataConnectionPageResponse,
        {},
        ErrorResponse
    >;
    @doc("Validate a data connection with a given dataConnectionName.")
    @action("validate")
    validate is Operations.ResourceCollectionAction<
        DataConnection,
        DataConnectionData,
        ValidateResponse
    >;
    @doc("Retrieve a data connection with a given dataConnectionName.")
    get is Operations.ResourceRead<DataConnection>;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Create or update a data connection with a given dataConnectionName.")
    @put
    put is Foundations.ResourceOperation<
        DataConnection,
        DataConnectionData,
        DataConnection,
        {},
        ErrorResponse
    >;
    @doc("Delete a data connection with a given dataConnectionName.")
    delete is Operations.ResourceDelete<DataConnection>;
}

@tag("Discovery Groups")
@doc("Provides access to discovery resources.")
interface DiscoveryGroups {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Retrieve a list of discovery group for the provided search parameters.")
    list is Foundations.ResourceList<
        DiscoGroup,
        CommonListParameter,
        DiscoGroupPageResponse,
        {},
        ErrorResponse
    >;
    @doc("Validate a discovery group with a given groupName.")
    @action("validate")
    validate is Operations.ResourceCollectionAction<
        DiscoGroup,
        DiscoGroupData,
        ValidateResponse
    >;
    @doc("Retrieve a discovery group with a given groupName.")
    get is Operations.ResourceRead<DiscoGroup>;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Create a discovery group with a given groupName.")
    @put
    put is Foundations.ResourceOperation<
        DiscoGroup,
        DiscoGroupData,
        DiscoGroup,
        {},
        ErrorResponse
    >;
    @doc("Run a discovery group with a given groupName.")
    @action("run")
    run is Operations.ResourceAction<DiscoGroup, {}, NoContentResponse>;
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
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Retrieve a list of disco templates for the provided search parameters.")
    list is Foundations.ResourceList<
        DiscoTemplate,
        CommonListParameter,
        DiscoTemplatePageResponse,
        {},
        ErrorResponse
    >;
    @doc("Retrieve a disco template with a given templateId.")
    get is Operations.ResourceRead<DiscoTemplate>;
}

@tag("Reports")
@doc("Provides access to reporting data.")
interface Reports {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Get billable assets summary for the workspace.")
    @route("/reports/assets:getBillable")
    @post
    billable is Foundations.Operation<
        {},
        ReportBillableAssetSummaryResponse,
        {},
        ErrorResponse
    >;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Get the most recent snapshot of asset summary values for the snapshot request.")
    @route("/reports/assets:getSnapshot")
    @post
    snapshot is Foundations.Operation<
        ReportAssetSnapshotRequest,
        ReportAssetSnapshotResponse,
        {},
        ErrorResponse
    >;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Get asset summary details for the summary request.")
    @route("/reports/assets:getSummary")
    @post
    summary is Foundations.Operation<
        ReportAssetSummaryRequest,
        ReportAssetSummaryResponse,
        {},
        ErrorResponse
    >;
}

@tag("Saved Filters")
@doc("Provides access to saved filter resources.")
interface SavedFilters {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Retrieve a list of saved filters for the provided search parameters.")
    list is Foundations.ResourceList<
        SavedFilter,
        CommonListParameter,
        SavedFilterPageResponse,
        {},
        ErrorResponse
    >;
    @doc("Retrieve a saved filter by filterName.")
    get is Operations.ResourceRead<SavedFilter>;
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Create or update a saved filter with a given filterName.")
    @put
    put is Foundations.ResourceOperation<
        SavedFilter,
        SavedFilterData,
        SavedFilter,
        {},
        ErrorResponse
    >;
    @doc("Delete a saved filter with a given filterName.")
    delete is Operations.ResourceDelete<SavedFilter>;
}

@tag("Tasks")
@doc("Provides access to task resources.")
interface Tasks {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @doc("Retrieve a list of tasks for the provided search parameters.")
    list is Foundations.ResourceList<
        Task,
        TasksListParameter,
        TaskPageResponse,
        {},
        ErrorResponse
    >;
    @doc("Retrieve a task by taskId.")
    get is Operations.ResourceRead<Task>;
    @doc("Cancel a task by taskId.")
    @action("cancel")
    cancel is Operations.ResourceAction<Task, {}, Task>;
}
