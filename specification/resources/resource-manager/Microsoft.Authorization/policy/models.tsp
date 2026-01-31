import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Authorization;

/**
 * The policy assignment enforcement mode. Possible values are Default, DoNotEnforce, and Enroll
 */
union EnforcementMode {
  string,

  /**
   * The policy effect is enforced during resource creation or update.
   */
  Default: "Default",

  /**
   * The policy effect is not enforced during resource creation or update.
   */
  DoNotEnforce: "DoNotEnforce",

  /**
   * The policy effect is not enforced during resource creation or update until the resource or scope of the resource is enrolled to the assignment instance. Enrollment occurs upon deployment of the policy enrollment resource.
   */
  Enroll: "Enroll",
}

/**
 * The selector kind.
 */
union SelectorKind {
  string,

  /**
   * The selector kind to filter policies by the resource location.
   */
  resourceLocation: "resourceLocation",

  /**
   * The selector kind to filter policies by the resource type.
   */
  resourceType: "resourceType",

  /**
   * The selector kind to filter policies by the resource without location.
   */
  resourceWithoutLocation: "resourceWithoutLocation",

  /**
   * The selector kind to filter policies by the policy definition reference ID.
   */
  policyDefinitionReferenceId: "policyDefinitionReferenceId",
}

/**
 * The override kind.
 */
union OverrideKind {
  string,

  /**
   * It will override the policy effect type.
   */
  policyEffect: "policyEffect",

  /**
   * It will override the definition version property value of the policy assignment.
   */
  definitionVersion: "definitionVersion",
}

/**
 * The type of policy assignment. Possible values are NotSpecified, System, SystemHidden, and Custom. Immutable.
 */
union AssignmentType {
  string,

  /**
   * The not specified assignment type.
   */
  NotSpecified: "NotSpecified",

  /**
   * The system assignment type.
   */
  System: "System",

  /**
   * The system hidden assignment type.
   */
  SystemHidden: "SystemHidden",

  /**
   * The custom assignment type.
   */
  Custom: "Custom",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

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
 * The result of the completed token acquisition operation. Possible values are Succeeded and Failed.
 */
union PolicyTokenResult {
  string,

  /**
   * The token acquisition succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The token acquisition failed.
   */
  Failed: "Failed",
}

/**
 * The result of the external endpoint. Possible values are Succeeded and Failed.
 */
union ExternalEndpointResult {
  string,

  /**
   * The external endpoint succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The external endpoint failed.
   */
  Failed: "Failed",
}

/**
 * The effective outcome of the policy evaluation based on both the policy effect and evaluation result. Possible values are Unknown, Allow, Audit, Deny, Error.
 */
@added(Versions.v2025_11_01)
union PolicyAction {
  string,

  /**
   * The effective outcome of policy evaluation is unknown.
   */
  Unknown: "Unknown",

  /**
   * The effective outcome of policy evaluation is to allow the request.
  Allow: "Allow",

  /**
   * The effective outcome of policy evaluation is to audit the request.
   */
  Audit: "Audit",

  /**
   * The effective outcome of policy evaluation is to deny the request.
   */
  Deny: "Deny",

  /**
   * The policy evaluation resulted in an error.
   */
  Error: "Error",
}

/**
 * The identity type. This is the only required field when adding a system or user assigned identity to a resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  /**
   * Indicates that a system assigned identity is associated with the resource.
   */
  SystemAssigned,

  /**
   * Indicates that a system assigned identity is associated with the resource.
   */
  UserAssigned,

  /**
   * Indicates that no identity is associated with the resource or that the existing identity should be removed.
   */
  None,
}

