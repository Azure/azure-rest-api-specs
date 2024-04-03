import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DocumentIntelligence;

alias ServiceTraits = NoConditionalRequests &
  NoRepeatableRequests &
  SupportsClientRequestId;

op DocumentIntelligenceOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model & Foundations.RetryAfterHeader
> is Foundations.Operation<TParams, TResponse, ServiceTraits, ErrorResponse>;

alias DIResourceOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
op DocumentIntelligenceLongRunningOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model
> is Foundations.Operation<
  TParams,
  AcceptedResponse &
    Foundations.RetryAfterHeader & {
      @pollingLocation
      @header("Operation-Location")
      operationLocation: ResourceLocation<TResponse>;
    },
  ServiceTraits,
  ErrorResponse
>;

@doc("Document model analyze request parameters.")
model DocumentModelAnalyzeRequestParams {
  @doc("Unique document model name.")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  @maxLength(64)
  modelId: string;

  @doc("List of 1-based page numbers to analyze.  Ex. \"1-3,5,7-9\"")
  @query
  @pattern("^(\\d+(-\\d+)?)(,\\s*(\\d+(-\\d+)?))*$")
  pages?: string;

  @doc("""
  Locale hint for text recognition and document analysis.  Value may contain only
  the language code (ex. \"en\", \"fr\") or BCP 47 language tag (ex. \"en-US\").
  """)
  @query
  locale?: string;

  @doc("Method used to compute string offset and length.")
  @query
  stringIndexType?: StringIndexType = StringIndexType.textElements;

  @doc("List of optional analysis features.")
  @query({
    format: "csv",
  })
  features?: DocumentAnalysisFeature[];

  @doc("List of additional fields to extract.  Ex. \"NumberOfGuests,StoreNumber\"")
  @query({
    format: "csv",
  })
  queryFields?: string[];

  @doc("Format of the analyze result top-level content.")
  @query
  outputContentFormat?: ContentFormat = ContentFormat.text;
}

@doc("Document classifier analyze request parameters.")
model DocumentClassifierAnalyzeRequestParams {
  @doc("Unique document classifier name.")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  @maxLength(64)
  classifierId: string;

  @doc("Method used to compute string offset and length.")
  @query
  stringIndexType?: StringIndexType = StringIndexType.textElements;

  @doc("Document splitting mode.")
  @query
  split?: SplitMode = SplitMode.none;
}

@doc("Analyze from stream request parameters.")
model AnalyzeFromStreamRequestParams {
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "This union cannot be open"
  @doc("Input content type.")
  @header
  contentType:
    | "application/octet-stream"
    | "application/pdf"
    | "image/jpeg"
    | "image/png"
    | "image/tiff"
    | "image/bmp"
    | "image/heif"
    | "text/html"
    | "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    | "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    | "application/vnd.openxmlformats-officedocument.presentationml.presentation";

  @doc("Input content.")
  @body
  input: bytes;
}

interface DocumentModels {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Gets the result of document analysis.")
  @route("/documentModels/{modelId}/analyzeResults/{resultId}")
  @get
  getAnalyzeResult is DocumentIntelligenceOperation<
    {
      @doc("Unique document model name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      modelId: string;

      @doc("Analyze operation result ID.")
      @path
      resultId: uuid;
    },
    AnalyzeResultOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" "Support uploading input files"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Analyzes document with document model.")
  @post
  @pollingOperation(DocumentModels.getAnalyzeResult)
  @sharedRoute
  @route("/documentModels/{modelId}:analyze")
  analyzeDocumentFromStream is DocumentIntelligenceLongRunningOperation<
    {
      ...DocumentModelAnalyzeRequestParams;
      ...AnalyzeFromStreamRequestParams;
    },
    AnalyzeResultOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Analyzes document with document model.")
  @post
  @pollingOperation(DocumentModels.getAnalyzeResult)
  @sharedRoute
  @route("/documentModels/{modelId}:analyze")
  analyzeDocument is DocumentIntelligenceLongRunningOperation<
    {
      ...DocumentModelAnalyzeRequestParams;

      @doc("Input content type")
      @header
      contentType: "application/json";

      @doc("Analyze request parameters.")
      @body
      analyzeRequest?: AnalyzeDocumentRequest;
    },
    AnalyzeResultOperation
  >;

