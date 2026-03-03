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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO delete pattern required by the Job API"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling is handled server-side; clients poll Operation-Location header"
  @doc("Delete a Job by id.")
  delete is JobOperations.LongRunningResourceDelete<CommandJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO cancel action required by the Job API"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling is handled server-side; clients poll Operation-Location header"
  @doc("Cancel a Job by id.")
  @post
  @Rest.action("cancel")
  cancel is JobOperations.LongRunningResourceAction<CommandJob, {}, {}>;
}
