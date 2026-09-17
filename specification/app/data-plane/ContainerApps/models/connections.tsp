using Rest;

namespace ContainerAppsSandbox {
  /** Parameters used to authorize a connection. */
  model AuthorizeConnectionContent {
    /** Provider-specific authorization parameters. */
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
  @resource("connections")
  @parentResource(SandboxGroupScope)
  model Connection {
    /** Connection identifier assigned by the service. */
    @key("id")
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

  /** Options for generating a connection consent link. */
  model GenerateConsentLinkContent {
    /** The URI to redirect to after consent completes. */
    redirectUrl?: string;
  }

  /** Consent link generated for connection authorization. */
  model GenerateConsentLinkResponse {
    /** The URL where a user grants consent for the connection. */
    consentLink: string;
  }

  /** A runtime policy rule that activates a declared PolicyHookBinding. Supplied per-sandbox at creation time (e.g., "block mail to ceo@corp.com"). */
  model McpPolicyRule {
    /** References string PolicyHookBinding.Id on a tool. Must match a declared hook. */
    hookId: string;

    /** Glob patterns used to allow or deny calls based on extracted field values. */
    patterns: string[];
  }

  /** Policy and tool settings to apply to a connection. */
  model UpdatePolicyRulesContent {
    /** Runtime policy rules for connection tool calls. */
    policyRules: McpPolicyRule[];

    /** Tool groups enabled for the connection. */
    enabledToolGroups?: string[];
  }
}
