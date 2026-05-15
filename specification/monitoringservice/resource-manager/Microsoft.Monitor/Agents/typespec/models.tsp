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

    /** Resource ID of the Azure Monitor workspace where this agent stores the issues it produces. */
    monitoringAccountId: Azure.Core.armResourceIdentifier<[{type: "Microsoft.Monitor/accounts"}]>;

    /** Whether the observability agent is enabled. Defaults to true when not specified. */
    enabled?: boolean;

    /** List of autonomous operations that are disabled on this observability agent. When omitted, no autonomous operations are disabled. Currently supported values: AutoInvestigate. Additional values may be added in the future. */
    disableAutonomousOperations?: AutonomousOperation[];

    /** Configuration overrides for agent operations. When omitted, default behavior applies for all operations. */
    operations?: AgentOperations;
  }

  /**
   * Autonomous operations supported by an observability agent.
   */
  union AutonomousOperation {
    /** AI-driven autonomous investigation of detected issues. */
    autoInvestigate: "AutoInvestigate",
    string,
  }

  /**
   * Configuration for agent operations.
   */
  model AgentOperations {
    /** Settings for the issue creation operation. */
    issueCreation?: OperationSettings;
  }

  /**
   * Settings for a specific agent operation.
   */
  model OperationSettings {
    /** Custom instructions that guide the agent's behavior for this operation. */
    @maxLength(4096)
    customInstructions?: string;
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
