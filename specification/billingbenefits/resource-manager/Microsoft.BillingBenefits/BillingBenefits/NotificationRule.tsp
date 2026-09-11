import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Notification rule resource definition. Extension resource that can be attached to any BillingBenefits resource.
 */
@added(Versions.v2026_07_01_preview)
model NotificationRule
  is Azure.ResourceManager.ExtensionResource<NotificationRuleProperties> {
  ...ResourceNameParameter<
    Resource = NotificationRule,
    KeyName = "notificationName",
    SegmentName = "notifications",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
  ...ResourceKindProperty<NotificationRuleKind>;
}

@armResourceOperations
@added(Versions.v2026_07_01_preview)
interface NotificationRules {
  /**
   * Get a notification rule.
   */
  get is ArmResourceRead<NotificationRule>;

  /**
   * Create or update a notification rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationRule>;

  /**
   * Update a notification rule.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NotificationRule,
    PatchModel = NotificationRulePatchRequest
  >;

  /**
   * Delete a notification rule.
   */
  delete is ArmResourceDeleteSync<NotificationRule>;

  /**
   * List notification rules for a resource.
   */
  list is ArmResourceListByParent<
    NotificationRule,
    Response = ArmResponse<NotificationRuleList>
  >;
}

@@doc(NotificationRule.name, "Name of the notification rule");
@@maxLength(NotificationRule.name, 64);
@@doc(NotificationRule.properties, "Notification rule properties");
@@doc(
  NotificationRules.createOrUpdate::parameters.resource,
  "Notification rule create or update request"
);
