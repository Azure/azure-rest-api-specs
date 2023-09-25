import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
// import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
// import "@azure-tools/typespec-autorest";
import "../Language/common.tsp";
import "./language.detection.tsp";
import "./entity.linking.tsp";
import "./entity.recognition.tsp";
import "./sentiment.analysis.tsp";
import "./key.phrase.extraction.tsp";
import "./custom.text.tsp";


using TypeSpec.Http;
using TypeSpec.Rest;
// using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@useAuth(
  TypeSpec.Http.ApiKeyAuth<
    TypeSpec.Http.ApiKeyLocation.header,
    "Ocp-Apim-Subscription-Key"
  >
)
@doc("The language service API is a suite of natural language processing (NLP) skills built with best-in-class Microsoft machine learning algorithms.  The API can be used to analyze unstructured text for tasks such as sentiment analysis, key phrase extraction, language detection and question answering. Further documentation can be found in <a href=\"https://docs.microsoft.com/azure/cognitive-services/language-service/overview\">https://docs.microsoft.com/azure/cognitive-services/language-service/overview</a>.0")
@service({
  title: "Microsoft Cognitive Language Service - Text Analysis",
})
@server(
  "{Endpoint}",
  "Single server endpoint",
  {
    @doc("Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com).")
    Endpoint: string,
  }
)
@versioned(Versions)
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

enum AnalyzeTextTaskKind {
  SentimentAnalysis,
  EntityRecognition,
  PiiEntityRecognition,
  KeyPhraseExtraction,
  LanguageDetection,
  EntityLinking,
}

enum AnalyzeTextLROTaskKind {
  SentimentAnalysis,
  EntityRecognition,
  PiiEntityRecognition,
  KeyPhraseExtraction,
  EntityLinking,
  Healthcare,
  CustomEntityRecognition,
  CustomSingleLabelClassification,
  CustomMultiLabelClassification,
}

enum AnalyzeTextTaskResultsKind {
  SentimentAnalysisResults,
  EntityRecognitionResults,
  PiiEntityRecognitionResults,
  KeyPhraseExtractionResults,
  LanguageDetectionResults,
  EntityLinkingResults
}

enum AnalyzeTextLROResultsKind {
  SentimentAnalysisLROResults,
  EntityRecognitionLROResults,
  PiiEntityRecognitionLROResults,
  KeyPhraseExtractionLROResults,
  EntityLinkingLROResults,
  HealthcareLROResults,
  CustomEntityRecognitionLROResults,
  CustomSingleLabelClassificationLROResults,
  CustomMultiLabelClassificationLROResults
}

model MultiLanguageAnalysisInput {
  @doc("The input documents to be analyzed.")
  documents?: Array<MultiLanguageInput>;
}

@discriminator("kind")
model AnalyzeTextTask {
  @doc("The kind of task to perform.")
  kind: AnalyzeTextTaskKind;
}

@discriminator("kind")
model AnalyzeTextLROTask extends TaskIdentifier{
  @doc("The kind of task to perform.")
  kind: AnalyzeTextLROTaskKind;
}

@discriminator("kind")
model AnalyzeTextTaskResult {
  @doc("The kind of task result.")
  kind: AnalyzeTextTaskResultsKind;
}

model AnalyzeTextJobsInput {
  displayName?: string;

  analysisInput: MultiLanguageAnalysisInput;

  tasks: Array<AnalyzeTextLROTask>;
}

model TaskIdentifier {
  @doc("The task name.")
  taskName?: string;
}

@doc("Base parameters object for a text analysis task.")
model TaskParameters {
  @doc("The task parameters.")
  loggingOptOut?: boolean = false;
}

@doc("Parameters object for a text analysis task using pre-built models.")
model PreBuiltTaskParameters extends TaskParameters {
  @doc("The task parameters.")
  modelVersion?: string = "latest";
}

model PreBuiltResult {
  @doc("Errors by document id.")
  errors: Array<DocumentError>;
  
  statistics?: RequestStatistics;

  @doc("This field indicates which model is used for scoring.")
  modelVersion: string;
}