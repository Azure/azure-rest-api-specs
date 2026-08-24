namespace AzureDevCompute {
  /** NamedEgressPolicyListResponse wire model. */
  model NamedEgressPolicyListResponse {
    /** egressPolicies value. */
    egressPolicies: NamedEgressPolicyResponse[];
  }

  /** NamedEgressPolicyResponse wire model. */
  model NamedEgressPolicyResponse {
    /** id value. */
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

    /** createdAt value. */
    createdAt?: utcDateTime;

    /** updatedAt value. */
    updatedAt?: utcDateTime;
  }

  /** NamedEgressPolicyUpsert wire model. */
  model NamedEgressPolicyUpsert {
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
  }
}
