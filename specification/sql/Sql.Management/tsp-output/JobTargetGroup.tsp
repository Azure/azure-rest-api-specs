import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A group of job targets.
 */
@parentResource(JobAgent)
model JobTargetGroup is ProxyResource<JobTargetGroupProperties> {
  /**
   * The name of the target group.
   */
  @path
  @key("targetGroupName")
  @segment("targetGroups")
  name: string;
}

@armResourceOperations
interface JobTargetGroups {
  /**
   * Gets a target group.
   */
  get is ArmResourceRead<JobTargetGroup>;

  /**
   * Creates or updates a target group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobTargetGroup>;

  /**
   * Deletes a target group.
   */
  delete is ArmResourceDeleteSync<JobTargetGroup>;

  /**
   * Gets all target groups in an agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobTargetGroups_ListByAgent")
  listByAgent is ArmResourceListByParent<JobTargetGroup>;
}

@@projectedName(JobTargetGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(JobTargetGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(JobTargetGroups.createOrUpdate::parameters.resource,
  "The requested state of the target group."
);
