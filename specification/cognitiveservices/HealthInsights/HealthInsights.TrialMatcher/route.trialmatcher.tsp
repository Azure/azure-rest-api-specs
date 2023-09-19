import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

import "./model.trialmatcher.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

interface TrialMatcher {
  @summary("Get Trial Matcher job details")
  @tag("TrialMatcher")
  @doc("Gets the status and details of the Trial Matcher job.")
  getJob is Azure.Core.ResourceRead<TrialMatcherResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Trial Matcher job")
  @tag("TrialMatcher")
  @doc("Creates a Trial Matcher job with the given request body.")
  @pollingOperation(TrialMatcher.getJob)
  @route("/trialmatcher/jobs")
  createJob is LongRunningRpcOperation<TrialMatcherData, TrialMatcherResult>;
}
