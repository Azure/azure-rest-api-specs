import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(
  Microsoft.AlertsManagement,
  "PreviewAlertRuleMgmtClient",
  "python"
);
@@clientName(
  Microsoft.AlertsManagement,
  "PreviewAlertRuleManagementClient",
  "javascript"
);
@@clientName(AlertSeverity.`0`, "ZERO", "python");
@@clientName(AlertSeverity.`1`, "ONE", "python");
@@clientName(AlertSeverity.`2`, "TWO", "python");
@@clientName(AlertSeverity.`3`, "THREE", "python");
@@clientName(AlertSeverity.`4`, "FOUR", "python");

@@clientName(AlertSeverity.`0`, "Zero", "go,javascript");
@@clientName(AlertSeverity.`1`, "One", "go,javascript");
@@clientName(AlertSeverity.`2`, "Two", "go,javascript");
@@clientName(AlertSeverity.`3`, "Three", "go,javascript");
@@clientName(AlertSeverity.`4`, "Four", "go,javascript");
@@clientName(Microsoft.AlertsManagement, "Client", "go");

// =============================================================================
// C# (.NET) MPG customizations for Azure.ResourceManager.PreviewAlertRule
// -----------------------------------------------------------------------------
// The C# management-plane generator (http-client-csharp-mgmt) has a few
// constraints that require renaming/grouping that doesn't apply to other
// language emitters. All such customizations below are scoped to the "csharp"
// target so they do not affect Python/JavaScript/Go/Java/AutoRest output.
// =============================================================================

// C# customizations: virtually group the free-standing `previewAlertRule` op
// under an interface `PreviewAlertRules` for the C# MPG emitter only, so the
// generator can emit a proper client / extension class for it. The interface
// is declared here in client.tsp (not in routes.tsp) so the OpenAPI/Swagger
// output is not affected — the swagger emitter does not load client.tsp, so
// the operationId remains `PreviewAlertRule` (rather than becoming
// `PreviewAlertRules_PreviewAlertRule`). `@@clientLocation` is scoped to
// "csharp" so other TCGC-based emitters (Python/Java/JS/Go) also see no change.

@@clientLocation(previewAlertRule, "PreviewAlertRules", "csharp");

// C# customizations: rename AlertSeverity enum members to use Word names since numeric
// names produce illegal identifiers in C# field names.
@@clientName(AlertSeverity.`0`, "Sev0", "csharp");
@@clientName(AlertSeverity.`1`, "Sev1", "csharp");
@@clientName(AlertSeverity.`2`, "Sev2", "csharp");
@@clientName(AlertSeverity.`3`, "Sev3", "csharp");
@@clientName(AlertSeverity.`4`, "Sev4", "csharp");

// C# customizations: rename overly-generic model names so the SDK surface follows
// the `<Resource><Concept>` naming convention used elsewhere in azure-sdk-for-net.
@@clientName(Kind, "LogAlertRuleKind", "csharp");
@@clientName(Evaluation, "RulePreviewEvaluation", "csharp");
@@clientName(EvaluatedPeriod, "RulePreviewEvaluatedPeriod", "csharp");

// C# customizations: follow mgmt API naming conventions — request/response body
// models use the `Content`/`Result` suffix (not `Request`/`Response`), and
// boolean properties are prefixed with `Is` (BOOL001).
@@clientName(PreviewAlertRuleRequest, "PreviewAlertRuleContent", "csharp");
@@clientName(PreviewAlertRuleResponse, "PreviewAlertRuleResult", "csharp");
@@clientName(Evaluation.thresholdMet, "IsThresholdMet", "csharp");
@@clientName(EvaluatedPeriod.thresholdMet, "IsThresholdMet", "csharp");
@@clientName(
  DimensionNameAndValue,
  "RulePreviewDimensionNameAndValue",
  "csharp"
);

// C# customizations: drop the "Resource" suffix on this body model. The mgmt InheritanceCheck
// test fails for any public type ending with "Resource" that does not derive from ArmResource;
// LogAlertRuleResource is an input/request body model, not an ARM resource.
@@clientName(LogAlertRuleResource, "LogAlertRule", "csharp");

// C# customizations: rename ConditionOperator.Equals to avoid conflict with
// ValueType.Equals(object) on the generated readonly struct.
@@clientName(ConditionOperator.Equals, "EqualTo", "csharp");

// C# customizations: force `LogAlertRuleResource` (and its nested
// `LogAlertRuleProperties`) to be treated as input-only models. Because the
// TypeSpec body declares `@visibility(Lifecycle.Read, Lifecycle.Create)` on
// `location` and the model is only ever sent as a request body (the POST
// response is `PreviewAlertRuleResponse`, not `LogAlertRuleResource`), TCGC's
// default `input | output` usage marks the model with output semantics and
// the C# emitter then emits an `internal` constructor with read-only
// properties — which makes it impossible for callers to construct a
// `LogAlertRule` payload. `Usage.input` keeps the public parameterless
// constructor and the writable scalar setters that are required for a
// request-body shape.
@@usage(LogAlertRuleResource, Usage.input, "csharp");
@@usage(LogAlertRuleProperties, Usage.input, "csharp");
@@usage(LogAlertRuleCriteria, Usage.input, "csharp");
@@usage(LogAlertRuleCondition, Usage.input, "csharp");
@@usage(LogAlertRuleDimension, Usage.input, "csharp");
@@usage(LogAlertRuleConditionFailingPeriods, Usage.input, "csharp");

// C# customizations: align Azure region strings with the Azure.Core.AzureLocation
// strongly-typed value used elsewhere in azure-sdk-for-net (matches the
// existing Azure.ResourceManager.AlertsManagement SDK surface).
@@alternateType(LogAlertRuleResource.location, azureLocation, "csharp");
@@alternateType(PreviewAlertRuleRequest.location, azureLocation, "csharp");

// C# customizations: scopes are ARM resource ids per the spec doc
// ("The list of resource id's that this scheduled query rule is scoped to.").
// Project them to the strongly-typed `ResourceIdentifier` element type.
@@alternateType(
  LogAlertRuleProperties.scopes,
  armResourceIdentifier[],
  "csharp"
);
