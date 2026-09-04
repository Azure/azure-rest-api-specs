#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
namespace ContainerAppsSandbox {
  /** AuthorizeConnectionContent wire model. */
  model AuthorizeConnectionContent {
    /** parameterValues value. */
    parameterValues: Record<string>;
  }

  /** Request body for creating a connection. */
  model CreateConnectionContent {
    /** Connection name. */
    name: string;

    /** Connection type. */
    type: string;

    /** Customer-defined labels. */
    labels?: Record<string>;

    /** Parameter value set selected when creating the connection. */
    parameterValueSetName?: string;

    /** Sensitive parameter values supplied when creating the connection. */
    @secret
    parameterValueSetValues?: Record<string>;

    /** Runtime policy rules. */
    policyRules?: McpPolicyRule[];

    /** Enabled tool groups. */
    enabledToolGroups?: string[];
  }

  /** Customer-facing connection resource returned by the service. */
  model Connection {
    /** Connection identifier assigned by the service. */
    @visibility(Lifecycle.Read)
    id: ConnectionId;

    /** Connection name. */
    name: string;

    /** Connection type. */
    type: string;

    /** Current connection state. */
    @visibility(Lifecycle.Read)
    state: string;

    /** Customer-defined labels. */
    labels?: Record<string>;

    /** Creation timestamp assigned by the service. */
    @visibility(Lifecycle.Read)
    createdAt?: utcDateTime;

    /** Whether the connection can currently be deleted. */
    @visibility(Lifecycle.Read)
    deletable?: boolean;

    /** Sandboxes currently using this connection. */
    @visibility(Lifecycle.Read)
    usedBySandboxIds?: string[];

    /** Runtime policy rules. */
    policyRules?: McpPolicyRule[];

    /** Enabled tool groups. */
    enabledToolGroups?: string[];
  }

  /** GenerateConsentLinkContent wire model. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire property names are preserved from the source contract; C# names can be customized separately in client.tsp."
  model GenerateConsentLinkContent {
    /** redirectUrl value. */
    redirectUrl?: string;
  }

  /** Consent-link response body. */
  model GenerateConsentLinkResponse {
    /** consentLink value. */
    consentLink: string;
  }

  /** A runtime policy rule that activates a declared PolicyHookBinding. Supplied per-sandbox at creation time (e.g., "block mail to ceo@corp.com"). */
  model McpPolicyRule {
    /** References string PolicyHookBinding.Id on a tool. Must match a declared hook. */
    hookId: string;

    /** Glob patterns to match against extracted field values. For PolicyHookType.FieldValueDenyList: if ANY value matches ANY pattern, the call is blocked. For PolicyHookType.FieldValueAllowList: if ANY value matches NO pattern, the call is blocked. */
    patterns: string[];
  }

  /** UpdatePolicyRulesContent wire model. */
  model UpdatePolicyRulesContent {
    /** policyRules value. */
    policyRules: McpPolicyRule[];

    /** enabledToolGroups value. */
    enabledToolGroups?: string[];
  }
}
