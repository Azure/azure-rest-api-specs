import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaTransform.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("A Job resource type. The progress and state can be obtained by polling a Job or subscribing to events using EventGrid.")
@parentResource(MediaTransform)
model MediaJob is ProxyResource<JobProperties> {
  @doc("The Job name.")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface MediaJobs {
  @doc("Gets a Job.")
  get is ArmResourceRead<MediaJob>;
  @doc("Creates a Job.")
  create is ArmResourceCreateOrReplaceSync<MediaJob>;
  @doc("Update is only supported for description and priority. Updating Priority will take effect when the Job state is Queued or Scheduled and depending on the timing the priority update may be ignored.")
  update is ArmResourcePatchSync<MediaJob, JobProperties>;
  @doc("Deletes a Job.")
  delete is ArmResourceDeleteSync<MediaJob>;
  @doc("Lists all of the Jobs for the Transform.")
  list is ArmResourceListByParent<
    MediaJob,
    {
      ...BaseParameters<MediaJob>;

      @doc("Restricts the set of items returned.")
      @query("$filter")
      $filter?: string;

      @doc("Specifies the key by which the result collection should be ordered.")
      @query("$orderby")
      $orderby?: string;
    }
  >;
  @doc("Cancel a Job.")
  cancelJob is ArmResourceActionSync<MediaJob, void, void>;
}
