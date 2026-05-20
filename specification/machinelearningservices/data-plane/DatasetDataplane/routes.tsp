import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.DatasetDataplane;

/** Common workspace path parameters. */
model WorkspacePathParameters {
  /** The Azure Subscription ID. */
  @path subscriptionId: string;

  /** The Name of the resource group in which the workspace is located. */
  @path resourceGroupName: string;

  /** The name of the workspace. */
  @path workspaceName: string;
}

// ─── DataCall Interface (data/v2.0) ───

interface DataCall {
  /** Get a preview for an MLTable. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  @route("/data/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacall/preview")
  @post
  getPreviewForMLTable is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data call request. */
      @bodyRoot body: DataCallRequest;
    },
    DataViewSetResult
  >;

  /** Get a quick profile for an MLTable. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  @route("/data/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacall/quickprofile")
  @post
  getQuickProfileForMLTable is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data call request. */
      @bodyRoot body: DataCallRequest;
    },
    ProfileResult[]
  >;

  /** Get the schema for an MLTable. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
  @route("/data/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacall/schema")
  @post
  getSchemaForMLTable is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data call request. */
      @bodyRoot body: DataCallRequest;
    },
    ColumnDefinition[]
  >;
}

// ─── DataContainer Interface (data/v1.0) ───

interface DataContainerOps {
  /** Create a data container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacontainer")
  @post
  createDataContainer is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container to create. */
      @bodyRoot body: DataContainer;
    },
    DataContainerEntity
  >;

  /** List data containers. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacontainer")
  @list
  @get
  listDataContainer is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;
    },
    PaginatedDataContainerEntityList
  >;

  /** Get a data container by name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacontainer/{name}")
  @get
  getDataContainer is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;
    },
    DataContainerEntity
  >;

  /** Modify a data container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacontainer/{name}")
  @patch(#{ implicitOptionality: true })
  modifyDataContainer is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;

      /** Request body. */
      @bodyRoot body: DataContainerMutable;
    },
    DataContainerEntity
  >;

  /** Delete a data container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datacontainer/{name}")
  @delete
  deleteDataContainer is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;
    },
    HttpResponseMessage
  >;
}

// ─── DataVersion Interface (data/v1.0) ───

interface DataVersionOps {
  /** Batch get resolved URIs. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/batchGetResolvedUris")
  @post
  batchGetResolvedUris is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The batch request. */
      @bodyRoot body: BatchGetResolvedURIs;
    },
    BatchDataUriResponse
  >;

  /** Create unregistered input data. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/createUnregisteredInput")
  @post
  createUnregisteredInputData is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The unregistered input data to create. */
      @bodyRoot body: CreateUnregisteredInputData;
    },
    DataContainerEntity
  >;

  /** Create unregistered output data. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/createUnregisteredOutput")
  @post
  createUnregisteredOutputData is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The unregistered output data to create. */
      @bodyRoot body: CreateUnregisteredOutputData;
    },
    DataContainerEntity
  >;

  /** Get a data version by asset ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/getByAssetId")
  @post
  getByAssetId is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The asset ID. */
      @bodyRoot body: AssetId;
    },
    DataVersionEntity
  >;

  /** Register existing data as a named data asset. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/registerExisting")
  @post
  registerExistingData is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The register existing data request. */
      @bodyRoot body: RegisterExistingData;
    },
    DataContainerEntity
  >;

  /** Create a data version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/{name}/versions")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;

      /** The data version to create. */
      @bodyRoot body: DataVersion;
    },
    DataVersionEntity
  >;

  /** List data versions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/{name}/versions")
  @list
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;

      /** Order by. */
      @query orderBy?: string;

      /** Top count. */
      @query top?: int32;
    },
    PaginatedDataVersionEntityList
  >;

  /** Get a specific data version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;

      /** The data version. */
      @path version: string;
    },
    DataVersionEntity
  >;

  /** Modify a data version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/{name}/versions/{version}")
  @patch(#{ implicitOptionality: true })
  modify is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;

      /** The data version. */
      @path version: string;

      /** Request body. */
      @bodyRoot body: DataVersionMutable;
    },
    DataVersionEntity
  >;

  /** Delete a data version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/{name}/versions/{version}")
  @delete
  deleteVersion is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;

      /** The data version. */
      @path version: string;
    },
    HttpResponseMessage
  >;

  /** Check if a data version exists. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/data/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/dataversion/{name}/versions/{version}/exists")
  @get
  exists is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The data container name. */
      @path name: string;

      /** The data version. */
      @path version: string;
    },
    boolean
  >;
}

