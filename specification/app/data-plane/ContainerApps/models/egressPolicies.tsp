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

    /** The policy name. */
    name: string;

    /** A description of the policy. */
    description?: string;

    /** The action applied when no rule matches. */
    defaultAction: EgressPolicyAction;

    /** Whether policy decisions are enforced or only audited. */
    enforcementMode?: EgressPolicyEnforcementMode;

    /** Ordered egress rules evaluated by the policy. */
    rules?: EgressPolicyRule[];

    /** Creation timestamp assigned by the service. */
    @visibility(Lifecycle.Read)
    createdAt?: utcDateTime;

    /** Last-update timestamp assigned by the service. */
    @visibility(Lifecycle.Read)
    updatedAt?: utcDateTime;
  }
}
