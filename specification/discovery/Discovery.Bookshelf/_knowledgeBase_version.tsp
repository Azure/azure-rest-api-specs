import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_knowledgeBase.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.DataPlane.Shared;

@versioned(Microsoft.Discovery.Bookshelf.Versions)
namespace Microsoft.Discovery.Bookshelf;

@doc("A version.")
@resource("versions")
@parentResource(KnowledgeBase)
model KnowledgeBaseVersion {
  @doc("The version name.")
  @visibility(Lifecycle.Read)
  @key("versionName")
  @maxLength(24)
  @pattern(Microsoft.Discovery.DataPlane.Shared.resourceNamePattern)
  name: string;

  ...BaseKnowledgeBase;
}

@doc("Resources for indexing operation")
model WithNodePool {
  @doc("Node pool ID")
  nodePoolId: string;

  @doc("Project ID")
  projectId?: string;

  @doc("Storage ID")
  storageId?: string;
}

@doc("Supercomputer run ID")
model WithRunId {
  @doc("Run ID")
  runId: string;
}

@added(Versions.`2026-02-01-preview`)
@doc("Type of reference in knowledge base")
union KnowledgeBaseReferenceType {
  string,

  /** Azure Blob reference */
  AzureBlob: "azureBlob",
}

@added(Versions.`2026-02-01-preview`)
@doc("Source data information")
model SourceData {
  @doc("The unique identifier for the source document")
  id?: string;

  @doc("The title")
  title?: string;

  @doc("The content")
  content?: string;
}

@added(Versions.`2026-02-01-preview`)
@doc("Azure Blob reference in knowledge base")
model KnowledgeBaseAzureBlobReference {
  @doc("The type of reference")
  type?: KnowledgeBaseReferenceType;

  @doc("The URL of the blob in Azure storage")
  blobUrl?: url;

  @doc("The unique identifier for the document in the knowledge base")
  id?: string;

  @doc("The relevance score")
  relevanceScore?: float32;

  @doc("Source data information")
  sourceData?: SourceData;
}

@added(Versions.`2026-02-01-preview`)
@doc("Search results from knowledge base")
model SearchResults {
  @doc("The AI-generated response summarizing the search results based on the query and knowledge base content")
  response: string;

  @doc("References to knowledge base sources")
  references?: KnowledgeBaseAzureBlobReference[];
}

@added(Versions.`2026-02-01-preview`)
@doc("Request body for search operation")
model SearchRequestBody {
  @doc("The search query string")
  query: string;
}

@added(Versions.`2026-02-01-preview`)
@doc("Status of the search operation")
model SearchOperationStatus {
  @doc("The unique ID of the operation.")
  id: string;

  @doc("The status of the operation")
  status: Azure.Core.Foundations.OperationState;

  @doc("Error object that describes the error when status is 'Failed'.")
  error?: Azure.Core.Foundations.Error;
}

@added(Versions.`2026-02-01-preview`)
@doc("Accepted response for search operation")
model SearchAcceptedResponse {
  @doc("The HTTP status code")
  @statusCode
  statusCode: 202;

  @doc("The location for monitoring the operation state.")
  @header("Operation-Location")
  operationLocation: url;

  @doc("The operation status")
  @body
  body: SearchOperationStatus;
}

@doc("Status of a KnowledgeBase operation")
model KnowledgeBaseOperationStatus {
  @doc("The unique ID of the operation.")
  id: string;

  @doc("The status of the operation")
  status: Azure.Core.Foundations.OperationState;

  @doc("Error object that describes the error when status is 'Failed'.")
  error?: Azure.Core.Foundations.Error;

  @doc("The KnowledgeBaseVersion result of the operation.")
  result?: KnowledgeBaseVersion;

  @added(Versions.`2026-02-01-preview`)
  @doc("Search results, populated when the operation is a search")
  searchResults?: SearchResults;
}

/**
 * Operation signature to retrieve a resource operation status.
 * @template Resource The type of the resource.
 * @template StatusResult Object describing the result of the status operation.
 * @template StatusError Object describing the error of the status operation. If not provided, the default error type is used.
 * @template Traits Traits to apply to the operation.
 */
