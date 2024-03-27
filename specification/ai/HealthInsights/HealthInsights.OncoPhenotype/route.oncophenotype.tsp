import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

import "./model.oncophenotype.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

@TypeSpec.Versioning.removed(AzureHealthInsights.ApiVersion.v2024_04_01)
interface OncoPhenotype {
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Service uses a jobId in the path"
  @summary("Get Onco Phenotype job details")
  @tag("OncoPhenotype")
  @doc("Gets the status and details of the Onco Phenotype job.")
  @get
  @route("/onco-phenotype/jobs/{id}")
  getJob is HealthInsightsLongRunningPollOperation<OncoPhenotypeResult>;

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Onco Phenotype job")
  @tag("OncoPhenotype")
  @doc("Creates an Onco Phenotype job with the given request body.")
  @pollingOperation(OncoPhenotype.getJob)
  @route("/onco-phenotype/jobs")
  createJob is HealthInsightsLongRunningRpcOperation<
    OncoPhenotypeData,
    OncoPhenotypeResult,
    OncoPhenotypeInferenceResult
  >;
}