// ─── DatasetsV1 Interface (dataset/v1.0) ───

interface DatasetsV1 {
  /** List datasets. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @list
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Dataset names to filter by. */
      @query datasetNames?: string[];

      /** Search text. */
      @query searchText?: string;

      /** Include invisible datasets. */
      @query includeInvisible?: boolean;

      /** Filter by status. */
      @query status?: string;

      /** Continuation token for pagination. */
      @continuationToken
      @continuationToken
      @query
      continuationToken?: string;

      /** Page size. */
      @query pageSize?: int32;

      /** Include latest definition. */
      @query includeLatestDefinition?: boolean;

      /** Order by field. */
      @query orderBy?: string;

      /** Order ascending. */
      @query orderByAsc?: boolean;

      /** Dataset types to filter by. */
      @query datasetTypes?: string[];
    },
    PaginatedDatasetList
  >;

  /** Register a dataset. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @post
  register is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Register as pending. */
      @query registerAsPending?: boolean;

      /** If exists, return OK. */
      @query ifExistsOk?: boolean;

      /** Update definition if exists. */
      @query updateDefinitionIfExists?: boolean;

      /** With data hash. */
      @query withDataHash?: boolean;

      /** User version ID. */
      @query userVersionId?: string;

      /** The dataset to register. */
      @bodyRoot body: Dataset;
    },
    Dataset
  >;

  /** Delete all datasets. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @delete
  deleteAllDatasets is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;
    },
    void
  >;

  /** Get a dataset by name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/query/name={datasetName}")
  @get
  getDatasetByName is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset name. */
      @path datasetName: string;

      /** The version ID. */
      @query versionId?: string;

      /** Include latest definition. */
      @query includeLatestDefinition?: boolean;
    },
    Dataset
  >;

  /** Update a dataset. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}")
  @put
  updateDataset is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Force update. */
      @query forceUpdate?: boolean;

      /** The dataset to update. */
      @bodyRoot body: Dataset;
    },
    Dataset
  >;

  /** Get all dataset definitions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/definitions")
  @list
  @get
  getAllDatasetDefinitions is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Continuation token for pagination. */
      @continuationToken
      @continuationToken
      @query
      continuationToken?: string;

      /** Page size. */
      @query pageSize?: int32;
    },
    PaginatedDatasetDefinitionList
  >;

  /** Update a dataset definition. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/definitions")
  @post
  updateDefinition is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Register as pending. */
      @query registerAsPending?: boolean;

      /** Force update. */
      @query forceUpdate?: boolean;

      /** Dataset type. */
      @query datasetType?: string;

      /** User version ID. */
      @query userVersionId?: string;

      /** The dataset definition. */
      @bodyRoot body: DatasetDefinition;
    },
    Dataset
  >;

  /** Get a specific dataset definition version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/definitions/{version}")
  @get
  getDatasetDefinition is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** The definition version. */
      @path version: string;
    },
    DatasetDefinition
  >;

  /** Get all dataset versions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/versions")
  @list
  @get
  getAllDatasetVersions is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Continuation token for pagination. */
      @continuationToken
      @continuationToken
      @query
      continuationToken?: string;

      /** Page size. */
      @query pageSize?: int32;
    },
    PaginatedStringList
  >;

  /** Unregister a dataset by name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{name}")
  @delete
  unregisterDataset is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset name. */
      @path name: string;
    },
    void
  >;
}

// ─── DatasetControllerV2 Interface (dataset/v1.2) ───

interface DatasetControllerV2 {
  /** List datasets (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @list
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Dataset names to filter by. */
      @query datasetNames?: string[];

      /** Search text. */
      @query searchText?: string;

      /** Include invisible datasets. */
      @query includeInvisible?: boolean;

      /** Filter by status. */
      @query status?: string;

      /** Continuation token for pagination. */
      @continuationToken
      @continuationToken
      @query
      continuationToken?: string;

      /** Page size. */
      @query pageSize?: int32;

      /** Include latest definition. */
      @query includeLatestDefinition?: boolean;

      /** Order by field. */
      @query orderBy?: string;

      /** Order ascending. */
      @query orderByAsc?: boolean;

