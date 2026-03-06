import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

alias JobServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias JobOperations = Azure.Core.ResourceOperations<JobServiceTraits>;

@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface Jobs {
  @doc("List Jobs in the workspace.")
  list is JobOperations.ResourceList<CommandJob, ListJobsQueryParameters>;

  @doc("Get a Job by id.")
  get is JobOperations.ResourceRead<CommandJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "PUT create-or-update pattern required by the Job API wire format"
  @doc("Create and execute a Job. For update case, the Tags in the definition passed in will replace Tags in the existing job.")
  @put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    CommandJob,
    {
      @doc("The command job to create or update.")
      @bodyRoot
      body: CommandJob;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<CommandJob>
  >;

  @doc("Delete a Job by id.")
  delete is JobOperations.ResourceDelete<CommandJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Cancel action uses ResourceAction with no response body"
  @doc("Cancel a Job by id.")
  @post
  cancel is JobOperations.ResourceAction<
    CommandJob,
    {},
    Http.NoContentResponse
  >;
}
