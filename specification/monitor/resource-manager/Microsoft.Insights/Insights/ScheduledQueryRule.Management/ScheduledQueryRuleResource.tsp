import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The scheduled query rule resource.
 */
model ScheduledQueryRuleResource
  is Azure.ResourceManager.ProxyResource<ScheduledQueryRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = ScheduledQueryRuleResource,
    KeyName = "ruleName",
    SegmentName = "scheduledQueryRules",
    NamePattern = "^[^#<>%&:\\?/{}*]{1,260}$"
  >;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;

  /**
   * Resource tags.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Indicates the type of scheduled query rule. The default is LogAlert.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: Kind;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations(#{ omitTags: true })
interface ScheduledQueryRuleResources {
  /**
   * Retrieve an scheduled query rule definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledQueryRules_Get")
  @tag("ScheduledQueryRules")
  get is ArmResourceRead<ScheduledQueryRuleResource, Error = ErrorContract>;

  /**
   * Creates or updates a scheduled query rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledQueryRules_CreateOrUpdate")
  @tag("ScheduledQueryRules")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ScheduledQueryRuleResource,
    Error = ErrorContract
  >;

  /**
   * Update a scheduled query rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledQueryRules_Update")
  @patch(#{ implicitOptionality: false })
  @tag("ScheduledQueryRules")
  update is ArmCustomPatchSync<
    ScheduledQueryRuleResource,
    PatchModel = ScheduledQueryRuleResourcePatch,
    Error = ErrorContract
  >;

  /**
   * Deletes a scheduled query rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledQueryRules_Delete")
  @tag("ScheduledQueryRules")
  delete is ArmResourceDeleteSync<
    ScheduledQueryRuleResource,
    Error = ErrorContract
  >;

  /**
   * Retrieve scheduled query rule definitions in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledQueryRules_ListByResourceGroup")
  @tag("ScheduledQueryRules")
  listByResourceGroup is ArmResourceListByParent<
    ScheduledQueryRuleResource,
    Response = ArmResponse<ScheduledQueryRuleResourceCollection>,
    Error = ErrorContract
  >;

  /**
   * Retrieve a scheduled query rule definitions in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledQueryRules_ListBySubscription")
  @tag("ScheduledQueryRules")
  listBySubscription is ArmListBySubscription<
    ScheduledQueryRuleResource,
    Response = ArmResponse<ScheduledQueryRuleResourceCollection>,
    Error = ErrorContract
  >;
}

@@doc(ScheduledQueryRuleResource.name, "The name of the rule.");
@@doc(ScheduledQueryRuleResource.properties,
  "The rule properties of the resource."
);
@@doc(ScheduledQueryRuleResources.createOrUpdate::parameters.resource,
  "The parameters of the rule to create or update."
);
@@doc(ScheduledQueryRuleResources.update::parameters.properties,
  "The parameters of the rule to update."
);
