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
model ScheduledQueryRuleResource
  is TrackedResource<ScheduledQueryRuleProperties> {
  @doc("The name of the rule.")
  @key("ruleName")
  @segment("scheduledQueryRules")
  name: string;

  @doc("The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields. ")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ScheduledQueryRules {
  @doc("Retrieve an scheduled query rule definition.")
  get is ArmResourceRead<ScheduledQueryRuleResource>;
  @doc("Creates or updates a scheduled query rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ScheduledQueryRuleResource>;
  @doc("Update a scheduled query rule.")
  update is ArmCustomPatchSync<
    ScheduledQueryRuleResource,
    ScheduledQueryRuleResourcePatch
  >;
  @doc("Deletes a scheduled query rule.")
  delete is ArmResourceDeleteSync<ScheduledQueryRuleResource>;
  @doc("Retrieve scheduled query rule definitions in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ScheduledQueryRuleResource>;
  @doc("Retrieve a scheduled query rule definitions in a subscription.")
  listBySubscription is ArmListBySubscription<ScheduledQueryRuleResource>;
}
