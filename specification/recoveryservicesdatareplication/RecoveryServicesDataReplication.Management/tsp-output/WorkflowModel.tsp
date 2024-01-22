import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Workflow model.
 */
@parentResource(VaultModel)
model WorkflowModel is ProxyResource<WorkflowModelProperties> {
  /**
   * The job (workflow) name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface WorkflowModels {
  /**
   * Gets the details of the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workflow_Get")
  get is ArmResourceRead<WorkflowModel>;

  /**
   * Gets the list of jobs in the given vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workflow_List")
  list is ArmResourceListByParent<
    WorkflowModel,
    {
      ...BaseParameters<WorkflowModel>;

      /**
       * Filter string.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
