import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace PolicyInsightsApi;

/**
 * Evaluation details of policy language expressions.
 */
model ExpressionEvaluationDetails {
  /**
   * Evaluation result.
   */
  result?: string;

  /**
   * Expression evaluated.
   */
  expression?: string;

  /**
   * The kind of expression that was evaluated.
   */
  @visibility(Lifecycle.Read)
  expressionKind?: string;

  /**
   * Property path if the expression is a field or an alias.
   */
  path?: string;

  /**
   * Value of the expression.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expressionValue?: unknown;

  /**
   * Target value to be compared with the expression value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetValue?: unknown;

  /**
   * Operator to compare the expression value and the target value.
   */
  operator?: string;
}

/**
 * Evaluation details of IfNotExists effect.
 */
model IfNotExistsEvaluationDetails {
  /**
   * ID of the last evaluated resource for IfNotExists effect.
   */
  resourceId?: string;

  /**
   * Total number of resources to which the existence condition is applicable.
   */
  totalResources?: int32;
}

/**
 * Resource identifiers for a policy.
 */
model PolicyReference {
  /**
   * The resource identifier of the policy definition.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionId?: string;

  /**
   * The resource identifier of the policy set definition.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionId?: string;

  /**
   * The reference identifier of a specific policy definition within a policy set definition.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionReferenceId?: string;

  /**
   * The resource identifier of the policy assignment.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentId?: string;
}

/**
 * Policy evaluation details.
 */
model CheckRestrictionEvaluationDetails {
  /**
   * Details of the evaluated expressions.
   */
  @identifiers(#[])
  evaluatedExpressions?: ExpressionEvaluationDetails[];

  /**
   * Evaluation details of IfNotExists effect.
   */
  ifNotExistsDetails?: IfNotExistsEvaluationDetails;

  /**
   * The reason for the evaluation result.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}
