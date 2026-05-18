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
    monitoringAccountId: Azure.Core.armResourceIdentifier<[
      {
        type: "Microsoft.Monitor/accounts";
      }
    ]>;

    /** Whether the observability agent is enabled. Defaults to true when not specified. */
    enabled?: boolean;

    /** Configuration overrides for agent operations. When omitted, default behavior applies for all operations. */
    operations?: AgentOperations;
  }

  /**
   * Execution mode for a specific agent operation.
   */
  union OperationMode {
    /** The operation runs autonomously. */
    auto: "Auto",

    /** The operation runs only when triggered manually. */
    manual: "Manual",

    string,
  }

  /**
   * Configuration for agent operations.
   */
  model AgentOperations {
    /** Settings for the issue creation operation. */
    issueCreation?: OperationSettings;

    /** Settings for the investigation operation. */
    investigation?: OperationSettings;
  }

  /**
   * Settings for a specific agent operation.
   */
  model OperationSettings {
    /** Execution mode for this operation. Defaults to Auto when not specified. */
    mode?: OperationMode;

    /** Custom instructions that guide the agent's behavior for this operation. */
    @maxLength(8192)
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
