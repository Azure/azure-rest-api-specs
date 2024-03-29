import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

import "./model.oncophenotype.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

interface OncoPhenotype {
  @summary("Get Onco Phenotype job details")
  @tag("OncoPhenotype")
  @doc("Gets the status and details of the Onco Phenotype job.")
  getJob is Azure.Core.ResourceRead<OncoPhenotypeResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Onco Phenotype job")
  @tag("OncoPhenotype")
  @doc("Creates an Onco Phenotype job with the given request body.")
  @pollingOperation(OncoPhenotype.getJob)
  @route("/oncophenotype/jobs")
  createJob is LongRunningRpcOperation<OncoPhenotypeData, OncoPhenotypeResult>;
}
