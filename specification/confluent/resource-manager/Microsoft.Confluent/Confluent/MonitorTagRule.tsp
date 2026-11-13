import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./ObservabilityModels.tsp";
import "./MonitorResource.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Confluent;

/**
 * A rule set that specifies which Azure logs are sent to a monitor's configured
 * Confluent topic.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
@parentResource(MonitorResource)
model MonitorTagRule
  is Azure.ResourceManager.ProxyResource<MonitorTagRuleProperties> {
  ...ResourceNameParameter<
    Resource = MonitorTagRule,
    KeyName = "ruleSetName",
    SegmentName = "tagRules"
  >;
}

/**
 * Operations for monitor tag rules.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
@armResourceOperations
interface MonitorTagRules {
  /**
   * Gets a named rule set for a Confluent monitor.
   */
  get is ArmResourceRead<
    MonitorTagRule,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Creates or fully replaces a named rule set that specifies which Azure logs
   * are sent through a Confluent monitor.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MonitorTagRule,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Deletes a named rule set from a Confluent monitor.
   */
  delete is ArmResourceDeleteSync<
    MonitorTagRule,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Lists the rule sets configured for a Confluent monitor.
   */
  listByMonitor is ArmResourceListByParent<
    MonitorTagRule,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@doc(MonitorTagRule.name, "Name of the rule set.");
@@doc(
  MonitorTagRule.properties,
  "The rules that select Azure logs and the current status of the rule set."
);
