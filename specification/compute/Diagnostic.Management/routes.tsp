// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Compute;

interface DiagnosticOperationsOperations {
  /**
   * Gets status of a Diagnostic operation issued for Disk Inspection.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/diagnosticOperations/{operationId}")
  @get
  read(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @minLength(1)
    @path
    operationId: string,
  ): ArmResponse<ComputeDiagnosticsOperationResult | void> | ErrorResponse;
}

interface SpotPlacementRecommenderOperations {
  /**
   * [SOON TO BE DEPRECATED] Gets Spot Placement Recommender diagnostic metadata.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/diagnostics/spotPlacementRecommender")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
  ): ArmResponse<ComputeDiagnosticBase> | ErrorResponse;

  /**
   * [SOON TO BE DEPRECATED] Generates placement scores for Spot VM skus.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/diagnostics/spotPlacementRecommender/generate")
  @post
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * SpotPlacementRecommender object supplied in the body of the Post spot placement recommender operation.
     */
    @body
    spotPlacementRecommenderInput: SpotPlacementRecommenderInput,
  ): ArmResponse<SpotPlacementRecommenderResponse> | ErrorResponse;
}

interface SpotPlacementScoresOperations {
  /**
   * Gets Spot Placement Scores metadata.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/placementScores/spot")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
  ): ArmResponse<ComputeDiagnosticBase> | ErrorResponse;

  /**
   * Generates placement scores for Spot VM skus.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/placementScores/spot/generate")
  @post
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * SpotPlacementScores object supplied in the body of the Post spot placement scores operation.
     */
    @body
    spotPlacementScoresInput: SpotPlacementScoresInput,
  ): ArmResponse<SpotPlacementScoresResponse> | ErrorResponse;
}
