import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./model.trialmatcher.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

@TypeSpec.Versioning.removed(AzureHealthInsights.ApiVersion.v2024_04_01)
interface TrialMatcher {
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Service uses a jobId in the path"
  @summary("Get Trial Matcher job details")
  @tag("TrialMatcher")
  @doc("Gets the status and details of the Trial Matcher job.")
  @get
  @route("/trial-matcher/jobs/{id}")
  getJob is HealthInsightsLongRunningPollOperation<BodyParameter<TrialMatcherResult>>;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Trial Matcher job")
  @tag("TrialMatcher")
  @doc("Creates a Trial Matcher job with the given request body.")
  @pollingOperation(TrialMatcher.getJob)
  @route("/trial-matcher/jobs")
  createJob is HealthInsightsLongRunningRpcOperation<
    TrialMatcherData,
    TrialMatcherResult,
    TrialMatcherInferenceResult
  >;
}
