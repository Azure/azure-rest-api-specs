import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
@doc("The scheduled query rule resource.")
model ScheduledQueryRuleResource
  is TrackedResource<ScheduledQueryRuleProperties> {
  @doc("The name of the rule.")
  @path
  @key("ruleName")
  @segment("scheduledQueryRules")
  name: string;

  @doc("The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields. ")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ScheduledQueryRuleResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve an scheduled query rule definition.")
  @operationId("ScheduledQueryRules_Get")
  get is ArmResourceRead<ScheduledQueryRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a scheduled query rule.")
  @operationId("ScheduledQueryRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ScheduledQueryRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a scheduled query rule.")
  @operationId("ScheduledQueryRules_Update")
  update is ArmCustomPatchSync<
    ScheduledQueryRuleResource,
    ScheduledQueryRuleResourcePatch
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a scheduled query rule.")
  @operationId("ScheduledQueryRules_Delete")
  delete is ArmResourceDeleteSync<ScheduledQueryRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve scheduled query rule definitions in a resource group.")
  @operationId("ScheduledQueryRules_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ScheduledQueryRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a scheduled query rule definitions in a subscription.")
  @operationId("ScheduledQueryRules_ListBySubscription")
  listBySubscription is ArmListBySubscription<ScheduledQueryRuleResource>;
}

@@projectedName(ScheduledQueryRuleResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ScheduledQueryRuleResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ScheduledQueryRuleResources.createOrUpdate::parameters.resource,
  "The parameters of the rule to create or update."
);
@@projectedName(ScheduledQueryRuleResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ScheduledQueryRuleResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ScheduledQueryRuleResources.update::parameters.properties,
  "The parameters of the rule to update."
);
