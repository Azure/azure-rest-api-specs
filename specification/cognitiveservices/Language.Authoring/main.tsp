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
// Todo how to use the projectName as searching parameter
@resource("authoring/analyze-text/projects/{projectName}/deployments")
model ProjectDeployments {
  @key projectName: string;
  deployments: DeploymentObject[];
  nextPageLink?: string;
}

/** Deployment object model */
@resource("authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
model DeploymentObject {
  @key projectName: string;
  @key deploymentName: string;
  
  /** The ID of the trained model associated with this deployment */
  trainedModelId: string;

  /** The date and time when the deployment was last deployed */
  lastDeployedDateTime: utcDateTime;

  /** The date and time when the model was last trained */
  lastTrainedDateTime: utcDateTime;

  /** The expiration date of the deployment */
  deploymentExpirationDate?: utcDateTime;

  /** The version of the model training configuration */
  modelTrainingConfigVersion: string;
}


/** Represents the state of a deployment job */
model DeploymentJobState {
  /** The current status of the job */
  status: State;

  /** The date and time when the job was created */
  createdDateTime: utcDateTime;

  /** The date and time when the job was last updated */
  lastUpdatedDateTime: utcDateTime;

  /** Any errors encountered during the job execution */
  errors?: Array<Error>;

  /** The unique identifier for the job */
  @key
  @visibility("read")
  jobId: uuid;
}

// Define the relevant models
model CreateDeploymentOptions {
  trainedModelLabel: string;
  // Todo add other fields as needed
}

/** Input model for swapping deployments */
model SwapDeploymentsOptions {
  firstDeploymentName: string;
  secondDeploymentName: string;
  // Todo Add other fields as necessary
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

alias GetDeploymentStatusPathParameters = {
  /** The project name */
  @path
  projectName: string;

  /** The deployment name */
  @path
  deploymentName: string;

  /** The job ID */
  @path
  jobId: string;
};

/** List deployments belonging to a project */
@summary("Lists the deployments belonging to a project.")
op ListDeployments is languageOperations.ResourceRead<
  ProjectDeployments,
  ListDeploymentsQueryParameters
>;


/** Get deployment details */
@summary("Gets the details of a deployment.")
op GetDeployment is languageOperations.ResourceRead<
  DeploymentObject,
  {
    @path projectName: string;
    @path deploymentName: string;
  }
>;

/** Get deployment status */
@summary("Gets the status of an existing deployment job.")
@route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/jobs/{jobId}")
@get
op GetDeploymentStatus is languageOperations.ResourceRead<
  DeploymentJobState,
  GetDeploymentStatusPathParameters
>;

/** Update deployment */
@summary("Creates a new deployment or replaces an existing one.")
@pollingOperation(GetDeploymentStatus)
@route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
@put
op DeployProject is Foundations.LongRunningOperation<
  {
    @path projectName: string;
    @path deploymentName: string;
    @body createDeploymentOptions: CreateDeploymentOptions;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;


/** Delete deployment */
@summary("Deletes a project deployment.")
@pollingOperation(GetDeploymentStatus)  // Link to the status-checking operation
@route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
@delete
op DeleteDeployment is Foundations.LongRunningOperation<
  {
    @path projectName: string;
    @path deploymentName: string;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;

/** Swap deployments */
@summary("Swaps two existing deployments with each other.")
@pollingOperation(GetSwapDeploymentsStatus)  // Link to the status-checking operation
@route("/authoring/analyze-text/projects/{projectName}/deployments/swap")
@post
op SwapDeployments is Foundations.LongRunningOperation<
  {
    @path projectName: string;
    @body swapDeploymentJobObject: SwapDeploymentsOptions;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;

/** Get swap deployment status */
@summary("Gets the status of an existing swap deployment job.")
@route("/authoring/analyze-text/projects/{projectName}/deployments/swap/jobs/{jobId}")
@get
op GetSwapDeploymentsStatus is languageOperations.ResourceRead<
  DeploymentJobState,
  {
    @path projectName: string;
    @path jobId: string;
  }
>;