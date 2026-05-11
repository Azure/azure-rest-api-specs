import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A group of job targets.
 */
@parentResource(JobAgent)
model JobTargetGroup
  is Azure.ResourceManager.ProxyResource<JobTargetGroupProperties> {
  ...ResourceNameParameter<
    Resource = JobTargetGroup,
    KeyName = "targetGroupName",
    SegmentName = "targetGroups",
    NamePattern = ""
  >;
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
  listByAgent is ArmResourceListByParent<JobTargetGroup>;
}

@@doc(JobTargetGroup.name, "The name of the target group.");
@@doc(JobTargetGroup.properties, "Resource properties.");
@@doc(JobTargetGroups.createOrUpdate::parameters.resource,
  "The requested state of the target group."
);
