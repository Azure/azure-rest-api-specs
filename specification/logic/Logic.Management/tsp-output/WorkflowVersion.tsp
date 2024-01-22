import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workflow.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The workflow version.
 */
@parentResource(Workflow)
model WorkflowVersion is TrackedResource<WorkflowVersionProperties> {
  /**
   * The workflow versionId.
   */
  @path
  @key("versionId")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface WorkflowVersions {
  /**
   * Gets a workflow version.
   */
  get is ArmResourceRead<WorkflowVersion>;

  /**
   * Gets a list of workflow versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowVersions_List")
  list is ArmResourceListByParent<
    WorkflowVersion,
    {
      ...BaseParameters<WorkflowVersion>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Get the callback url for a trigger of a workflow version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkflowVersionTriggers_ListCallbackUrl")
  listCallbackUrl is ArmResourceActionSync<
    WorkflowVersion,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl,
    {
      ...BaseParameters<WorkflowVersion>;

      /**
       * The workflow trigger name.
       */
      @path
      triggerName: string;
    }
  >;
}

@@projectedName(WorkflowVersions.listCallbackUrl::parameters.body,
  "json",
  "parameters"
);
@@extension(WorkflowVersions.listCallbackUrl::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(WorkflowVersions.listCallbackUrl::parameters.body,
  "The callback URL parameters."
);
