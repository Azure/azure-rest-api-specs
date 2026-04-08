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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Indicates the type of scheduled query rule. The default is LogAlert.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: Kind;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations(#{ omitTags: true })
interface ScheduledQueryRuleResources {
  /**
   * Retrieve an scheduled query rule definition.
   */
  @tag("ScheduledQueryRules")
  get is ArmResourceRead<ScheduledQueryRuleResource, Error = ErrorContract>;

  /**
   * Creates or updates a scheduled query rule.
   */
  @tag("ScheduledQueryRules")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ScheduledQueryRuleResource,
    Error = ErrorContract
  >;

  /**
   * Update a scheduled query rule.
   */
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
  @tag("ScheduledQueryRules")
  delete is ArmResourceDeleteSync<
    ScheduledQueryRuleResource,
    Error = ErrorContract
  >;

  /**
   * Retrieve scheduled query rule definitions in a resource group.
   */
  @tag("ScheduledQueryRules")
  listByResourceGroup is ArmResourceListByParent<
    ScheduledQueryRuleResource,
    Response = ArmResponse<ScheduledQueryRuleResourceCollection>,
    Error = ErrorContract
  >;

  /**
   * Retrieve a scheduled query rule definitions in a subscription.
   */
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
