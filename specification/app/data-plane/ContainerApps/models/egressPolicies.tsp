#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
namespace ContainerAppsSandbox {
  /** Named egress policy list response body. */
  model NamedEgressPolicyListResponse {
    /** Egress policies returned by the request. */
    @pageItems
    value: NamedEgressPolicy[];

    /** Link to the next page of egress policies, if one is available. */
    @nextLink
    nextLink?: string;
  }

  /** Customer-facing named egress policy resource. */
  model NamedEgressPolicy {
    /** Policy identifier assigned by the service. */
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
