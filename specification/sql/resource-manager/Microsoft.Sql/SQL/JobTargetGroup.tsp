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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(JobAgent)
@Azure.ResourceManager.Legacy.feature(Features.JobTargetGroups)
model JobTargetGroup
  is Azure.ResourceManager.ProxyResource<JobTargetGroupProperties> {
  ...ResourceNameParameter<
    Resource = JobTargetGroup,
    KeyName = "targetGroupName",
    SegmentName = "targetGroups",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.JobTargetGroups)
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
@@doc(
  JobTargetGroups.createOrUpdate::parameters.resource,
  "The requested state of the target group."
);
