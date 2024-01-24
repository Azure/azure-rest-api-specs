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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(JobVersion)
@Azure.ResourceManager.Private.armResourceInternal(JobStepProperties)
@includeInapplicableMetadataInPayload(false)
model JobStep extends ProxyResource {
  /**
   * The name of the job step.
   */
  @path
  @key("stepName")
  @segment("steps")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JobStepProperties;
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
