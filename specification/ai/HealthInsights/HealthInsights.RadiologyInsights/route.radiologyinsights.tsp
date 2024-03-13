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
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Service uses a jobId in the path"
  @summary("Get Radiology Insights job details")
  @tag("RadiologyInsights")
  @doc("Gets the status and details of the Radiology Insights job.")
  @get
  @route("/radiology-insights/jobs/{id}")
  getJob is HealthInsightsLongRunningPollOperation<RadiologyInsightsResult>;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Radiology Insights job")
  @tag("RadiologyInsights")
  @doc("Creates a Radiology Insights job with the given request body.")
  @pollingOperation(RadiologyInsights.getJob)
  @route("/radiology-insights/jobs")
  createJob is HealthInsightsLongRunningRpcOperation<
    RadiologyInsightsData,
    RadiologyInsightsResult,
    RadiologyInsightsInferenceResult
  >;
}
