import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
// FIXME: AlertRuleTemplate has no properties property
/**
 * Alert rule template.
 */
model AlertRuleTemplate is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = AlertRuleTemplate,
    KeyName = "alertRuleTemplateId",
    SegmentName = "alertRuleTemplates",
    NamePattern = ""
  >;

  /**
   * The alert rule kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: AlertRuleKind;
}

alias AlertRuleWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface AlertRuleTemplates {
  /**
   * Gets the alert rule template.
   */
  get is ArmResourceRead<AlertRuleTemplate>;

  /**
   * Gets all alert rule templates.
   */
  list is ArmResourceListByParent<
    AlertRuleTemplate,
    Response = ArmResponse<AlertRuleTemplatesList>
  >;
}

@@doc(AlertRuleTemplate.name, "Alert rule template ID");
