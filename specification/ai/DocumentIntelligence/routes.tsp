import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace DocumentIntelligence;

alias ServiceTraits = NoConditionalRequests &
  NoRepeatableRequests &
  SupportsClientRequestId;

op DocumentIntelligenceOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model & Foundations.RetryAfterHeader
> is Foundations.Operation<
  TParams,
  TResponse,
  ServiceTraits,
  DocumentIntelligenceErrorResponse
>;

alias DIResourceOperations = ResourceOperations<
  ServiceTraits,
  DocumentIntelligenceErrorResponse
>;

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
  DocumentIntelligenceErrorResponse
>;

@doc("Document model analyze request parameters.")
model DocumentModelAnalyzeRequestParams {
  @doc("Unique document model name.")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  @maxLength(64)
  modelId: string;

  @doc("1-based page numbers to analyze.  Ex. \"1-3,5,7-9\"")
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
  @query
  features?: DocumentAnalysisFeature[];

  @doc("List of additional fields to extract.  Ex. \"NumberOfGuests,StoreNumber\"")
  @query
  queryFields?: string[];

  @doc("Format of the analyze result top-level content.")
  @query
  outputContentFormat?: DocumentContentFormat = DocumentContentFormat.text;

  @doc("Additional outputs to generate during analysis.")
  @query
  output?: AnalyzeOutputOption[];
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

  @doc("1-based page numbers to analyze.  Ex. \"1-3,5,7-9\"")
  @query
  @pattern("^(\\d+(-\\d+)?)(,\\s*(\\d+(-\\d+)?))*$")
  pages?: string;
}

@doc("Analyze from stream request parameters.")
model AnalyzeFromStreamRequestParams {
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "This union cannot be open"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with existing clients"
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
  @bodyRoot
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
    AnalyzeOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Gets the generated searchable PDF output from document analysis.")
  @route("/documentModels/{modelId}/analyzeResults/{resultId}/pdf")
  @get
  getAnalyzeResultPdf is DocumentIntelligenceOperation<
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
    {
      @doc("Response content type.")
      @header
      contentType: "application/pdf";

      @doc("Response PDF.")
      @body
      pdf: bytes;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Gets the generated cropped image of specified figure from document analysis.")
  @route("/documentModels/{modelId}/analyzeResults/{resultId}/figures/{figureId}")
  @get
  getAnalyzeResultFigure is DocumentIntelligenceOperation<
    {
      @doc("Unique document model name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      modelId: string;

      @doc("Analyze operation result ID.")
      @path
      resultId: uuid;

      @doc("Figure ID.")
      @path
      figureId: string;
    },
    {
      @doc("Response content type.")
      @header
      contentType: "image/png";

      @doc("Response image.")
      @body
      image: bytes;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Mark the result of document analysis for deletion.")
  @route("/documentModels/{modelId}/analyzeResults/{resultId}")
  @delete
  deleteAnalyzeResult is DocumentIntelligenceOperation<
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
    TypeSpec.Http.NoContentResponse
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
    AnalyzeOperation
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

      @doc("Input content type.")
      @header
      contentType: "application/json";

      @doc("Analyze request parameters.")
      @bodyRoot
      @clientName("body", "python")
      analyzeRequest: AnalyzeDocumentRequest;
    },
    AnalyzeOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Gets the result of batch document analysis.")
  @route("/documentModels/{modelId}/analyzeBatchResults/{resultId}")
  @get
  getAnalyzeBatchResult is DocumentIntelligenceOperation<
    {
      @doc("Unique document model name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      modelId: string;

      @doc("Analyze batch operation result ID.")
      @path
      resultId: uuid;
    },
    AnalyzeBatchOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Analyzes batch documents with document model.")
  @post
  @pollingOperation(DocumentModels.getAnalyzeBatchResult)
  @route("/documentModels/{modelId}:analyzeBatch")
  analyzeBatchDocuments is DocumentIntelligenceLongRunningOperation<
    {
      ...DocumentModelAnalyzeRequestParams;

      @doc("Input content type")
      @header
      contentType: "application/json";

      @doc("Analyze batch request parameters.")
      @body
      @clientName("body", "python")
      analyzeBatchRequest: AnalyzeBatchDocumentsRequest;
    },
    AnalyzeBatchOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("List batch document analysis results.")
  @route("/documentModels/{modelId}/analyzeBatchResults")
  @get
  listAnalyzeBatchResults is DocumentIntelligenceOperation<
    {
      @doc("Unique document model name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      modelId: string;
    },
    Foundations.CustomPage<AnalyzeBatchOperation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Mark the batch document analysis result for deletion.")
  @route("/documentModels/{modelId}/analyzeBatchResults/{resultId}")
  @delete
  deleteAnalyzeBatchResult is DocumentIntelligenceOperation<
    {
      @doc("Unique document model name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      modelId: string;

      @doc("Analyze batch operation result ID.")
      @path
      resultId: uuid;
    },
    NoContentResponse
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
      @bodyRoot
      @clientName("body", "python")
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
      @bodyRoot
      @clientName("body", "python")
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
      @bodyRoot
      @clientName("body", "python")
      authorizeCopyRequest: AuthorizeCopyRequest;
    },
    ModelCopyAuthorization
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
      @bodyRoot
      @clientName("body", "python")
      copyToRequest: ModelCopyAuthorization;
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
  listOperations is DIResourceOperations.ResourceList<DocumentIntelligenceOperationDetails>;

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
  getDocumentClassifierCopyToOperation is DIResourceOperations.ResourceRead<DocumentClassifierCopyToOperationDetails>;

  @sharedRoute
  @doc("Gets operation info.")
  getDocumentClassifierBuildOperation is DIResourceOperations.ResourceRead<DocumentClassifierBuildOperationDetails>;

  @sharedRoute
  @doc("Gets operation info.")
  getOperation is DIResourceOperations.ResourceRead<DocumentIntelligenceOperationDetails>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Return information about the current resource.")
  @route("/info")
  @get
  getResourceDetails is DocumentIntelligenceOperation<
    {},
    DocumentIntelligenceResourceDetails
  >;
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
      @bodyRoot
      @clientName("body", "python")
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
    AnalyzeOperation
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
      @bodyRoot
      @clientName("body", "python")
      classifyRequest: ClassifyDocumentRequest;
    },
    AnalyzeOperation
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
    AnalyzeOperation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("""
    Generates authorization to copy a document classifier to this location with
    specified classifierId and optional description.
    """)
  @route("/documentClassifiers:authorizeCopy")
  @post
  authorizeClassifierCopy is DocumentIntelligenceOperation<
    {
      @doc("Authorize copy request parameters.")
      @body
      @clientName("body", "python")
      authorizeCopyRequest: AuthorizeClassifierCopyRequest;
    },
    ClassifierCopyAuthorization
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Copies document classifier to the target resource, region, and classifierId.")
  @pollingOperation(
    MiscellaneousOperations.getDocumentClassifierCopyToOperation
  )
  @route("/documentClassifiers/{classifierId}:copyTo")
  @post
  copyClassifierTo is DocumentIntelligenceLongRunningOperation<
    {
      @doc("Unique document classifier name.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
      @maxLength(64)
      classifierId: string;

      @doc("Copy to request parameters.")
      @body
      @clientName("body", "python")
      copyToRequest: ClassifierCopyAuthorization;
    },
    DocumentClassifierCopyToOperationDetails
  >;
}
