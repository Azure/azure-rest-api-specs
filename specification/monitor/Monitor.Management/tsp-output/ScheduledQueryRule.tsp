import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("The scheduled query rule resource.")
model ScheduledQueryRule is TrackedResource<ScheduledQueryRuleProperties> {
  @doc("The name of the rule.")
  @path
  @key("ruleName")
  @segment("scheduledQueryRules")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ScheduledQueryRules {
  @doc("Retrieve an scheduled query rule definition.")
  get is ArmResourceRead<ScheduledQueryRule>;
  @doc("Creates or updates a scheduled query rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ScheduledQueryRule>;
  @doc("Update a scheduled query rule.")
  update is ArmResourcePatchSync<
    ScheduledQueryRule,
    ScheduledQueryRuleProperties
  >;
  @doc("Deletes a scheduled query rule.")
  delete is ArmResourceDeleteSync<ScheduledQueryRule>;
  @doc("Retrieve scheduled query rule definitions in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ScheduledQueryRule>;
  @doc("Retrieve a scheduled query rule definitions in a subscription.")
  listBySubscription is ArmListBySubscription<ScheduledQueryRule>;
}
