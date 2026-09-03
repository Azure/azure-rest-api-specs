namespace ContainerAppsSandbox {
  /** AuthorizeConnectionContent wire model. */
  model AuthorizeConnectionContent {
    /** parameterValues value. */
    parameterValues: Record<string>;
  }

  /** ConnectionCreateContent wire model. */
  model ConnectionCreateContent {
    /** name value. */
    name: string;

    /** type value. */
    type: string;

    /** labels value. */
    labels?: Record<string>;

    /** parameterValueSetName value. */
    parameterValueSetName?: string;

    /** parameterValueSetValues value. */
    parameterValueSetValues?: Record<string>;

    /** policyRules value. */
    policyRules?: McpPolicyRule[];

    /** enabledToolGroups value. */
    enabledToolGroups?: string[];
  }

  /** Connection wire model. */
  model Connection {
    /** id value. */
    id: ConnectionId;

    /** name value. */
    name: string;

    /** type value. */
    type: string;

    /** state value. */
    state: string;

    /** labels value. */
    labels?: Record<string>;

    /** createdAt value. */
    createdAt?: utcDateTime;

    /** deletable value. */
    deletable?: boolean;

    /** usedBySandboxIds value. */
    usedBySandboxIds?: string[];

    /** policyRules value. */
    policyRules?: McpPolicyRule[];

    /** enabledToolGroups value. */
    enabledToolGroups?: string[];
  }

  /** GenerateConsentLinkContent wire model. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire property names are preserved from the source contract; C# names can be customized separately in client.tsp."
  model GenerateConsentLinkContent {
    /** redirectUrl value. */
    redirectUrl?: string;
  }

  /** GenerateConsentLinkResult wire model. */
  model GenerateConsentLinkResult {
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
