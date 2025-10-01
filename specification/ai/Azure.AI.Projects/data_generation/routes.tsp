import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

@route("data_generation/jobs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface DataGenerationJobs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get info about a data generation job.")
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the data generation job.")
      @path
      @maxLength(1024)
      data_generation_job_id: string;
    },
    DataGenerationJob
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Returns a list of data generation jobs")
  @get
  @list
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier for the last job from the previous pagination request.")
      @query
      after?: string;

      @doc("Number of data generation jobs to retrieve.")
      @query
      limit?: int32 = 20;
    },
    Array<DataGenerationJob>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a data generation job.")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Data generation job create request body")
      @body
      dataGenerationJob: DataGenerationJobCreateParams;
    },
    DataGenerationJob
  >;
}
