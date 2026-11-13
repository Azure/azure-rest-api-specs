import "./PolicyDefinitionContent.tsp";
import "@typespec/openapi";

using Azure.ResourceManager;
using PolicyInsightsCommon;

namespace PolicyAuthoringApi;

/** Input for retrieving a policy authoring reference. */
model GeneratePolicyAuthoringGuideContent {
  /** The policy question or authoring intent. */
  @minLength(1)
  userQuestion: string;

  /** An optional exact ARM resource type used to filter aliases. */
  resourceType?: string;

  /** Optional conversation history. It is validated but is not used to retrieve the authoring guide. */
  @identifiers(#[])
  history?: PolicyAuthoringHistory[];
}

/** A previous conversation message. System-role messages are not accepted. */
model PolicyAuthoringHistory {
  /** The message text. */
  content: string;

  /** The message role. */
  role: PolicyAuthoringRole;

  /** An optional system prompt identifier associated with the previous message. */
  systemPromptId?: string;
}

/** Accepted roles in caller-supplied history. */
union PolicyAuthoringRole {
  /** A user message. */
  User: "User",

  /** An assistant message. */
  Assistant: "Assistant",

  string,
}

/** Retrieved policy authoring reference material. */
model PolicyAuthoringGuideResult {
  /** Markdown reference material covering rule, effect, mode, and parameter syntax. */
  syntaxGuides?: string;

  /** Aliases relevant to the question, ordered by relevance. Available metadata depends on the retrieval mode. */
  @identifiers(#["aliasName"])
  relevantAliases?: PolicyAuthoringAlias[];

  /** Relevant if-condition examples. */
  @identifiers(#[])
  relevantRuleExamples?: PolicyAuthoringRuleExample[];

  /** Relevant then-block examples. */
  @identifiers(#[])
  relevantEffectExamples?: PolicyAuthoringEffectExample[];
}

/** An Azure Policy alias and its available retrieval metadata. */
model PolicyAuthoringAlias {
  /** The narrative document identifier. */
  id?: string;

  /** The Azure Policy alias name. */
  aliasName: string;

  /** A description of the alias. */
  aliasDescription?: string;

  /** An explanation of the alias and its usage. */
  aliasNarrative?: string;

  /** The source used to construct the narrative. */
  narrativeSource?: string;

  /** The ARM resource type. */
  resourceType?: string;

  /** All ARM resource types associated with the alias. */
  resourceTypes?: string[];

  /** The default ARM property path. */
  propertyPath?: string;

  /** Resource-type, property-path, and API-version mappings. */
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
  paths?: unknown[];

  /** The alias value type. */
  valueType?: string;

  /** The allowed alias values. */
  allowedValues?: string[];

  /** The derived path classification. */
  derivedPathType?: string;

  /** Built-in policy usage examples. */
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
  policyExamples?: unknown[];

  /** The source of policy examples. */
  exampleSource?: string;

  /** Whether the alias has one stable path across API versions. */
  isStableAlias?: boolean;

  /** A summary of API-version behavior. */
  apiVersionsSummary?: string;

  /** The latest API version supporting the alias. */
  latestApiVersion?: string;

  /** The application-level relevance score. */
  retrievalScore?: float64;

  /** The retrieval technique that found the alias. */
  retrievalSource?: string;
}

/** An example policy rule if-condition. */
model PolicyAuthoringRuleExample {
  /** A description of the example. */
  description?: string;

  /** The if-condition encoded as a JSON string. */
  ifCondition?: string;

  /** Parameter definitions encoded as a JSON string, when applicable. */
  parameterExample?: string;
}

/** An example policy effect then-block. */
model PolicyAuthoringEffectExample {
  /** A description of the example. */
  description?: string;

  /** The then-block encoded as a JSON string. */
  thenBlock?: string;

  /** Parameter definitions encoded as a JSON string, when applicable. */
  parameterExample?: string;
}

/** Input for verifying a policy definition. */
model VerifyPolicyContent {
  /** The policy definition to validate and lint. */
  policyDefinition: PolicyDefinitionContent;

  /** Linter rule-set names. Omit to use the service defaults. Unsupported names cause a bad-request response. */
  ruleSets?: string[];
}

/** The result of policy definition validation and linting. */
model PolicyVerificationResult {
  /** The outcome of verification. */
  verificationResult: PolicyVerificationOutcome;

  /** Phase-specific guidance for correcting the policy. */
  revisionGuidance?: string;

  /** Structural validation failures. Linting is skipped when validation fails. */
  validationErrors?: string[];

  /** Issues reported by the linter after successful validation. */
  @identifiers(#[])
  lintIssues?: PolicyLintIssue[];
}

/** The outcome of policy verification. */
union PolicyVerificationOutcome {
  /** Validation and linting succeeded. */
  AllValid: "AllValid",

  /** Structural validation failed. */
  FailedValidation: "FailedValidation",

  /** Validation succeeded, but linting reported issues. */
  FailedLinting: "FailedLinting",

  string,
}

/** An issue reported by policy linting. */
model PolicyLintIssue {
  /** The rule identifier. */
  ruleIdentifier?: string;

  /** The issue title. */
  title?: string;

  /** The issue category. */
  category?: PolicyLintCategory;

  /** The issue severity. */
  severity?: PolicyLintSeverity;

  /** The source line number, when available. */
  lineNumber?: int32;

  /** The source column, when available. */
  linePosition?: int32;

  /** A description of the issue. */
  description?: string;

  /** The policy property path. */
  path?: string;

  /** The rule documentation URL. */
  documentationUrl?: string;
}

/** Categories of policy lint issues. */
union PolicyLintCategory {
  /** Unknown category. */
  Unknown: "Unknown",

  /** Test-related issue. */
  Test: "Test",

  /** Linter-related issue. */
  Linter: "Linter",

  /** Linter-rule issue. */
  LinterRule: "LinterRule",

  /** Parsing issue. */
  Parsing: "Parsing",

  /** Resource-field issue. */
  ResourceFields: "ResourceFields",

  /** Best-practice issue. */
  BestPractices: "BestPractices",

  /** Miscellaneous issue. */
  Misc: "Misc",

  string,
}

/** Severity of a policy lint issue. */
union PolicyLintSeverity {
  /** Unknown severity. */
  Unknown: "Unknown",

  /** Informational issue. */
  Informational: "Informational",

  /** A warning-level issue. */
  Warning: "Warning",

  /** An error-level issue. */
  Error: "Error",

  /** Critical issue. */
  Critical: "Critical",

  string,
}
