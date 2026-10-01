import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(
  Microsoft.AlertsManagement,
  "PrometheusRuleGroupsMgmtClient",
  "python"
);
@@clientName(
  Microsoft.AlertsManagement,
  "PrometheusRuleGroupsManagementClient",
  "javascript"
);

// C# customizations: keep the operations on the original armResourceOperations
// interface so the synthetic "PrometheusRuleGroups" operation group declared in
// back-compatible.tsp does not collide with the C# namespace
// (Azure.ResourceManager.PrometheusRuleGroups), which would otherwise cause the
// generator to emit Azure.ResourceManager._PrometheusRuleGroups.
@@clientLocation(
  PrometheusRuleGroupResources.get,
  PrometheusRuleGroupResources,
  "csharp"
);
@@clientLocation(
  PrometheusRuleGroupResources.createOrUpdate,
  PrometheusRuleGroupResources,
  "csharp"
);
@@clientLocation(
  PrometheusRuleGroupResources.update,
  PrometheusRuleGroupResources,
  "csharp"
);
@@clientLocation(
  PrometheusRuleGroupResources.delete,
  PrometheusRuleGroupResources,
  "csharp"
);
@@clientLocation(
  PrometheusRuleGroupResources.listByResourceGroup,
  PrometheusRuleGroupResources,
  "csharp"
);
@@clientLocation(
  PrometheusRuleGroupResources.listBySubscription,
  PrometheusRuleGroupResources,
  "csharp"
);

// common-types v3 types Resource.id as `string`; map to armResourceIdentifier so
// the C# generator emits ResourceIdentifier compatible with the ResourceData base.
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C# customizations: drop the redundant "Resource" suffix on the resource body model
// so the generator emits idiomatic `PrometheusRuleGroupResource` (ArmResource),
// `PrometheusRuleGroupData` (data class), and `PrometheusRuleGroupCollection` (ArmCollection)
// instead of `PrometheusRuleGroupResourceData` / `PrometheusRuleGroupResourceCollection`.
@@clientName(PrometheusRuleGroupResource, "PrometheusRuleGroup", "csharp");

// C# customizations: rename the patch body model from the verbose
// `PrometheusRuleGroupResourcePatchParameters` to the conventional `PrometheusRuleGroupPatch`.
@@clientName(
  PrometheusRuleGroupResourcePatchParameters,
  "PrometheusRuleGroupPatch",
  "csharp"
);

// C# customizations: boolean properties must use a verb prefix
// (Is/Can/Has/Does/Should/Allow/Enable/Disable/Use/Support) per .NET naming guidelines.
@@clientName(
  PrometheusRuleResolveConfiguration.autoResolved,
  "IsAutoResolved",
  "csharp"
);
@@clientName(PrometheusRuleGroupProperties.enabled, "IsEnabled", "csharp");
@@clientName(PrometheusRule.enabled, "IsEnabled", "csharp");
@@clientName(
  PrometheusRuleGroupResourcePatchParametersProperties.enabled,
  "IsEnabled",
  "csharp"
);

// C# customizations: rename `PrometheusRule.for` to a descriptive name —
// `For` is awkward in C# (clashes visually with the `for` keyword); the doc
// describes this as the amount of time an alert must be active before firing.
@@clientName(PrometheusRule.for, "MinActiveDuration", "csharp");

// C# customizations: properties that carry ARM resource ids should surface as
// `ResourceIdentifier` rather than `string` to match the .NET SDK convention.
@@alternateType(
  PrometheusRuleGroupAction.actionGroupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PrometheusRuleGroupProperties.scopes,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
