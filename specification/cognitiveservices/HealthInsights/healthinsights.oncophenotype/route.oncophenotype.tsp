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
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Service uses a jobId in the path"
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

  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no long-running RPC template in Azure.Core"
  @summary("Create Onco Phenotype job")
  @tag("OncoPhenotype")
  @doc("Creates an Onco Phenotype job with the given request body.")
  @route("/oncophenotype/jobs")
  @example(
    "./examples/SuccessfulOncoPhenotypeRequest.json",
    "SuccessfulOncoPhenotypeAnalyzeRequest"
  )
  createJob is TLongRunningRpcOperation<OncoPhenotypeData, OncoPhenotypeResult>;
}
