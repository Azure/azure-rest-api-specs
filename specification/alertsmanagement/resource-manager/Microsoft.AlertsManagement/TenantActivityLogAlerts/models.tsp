import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AlertsManagement;

@tenantResource
@armVirtualResource("Microsoft.Management")
model ManagementGroup<ParameterName extends valueof string = "managementGroupName"> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  @minLength(1)
  @maxLength(90)
  @segment("managementGroups")
  @key(ParameterName)
  @doc("The management group ID.")
  name: string;
}

/**
 * An Azure Activity Log Alert rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertRuleProperties {
  /**
   * The tenant GUID. Must be provided for tenant-level and management group events rules.
   */
  tenantScope?: string;

  /**
   * A list of resource IDs that will be used as prefixes. The alert will only apply to Activity Log events with resource IDs that fall under one of these prefixes. This list must include at least one item.
   */
  scopes?: string[];

  /**
   * The condition that will cause this alert to activate.
   */
  condition: AlertRuleAllOfCondition;

  /**
   * The actions that will activate when the condition is met.
   */
  actions: ActionList;

  /**
   * Indicates whether this Activity Log Alert rule is enabled. If an Activity Log Alert rule is not enabled, then none of its actions will be activated.
   */
  enabled?: boolean = true;

  /**
   * A description of this Activity Log Alert rule.
   */
  description?: string;
}

/**
 * An Activity Log Alert rule condition that is met when all its member conditions are met.
 */
model AlertRuleAllOfCondition {
  /**
   * The list of Activity Log Alert rule conditions.
   */
  @identifiers(#[])
  allOf: AlertRuleAnyOfOrLeafCondition[];
}

/**
 * An Activity Log Alert rule condition that is met when all its member conditions are met.
 * Each condition can be of one of the following types:
 * __Important__: Each type has its unique subset of properties. Properties from different types CANNOT exist in one condition.
 *    * __Leaf Condition -__ must contain 'field' and either 'equals' or 'containsAny'.
 *   _Please note, 'anyOf' should __not__ be set in a Leaf Condition._
 *   * __AnyOf Condition -__ must contain __only__ 'anyOf' (which is an array of Leaf Conditions).
 *   _Please note, 'field', 'equals' and 'containsAny' should __not__ be set in an AnyOf Condition._
 *
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertRuleAnyOfOrLeafCondition extends AlertRuleLeafCondition {
  /**
   * An Activity Log Alert rule condition that is met when at least one of its member leaf conditions are met.
   */
  @identifiers(#[])
  anyOf?: AlertRuleLeafCondition[];
}

/**
 * An Activity Log Alert rule condition that is met by comparing the field and value of an Activity Log event.
 * This condition must contain 'field' and either 'equals' or 'containsAny'.
 */
model AlertRuleLeafCondition {
  /**
   * The name of the Activity Log event's field that this condition will examine.
   * The possible values for this field are (case-insensitive): 'resourceId', 'category', 'caller', 'level', 'operationName', 'resourceGroup', 'resourceProvider', 'status', 'subStatus', 'resourceType', or anything beginning with 'properties'.
   */
  field?: string;

  /**
   * The value of the event's field will be compared to this value (case-insensitive) to determine if the condition is met.
   */
  equals?: string;

  /**
   * The value of the event's field will be compared to the values in this array (case-insensitive) to determine if the condition is met.
   */
  containsAny?: string[];
}

/**
 * A list of Activity Log Alert rule actions.
 */
model ActionList {
  /**
   * The list of the Action Groups.
   */
  @identifiers(#["actionGroupId"])
  actionGroups?: ActionGroup[];
}

/**
 * A pointer to an Azure Action Group.
 */
model ActionGroup {
  /**
   * The resource ID of the Action Group. This cannot be null or empty.
   */
  actionGroupId: string;

  /**
   * the dictionary of custom properties to include with the post operation. These data are appended to the webhook payload.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  webhookProperties?: Record<string>;

  /**
   * Predefined list of properties and configuration items for the action group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  actionProperties?: Record<string>;
}

/**
 * An Azure resource object.
 */
model AzureResource {
  /**
   * The resource Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource. Since Azure Activity Log Alerts is a global service, the location of the rules should always be 'global'.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string = "global";

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * An Activity Log Alert rule object for the body of patch operations.
 */
model TenantAlertRulePatchObject {
  /**
   * The resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The activity log alert settings for an update operation.
   */
  properties?: TenantAlertRulePatchProperties;
}

/**
 * An Activity Log Alert rule properties for patch operations.
 */
model TenantAlertRulePatchProperties {
  /**
   * Indicates whether this Activity Log Alert rule is enabled. If an Activity Log Alert rule is not enabled, then none of its actions will be activated.
   */
  enabled?: boolean = true;
}

/**
 * A list of Tenant Activity Log Alert rules.
 */
model TenantAlertRuleList is Azure.Core.Page<TenantActivityLogAlertResource>;
