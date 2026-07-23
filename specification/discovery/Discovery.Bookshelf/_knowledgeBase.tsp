import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_knowledgeBase_operation.tsp";
import "./shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.Common;

@versioned(Microsoft.Discovery.Bookshelf.Versions)
namespace Microsoft.Discovery.Bookshelf;

/** Enum for IndexingStatus */
@lroStatus
union IndexingStatus {
  /** Indexing Not started */
  NotStarted: "NotStarted",

  /** Running */
  Running: "Running",

  /** Succeeded */
  @lroSucceeded
  Succeeded: "Succeeded",

  /** Canceled */
  @lroCanceled
  Canceled: "Canceled",

  /** Failed */
  @lroFailed
  Failed: "Failed",

  string,
}

@doc("Reference to a storage asset with identity information.")
@added(Versions.`2026-02-01-preview`)
model StorageAssetReference {
  @doc("The ARM resource ID of the storage asset.")
  id: StorageAssetId;

  @doc("The ARM resource ID of the User Assigned Managed Identity to access the storage asset.")
  userAssignedIdentity?: UserAssignedIdentityId;
}

@doc("Indexing metrics for a run.")
@added(Versions.`2026-06-01`)
model IndexingMetrics {
  @doc("The number of documents that were successfully processed.")
  documentsProcessed: int32;

  @doc("The number of documents that failed during indexing.")
  documentsFailed: int32;

  @doc("The total number of documents considered for indexing.")
  documentsTotal: int32;

  @doc("The indexing completion percentage from 0 to 100.")
  indexingPercentageComplete: int32;

  @doc("The UTC timestamp when enrichment started.")
  enrichmentStartTimeUtc?: utcDateTime;

  @doc("The UTC timestamp when enrichment ended.")
  enrichmentEndTimeUtc?: utcDateTime;

  @doc("The UTC timestamp when indexing started.")
  indexingStartTimeUtc?: utcDateTime;

  @doc("The UTC timestamp when indexing ended.")
  indexingEndTimeUtc?: utcDateTime;
}

@doc("The details of the last indexing run.")
@added(Versions.`2026-06-01`)
model LastIndexingRun {
  @doc("The operation run identifier.")
  runId?: string;

  @doc("The status of the indexing run.")
  status?: IndexingStatus;

  @doc("Error object that describes the error when status is 'Failed'.")
  error?: Azure.Core.Foundations.Error;

  @doc("Indexing metrics for the run.")
  indexingMetrics?: IndexingMetrics;
}