@readsResource(ResourceOperationStatus<Resource>)
@Foundations.Private.ensureResourceType(Resource)
op GetResourceOperationStatus<
  Resource extends TypeSpec.Reflection.Model,
  StatusResult = Resource,
  StatusError = Foundations.Error,
  Traits extends TypeSpec.Reflection.Model = {}
> is Foundations.ResourceOperation<
  ResourceOperationStatus<Resource, StatusResult, StatusError>,
  {},
  ResourceOperationStatusResponse<Resource, StatusResult, StatusError>,
  Traits
>;

interface KnowledgeBaseVersions {
  @doc("Creates or updates a KnowledgeBaseVersion.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseVersion>;

  @doc("Fetch a KnowledgeBaseVersion by name.")
  get is ResourceRead<KnowledgeBaseVersion>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the most recent version of KnowledgeBase.")
  @get
  @route("/knowledgeBases/{knowledgeBaseName}/versions/@latest")
  getLatestVersion is Foundations.Operation<
    {
      /** Name of the KnowledgeBase */
      @path
      @maxLength(24)
      knowledgeBaseName: string;
    },
    KnowledgeBaseVersion
  >;

  @doc("List KnowledgeBaseVersion resources")
  list is ResourceList<
    KnowledgeBaseVersion,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  //   @route("/indexingOperations/{operationId}")
  //   getIndexingOperationStatus is Operations.GetResourceOperationStatus<KnowledgeBaseVersion,
  //     WithRunId
  //   >;

  //   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  //   @route("/knowledgeBases/{knowledgeBaseName}/versions/{versionName}/indexingOperations/{operationId}")
  //   getIndexingOperationStatus is Foundations.GetOperationStatus<
  //       {
  //           /** Name of the knowledgeBase resource. */
  //           @path knowledgeBaseName: string;
  //           /** Version of the knowledgeBase resource. */
  //           @path versionName: string;
  //       },
  //       KnowledgeBaseVersion
  //   >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation to include searchResults field"
  @doc("Get the status of a long-running operation.")
  @route("/knowledgeBases/{knowledgeBaseName}/versions/{versionName}/operations/{operationId}")
  @get
  getOperationStatus(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("The knowledgeBase name.")
    @path
    @maxLength(24)
    @pattern(Microsoft.Discovery.DataPlane.Shared.resourceNamePattern)
    knowledgeBaseName: string,

    @doc("The version name.")
    @path
    @maxLength(24)
    @pattern(Microsoft.Discovery.DataPlane.Shared.resourceNamePattern)
    versionName: string,

    @doc("The unique ID of the operation.")
    @path
    @maxLength(38)
    operationId: string,
  ): KnowledgeBaseOperationStatus | Azure.Core.Foundations.ErrorResponse;

  @doc("Start indexing.")
  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  startIndexing is Operations.LongRunningResourceAction<
    KnowledgeBaseVersion,
    WithNodePool,
    WithRunId
  >;

  @doc("Cancel indexing.")
  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  cancelIndexing is Operations.LongRunningResourceAction<
    KnowledgeBaseVersion,
    WithNodePool,
    WithRunId
  >;

  @doc("Delete a KnowledgeBaseVersion.")
  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  delete is LongRunningResourceDelete<KnowledgeBaseVersion>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation to return named response model for LRO"
  @added(Versions.`2026-02-01-preview`)
  @doc("Search within a KnowledgeBase version")
  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  @route("/knowledgeBases/{knowledgeBaseName}/versions/{versionName}:search")
  @post
  search(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("The knowledgeBase name.")
    @path
    @maxLength(24)
    @pattern(Microsoft.Discovery.DataPlane.Shared.resourceNamePattern)
    knowledgeBaseName: string,

    @doc("The version name.")
    @path
    @maxLength(24)
    @pattern(Microsoft.Discovery.DataPlane.Shared.resourceNamePattern)
    versionName: string,

    @doc("The request body for search")
    @body
    body: SearchRequestBody,
  ): SearchAcceptedResponse | Azure.Core.Foundations.ErrorResponse;

  //  @doc("Restore the KnowledgeBase to the state of this version.")
  //  restore is Operations.ResourceAction<KnowledgeBaseVersion, {}, KnowledgeBase>;
}
