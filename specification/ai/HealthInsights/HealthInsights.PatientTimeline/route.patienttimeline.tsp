import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

import "./model.patienttimeline.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

@TypeSpec.Versioning.removed(AzureHealthInsights.ApiVersion.v2024_04_01)
interface PatientTimeline {
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Service uses a jobId in the path"
  @summary("Get Patient Timeline job details")
  @tag("PatientTimeline")
  @doc("Gets the status and details of the Patient Timeline job.")
  @get
  @route("/patient-timeline/jobs/{id}")
  getJob is HealthInsightsLongRunningPollOperation<BodyParameter<PatientTimelineResult>>;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Patient Timeline job")
  @tag("PatientTimeline")
  @doc("Creates a Patient Timeline job with the given request body.")
  @pollingOperation(PatientTimeline.getJob)
  @route("/patient-timeline/jobs")
  createJob is HealthInsightsLongRunningRpcOperation<
    PatientTimelineData,
    PatientTimelineResult,
    PatientTimelineInferenceResult
  >;
}
