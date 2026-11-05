import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Authorization;

/**
 * The type of policy definition. Possible values are NotSpecified, BuiltIn, Custom, and Static.
 */
union PolicyType {
  string,

  /**
   * The not specified policy definition type.
   */
  NotSpecified: "NotSpecified",

  /**
   * The built in policy definition type.
   */
  BuiltIn: "BuiltIn",

  /**
   * The custom policy definition type.
   */
  Custom: "Custom",

  /**
   * The static policy definition type.
   */
  Static: "Static",
}

/**
 * The data type of the parameter.
 */
union ParameterType {
  string,

  /**
   * The string parameter type.
   */
  String: "String",

  /**
   * The array parameter type.
   */
  Array: "Array",

  /**
   * The object parameter type.
   */
  Object: "Object",

  /**
   * The boolean parameter type.
   */
  Boolean: "Boolean",

  /**
   * The integer parameter type.
   */
  Integer: "Integer",

  /**
   * The float parameter type.
   */
  Float: "Float",

  /**
   * The date-time parameter type.
   */
  DateTime: "DateTime",
}

/**
 * The policy definition properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PolicyDefinitionProperties {
  /**
   * The type of policy definition. Possible values are NotSpecified, BuiltIn, Custom, and Static.
   */
  policyType?: PolicyType;

  /**
   * The policy definition mode. Some examples are All, Indexed, Microsoft.KeyVault.Data.
   */
  mode?: string = "Indexed";

  /**
   * The display name of the policy definition.
   */
  displayName?: string;

  /**
   * The policy definition description.
   */
  description?: string;

  /**
   * The policy rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  policyRule?: unknown;

  /**
   * The policy definition metadata.  Metadata is an open ended object and is typically a collection of key value pairs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  metadata?: unknown;

  /**
   * The parameter definitions for parameters used in the policy rule. The keys are the parameter names.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<ParameterDefinitionsValue>;

  /**
   * The policy definition version in #.#.# format.
   */
  version?: string;

  /**
   * A list of available versions for this policy definition.
   */
  versions?: string[];

  /**
   * The details of the source of external evaluation results required by the policy during enforcement evaluation.
   */
  externalEvaluationEnforcementSettings?: ExternalEvaluationEnforcementSettings;
}

/**
 * The definition of a parameter that can be provided to the policy.
 */
model ParameterDefinitionsValue {
  /**
   * The data type of the parameter.
   */
  type?: ParameterType;

  /**
   * The allowed values for the parameter.
   */
  allowedValues?: unknown[];

  /**
   * The default value for the parameter if no value is provided.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  defaultValue?: unknown;

  /**
   * Provides validation of parameter inputs during assignment using a self-defined JSON schema. This property is only supported for object-type parameters and follows the Json.NET Schema 2019-09 implementation. You can learn more about using schemas at https://json-schema.org/ and test draft schemas at https://www.jsonschemavalidator.net/.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  schema?: unknown;

  /**
   * General metadata for the parameter.
   */
  metadata?: ParameterDefinitionsValueMetadata;
}

/**
 * General metadata for the parameter.
 */
model ParameterDefinitionsValueMetadata {
  ...Record<unknown>;

  /**
   * The display name for the parameter.
   */
  displayName?: string;

  /**
   * The description of the parameter.
   */
  description?: string;

  /**
   * Used when assigning the policy definition through the portal. Provides a context aware list of values for the user to choose from.
   */
  strongType?: string;

  /**
   * Set to true to have Azure portal create role assignments on the resource ID or resource scope value of this parameter during policy assignment. This property is useful in case you wish to assign permissions outside the assignment scope.
   */
  assignPermissions?: boolean;
}

/**
 * The details of the source of external evaluation results required by the policy during enforcement evaluation.
 */
model ExternalEvaluationEnforcementSettings {
  /**
   * What to do when evaluating an enforcement policy that requires an external evaluation and the token is missing. Possible values are Audit and Deny and language expressions are supported.
   */
  missingTokenAction?: string;

  /**
   * The lifespan of the endpoint invocation result after which it's no longer valid. Value is expected to follow the ISO 8601 duration format and language expressions are supported.
   */
  resultLifespan?: string;

  /**
   * The settings of an external endpoint providing evaluation results.
   */
  endpointSettings?: ExternalEvaluationEndpointSettings;

  /**
   * An array of the role definition Ids the assignment's MSI will need in order to invoke the endpoint.
   */
  roleDefinitionIds?: string[];
}

/**
 * The settings of an external endpoint providing evaluation results.
 */
model ExternalEvaluationEndpointSettings {
  /**
   * The kind of the endpoint.
   */
  kind?: string;

  /**
   * The details of the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  details?: unknown;
}
