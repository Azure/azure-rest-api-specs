import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using Azure.ResourceManager;

namespace PolicyInsightsCommon;

/** A policy definition supplied for verification or hypothetical evaluation. */
@withVisibility(Lifecycle.Read)
model PolicyDefinitionContent {
  ...OmitProperties<
    ProxyResource<PolicyDefinitionContentProperties>,
    "properties"
  >;

  /** The definition properties. */
  properties: PolicyDefinitionContentProperties;
}

/** Policy definition properties with the required verification inputs. */
model PolicyDefinitionContentProperties {
  /** The definition type, such as BuiltIn, Custom, or Static. */
  policyType?: PolicyType;

  /** The policy evaluation mode. */
  mode?: string;

  /** The display name of the policy definition. */
  displayName?: string;

  /** The policy definition description. */
  description?: string;

  /** The policy rule, including its if condition and then effect. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Azure Policy rules use the existing Policy JSON expression language."
  policyRule: unknown;

  /** Open-ended policy definition metadata. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Policy metadata contains caller-defined JSON values, matching the existing policy definition contract."
  metadata?: unknown;

  /** Parameter definitions, indexed by caller-defined parameter names. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Policy parameter names are caller-defined dictionary keys."
  parameters?: Record<PolicyDefinitionParameter>;

  /** The policy definition version in #.#.# format. */
  version?: string;

  /** Available versions of the policy definition. */
  versions?: string[];

  /** The source of external evaluation results required during enforcement. */
  externalEvaluationEnforcementSettings?: ExternalEvaluationEnforcementSettings;
}

/** A policy parameter definition with its required value type. */
model PolicyDefinitionParameter {
  /** The parameter value type. */
  type: ParameterType;

  /** The allowed parameter values, which may be any JSON type. */
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
  allowedValues?: unknown[];

  /** The default parameter value. Every simulation parameter must supply a default. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Parameter defaults can be any JSON type supported by the policy parameter's declared type."
  defaultValue?: unknown;

  /** A JSON schema validating object-type parameter inputs. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Object parameters support caller-defined JSON schemas, matching the existing policy definition contract."
  schema?: unknown;

  /** General parameter metadata. */
  metadata?: ParameterDefinitionsValueMetadata;
}

/** The type of policy definition. */
union PolicyType {
  /** A definition without a specified type. */
  NotSpecified: "NotSpecified",

  /** A built-in policy definition. */
  BuiltIn: "BuiltIn",

  /** A custom policy definition. */
  Custom: "Custom",

  /** A static policy definition. */
  Static: "Static",

  string,
}

/** The data type of a policy parameter. */
union ParameterType {
  /** A string parameter. */
  String: "String",

  /** An array parameter. */
  Array: "Array",

  /** An object parameter. */
  Object: "Object",

  /** A boolean parameter. */
  Boolean: "Boolean",

  /** An integer parameter. */
  Integer: "Integer",

  /** A floating-point parameter. */
  Float: "Float",

  /** A date-time parameter. */
  DateTime: "DateTime",

  string,
}

/** General metadata for a policy parameter. */
model ParameterDefinitionsValueMetadata {
  ...Record<unknown>;

  /** The display name for the parameter. */
  displayName?: string;

  /** The description of the parameter. */
  description?: string;

  /** A context-aware list of values used when assigning the definition through the portal. */
  strongType?: string;

  /** Whether the portal should create role assignments on the parameter's resource ID or scope. */
  assignPermissions?: boolean;
}

/** The source of external evaluation results required during enforcement. */
model ExternalEvaluationEnforcementSettings {
  /** The action when an external evaluation token is missing. Supports Audit, Deny, and policy expressions. */
  missingTokenAction?: string;

  /** The endpoint result lifespan, as an ISO 8601 duration or policy expression. */
  resultLifespan?: string;

  /** Settings for the external evaluation endpoint. */
  endpointSettings?: ExternalEvaluationEndpointSettings;

  /** Role definition IDs required by the assignment's managed identity to invoke the endpoint. */
  roleDefinitionIds?: string[];
}

/** Settings for an external evaluation endpoint. */
model ExternalEvaluationEndpointSettings {
  /** The endpoint kind. */
  kind?: string;

  /** Endpoint-specific details. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External evaluation endpoint details depend on the endpoint kind, matching the existing policy definition contract."
  details?: unknown;
}
