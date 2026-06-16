import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.MachineLearningServices.ModelDataplane;

/** Common workspace path parameters. */
model WorkspacePathParameters {
  /** The Azure subscription identifier. */
  @path subscriptionId: string;

  /** The resource group name. */
  @path resourceGroupName: string;

  /** The workspace name. */
  @path workspaceName: string;
}

interface Assets {
  /** Create a new asset. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/assets")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The asset to create. */
      @body body?: Asset;
    },
    Asset
  >;

  /** List assets in a workspace. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/assets")
  @list
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Filter by run identifier. */
      @query runId?: string;

      /** Filter by project identifier. */
      @query projectId?: string;

      /** Filter by name. */
      @query name?: string;

      /** Filter by tag. */
      @query tag?: string;

      /** Number of results to return. */
      @query count?: int32;

      /** Skip token for pagination. */
      @query("$skipToken") skipToken?: string;

      /** Filter by tags string. */
      @query tags?: string;

      /** Filter by properties string. */
      @query properties?: string;

      /** Filter by type. */
      @query type?: string;

      /** Order by expression. */
      @query orderby?: OrderString;
    },
    AssetPaginatedResult
  >;

  /** Get an asset by identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/assets/{id}")
  @get
  queryById is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The asset identifier. */
      @path id: string;
    },
    Asset
  >;

  /** Patch an asset. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API contract"
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/assets/{id}")
  @patch(#{ implicitOptionality: true })
  patch is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The asset identifier. */
      @path id: string;

      /** The patch operations to apply. */
      @header("Content-Type") contentType: "application/json-patch+json";

      /** The patch operations to apply. */
      @body body: PatchOperation[];
    },
    Asset
  >;

  /** Delete an asset. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/assets/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The asset identifier. */
      @path id: string;
    },
    void
  >;
}

interface ExtensiveModels {
  /** Get an extensive model by identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/extensiveModels/{id}")
  @get
  queryById is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The extensive model identifier. */
      @path id: string;
    },
    ExtensiveModel
  >;
}

interface Migration {
  /** Start a migration operation. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/meta/migration")
  @post
  startMigration is Azure.Core.Foundations.Operation<
    {
      /** The migration name. */
      @query migration?: string;

      /** The timeout duration. */
      @query timeout?: string;

      /** The collection identifier. */
      @query collectionId?: string;

      /** The workspace identifier. */
      @query workspaceId?: string;
    },
    void
  >;
}

interface Models {
  /** Register a new model. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models")
  @post
  register is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Whether to auto-version the model. */
      @query autoVersion?: boolean;

      /** The model to register. */
      @body body: Model;
    },
    Model
  >;

  /** List models in a workspace. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models")
  @list
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** Filter by model name. */
      @query name?: string;

      /** Filter by tag. */
      @query tag?: string;

      /** Filter by version. */
      @query version?: string;

      /** Filter by framework. */
      @query framework?: string;

      /** Filter by description. */
      @query description?: string;

      /** Number of results to return. */
      @query count?: int32;

      /** Offset for pagination. */
      @query offset?: int32;

      /** Skip token for pagination. */
      @query("$skipToken") skipToken?: string;

      /** Filter by tags string. */
      @query tags?: string;

      /** Filter by properties string. */
      @query properties?: string;

      /** Filter by run identifier. */
      @query runId?: string;

      /** Filter by dataset identifier. */
      @query datasetId?: string;

      /** Order by expression. */
      @query orderBy?: string;

      /** Whether to return only the latest version. */
      @query latestVersionOnly?: boolean;

      /** Filter by feed. */
      @query feed?: string;

      /** The list view type filter. */
      @query listViewType?: ListViewType;
    },
    ModelPagedResponse
  >;

  /** Create an unregistered input model. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/createUnregisteredInput")
  @post
  createUnregisteredInputModel is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The unregistered input model to create. */
      @body body: CreateUnregisteredInputModelDto;
    },
    Model
  >;

  /** Create an unregistered output model. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/createUnregisteredOutput")
  @post
  createUnregisteredOutputModel is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The unregistered output model to create. */
      @body body: CreateUnregisteredOutputModelDto;
    },
    Model
  >;

  /** Batch get resolved URIs for models. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/batchGetResolvedUris")
  @post
  batchGetResolvedUris is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The batch resolve request. */
      @body body?: BatchGetResolvedUrisDto;
    },
    BatchModelPathResponseDto
  >;

  /** Get a model by identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{id}")
  @get
  queryById is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The model identifier. */
      @path id: string;

      /** Whether to include deployment settings. */
      @query includeDeploymentSettings?: boolean;
    },
    Model
  >;

  /** Delete a model by identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The model identifier. */
      @path id: string;
    },
    void
  >;

  /** Patch a model. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API contract"
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{id}")
  @patch(#{ implicitOptionality: true })
  patch is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The model identifier. */
      @path id: string;

      /** The content type for patch operations. */
      @header("Content-Type") contentType: "application/json-patch+json";

      /** The patch operations to apply. */
      @body body: PatchOperation[];
    },
    Model
  >;

  /** List models using POST with request body. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/list")
  @post
  listQueryPost is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The list models request. */
      @body body?: ListModelsRequest;
    },
    ModelListModelsRequestPagedResponse
  >;

  /** Batch query models by identifiers. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/querybatch")
  @post
  batchQuery is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The batch query request. */
      @body body?: ModelBatchDto;
    },
    ModelBatchResponseDto
  >;

  /** Set deployment settings for models. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/modelregistry/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/deploymentSettings")
  @post
  deploymentSettings is Azure.Core.Foundations.Operation<
    {
      ...WorkspacePathParameters;

      /** The model settings identifiers. */
      @body body?: ModelSettingsIdentifiers;
    },
    void
  >;
}