/** Base knowledgeBase properties. */
alias BaseKnowledgeBase = WithId & {
  @doc("Version.")
  @visibility(Lifecycle.Read)
  @removed(Versions.`2026-06-01`)
  version: string;

  /** The name of the associated Bookshelf tracked resource. */
  @visibility(Lifecycle.Read)
  bookshelfName: string;

  @doc("Storage asset references to index.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.`2026-02-01-preview`)
  storageAssetReferences?: StorageAssetReference[];

  @doc("Catalog data assets to index.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @removed(Versions.`2026-02-01-preview`)
  dataAssetIds: DataAssetId[];

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("URL to access the knowledge base.")
  @visibility(Lifecycle.Read)
  knowledgeBaseUrl?: string;

  /** Provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Error details if provisioning failed.")
  @visibility(Lifecycle.Read)
  @added(Versions.`2026-06-01`)
  error?: Azure.Core.Foundations.Error;

  @doc("The status")
  @visibility(Lifecycle.Read)
  status?: IndexingStatus;

  @doc("The API version used to create this knowledge base.")
  @visibility(Lifecycle.Read)
  @added(Versions.`2026-06-01`)
  createdByApiVersion?: string;

  @doc("The details of the most recent indexing run.")
  @visibility(Lifecycle.Read)
  @added(Versions.`2026-06-01`)
  lastIndexingRun?: LastIndexingRun;
} & DataPlaneResource &
  WithTags &
  WithDescription &
  WithCopilotInstruction;

@doc("A knowledgeBase.")
@resource("knowledgeBases")
model KnowledgeBase {
  @doc("The knowledgeBase name.")
  @visibility(Lifecycle.Read)
  @key("knowledgeBaseName")
  @maxLength(24)
  @pattern(knowledgeBaseNamePattern)
  name: string;

  ...BaseKnowledgeBase;
}

@doc("Status indicating the KnowledgeBase operation.")
@added(Versions.`2026-06-01`)
union KnowledgeBaseOperationType {
  @doc("An indexing operation.")
  Indexing: "Indexing",

  @doc("A cancel indexing operation.")
  CancelIndexing: "CancelIndexing",

  @doc("A search operation.")
  Search: "Search",

  @doc("A delete operation.")
  Delete: "Delete",

  string,
}

@doc("Result details for an indexing operation.")
@added(Versions.`2026-06-01`)
model IndexingOperationResult {
  @doc("The operation run identifier.")
  runId: string;

  @doc("Indexing run metrics.")
  metrics?: IndexingMetrics;
}

@doc("The type of citation.")
@added(Versions.`2026-06-01`)
union CitationType {
  @doc("A file citation.")
  FileCitation: "file_citation",

  string,
}

@doc("A citation for a generated result.")
@added(Versions.`2026-06-01`)
model Citation {
  @doc("The type of citation.")
  type: CitationType;

  @doc("Zero-based index of the citation in the result.")
  index?: int32;

  @doc("The source file name.")
  fileName: string;

  @doc("Character offset where the cited passage begins.")
  startOffset?: int32;

  @doc("Character offset where the cited passage ends.")
  endOffset?: int32;
}

@doc("A single search result item.")
@added(Versions.`2026-06-01`)
model SearchResultItem {
  @doc("The generated response text for this result.")
  text: string;

  @doc("Source citations for this result.")
  citations?: Citation[];
}

@doc("Results of a knowledge base search.")
@added(Versions.`2026-06-01`)
model SearchResponse {
  @doc("The search results.")
  searchResults: SearchResultItem[];
}

@doc("Response indicating the KnowledgeBase operation.")
@discriminator("operationType")
model KnowledgeBaseOperationResponse {
  @doc("The unique ID of the operation.")
  id: string;

  @doc("The status of the operation.")
  status: Azure.Core.Foundations.OperationState;

  @doc("Error object that describes the error when status is 'Failed'.")
  error?: Azure.Core.Foundations.Error;

  @doc("The type of operation.")
  @added(Versions.`2026-06-01`)
  operationType: KnowledgeBaseOperationType;
}

@doc("Response for indexing operations.")
@added(Versions.`2026-06-01`)
model KnowledgeBaseIndexingOperationResponse
  extends KnowledgeBaseOperationResponse {
  @doc("The type of operation.")
  operationType: "Indexing";

  @doc("Result details for indexing operations.")
  indexingResult?: IndexingOperationResult;
}

@doc("Response for search operations.")
@added(Versions.`2026-06-01`)
model KnowledgeBaseSearchOperationResponse
  extends KnowledgeBaseOperationResponse {
  @doc("The type of operation.")
  operationType: "Search";

  @doc("Result details for search operations.")
  searchResult?: SearchResponse;
}

interface KnowledgeBases {
  @doc("Creates or updates a KnowledgeBase.")
  @pollingOperation(KnowledgeBases.getOperationStatus)
  @added(Versions.`2026-06-01`)
  createOrUpdate is StandardResourceOperations.LongRunningResourceCreateOrUpdate<KnowledgeBase>;

  @doc("Fetch a KnowledgeBase by name.")
  @added(Versions.`2026-06-01`)
  get is ResourceRead<KnowledgeBase>;

  @doc("List KnowledgeBase resources")
  list is ResourceList<KnowledgeBase>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation to include searchResults field"
  @doc("Get the status of a long-running operation.")
  @route("/knowledgeBases/{knowledgeBaseName}/operations/{operationId}")
  @get
  @added(Versions.`2026-06-01`)
  getOperationStatus(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("The knowledgeBase name.")
    @path
    @maxLength(24)
    @pattern(knowledgeBaseNamePattern)
    knowledgeBaseName: string,

    @doc("The unique ID of the operation.")
    @path
    @maxLength(38)
    operationId: string,
  ): KnowledgeBaseOperationResponse | Azure.Core.Foundations.ErrorResponse;

  @doc("Start indexing.")
  @pollingOperation(KnowledgeBases.getOperationStatus)
  @added(Versions.`2026-06-01`)
  startIndexing is Operations.LongRunningResourceAction<
    KnowledgeBase,
    IndexingRequest,
    IndexingResponse
  >;

  @doc("Cancel indexing.")
  @pollingOperation(KnowledgeBases.getOperationStatus)
  @added(Versions.`2026-06-01`)
  cancelIndexing is Operations.LongRunningResourceAction<
    KnowledgeBase,
    {},
    IndexingResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom action response for runId and Processing status."
  @doc("Search the knowledge base.")
  @post
  @route("/knowledgeBases/{knowledgeBaseName}:search")
  @pollingOperation(KnowledgeBases.getOperationStatus)
  @added(Versions.`2026-06-01`)
  search(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("The knowledgeBase name.")
    @path
    @maxLength(24)
    @pattern(knowledgeBaseNamePattern)
    knowledgeBaseName: string,

    @doc("An opaque, globally-unique, client-generated string identifier for request repeatability.")
    @header("Repeatability-Request-ID")
    repeatabilityRequestId?: string,

    @doc("Specifies the date and time at which the request was first created.")
    @header("Repeatability-First-Sent")
    repeatabilityFirstSent?: utcDateTime,

    @doc("An opaque, globally-unique, client-generated string identifier for the request.")
    @header("x-ms-client-request-id")
    clientRequestId?: uuid,

    @doc("The search request body.")
    @body
    body: SearchRequest,
  ):
    | {
        @statusCode _: 202;

        @header("Operation-Location")
        operationLocation: ResourceLocation<KnowledgeBase>;

        @body body: {
          @doc("The unique ID of the operation.")
          id: string;

          @doc("The status of the operation.")
          status: Azure.Core.Foundations.OperationState;

          @doc("Error object that describes the error when status is 'Failed'.")
          error?: Azure.Core.Foundations.Error;
        };
      }
    | Azure.Core.Foundations.ErrorResponse;

  @doc("Delete a KnowledgeBase.")
  @pollingOperation(KnowledgeBases.getOperationStatus)
  @added(Versions.`2026-06-01`)
  delete is LongRunningResourceDelete<KnowledgeBase>;
}
