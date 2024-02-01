import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace HealthDataAIServices.Deidentification;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias DeidOperations = ResourceOperations<
  ServiceTraits,
  Azure.Core.Foundations.ErrorResponse
>;

interface Jobs {
  @summary("Create a DeID Job")
  @pollingOperation(Jobs.get)
  create is DeidOperations.LongRunningResourceCreateOrReplace<Job>;

  @summary("Get a DeID Job")
  get is DeidOperations.ResourceRead<Job>;

  @summary("List DeID Jobs")
  list is DeidOperations.ResourceList<
    Job,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("List processed files within a Job")
  listFiles is DeidOperations.ResourceList<
    File,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("Cancel a DeID Job")
  @doc("""
  Cancels a job that is in progress. 
  
  The job will be marked as canceled and the service will stop processing the job. The service will not delete any files that have already been processed.

  If the job is already complete, this will have no effect. 
  """)
  cancel is DeidOperations.ResourceAction<Job, {}, Job>;

  @summary("Delete a DeID Job")
  @doc("Removes the record of the job from the service. Does not delete any files.")
  delete is DeidOperations.ResourceDelete<Job>;
}

interface RealtimeOperations {
  @summary("Realtime Synchronous Deidentification.")
  @route("/deid")
  @post
  deid is Azure.Core.RpcOperation<
    {
      @doc("The request body for realtime deidentification.")
      @body
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
      body: DeidRequest;
    },
    DeidResponse
  >;
}