      /** Dataset types to filter by. */
      @query datasetTypes?: string[];
    },
    PaginatedDatasetList
  >;

  /** Register a dataset (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @post
  register is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Register as pending. */
      @query registerAsPending?: boolean;

      /** If exists, return OK. */
      @query ifExistsOk?: boolean;

      /** Update definition if exists. */
      @query updateDefinitionIfExists?: boolean;

      /** With data hash. */
      @query withDataHash?: boolean;

      /** User version ID. */
      @query userVersionId?: string;

      /** The dataset to register. */
      @bodyRoot body: Dataset;
    },
    Dataset
  >;

  /** Delete all datasets (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @delete
  deleteAllDatasets is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;
    },
    void
  >;

  /** Get a dataset by name (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/query/name={datasetName}")
  @get
  getDatasetByName is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset name. */
      @path datasetName: string;

      /** The version ID. */
      @query versionId?: string;

      /** Include latest definition. */
      @query includeLatestDefinition?: boolean;
    },
    Dataset
  >;

  /** Update a dataset (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}")
  @put
  updateDataset is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Force update. */
      @query forceUpdate?: boolean;

      /** The dataset to update. */
      @bodyRoot body: Dataset;
    },
    Dataset
  >;

  /** Get all dataset definitions (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/definitions")
  @list
  @get
  getAllDatasetDefinitions is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Continuation token for pagination. */
      @continuationToken
      @continuationToken
      @query
      continuationToken?: string;

      /** Page size. */
      @query pageSize?: int32;
    },
    PaginatedDatasetDefinitionList
  >;

  /** Update a dataset definition (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/definitions")
  @post
  updateDefinition is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Register as pending. */
      @query registerAsPending?: boolean;

      /** Force update. */
      @query forceUpdate?: boolean;

      /** Dataset type. */
      @query datasetType?: string;

      /** User version ID. */
      @query userVersionId?: string;

      /** The dataset definition. */
      @bodyRoot body: DatasetDefinition;
    },
    Dataset
  >;

  /** Get a specific dataset definition version (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/definitions/{version}")
  @get
  getDatasetDefinition is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** The definition version. */
      @path version: string;
    },
    DatasetDefinition
  >;

  /** Get all dataset versions (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}/versions")
  @list
  @get
  getAllDatasetVersions is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** Continuation token for pagination. */
      @continuationToken
      @continuationToken
      @query
      continuationToken?: string;

      /** Page size. */
      @query pageSize?: int32;
    },
    PaginatedStringList
  >;

  /** Unregister a dataset by name (v1.2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v1.2/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{name}")
  @delete
  unregisterDataset is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset name. */
      @path name: string;
    },
    void
  >;
}

// ─── DatasetV2 Interface (dataset/v2.0) ───

interface DatasetV2Operations {
  /** Create a dataset (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** If exists, update. */
      @query ifExistsUpdate?: boolean;

      /** The dataset to create. */
      @bodyRoot body: DatasetV2;
    },
    DatasetV2
  >;

  /** Delete all datasets (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @delete
  deleteAllDatasets is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;
    },
    void
  >;

  /** List datasets (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets")
  @list
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Dataset names to filter by. */
      @query names?: string[];

      /** Search text. */
      @query searchText?: string;

      /** Continuation token for pagination. */
      @continuationToken
      @continuationToken
      @query
      continuationToken?: string;

      /** Page size. */
      @query pageSize?: int32;
    },
    PaginatedDatasetV2List
  >;

  /** Get a dataset by name (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/query/name={datasetName}")
  @get
  getDatasetByName is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset name. */
      @path datasetName: string;

      /** The version ID. */
      @query versionId?: string;
    },
    DatasetV2
  >;

  /** Get a dataset by ID (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}")
  @get
  getDatasetById is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;
    },
    DatasetV2
  >;

  /** Update a dataset (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{datasetId}")
  @put
  updateDataset is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset ID. */
      @path datasetId: string;

      /** The dataset to update. */
      @bodyRoot body: DatasetV2;
    },
    DatasetV2
  >;

  /** Delete a dataset by name and version (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{name}/versions/{versionId}")
  @delete
  deleteDatasetByName is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset name. */
      @path name: string;

      /** The version ID. */
      @path versionId: string;
    },
    void
  >;

  /** Update a dataset by name and version (v2). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/dataset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/datasets/{name}/versions/{versionId}")
  @put
  updateDatasetByNameAndVersion is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The dataset name. */
      @path name: string;

      /** The version ID. */
      @path versionId: string;

      /** The dataset to update. */
      @bodyRoot body: DatasetV2;
    },
    DatasetV2
  >;
}

// ─── GetOperationStatus Interface (dataset/v1.0) ───

interface GetOperationStatus {
  /** Get dataset operation status. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/dataset/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/operations/{operationId}")
  @get
  getDatasetOperationStatus is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The operation ID. */
      @path operationId: string;
    },
    LongRunningOperationResponse
  >;
}
