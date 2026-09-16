using Rest;

namespace ContainerAppsSandbox {
  /** Customer-facing named egress policy resource. */
  @resource("egressPolicies")
  @parentResource(SandboxGroupScope)
  model NamedEgressPolicy {
    /** Policy identifier assigned by the service. */
    @key("policyId")
    @visibility(Lifecycle.Read)
    id: string;

    /** name value. */
    name: string;

    /** description value. */
    description?: string;

    /** defaultAction value. */
    defaultAction: EgressPolicyAction;

    /** enforcementMode value. */
    enforcementMode?: EgressPolicyEnforcementMode;

    /** rules value. */
    rules?: EgressPolicyRule[];

    /** Creation timestamp assigned by the service. */
    @visibility(Lifecycle.Read)
    createdAt?: utcDateTime;

    /** Last-update timestamp assigned by the service. */
    @visibility(Lifecycle.Read)
    updatedAt?: utcDateTime;
  }
}
