import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./model.trialmatcher.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace AzureHealthInsights;

@TypeSpec.Versioning.added(AzureHealthInsights.ApiVersion.v2024_08_01_preview)
interface TrialMatcher {
  @summary("Get Trial Matcher job details")
  @tag("TrialMatcher")
  @doc("Gets the status and details of the Trial Matcher job.")
  @get
  getJob is HealthInsightsOperations.ResourceRead<TrialMatcherJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
  @summary("Create Trial Matcher job")
  @tag("TrialMatcher")
  @doc("Creates a Trial Matcher job with the given request body.")
  @pollingOperation(TrialMatcher.getJob)
  createJob is HealthInsightsOperations.LongRunningResourceCreateOrReplace<TrialMatcherJob>;
}