  @doc("Gets detailed document model information.")
  getModel is DIResourceOperations.ResourceRead<DocumentModelDetails>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Builds a custom document analysis model.")
  @pollingOperation(MiscellaneousOperations.getDocumentModelBuildOperation)
  @route("/documentModels:build")
  @post
  buildModel is DocumentIntelligenceLongRunningOperation<
    {
      @doc("Build request parameters.")
      @body
      buildRequest: BuildDocumentModelRequest;
    },
    DocumentModelBuildOperationDetails
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Creates a new document model from document types of existing document models.")
  @pollingOperation(MiscellaneousOperations.getDocumentModelComposeOperation)
  @route("/documentModels:compose")
  @post
  composeModel is DocumentIntelligenceLongRunningOperation<
    {
      @doc("Compose request parameters.")
      @body
      composeRequest: ComposeDocumentModelRequest;
    },
    DocumentModelComposeOperationDetails
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
  Generates authorization to copy a document model to this location with
  specified modelId and optional description.
  """)
  @route("/documentModels:authorizeCopy")
  @post
  authorizeModelCopy is DocumentIntelligenceOperation<
    {
      @doc("Authorize copy request parameters.")
      @body
      authorizeCopyRequest: AuthorizeCopyRequest;
    },
    CopyAuthorization
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Copies document model to the target resource, region, and modelId.")
  @pollingOperation(MiscellaneousOperations.getDocumentModelCopyToOperation)
  @route("/documentModels/{modelId}:copyTo")
  @post
  copyModelTo is DocumentIntelligenceLongRunningOperation<
    {
      @doc("Unique document model name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      modelId: string;

      @doc("Copy to request parameters.")
      @body
      copyToRequest: CopyAuthorization;
    },
    DocumentModelCopyToOperationDetails
  >;

  @doc("List all document models")
  listModels is DIResourceOperations.ResourceList<DocumentModelDetails>;

  @doc("Deletes document model.")
  @delete
  deleteModel is DIResourceOperations.ResourceDelete<DocumentModelDetails>;
}

interface MiscellaneousOperations {
  @doc("Lists all operations.")
  listOperations is DIResourceOperations.ResourceList<OperationDetails>;

  @sharedRoute
  @doc("Gets operation info.")
  getDocumentModelBuildOperation is DIResourceOperations.ResourceRead<DocumentModelBuildOperationDetails>;

  @sharedRoute
  @doc("Gets operation info.")
  getDocumentModelComposeOperation is DIResourceOperations.ResourceRead<DocumentModelComposeOperationDetails>;

  @sharedRoute
  @doc("Gets operation info.")
  getDocumentModelCopyToOperation is DIResourceOperations.ResourceRead<DocumentModelCopyToOperationDetails>;

  @sharedRoute
  @doc("Gets operation info.")
  getDocumentClassifierBuildOperation is DIResourceOperations.ResourceRead<DocumentClassifierBuildOperationDetails>;

  @sharedRoute
  @doc("Gets operation info.")
  getOperation is DIResourceOperations.ResourceRead<OperationDetails>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Return information about the current resource.")
  @route("/info")
  @get
  getResourceInfo is DocumentIntelligenceOperation<{}, ResourceDetails>;
}

interface DocumentClassifiers {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Builds a custom document classifier.")
  @pollingOperation(MiscellaneousOperations.getDocumentClassifierBuildOperation)
  @route("/documentClassifiers:build")
  @post
  buildClassifier is DocumentIntelligenceLongRunningOperation<
    {
      @doc("Build request parameters.")
      @body
      buildRequest: BuildDocumentClassifierRequest;
    },
    DocumentClassifierBuildOperationDetails
  >;

  @doc("List all document classifiers.")
  listClassifiers is DIResourceOperations.ResourceList<DocumentClassifierDetails>;

  @doc("Gets detailed document classifier information.")
  getClassifier is DIResourceOperations.ResourceRead<DocumentClassifierDetails>;

  @doc("Deletes document classifier.")
  deleteClassifier is DIResourceOperations.ResourceDelete<DocumentClassifierDetails>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "Support uploading input files"
  @doc("Classifies document with document classifier.")
  @pollingOperation(DocumentClassifiers.getClassifyResult)
  @sharedRoute
  @route("/documentClassifiers/{classifierId}:analyze")
  @post
  classifyDocumentFromStream is DocumentIntelligenceLongRunningOperation<
    {
      ...DocumentClassifierAnalyzeRequestParams;
      ...AnalyzeFromStreamRequestParams;
    },
    AnalyzeResultOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Classifies document with document classifier.")
  @pollingOperation(DocumentClassifiers.getClassifyResult)
  @sharedRoute
  @route("/documentClassifiers/{classifierId}:analyze")
  @post
  classifyDocument is DocumentIntelligenceLongRunningOperation<
    {
      ...DocumentClassifierAnalyzeRequestParams;

      @doc("Input content type")
      @header
      contentType: "application/json";

      @doc("Classify request parameters.")
      @body
      classifyRequest: ClassifyDocumentRequest;
    },
    AnalyzeResultOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Gets the result of document classifier.")
  @route("/documentClassifiers/{classifierId}/analyzeResults/{resultId}")
  @get
  getClassifyResult is DocumentIntelligenceOperation<
    {
      @doc("Unique document classifier name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      classifierId: string;

      @doc("Analyze operation result ID.")
      @path
      resultId: uuid;
    },
    AnalyzeResultOperation
  >;
}
