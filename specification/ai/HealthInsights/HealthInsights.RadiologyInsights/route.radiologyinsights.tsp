import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./model.radiologyinsights.tsp";
import "./model.radiologyinsights.valuesets.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

interface RadiologyInsights {
  @summary("Get Radiology Insights job details")
  @tag("RadiologyInsights")
  @doc("Gets the status and details of the Radiology Insights job.")
  @get
  getJob is HealthInsightsOperations.ResourceRead<RadiologyInsightsJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
  @summary("Create Radiology Insights job")
  @tag("RadiologyInsights")
  @doc("Creates a Radiology Insights job with the given request body.")
  @pollingOperation(RadiologyInsights.getJob)
  createJob is HealthInsightsOperations.LongRunningResourceCreateOrReplace<RadiologyInsightsJob>;
}
