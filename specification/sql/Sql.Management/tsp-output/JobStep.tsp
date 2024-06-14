import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobVersion.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A job step.
 */
@parentResource(JobVersion)
model JobStep is ProxyResource<JobStepProperties> {
  /**
   * The name of the job step.
   */
  @path
  @key("stepName")
  @segment("steps")
  name: string;
}

@armResourceOperations
interface JobSteps {
  /**
   * Gets the specified version of a job step.
   */
  getByVersion is ArmResourceRead<JobStep>;

  /**
   * Gets all job steps in the specified job version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobSteps_ListByVersion")
  listByVersion is ArmResourceListByParent<JobStep>;
}
