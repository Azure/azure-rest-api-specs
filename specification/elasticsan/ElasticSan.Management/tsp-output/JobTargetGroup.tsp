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
@doc("A group of job targets.")
@parentResource(JobAgent)
model JobTargetGroup is ProxyResource<JobTargetGroupProperties> {
  @doc("The name of the target group.")
  @path
  @key("targetGroupName")
  @segment("targetGroups")
  name: string;
}

@armResourceOperations
interface JobTargetGroups {
  @doc("Gets a target group.")
  get is ArmResourceRead<JobTargetGroup>;

  @doc("Creates or updates a target group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobTargetGroup>;

  @doc("Deletes a target group.")
  delete is ArmResourceDeleteSync<JobTargetGroup>;

  @doc("Gets all target groups in an agent.")
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
