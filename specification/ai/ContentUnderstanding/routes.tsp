import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

@doc("Provides the 'Operation-Id' header to enable idempotent long-running operations.")
model OperationIdHeader {
  @header("Operation-Id")
  @doc("A client-provided GUID to identify the long-running operation.")
  operationId?: string;
}

alias ServiceTraits = Traits.NoRepeatableRequests &
  Traits.NoConditionalRequests &
  Traits.SupportsClientRequestId;
alias Operations = ResourceOperations<ServiceTraits>;

interface ContentAnalyzers {
  @doc("Get the status of an analyzer creation operation.")
  getOperationStatus is Operations.GetResourceOperationStatus<
    ContentAnalyzer,
    ContentAnalyzer
  >;

  @doc("Create a new analyzer asynchronously.")
  @pollingOperation(ContentAnalyzers.getOperationStatus)
  createOrReplace is Operations.LongRunningResourceCreateOrReplace<ContentAnalyzer>;

  @doc("Update analyzer properties.")
  update is Operations.ResourceUpdate<ContentAnalyzer>;

  @doc("Get analyzer properties.")
  get is Operations.ResourceRead<ContentAnalyzer>;

  @doc("Delete analyzer.")
  delete is Operations.ResourceDelete<ContentAnalyzer>;

  @doc("List analyzers.")
  list is Operations.ResourceList<ContentAnalyzer>;

  @doc("Extract content and fields from input.")
  @sharedRoute
  @action("analyze")
  @pollingOperation(ContentAnalyzers.getResult)
  analyze is Operations.LongRunningResourceAction<
    ContentAnalyzer,
    AnalyzeRequest,
    AnalyzeResult
  >;

  @doc("Extract content and fields from input.")
  @sharedRoute
  @action("analyze")
  @pollingOperation(ContentAnalyzers.getResult)
  analyzeBinary is Operations.LongRunningResourceAction<
    ContentAnalyzer,
    AnalyzeBinaryRequest,
    AnalyzeResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  @doc("Get the result of an analysis operation.")
  @route("/analyzerResults/{operationId}")
  getResult is Foundations.GetOperationStatus<
    GetResultParameters,
    AnalyzeResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @removed(Versions.v2025_05_01_preview)
  @doc("Get an image associated with the result of an analysis operation.")
  @route("/analyzers/{analyzerId}/results/{operationId}/images/{imageId}")
  @get
  getResultImage is Foundations.Operation<
    {
      @doc("Analyzer identifier.")
      @path
      analyzerId: string;

      @doc("Operation identifier.")
      @path
      operationId: string;

      @doc("Image identifier.")
      @path
      imageId: string;
    },
    {
      @doc("Response content type.")
      @header
      contentType: "image/*";

      @doc("Image content.")
      @bodyRoot
      image: bytes;
    },
    ServiceTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(Versions.v2025_05_01_preview)
  @doc("Get a file associated with the result of an analysis operation.")
  @route("/analyzerResults/{operationId}/files/{+path}")
  @get
  getResultFile is Foundations.Operation<
    {
      @doc("Operation identifier.")
      @path
      operationId: string;

      @doc("File path.")
      @path
      path: string;
    },
    {
      @doc("Response content type.")
      @header
      contentType: string;

      @doc("Result file content.")
      @bodyRoot
      data: bytes;
    },
    ServiceTraits
  >;

  // #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  // @added(Versions.v2025_05_01_preview)
  // @doc("Mark the result of an analysis operation for deletion.")
  // @route("/analyzerResults/{operationId}")
  // @delete
  // deleteResult is Foundations.Operation<
  //   {
  //     @doc("Operation identifier.")
  //     @path
  //     operationId: string;
  //   },
  //   TypeSpec.Http.NoContentResponse,
  //   ServiceTraits
  // >;
}
