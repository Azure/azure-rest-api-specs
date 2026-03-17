import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias JobsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.jobs_v1_preview>;

alias JobsFilterQueryParams = {
  @doc("Filter jobs by tag in the format 'key=value' (e.g., 'framework=pytorch').")
  @query
  tag?: string;

  @doc("Specifies which view type to apply when listing jobs.")
  @query
  listViewType?: ListViewType;
};

alias JobOperations = FoundryAzureOperations<{}>;

@tag("Jobs")
interface Jobs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List Jobs.")
  @Rest.listsResource(CommandJob)
  list is Azure.Core.Foundations.ResourceList<
    CommandJob,
    JobsFilterQueryParams & JobsPreviewHeader,
    Azure.Core.Page<CommandJob>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a Job by name.")
  @get
  get is Azure.Core.Foundations.ResourceOperation<
    CommandJob,
    {
      ...JobsPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<CommandJob>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "PUT create-or-update pattern required by the Job API wire format"
  @doc("Create and execute a Job. For update case, the Tags in the definition passed in will replace Tags in the existing job.")
  @put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    CommandJob,
    {
      ...JobsPreviewHeader;

      @doc("The command job to create or update.")
      @bodyRoot
      body: CommandJob;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<CommandJob>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Delete a Job by name.")
  @delete
  delete is Azure.Core.Foundations.ResourceOperation<
    CommandJob,
    {
      ...JobsPreviewHeader;
    },
    Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Cancel action uses ResourceAction with no response body"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Cancel returns 200 with no body"
  @doc("Cancel a Job by name.")
  @post
  @actionSeparator("/")
  cancel is Azure.Core.Foundations.ResourceOperation<
    CommandJob,
    {
      ...JobsPreviewHeader;
    },
    Http.OkResponse
  >;
}
