using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Monitor;

/** Advisory identity role inspection before creating an observability agent. */
@autoRoute
@armResourceOperations
interface Locations {
  /**
   * Inspects whether a user-assigned managed identity has the Monitoring Contributor role
   * at each target subscription or an applicable inherited scope, using the caller's delegated
   * authorization. Use this route when the agent's resource group already exists; the caller
   * needs Microsoft.Monitor/observabilityAgents/read at that resource group or an ancestor.
   * The location selects regional routing and is not a role-assignment target.
   * Returns HTTP 200 for present, missing, and unverifiable role outcomes. This advisory action
   * neither creates an agent nor enforces creation, and does not evaluate effective permissions.
   */
  @action("validateObservabilityAgentIdentityAccess")
  validateObservabilityAgentIdentityAccessAtResourceGroup is ArmProviderActionSync<
    ObservabilityAgentIdentityAccessContent,
    ArmResponse<ObservabilityAgentIdentityAccessResult>,
    {},
    LocationResourceParameter,
    ObservabilityAgentIdentityAccessError
  >;

  /**
   * Inspects whether a user-assigned managed identity has the Monitoring Contributor role
   * at each target subscription or an applicable inherited scope, using the caller's delegated
   * authorization. Use this route before the agent's resource group exists; the caller needs
   * Microsoft.Monitor/observabilityAgents/read at the subscription or an ancestor.
   * The location selects regional routing and is not a role-assignment target.
   * Returns HTTP 200 for present, missing, and unverifiable role outcomes. This advisory action
   * neither creates an agent nor enforces creation, and does not evaluate effective permissions.
   */
  @action("validateObservabilityAgentIdentityAccess")
  validateObservabilityAgentIdentityAccessAtSubscription is ArmProviderActionSync<
    ObservabilityAgentIdentityAccessContent,
    ArmResponse<ObservabilityAgentIdentityAccessResult>,
    SubscriptionActionScope,
    LocationResourceParameter,
    ObservabilityAgentIdentityAccessError
  >;
}
