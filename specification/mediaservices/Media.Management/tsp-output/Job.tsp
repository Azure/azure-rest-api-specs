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
/**
 * A Job resource type. The progress and state can be obtained by polling a Job or subscribing to events using EventGrid.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Transform)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(JobProperties)
model Job extends ProxyResourceBase {
  /**
   * The Job name.
   */
  @path
  @key("jobName")
  @segment("jobs")
  @visibility("read")
  name: string;

  /**
   * The resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JobProperties;
}

@armResourceOperations
interface Jobs {
  /**
   * Gets a Job.
   */
  get is ArmResourceRead<Job>;

  /**
   * Creates a Job.
   */
  create is ArmResourceCreateOrReplaceSync<Job>;

  /**
   * Update is only supported for description and priority. Updating Priority will take effect when the Job state is Queued or Scheduled and depending on the timing the priority update may be ignored.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Job, Job>;

  /**
   * Deletes a Job.
   */
  delete is ArmResourceDeleteSync<Job>;

  /**
   * Lists all of the Jobs for the Transform.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Jobs_List")
  list is ArmResourceListByParent<
    Job,
    {
      ...BaseParameters<Job>;

      /**
       * Restricts the set of items returned.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies the key by which the result collection should be ordered.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Cancel a Job.
   */
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
