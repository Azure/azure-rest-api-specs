import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias JobOperations = FoundryAzureOperations<{}>;

@tag("Jobs")
interface Jobs {
  @doc("List Jobs.")
  list is JobOperations.ResourceList<
    CommandJob,
    ListQueryParametersTrait<{
      @doc("Filter jobs by tag in the format 'key=value' (e.g., 'framework=pytorch').")
      @query
      tag?: string;

      @doc("Specifies which view type to apply when listing jobs.")
      @query
      listViewType?: ListViewType;
    }>
  >;

  @doc("Get a Job by name.")
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

  @doc("Delete a Job by name.")
  delete is JobOperations.ResourceDelete<CommandJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Cancel action uses ResourceAction with no response body"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Cancel returns 200 with no body"
  @doc("Cancel a Job by name.")
  @post
  @actionSeparator("/")
  cancel is JobOperations.ResourceAction<CommandJob, {}, Http.OkResponse>;
}
