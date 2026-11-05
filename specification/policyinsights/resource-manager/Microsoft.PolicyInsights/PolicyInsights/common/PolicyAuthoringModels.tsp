import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace PolicyInsightsCommon;

/** A policy definition supplied for verification or hypothetical evaluation. */
model PolicyAuthoringDefinition {
  /** The policy definition resource identifier. */
  id?: string;

  /** The resource name. */
  name?: string;

  /** The resource type. */
  type?: string;

  /** Resource SKU information. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The policy resource envelope accepts SKU information as an arbitrary JSON value."
  sku?: unknown;

  /** The resource kind. */
  kind?: string;

  /** The identifier of the resource managing this definition. */
  managedBy?: string;

  /** The resource entity tag. */
  etag?: string;

  /** The resource location. */
  location?: string;

  /** Resource creation and modification information. */
  systemData?: CommonTypes.SystemData;

  /** The policy definition properties. */
  properties: PolicyAuthoringDefinitionProperties;
}

/** Properties of a policy definition supplied by the caller. */
model PolicyAuthoringDefinitionProperties {
  /** The display name. */
  displayName?: string;

  /** The policy type. */
  policyType?: string;

  /** The policy evaluation mode. */
  mode?: string;

  /** The policy description. */
  description?: string;

  /** Arbitrary policy metadata. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Azure Policy metadata is caller-defined JSON, not a fixed service schema."
  metadata?: unknown;

  /** The policy definition version. */
  version?: string;

  /** Parameter definitions, indexed by parameter name. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Policy parameter names are caller-defined dictionary keys."
  parameters?: Record<PolicyAuthoringParameter>;

  /** The policy rule, including its if condition and then effect. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Azure Policy rules are expressions in the Policy JSON language and cannot be described by a fixed resource schema."
  policyRule: unknown;

  /** The available policy definition versions. */
  versions?: string[];

  /** Settings for external evaluation results used during enforcement. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The Policy definition contract accepts these enforcement settings as arbitrary JSON."
  externalEvaluationEnforcementSettings?: unknown;
}

/** A parameter declared by a policy definition. */
model PolicyAuthoringParameter {
  /** The parameter value type. */
  type: string;

  /** Arbitrary parameter metadata. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Policy parameter metadata is caller-defined JSON."
  metadata?: unknown;

  /** The allowed parameter values. */
  allowedValues?: unknown[];

  /** The default parameter value. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The JSON value type depends on the caller-defined parameter type."
  defaultValue?: unknown;

  /** A JSON schema used to validate object parameter values. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "This property contains a caller-defined JSON schema, not a fixed ARM resource schema."
  schema?: unknown;
}
