import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FormRecognizer;

interface DocumentModelsOperations {
  @summary("Analyze document")
  @doc("Analyzes document with document model.")
  @route("/documentModels/{modelId}:analyze")
  @post
  AnalyzeDocument is Azure.Core.Foundations.LongRunningOperation<
    {
      @doc("Unique document model name.")
      @path
      modelId: string;

      @doc("List of 1-based page numbers to analyze.  Ex. \"1-3,5,7-9\"")
      @query
      pages: string;

      @doc("""
Locale hint for text recognition and document analysis.  Value may contain only
the language code (ex. \"en\", \"fr\") or BCP 47 language tag (ex. \"en-US\").
""")
      @query
      locale: string;

      @doc("Method used to compute string offset and length.")
      @query
      stringIndexType: StringIndexType;

      @doc("List of optional analysis features.")
      @query
      features: DocumentAnalysisFeature[];

      @doc("List of additional fields to extract.  Ex. \"NumberOfGuests,StoreNumber\"")
      @query
      queryFields: string[];

      @doc("Analyze request parameters.")
      @body
      analyzeRequest: AnalyzeDocumentRequest;
    },
    AnalyzeResultOperation
  >;

  @summary("Get analyze result")
  @doc("Gets the result of document analysis.")
  @route("/documentModels/{modelId}/analyzeResults/{resultId}")
  @get
  GetAnalyzeResult is Azure.Core.Foundations.Operation<
    {
      @doc("Unique document model name.")
      @path
      modelId: string;

      @doc("Analyze operation result ID.")
      @path
      resultId: string;
    },
    AnalyzeResultOperation
  >;

  @summary("Build document model")
  @doc("Builds a custom document analysis model.")
  @route("/documentModels:build")
  @post
  BuildModel is Azure.Core.Foundations.LongRunningOperation<
    {
      @doc("Building request parameters.")
      @body
      buildRequest: BuildDocumentModelRequest;
    },
    DocumentModelDetails
  >;

  @summary("Compose document model")
  @doc("Creates a new document model from document types of existing document models.")
  @route("/documentModels:compose")
  @post
  ComposeModel is Azure.Core.Foundations.LongRunningOperation<
    {
      @doc("Compose request parameters.")
      @body
      composeRequest: ComposeDocumentModelRequest;
    },
    DocumentModelDetails
  >;

  @summary("Generate copy authorization")
  @doc("""
Generates authorization to copy a document model to this location with
specified modelId and optional description.
""")
  AuthorizeModelCopy is Azure.Core.ResourceCreateWithServiceProvidedName<CopyAuthorization>;

  @summary("Copy document model")
  @doc("Copies document model to the target resource, region, and modelId.")
  @route("/documentModels/{modelId}:copyTo")
  @post
  CopyModelTo is Azure.Core.Foundations.LongRunningOperation<
    {
      @doc("Unique document model name.")
      @path
      modelId: string;

      @doc("Copy to request parameters.")
      @body
      copyToRequest: CopyAuthorization;
    },
    DocumentModelDetails
  >;

  @summary("List document models")
  @doc("List all document models")
  ListModels is Azure.Core.ResourceList<DocumentModelSummary>;

  @summary("Get document model")
  @doc("Gets detailed document model information.")
  GetModel is Azure.Core.ResourceRead<DocumentModelDetails>;

  @summary("Delete document model")
  @doc("Deletes document model.")
  DeleteModel is Azure.Core.ResourceDelete<DocumentModelDetails>;
}

interface MiscellaneousOperations {
  @summary("List operations")
  @doc("Lists all operations.")
  ListOperations is Azure.Core.ResourceList<OperationSummary>;

  @summary("Get operation")
  @doc("Gets operation info.")
  GetOperation is Azure.Core.ResourceRead<OperationDetails>;

  @summary("Get resource info")
  @doc("Return information about the current resource.")
  @route("/info")
  @get
  GetResourceInfo is Azure.Core.Foundations.Operation<{}, ResourceDetails>;
}

interface DocumentClassifiersOperations {
  @summary("Build document classifier")
  @doc("Builds a custom document classifier.")
  @route("/documentClassifiers:build")
  @post
  BuildClassifier is Azure.Core.Foundations.LongRunningOperation<
    {
      @doc("Building request parameters.")
      @body
      buildRequest: BuildDocumentClassifierRequest;
    },
    DocumentClassifierDetails
  >;

  @summary("List document classifiers")
  @doc("List all document classifiers.")
  ListClassifiers is Azure.Core.ResourceList<DocumentClassifierDetails>;

  @summary("Get document classifier")
  @doc("Gets detailed document classifier information.")
  GetClassifier is Azure.Core.ResourceRead<DocumentClassifierDetails>;

  @summary("Delete document classifier")
  @doc("Deletes document classifier.")
  DeleteClassifier is Azure.Core.ResourceDelete<DocumentClassifierDetails>;

  @summary("Classify document")
  @doc("Classifies document with document classifier.")
  @route("/documentClassifiers/{classifierId}:analyze")
  @post
  ClassifyDocument is Azure.Core.Foundations.Operation<
    {
      @doc("Unique document classifier name.")
      @path
      classifierId: string;

      @doc("Method used to compute string offset and length.")
      @query
      stringIndexType: StringIndexType;

      @doc("Classify request parameters.")
      @body
      classifyRequest: ClassifyDocumentRequest;
    },
    AnalyzeResultOperation
  >;

  @summary("Get document classifier result")
  @doc("Gets the result of document classifier.")
  @route("/documentClassifiers/{classifierId}/analyzeResults/{resultId}")
  @get
  GetClassifyResult is Azure.Core.Foundations.Operation<
    {
      @doc("Unique document classifier name.")
      @path
      classifierId: string;

      @doc("Analyze operation result ID.")
      @path
      resultId: string;
    },
    AnalyzeResultOperation
  >;
}
