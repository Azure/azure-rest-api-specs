import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.DatabaseWatcher;

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;

@armResourceOperations
@added(Versions.v2024_07_19_preview)
interface AlertRuleResources {
  get is ArmResourceRead<AlertRuleResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<AlertRuleResource>;
  delete is ArmResourceDeleteSync<AlertRuleResource>;
  listByParent is ArmResourceListByParent<AlertRuleResource>;
}

@parentResource(Watcher)
@added(Versions.v2024_07_19_preview)
model AlertRuleResource is ProxyResource<AlertRuleResourceProperties> {
  @doc("The alert rule proxy resource name.")
  @key("alertRuleResourceName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_.]{0,62}[a-zA-Z0-9_]{1}$")
  @segment("alertRuleResources")
  @path
  name: string;
}

@doc("The generic properties of the alert rule proxy resource.")
@added(Versions.v2024_07_19_preview)
model AlertRuleResourceProperties {
  @doc("The resource ID of the alert rule resource.")
  alertRuleResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Insights/scheduledQueryRules";
    }
  ]>;

  @doc("The properties with which the alert rule resource was created.")
  createdWithProperties: alertRuleCreationProperties;

  @doc("The creation time of the alert rule resource.")
  creationTime: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the alert rule resource.")
  provisioningState?: ResourceProvisioningState;

  @doc("The template ID associated with alert rule resource.")
  alertRuleTemplateId: string;

  @doc("The alert rule template version.")
  alertRuleTemplateVersion: string;
}

@doc("The properties with which the alert rule resource was created.")
@added(Versions.v2024_07_19_preview)
union alertRuleCreationProperties {
  string,

  @doc("The alert rule was created with an action group.")
  CreatedWithActionGroup: "CreatedWithActionGroup",

  @doc("The alert rule was created with no properties.")
  None: "None",
}
