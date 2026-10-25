import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Monitor {
  /**
   * Properties for an observability agent resource.
   */
  model ObservabilityAgentProperties {
    /** The resource provisioning state. */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

    /** Description of the observability agent. */
    description?: string;

    /** Resource ID of the Azure Monitor workspace where this agent stores the issues it produces. The workspace must be in the same location as the agent. Required when autonomous operations are enabled. */
    monitoringAccountId?: Azure.Core.armResourceIdentifier;

    /** Whether the agent can run operations autonomously. When true, monitoringAccountId and at least one investigation policy must be configured. */
    autonomousOperationsEnabled: boolean;

    /** Instructions that guide the agent's behavior. */
    @maxLength(8192)
    instructions?: string;

    /** Configuration of agent investigations. */
    investigation?: ObservabilityAgentInvestigationConfiguration;

    /** Usage cap in Azure Agent Credits. */
    usageCap?: ObservabilityAgentUsageCapConfiguration;

    /** Resources monitored by this agent. These entries are embedded configuration, not child ARM resources. */
    @maxItems(10)
    @Azure.ResourceManager.identifiers(#["name"])
    monitoredResources?: ObservabilityAgentMonitoredResource[];
  }

  /**
   * Configuration of agent investigations. On PATCH, omitted members are unchanged and null clears the specified member.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The deployed PATCH contract distinguishes an omitted member from null, which clears that member."
  model ObservabilityAgentInvestigationConfiguration {
    /** Instructions that guide investigations. */
    @maxLength(8192)
    instructions?: string | null;

    /** Policies that select alerts for investigation. At least one policy is required when autonomous operations are enabled. On PATCH, a supplied array replaces the existing array. */
    @maxItems(10)
    @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
    policies?: ObservabilityAgentInvestigationPolicy[] | null;
  }

  /**
   * An investigation policy. At least one of minimumSeverity, ruleNameContains, or ruleResourceId must be specified.
   */
  model ObservabilityAgentInvestigationPolicy {
    /** Name of the policy. */
    policyName?: string;

    /** Description of the policy. */
    description?: string;

    /** Minimum alert severity used by this policy, represented as a nonempty string. */
    @minLength(1)
    @maxLength(64)
    minimumSeverity?: string;

    /** Nonempty alert-rule name fragments used by this policy. */
    @maxItems(10)
    ruleNameContains?: ObservabilityAgentRuleNameFragment[];

    /** ARM resource IDs of alert rules used by this policy. The wire property is named ruleResourceId even though its value is an array. */
    @maxItems(10)
    ruleResourceId?: Azure.Core.armResourceIdentifier[];

    /** Location filter for the policy. An empty string is allowed, but a nonempty value must not contain only whitespace. */
    @maxLength(64)
    locationFilter?: string;
  }

  /**
   * A nonempty alert-rule name fragment.
   */
  @minLength(1)
  @maxLength(64)
  scalar ObservabilityAgentRuleNameFragment extends string;

  /**
   * Usage cap configuration for an observability agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The deployed PATCH contract accepts null to clear the existing Azure Agent Credits cap."
  model ObservabilityAgentUsageCapConfiguration {
    /** Nonnegative cap in Azure Agent Credits (AAC). On PATCH, null clears the cap and omission leaves it unchanged. */
    @minValue(0)
    @encodedName("application/json", "amountAAC")
    amountAac?: float64 | null;
  }

  /**
   * An embedded resource monitored by an observability agent.
   */
  model ObservabilityAgentMonitoredResource {
    /** Logical name of the monitored resource. Must not contain only whitespace. */
    @minLength(1)
    @maxLength(64)
    name: string;

    /** ARM resource ID of the monitored resource. */
    resourceId: Azure.Core.armResourceIdentifier;
  }

  /**
   * Updatable properties of an observability agent. Omitted properties are unchanged. Null clears optional configuration; a null autonomousOperationsEnabled leaves its existing value unchanged. The resulting configuration must satisfy the autonomous-operation requirements.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The deployed PATCH contract uses explicit null to clear optional configuration and treats a null autonomousOperationsEnabled as unchanged."
  model ObservabilityAgentPropertiesUpdate {
    /** Description of the observability agent. Null clears the description. */
    description?: string | null;

    /** Resource ID of the Azure Monitor workspace where this agent stores issues. The workspace must be in the same location as the agent. Required when autonomous operations are enabled. If changed, existing issues remain in the previous workspace; only new issues are written to the new workspace. */
    monitoringAccountId?: Azure.Core.armResourceIdentifier | null;

    /** Whether the agent can run operations autonomously. Null leaves the existing value unchanged. Enabling autonomy requires a monitoring account and at least one investigation policy. */
    autonomousOperationsEnabled?: boolean | null;

    /** Instructions that guide the agent's behavior. Null clears the instructions. */
    @maxLength(8192)
    instructions?: string | null;

    /** Configuration of agent investigations. Null clears the configuration; supplied members are merged with the existing configuration. */
    investigation?: ObservabilityAgentInvestigationConfiguration | null;

    /** Usage cap configuration. Null clears the configuration; supplied members are merged with the existing configuration. */
    usageCap?: ObservabilityAgentUsageCapConfiguration | null;

    /** Resources monitored by this agent. A supplied array replaces the existing array; null or an empty array clears the list. */
    @maxItems(10)
    @TypeSpec.OpenAPI.extension("x-ms-identifiers", #["name"])
    monitoredResources?: ObservabilityAgentMonitoredResource[] | null;
  }

  /**
   * The request body used to update an observability agent resource.
   */
  model ObservabilityAgentPatch {
    ...Azure.ResourceManager.Foundations.TagsUpdateModel<ObservabilityAgentResource>;

    /** The managed service identities assigned to this resource. */
    ...ManagedServiceIdentityProperty;

    /** Updatable resource properties. */
    properties?: ObservabilityAgentPropertiesUpdate;
  }

  /**
   * An observability agent resource.
   */
  model ObservabilityAgentResource
    is Azure.ResourceManager.TrackedResource<ObservabilityAgentProperties> {
    ...ResourceNameParameter<
      Resource = ObservabilityAgentResource,
      KeyName = "observabilityAgentName",
      SegmentName = "observabilityAgents",
      NamePattern = "^(?=.{1,63}$)(?!-)[a-zA-Z0-9-]*[a-zA-Z0-9]$"
    >;
    ...ManagedServiceIdentityProperty;
  }
}
