import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@typespec/rest";
import "@typespec/http";

import "./model.trialmatcher.tsp";
import "../healthinsights.common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using Autorest;

namespace AzureHealthInsights;

interface TrialMatcher {
  @summary("Get Trial Matcher job details")
  @tag("TrialMatcher")
  @doc("Gets the status and details of the Trial Matcher job.")
  @example(
    "./examples/SuccessfulTrialMatcherResponse.json",
    "SuccessfulTrialMatcherGetAnalyzeStatus"
  )
  getJob is Azure.Core.ResourceRead<TrialMatcherResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Trial Matcher job")
  @tag("TrialMatcher")
  @doc("Creates a Trial Matcher job with the given request body.")
  @pollingOperation(TrialMatcher.getJob)
  @route("/trialmatcher/jobs")
  @example(
    "./examples/SuccessfulTrialMatcherRequest.json",
    "SuccessfulTrialMatcherAnalyzeRequest"
  )
  createJob is TLongRunningRpcOperation<TrialMatcherData, TrialMatcherResult>;
}
