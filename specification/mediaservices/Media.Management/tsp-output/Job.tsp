import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Transform.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
@doc("A Job resource type. The progress and state can be obtained by polling a Job or subscribing to events using EventGrid.")
@parentResource(Transform)
model Job is ProxyResource<JobProperties> {
  @doc("The Job name.")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface Jobs {
  @doc("Gets a Job.")
  get is ArmResourceRead<Job>;

  @doc("Creates a Job.")
  create is ArmResourceCreateOrReplaceSync<Job>;

  @doc("Update is only supported for description and priority. Updating Priority will take effect when the Job state is Queued or Scheduled and depending on the timing the priority update may be ignored.")
  update is ArmCustomPatchSync<Job, Job>;

  @doc("Deletes a Job.")
  delete is ArmResourceDeleteSync<Job>;

  @doc("Lists all of the Jobs for the Transform.")
  list is ArmResourceListByParent<
    Job,
    {
      ...BaseParameters<Job>;

      @doc("Restricts the set of items returned.")
      @query("$filter")
      $filter?: string;

      @doc("Specifies the key by which the result collection should be ordered.")
      @query("$orderby")
      $orderby?: string;
    }
  >;

  @doc("Cancel a Job.")
  cancelJob is ArmResourceActionSync<Job, void, void>;
}

@@projectedName(Jobs.create::parameters.resource, "json", "parameters");
@@extension(Jobs.create::parameters.resource, "x-ms-client-name", "parameters");
@@doc(Jobs.create::parameters.resource, "The request parameters");
@@projectedName(Jobs.update::parameters.properties, "json", "parameters");
@@extension(Jobs.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Jobs.update::parameters.properties, "The request parameters");
