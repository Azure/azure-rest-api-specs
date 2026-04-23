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

    /** The resource ID of the Azure Monitor workspace used as the issue container. */
    issueContainerId?: Azure.Core.armResourceIdentifier;

    /** Whether the observability agent is enabled. */
    enabled?: boolean;

    /** Comma-delimited list of operations that are disabled on this observability agent. Currently supported values: IssueCreation, Investigation. Additional values may be added in the future. */
    disabledOperations?: string;
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
      NamePattern = "^(?!-)[a-zA-Z0-9-]+[^-]$"
    >;
    ...ManagedServiceIdentityProperty;
  }
}
