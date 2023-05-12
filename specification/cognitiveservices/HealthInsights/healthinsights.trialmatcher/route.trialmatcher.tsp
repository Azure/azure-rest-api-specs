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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing spec should not be changed"
  @summary("Get Trial Matcher job details")
  @tag("TrialMatcher")
  @doc("Gets the status and details of the Trial Matcher job.")
  @example(
    "./examples/SuccessfulTrialMatcherResponse.json",
    "SuccessfulTrialMatcherGetAnalyzeStatus"
  )
  GetJob is Azure.Core.ResourceRead<TrialMatcherResult>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing spec should not be updated"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No LRO RPC Operation"
  @summary("Create Trial Matcher job")
  @tag("TrialMatcher")
  @doc("Creates a Trial Matcher job with the given request body.")
  @pollingOperation(TrialMatcher.GetJob)
  @route("/trialmatcher/jobs")
  @example(
    "./examples/SuccessfulTrialMatcherRequest.json",
    "SuccessfulTrialMatcherAnalyzeRequest"
  )
  CreateJob is LongRunningRpcOperation<
    TrialMatcherData,
    TrialMatcherResult,
    Azure.Core.Traits.SupportsRepeatableRequests
  >;
}
