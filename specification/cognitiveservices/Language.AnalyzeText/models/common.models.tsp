import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("These are the [Azure Active Directory OAuth2](https://docs.microsoft.com/azure/active-directory/develop/v1-overview) Flows. When paired with [Azure role-based access](https://docs.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs. Azure role-based access controls are used to designate access to one or more Azure Maps resource account or sub-resources. Any user, group, or service principal can be granted access via a  built-in role or a custom role composed of one or more permissions to Azure Maps REST APIs.\n\nTo implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth). In summary, this security definition provides a solution for modeling application(s) via objects capable of access control on specific APIs and scopes.\n\n#### Notes\n* This security definition **requires** the use of the `x-ms-client-id` header to indicate which Azure Maps resource the application is requesting access to. This can be acquired from the [Maps management API](https://aka.ms/amauthdetails).\n* \nThe `Authorization URL` is specific to the Azure public cloud instance. Sovereign clouds have unique Authorization URLs and Azure Active directory configurations. \n* \nThe Azure role-based access control is configured from the [Azure management plane](https://aka.ms/amrbac) via Azure portal, PowerShell, CLI, Azure SDKs, or REST APIs.\n* \nUsage of the [Azure Maps Web SDK](https://aka.ms/amaadmc) allows for configuration based setup of an application for multiple use cases.\n* Currently, Azure Active Directory [v1.0 or v2.0](https://docs.microsoft.com/azure/active-directory/develop/azure-ad-endpoint-comparison) supports Work, School, and Guests but does not support Personal accounts.")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextTaskKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysis,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtraction,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LanguageDetection,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinking,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextLroTaskKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysis,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtraction,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinking,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Healthcare,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomEntityRecognition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomSingleLabelClassification,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomMultiLabelClassification,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExtractiveSummarization,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  AbstractiveSummarization
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextTaskResultsKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysisResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognitionResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognitionResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtractionResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LanguageDetectionResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinkingResults
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextLroResultsKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysisLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognitionLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognitionLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtractionLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinkingLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HealthcareLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomEntityRecognitionLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomSingleLabelClassificationLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomMultiLabelClassificationLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExtractiveSummarizationLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  AbstractiveSummarizationLROResults
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model MultiLanguageAnalysisInput {
  @doc("The input documents to be analyzed.")
  documents?: Array<MultiLanguageInput>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@resource("language")
@discriminator("kind")
model AnalyzeTextTask {
  @key
  @visibility("read", "create", "query" )
  @doc("The kind of task to perform.")
  kind: AnalyzeTextTaskKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@discriminator("kind")
model AnalyzeTextLroTask extends TaskIdentifier{
  @doc("The kind of task to perform.")
  kind: AnalyzeTextLroTaskKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@discriminator("kind")
model AnalyzeTextTaskResult {
  @doc("The kind of task result.")
  kind: AnalyzeTextTaskResultsKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextJobsInput {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  displayName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput: MultiLanguageAnalysisInput;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  tasks: Array<AnalyzeTextLroTask>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextPreBuiltResult {
  @doc("Errors by document id.")
  errors: Array<AnalyzeTextDocumentError>;
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  statistics?: RequestStatistics;

  @doc("This field indicates which model is used for scoring.")
  modelVersion: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@resource("language/analyze-text/jobs")
model AnalyzeTextJobState {
  ...JobState;
  ...TasksState;
  ...AnalyzeTextJobStatistics;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model Pagination {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  nextLink: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextJobErrors {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  errors: Array<Error>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextJobStatistics {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  statistics: RequestStatistics;
}
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model TasksState {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  completed: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  failed: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  inProgress: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  total: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  items?: Array<AnalyzeTextLroResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum Status {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  notStarted,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  running,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  succeeded,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  failed,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  cancelled,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  cancelling
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@discriminator("kind")
model AnalyzeTextLroResult extends TaskState {
  ...TaskIdentifier;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DocumentResponse {}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DocumentResult {
  @doc("Unique, non-empty document identifier.")
  id: string;

  @doc("Warnings encountered while processing document.")
  warnings: Array<DocumentWarning>;

  @doc("if showStats=true was specified in the request this field will contain information about the document payload.")
  statistics?: DocumentStatistics
}



#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextDocumentError {
  @doc("Document Id.")
  id: string;

  @doc("Document Error.")
  error: Error;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DocumentWarning {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  code: Code;

  @doc("Warning message.")
  message: string;

  @doc("A JSON pointer reference indicating the target object.")
  targetRef?: string
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum Code {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LongWordsInDocument,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DocumentTruncated
}

@doc("if showStats=true was specified in the request this field will contain information about the document payload.")
model DocumentStatistics {

  @doc("Number of text elements recognized in the document.")
  charactersCount: int32;

  @doc("Number of transactions for the document.")
  transactionsCount: int32;
}


@doc("Contains an input document to be analyzed by the service.")
model MultiLanguageInput {
  @doc("A unique, non-empty document identifier.")
  id: string;

  @doc("The input text to process.")
  text: string;

  @doc("(Optional) This is the 2 letter ISO 639-1 representation of a language. For example, use \"en\" for English; \"es\" for Spanish etc. If not set, use \"en\" for English as default.")
  language?: string;
}