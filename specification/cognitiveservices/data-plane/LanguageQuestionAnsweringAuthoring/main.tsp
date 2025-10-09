import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * The language service API is a suite of natural language processing (NLP) skills
 * built with best-in-class Microsoft machine learning algorithms.  The API can be
 * used to analyze unstructured text for tasks such as sentiment analysis, key
 * phrase extraction, language detection and question answering.
 */
@useAuth(AzureKey | AADToken)
@service(#{
  title: "Microsoft Cognitive Language Service - Question Answering Authoring",
})
@versioned(Versions)
@server(
  "{Endpoint}/language",
  "The language service API is a suite of natural language processing (NLP) skills built with best-in-class Microsoft machine learning algorithms.  The API can be used to analyze unstructured text for tasks such as sentiment analysis, key phrase extraction, language detection and question answering. Further documentation can be found in <a href=\"https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/overview\">https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/overview</a>.",
  {
    /** Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com). */
    Endpoint: url,
  }
)
namespace Language.QuestionAnswering.Authoring;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-04-01 API version.
   */
  v2023_04_01: "2023-04-01",

  /** Version 2025-05-15-preview */
  v2025_05_15_preview: "2025-05-15-preview",
}
