import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@typespec/rest";
import "@typespec/http";

import "./model.oncophenotype.tsp";
import "../healthinsights.common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using Autorest;

namespace AzureHealthInsights;

interface OncoPhenotype {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing spec should not be updated"
  @summary("Get Onco Phenotype job details")
  @tag("OncoPhenotype")
  @doc("Gets the status and details of the Onco Phenotype job.")
  @example(
    "./examples/SuccessfulOncoPhenotypeResponse.json",
    "SuccessfulOncoPhenotypeGetAnalyzeStatus"
  )
  GetJob is Azure.Core.ResourceRead<OncoPhenotypeResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No LRO RPC Operation"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing spec should not be updated"
  @summary("Create Onco Phenotype job")
  @tag("OncoPhenotype")
  @doc("Creates an Onco Phenotype job with the given request body.")
  @pollingOperation(OncoPhenotype.GetJob)
  @route("/oncophenotype/jobs")
  @example(
    "./examples/SuccessfulOncoPhenotypeRequest.json",
    "SuccessfulOncoPhenotypeAnalyzeRequest"
  )
  CreateJob is LongRunningRpcOperation<
    OncoPhenotypeData,
    OncoPhenotypeResult,
    Azure.Core.Traits.SupportsRepeatableRequests
  >;
}
