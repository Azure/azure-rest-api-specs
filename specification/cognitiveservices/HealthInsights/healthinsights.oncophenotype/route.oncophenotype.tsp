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
  @summary("Get Onco Phenotype job details")
  @tag("OncoPhenotype")
  @doc("Gets the status and details of the Onco Phenotype job.")
  @example(
    "./examples/SuccessfulOncoPhenotypeResponse.json",
    "SuccessfulOncoPhenotypeGetAnalyzeStatus"
  )
  @get
  @route("/oncophenotype/jobs/{jobId}")
  getJob is Azure.Core.RpcOperation<
    {
      @doc("A processing job identifier.")
      @format("uuid")
      @path("jobId")
      jobId: string;
    }, OncoPhenotypeResult
  >;

  @summary("Create Onco Phenotype job")
  @tag("OncoPhenotype")
  @doc("Creates an Onco Phenotype job with the given request body.")
  @route("/oncophenotype/jobs")
  @example(
    "./examples/SuccessfulOncoPhenotypeRequest.json",
    "SuccessfulOncoPhenotypeAnalyzeRequest"
  )
  @pollingOperation(
    OncoPhenotype.getJob,
    {@doc("job id") jobId: ResponseProperty<"operationLocation">}
  )
  createJob is TLongRunningRpcOperation<OncoPhenotypeData, OncoPhenotypeResult>;
}
