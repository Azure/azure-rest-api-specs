import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.DatabaseWatcher;

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;

@armResourceOperations
interface AlertRuleResources {
  get is ArmResourceRead<AlertRuleResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<AlertRuleResource>;
  delete is ArmResourceDeleteSync<AlertRuleResource>;
  listByParent is ArmResourceListByParent<AlertRuleResource>;
}

@parentResource(Watcher)
model AlertRuleResource is ProxyResource<AlertRuleResourceProperties> {
  @doc("The alert rule proxy resource name.")
  @key("alertRuleResourceName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_.]{0,62}[a-zA-Z0-9_]{1}$")
  @segment("alertRuleResources")
  @path
  name: string;
}

@doc("The generic properties of the alert rule proxy resource.")
model AlertRuleResourceProperties {
  @doc("The resource ID of the alert rule resource.")
  alertRuleResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Insights/scheduledQueryRules";
    }
  ]>;

  @doc("Whether the alert rule was created with an action group.")
  createdWithActionGroup: boolean;

  @doc("The creation time of the alert rule resource.")
  creationTime: utcDateTime;

  @visibility("read")
  @doc("The provisioning state of the alert rule resource.")
  provisioningState?: ResourceProvisioningState;

  @doc("The template ID associated with alert rule resource.")
  alertRuleTemplateId: string;

  @doc("The alert rule template version.")
  alertRuleTemplateVersion: string;
}