/**
 * The policy assignment properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PolicyAssignmentProperties {
  /**
   * The display name of the policy assignment.
   */
  displayName?: string;

  /**
   * The ID of the policy definition or policy set definition being assigned.
   */
  policyDefinitionId?: string;

  /**
   * The version of the policy definition to use.
   */
  definitionVersion?: string;

  /**
   * The latest version of the policy definition available. This is only present if requested via the $expand query parameter.
   */
  @visibility(Lifecycle.Read)
  latestDefinitionVersion?: string;

  /**
   * The effective version of the policy definition in use. This is only present if requested via the $expand query parameter.
   */
  @visibility(Lifecycle.Read)
  effectiveDefinitionVersion?: string;

  /**
   * The scope for the policy assignment.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * The policy's excluded scopes.
   */
  notScopes?: string[];

  /**
   * The parameter values for the assigned policy rule. The keys are the parameter names.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<ParameterValuesValue>;

  /**
   * This message will be part of response in case of policy violation.
   */
  description?: string;

  /**
   * The policy assignment metadata. Metadata is an open ended object and is typically a collection of key value pairs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  metadata?: unknown;

  /**
   * The policy assignment enforcement mode. Possible values are Default, DoNotEnforce, and Enroll
   */
  enforcementMode?: EnforcementMode = EnforcementMode.Default;

  /**
   * The messages that describe why a resource is non-compliant with the policy.
   */
  @identifiers(#["message", "policyDefinitionReferenceId"])
  nonComplianceMessages?: NonComplianceMessage[];

  /**
   * The resource selector list to filter policies by resource properties.
   */
  @identifiers(#[])
  resourceSelectors?: ResourceSelector[];

  /**
   * The policy property value override.
   */
  @identifiers(#[])
  overrides?: Override[];

  /**
   * The type of policy assignment. Possible values are NotSpecified, System, SystemHidden, and Custom. Immutable.
   */
  assignmentType?: AssignmentType;

  /**
   * The instance ID of the policy assignment. This ID only and always changes when the assignment is deleted and recreated.
   */
  @visibility(Lifecycle.Read)
  instanceId?: string;

  /**
   * The self-serve exemption settings for the policy assignment.
   */
  @added(Versions.v2025_11_01)
  selfServeExemptionSettings?: SelfServeExemptionSettings;
}

/**
 * The self-serve exemption settings for a policy assignment.
 */
@added(Versions.v2025_11_01)
model SelfServeExemptionSettings {
  /**
   * Indicates whether self-serve exemption is enabled.
   */
  enabled?: boolean;

  /**
   * The policy definition reference IDs for self-serve exemption.
   */
  policyDefinitionReferenceIds?: string[];
}

/**
 * The value of a parameter.
 */
model ParameterValuesValue {
  /**
   * The value of the parameter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  value?: unknown;
}

/**
 * A message that describes why a resource is non-compliant with the policy. This is shown in 'deny' error messages and on resource's non-compliant compliance results.
 */
model NonComplianceMessage {
  /**
   * A message that describes why a resource is non-compliant with the policy. This is shown in 'deny' error messages and on resource's non-compliant compliance results.
   */
  message: string;

  /**
   * The policy definition reference ID within a policy set definition the message is intended for. This is only applicable if the policy assignment assigns a policy set definition. If this is not provided the message applies to all policies assigned by this policy assignment.
   */
  policyDefinitionReferenceId?: string;
}

/**
 * The resource selector to filter policies by resource properties.
 */
model ResourceSelector {
  /**
   * The name of the resource selector.
   */
  name?: string;

  /**
   * The list of the selector expressions.
   */
  @identifiers(#[])
  selectors?: Selector[];
}

/**
 * The selector expression.
 */
model Selector {
  /**
   * The selector kind.
   */
  kind?: SelectorKind;

  /**
   * The list of values to filter in.
   */
  in?: string[];

  /**
   * The list of values to filter out.
   */
  notIn?: string[];
}

/**
 * The policy property value override.
 */
model Override {
  /**
   * The override kind.
   */
  kind?: OverrideKind;

  /**
   * The value to override the policy property.
   */
  value?: string;

  /**
   * The list of the selector expressions.
   */
  @identifiers(#[])
  selectors?: Selector[];
}

/**
 * Identity for the resource.  Policy assignments support a maximum of one identity.  That is either a system assigned identity or a single user assigned identity.
 */
model Identity {
  /**
   * The principal ID of the resource identity.  This property will only be provided for a system assigned identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of the resource identity.  This property will only be provided for a system assigned identity
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type. This is the only required field when adding a system or user assigned identity to a resource.
   */
  type?: ResourceIdentityType;

  /**
   * The user identity associated with the policy. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The policy assignment for Patch request.
 */
model PolicyAssignmentUpdate {
  /**
   * The policy assignment properties for Patch request.
   */
  properties?: PolicyAssignmentUpdateProperties;

  /**
   * The location of the policy assignment. Only required when utilizing managed identity.
   */
  location?: string;

  /**
   * The managed identity associated with the policy assignment.
   */
  identity?: Identity;
}

/**
 * The policy assignment properties for Patch request.
 */
model PolicyAssignmentUpdateProperties {
  /**
   * The resource selector list to filter policies by resource properties.
   */
  @identifiers(#[])
  resourceSelectors?: ResourceSelector[];

  /**
   * The policy property value override.
   */
  @identifiers(#[])
  overrides?: Override[];

  /**
   * The self-serve exemption settings for the policy assignment.
   */
  @added(Versions.v2025_11_01)
  selfServeExemptionSettings?: SelfServeExemptionSettings;
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

/**
 * The policy definition properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PolicyDefinitionVersionProperties {
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
   * The details of the source of external evaluation results required by the policy during enforcement evaluation.
   */
  externalEvaluationEnforcementSettings?: ExternalEvaluationEnforcementSettings;
}

/**
 * The policy set definition properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PolicySetDefinitionProperties {
  /**
   * The type of policy set definition. Possible values are NotSpecified, BuiltIn, Custom, and Static.
   */
  policyType?: PolicyType;

  /**
   * The display name of the policy set definition.
   */
  displayName?: string;

  /**
   * The policy set definition description.
   */
  description?: string;

  /**
   * The policy set definition metadata.  Metadata is an open ended object and is typically a collection of key value pairs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  metadata?: unknown;

  /**
   * The policy set definition parameters that can be used in policy definition references.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<ParameterDefinitionsValue>;

  /**
   * An array of policy definition references.
   */
  @identifiers(#["policyDefinitionReferenceId"])
  policyDefinitions: PolicyDefinitionReference[];

  /**
   * The metadata describing groups of policy definition references within the policy set definition.
   */
  @identifiers(#["name"])
  policyDefinitionGroups?: PolicyDefinitionGroup[];

  /**
   * The policy set definition version in #.#.# format.
   */
  version?: string;

  /**
   * A list of available versions for this policy set definition.
   */
  versions?: string[];
}

/**
 * The policy definition reference.
 */
model PolicyDefinitionReference {
  /**
   * The ID of the policy definition or policy set definition.
   */
  policyDefinitionId: string;

  /**
   * The version of the policy definition to use.
   */
  definitionVersion?: string;

  /**
   * The latest version of the policy definition available. This is only present if requested via the $expand query parameter.
   */
  @visibility(Lifecycle.Read)
  latestDefinitionVersion?: string;

  /**
   * The effective version of the policy definition in use. This is only present if requested via the $expand query parameter.
   */
  @visibility(Lifecycle.Read)
  effectiveDefinitionVersion?: string;

  /**
   * The parameter values for the referenced policy rule. The keys are the parameter names.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<ParameterValuesValue>;

  /**
   * A unique id (within the policy set definition) for this policy definition reference.
   */
  policyDefinitionReferenceId?: string;

  /**
   * The name of the groups that this policy definition reference belongs to.
   */
  groupNames?: string[];
}

/**
 * The policy definition group.
 */
model PolicyDefinitionGroup {
  /**
   * The name of the group.
   */
  name: string;

  /**
   * The group's display name.
   */
  displayName?: string;

  /**
   * The group's category.
   */
  category?: string;

  /**
   * The group's description.
   */
  description?: string;

  /**
   * A resource ID of a resource that contains additional metadata about the group.
   */
  additionalMetadataId?: string;
}

/**
 * The policy set definition properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PolicySetDefinitionVersionProperties {
  /**
   * The type of policy definition. Possible values are NotSpecified, BuiltIn, Custom, and Static.
   */
  policyType?: PolicyType;

  /**
   * The display name of the policy set definition.
   */
  displayName?: string;

  /**
   * The policy set definition description.
   */
  description?: string;

  /**
   * The policy set definition metadata.  Metadata is an open ended object and is typically a collection of key value pairs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  metadata?: unknown;

  /**
   * The policy set definition parameters that can be used in policy definition references.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<ParameterDefinitionsValue>;

  /**
   * An array of policy definition references.
   */
  @identifiers(#["policyDefinitionReferenceId"])
  policyDefinitions: PolicyDefinitionReference[];

  /**
   * The metadata describing groups of policy definition references within the policy set definition.
   */
  @identifiers(#["name"])
  policyDefinitionGroups?: PolicyDefinitionGroup[];

  /**
   * The policy set definition version in #.#.# format.
   */
  version?: string;
}

/**
 * The policy token request properties.
 */
model PolicyTokenRequest {
  /**
   * The resource operation to acquire a token for.
   */
  operation: PolicyTokenOperation;

  /**
   * The change reference.
   */
  changeReference?: string;
}

/**
 * The resource operation to acquire a token for.
 */
model PolicyTokenOperation {
  /**
   * The request URI of the resource operation.
   */
  uri: string;

  /**
   * The http method of the resource operation.
   */
  httpMethod: string;

  /**
   * The payload of the resource operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  content?: unknown;
}

/**
 * The policy token response properties.
 */
model PolicyTokenResponse {
  /**
   * The result of the completed token acquisition operation. Possible values are Succeeded and Failed.
   */
  result?: PolicyTokenResult;

  /**
   * The external evaluation request details.
   */
  @added(Versions.v2025_11_01)
  requestDetails?: PolicyTokenEvaluatedRequestDetails;

  /**
   * Status message with additional details about the token acquisition operation result.
   */
  message?: string;

  /**
   * The date and time after which the client can try to acquire a token again in the case of retry-able failures.
   */
  retryAfter?: utcDateTime;

  /**
   * An array of external evaluation endpoint invocation results.
   */
  @identifiers(#[])
  results?: ExternalEvaluationEndpointInvocationResult[];

  /**
   * The change reference associated with the operation for which the token is acquired.
   */
  changeReference?: string;

  /**
   * The issued policy token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  token?: string;

  /**
   * The unique Id assigned to the policy token.
   */
  tokenId?: string;

  /**
   * The expiration of the policy token.
   */
  expiration?: utcDateTime;
}

/**
 * The external evaluation endpoint invocation results.
 */
model ExternalEvaluationEndpointInvocationResult {
  /**
   * The details of the policy requiring the external endpoint invocation.
   */
  policyInfo?: PolicyLogInfo;

  /**
   * The result of the external endpoint. Possible values are Succeeded and Failed.
   */
  result?: ExternalEndpointResult;

  /**
   * The external evaluation endpoint kind.
   */
  @added(Versions.v2025_11_01)
  endpointKind?: string;

  /**
   * The status message with additional details about the invocation result.
   */
  message?: string;

  /**
   * The date and time after which a failed endpoint invocation can be retried.
   */
  retryAfter?: utcDateTime;

  /**
   * The set of claims that will be attached to the policy token as an attestation for the result of the endpoint invocation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  claims?: unknown;

  /**
   * The effective outcome of the policy evaluation based on both the policy effect and evaluation result. Possible values are Unknown, Allow, Audit, Deny, Error.
   */
  @added(Versions.v2025_11_01)
  policyAction?: PolicyAction;

  /**
   * The evaluation details returned by the policy evaluation engine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  @added(Versions.v2025_11_01)
  policyEvaluationDetails?: unknown;

  /**
   * The endpoint specific metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  @added(Versions.v2025_11_01)
  additionalInfo?: unknown;

  /**
   * The expiration of the results.
   */
  expiration?: utcDateTime;
}

/**
 * The policy token evaluated request details.
 */
@added(Versions.v2025_11_01)
model PolicyTokenEvaluatedRequestDetails {
  /**
   * The request URI of the resource operation that is targeted by the issued token.
   */
  uri: string;

  /**
   * The resource Id of the resource operation that is targeted by the issued token.
   */
  resourceId: string;

  /**
   * The api-version of the resource operation that is targeted by the issued token.
   */
  apiVersion: string;

  /**
   * The authorization action of the resource operation that is targeted by the issued token.
   */
  authorizationAction: string;

  /**
   * The http method of the resource operation that is targeted by the issued token.
   */
  httpMethod: string;

  /**
   * The hashed payload of the resource operation that is targeted by the issued token.
   */
  contentHash: string;
}

/**
 * The policy log info.
 */
model PolicyLogInfo {
  /**
   * The policy definition Id.
   */
  policyDefinitionId?: string;

  /**
   * The policy set definition Id.
   */
  policySetDefinitionId?: string;

  /**
   * The policy definition instance Id inside a policy set.
   */
  policyDefinitionReferenceId?: string;

  /**
   * The policy set definition name.
   */
  policySetDefinitionName?: string;

  /**
   * The policy set definition display name.
   */
  policySetDefinitionDisplayName?: string;

  /**
   * The policy set definition version.
   */
  policySetDefinitionVersion?: string;

  /**
   * The policy set definition category.
   */
  policySetDefinitionCategory?: string;

  /**
   * The policy definition name.
   */
  policyDefinitionName?: string;

  /**
   * The policy definition display name.
   */
  policyDefinitionDisplayName?: string;

  /**
   * The policy definition version.
   */
  policyDefinitionVersion?: string;

  /**
   * The policy definition action.
   */
  policyDefinitionEffect?: string;

  /**
   * An array of policy definition group names.
   */
  policyDefinitionGroupNames?: string[];

  /**
   * The policy assignment Id.
   */
  policyAssignmentId?: string;

  /**
   * The policy assignment name.
   */
  policyAssignmentName?: string;

  /**
   * The policy assignment display name.
   */
  policyAssignmentDisplayName?: string;

  /**
   * The policy assignment version.
   */
  policyAssignmentVersion?: string;

  /**
   * The policy assignment scope.
   */
  policyAssignmentScope?: string;

  /**
   * The resource location.
   */
  resourceLocation?: string;

  /**
   * The management group ancestors.
   */
  ancestors?: string;

  /**
   * The policy compliance reason code.
   */
  complianceReasonCode?: string;

  /**
   * An array of policy exemption Ids.
   */
  policyExemptionIds?: string[];
}
