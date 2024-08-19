import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;


/** The language service API is a suite of natural language processing (NLP) skills built with best-in-class Microsoft machine learning algorithms.  The API can be used to analyze unstructured text for tasks such as sentiment analysis, key phrase extraction, language detection and question answering. Further documentation can be found in <a href=\"https://docs.microsoft.com/azure/cognitive-services/language-service/overview\">https://docs.microsoft.com/azure/cognitive-services/language-service/overview</a>.0 */
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Microsoft Cognitive Language Service - API Language Authoring",
})
@server(
  "{Endpoint}/language",
  "Single server endpoint",
  {
    /** Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com). */
    Endpoint: string,
  }
)
@versioned(Versions)
namespace Language.Authoring;

/** Analyze Conversations Service Versions */
enum Versions {
  /** Version 2022-05-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_05_01: "2022-05-01",

  /** Version 2023-04-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01",

  /** Version 2023-11-15-preview */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_11_15_preview: "2023-11-15-preview",
}

/** The object containing the list of deployments for a project */
@resource("language/authoring/analyze-text/projects/{projectName}/deployments")
model ProjectDeployments {
  @key projectName: string;
  deployments: DeploymentObject[];
  nextPageLink?: string;
}

/** Deployment object model */
model DeploymentObject {
  trainedModelId: string;
  // Add other relevant fields here...
}

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias languageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

/** Query parameters for the ListDeployments operation */
alias ListDeploymentsQueryParameters = QueryParametersTrait<{
  /** The number of deployments to be returned. */
  @query
  top?: int32;

  /** The offset in the response. */
  @query
  skip?: int32;

  /** The maximum number of deployments per page. */
  @query
  maxpagesize?: int32;
}>;

/** List deployments belonging to a project */
@summary("Lists the deployments belonging to a project.")
op ListDeployments is languageOperations.ResourceRead<
  ProjectDeployments,
  ListDeploymentsQueryParameters
>;