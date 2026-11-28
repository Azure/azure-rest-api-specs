import "./PolicyDefinitionContent.tsp";
import "./PolicyEvaluationModels.tsp";

using Azure.ResourceManager;
using PolicyInsightsCommon;

namespace PolicySimulationApi;

/** A hypothetical policy evaluation request. */
model SimulatePolicyContent {
  /** The hypothetical policy definition. Caller-supplied policy assignments are not supported. */
  simulatedAssignment: PolicySimulatedAssignment;

  /** The main resource. Its API version is required. Supply resourceId or an id in resourceContent. */
  resource: PolicySimulationResource;

  /** Related resources used to evaluate existence conditions. Supply resourceId or resourceContent.id; when both are supplied, they must match. Related resources must have the same resource type and subscription. */
  @identifiers(#[])
  relatedResources?: PolicySimulationResourceSource[];

  /** Existing policy assignments to combine with the hypothetical definition. Omit or set to null to include all existing policies; use an empty array to evaluate only the hypothetical definition. */
  @identifiers(#[])
  policyTargets?: PolicySimulationTarget[];
}

/** The hypothetical assignment synthesized by the service. */
model PolicySimulatedAssignment {
  /** A definition that does not already exist. Every declared parameter must have a defaultValue. */
  policyDefinition: PolicySimulationDefinition;
}

/** A hypothetical policy definition identified by a nonexisting policy definition resource ID. */
model PolicySimulationDefinition {
  ...OmitProperties<PolicyDefinitionContent, "id">;

  /** A fully qualified policy definition resource identifier that does not already exist. */
  @minLength(1)
  id: string;
}

/** A resource supplied inline or read from ARM. */
model PolicySimulationResourceSource {
  /** The resource identifier. If omitted, the service uses resourceContent.id. */
  resourceId?: string;

  /** The resource provider API version compatible with the supplied content. */
  apiVersion?: string;

  /** An inline resource object. If omitted for the main resource, the service reads the resource from ARM. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Simulation accepts resource objects from arbitrary resource providers, whose properties depend on the target resource type and API version."
  resourceContent?: Record<unknown>;
}

/** The main resource to evaluate. */
model PolicySimulationResource {
  ...OmitProperties<PolicySimulationResourceSource, "apiVersion">;

  /** The resource provider API version used to read or interpret the resource. */
  @minLength(1)
  apiVersion: string;
}

/** An existing policy assignment and optional definition filters. */
@withVisibility(Lifecycle.Read)
model PolicySimulationTarget {
  ...OmitProperties<PolicyInsightsApi.PolicyReference, "policyAssignmentId">;

  /** The policy assignment identifier. */
  policyAssignmentId: string;
}

/** The hypothetical policy evaluation result. */
model PolicySimulationResult {
  /** The evaluation results and any content updated by Modify effects. */
  policyEvaluationResult: PolicySimulationEvaluationResult;

  /** Request content after Modify effects are applied. No resource changes are persisted. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Modified request content retains the arbitrary resource provider JSON supplied for evaluation."
  updatedRequestContent?: unknown;
}

/** The collection of individual policy evaluations. */
model PolicySimulationEvaluationResult {
  /** Request content after policy modifications. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Modified request content retains the arbitrary resource provider JSON supplied for evaluation."
  updatedRequestContent?: unknown;

  /** Individual policy evaluation results. */
  @identifiers(#[])
  policyEvaluations?: PolicySimulationEvaluation[];
}

/** The result of evaluating one policy. */
model PolicySimulationEvaluation {
  /** The policy and assignment identifiers and metadata. */
  policyInfo: PolicySimulationPolicyInfo;

  /** The evaluation outcome. */
  evaluationResult: PolicySimulationOutcome;

  /** The deployment identifier associated with the evaluation, when applicable. */
  deploymentId?: string;

  /** The error encountered during evaluation. */
  error?: CommonTypes.ErrorDetail;

  /** Details of policy expression and effect evaluation. */
  evaluationDetails?: PolicySimulationEvaluationDetails;

  /** The compliance reason code. */
  complianceReasonCode?: string;

  /** Additional compliance-state details. */
  stateDetails?: PolicySimulationStateDetails;

  /** Details of the evaluated policy effect. */
  effectDetails?: PolicySimulationEffectDetails;
}

/** Metadata identifying an evaluated policy and its assignment. */
model PolicySimulationPolicyInfo {
  ...OmitProperties<PolicyInsightsApi.PolicyReference, "policyAssignmentId">;

  /** The policy set definition name. */
  policySetDefinitionName?: string;

  /** The policy set definition display name. */
  policySetDefinitionDisplayName?: string;

  /** The policy set definition version. */
  policySetDefinitionVersion?: string;

  /** The policy set definition category. */
  policySetDefinitionCategory?: string;

  /** The policy definition name. */
  policyDefinitionName?: string;

  /** The policy definition display name. */
  policyDefinitionDisplayName?: string;

  /** The policy definition version. */
  policyDefinitionVersion?: string;

  /** The policy definition effect. */
  policyDefinitionEffect?: string;

  /** The policy definition group names. */
  policyDefinitionGroupNames?: string[];

  /** The assignment identifier. The synthesized assignment is named simulatePolicy. */
  policyAssignmentId: string;

  /** The policy assignment name. */
  policyAssignmentName?: string;

  /** The policy assignment display name. */
  policyAssignmentDisplayName?: string;

  /** The policy assignment version. */
  policyAssignmentVersion?: string;

  /** The policy assignment scope. */
  policyAssignmentScope?: string;

  /** The evaluated resource location. */
  resourceLocation?: string;

  /** The management group ancestors. */
  ancestors?: string;

  /** The compliance reason code. */
  complianceReasonCode?: string;

  /** The policy exemption identifiers. */
  policyExemptionIds?: string[];
}

/** An individual policy evaluation outcome. */
union PolicySimulationOutcome {
  /** No specific outcome was set. */
  NotSpecified: "NotSpecified",

  /** The resource is noncompliant. */
  NonCompliant: "NonCompliant",

  /** Policy definitions conflict. */
  Conflict: "Conflict",

  /** The policy does not apply. */
  NotApplicable: "NotApplicable",

  /** The resource is compliant. */
  Compliant: "Compliant",

  /** Evaluation encountered an error. */
  Error: "Error",

  /** The resource is protected. */
  Protected: "Protected",

  /** The resource is exempt. */
  Exempt: "Exempt",

  /** Compliance is unknown. */
  Unknown: "Unknown",

  string,
}

/** Expression and effect details for an evaluated policy. */
model PolicySimulationEvaluationDetails {
  ...OmitProperties<
    PolicyInsightsApi.CheckRestrictionEvaluationDetails,
    "evaluatedExpressions" | "ifNotExistsDetails"
  >;

  /** Evaluated policy expressions. */
  @identifiers(#[])
  evaluatedExpressions?: PolicySimulationExpression[];

  /** Details of an existence-condition evaluation. */
  ifNotExistsDetails?: PolicySimulationIfNotExistsDetails;

  /** Details of a manual-effect evaluation. */
  manualDetails?: PolicySimulationManualDetails;

  /** Action-effect evaluation details. */
  actionDetails?: PolicySimulationActionDetails;

  /** Schema-effect evaluation details. */
  schemaDetails?: PolicySimulationSchemaDetails;

  /** Details of missing external evaluation results. */
  missingPolicyTokenDetails?: PolicySimulationMissingTokenDetails;

  /** Self-serve exemption details. */
  selfServeExemptionDetails?: PolicySimulationExemptionDetails;
}

/** The evaluation of a policy expression. */
model PolicySimulationExpression {
  ...OmitProperties<PolicyInsightsApi.ExpressionEvaluationDetails, "result">;

  /** The expression evaluation outcome. */
  result?: PolicySimulationExpressionOutcome;
}

/** A policy expression evaluation outcome. */
union PolicySimulationExpressionOutcome {
  /** No outcome was set. */
  NotSpecified: "NotSpecified",

  /** The expression evaluated to true. */
  True: "True",

  /** The expression evaluated to false. */
  False: "False",

  string,
}

/** Additional details for an existence condition. */
model PolicySimulationIfNotExistsDetails {
  ...PolicyInsightsApi.IfNotExistsEvaluationDetails;

  /** The URI used to obtain related resources. */
  requestUri?: url;

  /** The error code returned when obtaining related resources. */
  errorCode?: string;
}

/** Additional details for a manual effect. */
model PolicySimulationManualDetails {
  /** The attestation identifier responsible for the compliance state. */
  attestationId?: string;
}

/** Additional details for an action effect. */
model PolicySimulationActionDetails {
  /** The actions associated with the evaluation. */
  actionNames?: string[];
}

/** Additional details for a schema effect. */
model PolicySimulationSchemaDetails {
  /** JSON schema validation errors. */
  @identifiers(#[])
  schemaValidationErrors?: PolicySimulationSchemaError[];

  /** Tag prefixes that the caller cannot modify. */
  unauthorizedPrefixes?: string[];
}

/** A JSON schema validation error. */
model PolicySimulationSchemaError {
  /** The error type. */
  errorType?: string;

  /** The JSON property path. */
  path?: string;

  /** The JSON value that failed validation. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "A schema validation error can refer to any JSON value."
  value?: unknown;

  /** The JSON schema that generated the error. */
  schema?: string;

  /** The schema identifier. */
  schemaId?: string;
}

/** Missing external evaluation results needed to evaluate a policy condition. */
model PolicySimulationMissingTokenDetails {
  /** Whether the policy denies requests missing external evaluation results. */
  shouldDeny: boolean;

  /** Whether a change reference is required when acquiring a policy token. */
  isChangeReferenceRequired?: boolean;

  /** The endpoint kind configured in the policy definition. */
  endpointKind?: string;

  /** Arbitrary endpoint details configured in the policy definition. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External evaluation endpoint details are arbitrary JSON from the policy definition."
  endpointDetails?: unknown;

  /** The lifespan of the endpoint invocation result. */
  endpointResultLifespan?: string;
}

/** Self-serve exemption details. */
model PolicySimulationExemptionDetails {
  /** Whether self-serve exemptions are enabled. */
  isEnabled: boolean;

  /** Whether exemptions are enabled for the entire assignment. */
  isEnabledForEntireAssignment?: boolean;
}

/** Additional compliance-state details. */
model PolicySimulationStateDetails {
  /** Action names associated with the evaluation. */
  actionNames?: string[];

  /** The compliance reason code. */
  complianceReasonCode?: string;

  /** The compliance substate. */
  complianceSubState?: string;
}

/** The policy effect used during evaluation. */
model PolicySimulationEffectDetails {
  /** The evaluated policy effect. */
  policyEffect: PolicySimulationEffect;
}

/** Policy effects reported by evaluation. */
union PolicySimulationEffect {
  /** No effect. */
  None: "None",

  /** Audit a noncompliant resource. */
  Audit: "Audit",

  /** Deny a noncompliant request. */
  Deny: "Deny",

  /** Append values to the request. */
  Append: "Append",

  /** Modify values in the request. */
  Modify: "Modify",

  /** Audit when a related resource does not exist. */
  AuditIfNotExists: "AuditIfNotExists",

  /** Deploy when a related resource does not exist. */
  DeployIfNotExists: "DeployIfNotExists",

  /** Disable evaluation. */
  Disabled: "Disabled",

  /** Evaluate manual compliance. */
  Manual: "Manual",

  /** Deny an action. */
  DenyAction: "DenyAction",

  /** Evaluate supported capabilities. */
  SupportsCapability: "SupportsCapability",

  /** Enforce a schema. */
  EnforceSchema: "EnforceSchema",

  /** Audit a schema. */
  AuditSchema: "AuditSchema",

  /** Audit an action. */
  AuditAction: "AuditAction",

  string,
}
