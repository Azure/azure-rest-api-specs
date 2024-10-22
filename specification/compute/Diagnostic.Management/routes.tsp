// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;

interface DiagnosticOperationsOperations {
  /**
   * Gets status of a Diagnostic operation issued for Disk Inspection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiagnosticOperations_Read")
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
  ): ArmResponse<ComputeDiagnosticsOperationResult> | ArmAcceptedResponse | ErrorResponse;
}

@armResourceOperations
interface SpotPlacementRecommenderOperations {
  /**
   * [SOON TO BE DEPRECATED] Gets Spot Placement Recommender diagnostic metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SpotPlacementRecommender_Get")
  @get
  @action("diagnostics/spotPlacementRecommender")
  get is ArmProviderActionAsync<
    Response = ComputeDiagnosticBase,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * [SOON TO BE DEPRECATED] Generates placement scores for Spot VM skus.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SpotPlacementRecommender_Post")
  @post
  @action("diagnostics/spotPlacementRecommender/generate")
  post is ArmProviderActionAsync<
    Response = SpotPlacementRecommenderResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Request = SpotPlacementRecommenderInput
  >;
}

@armResourceOperations
interface SpotPlacementScoresOperations {
  /**
   * Gets Spot Placement Scores metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SpotPlacementScores_Get")
  @get
  @action("placementScores/spot")
  get is ArmProviderActionAsync<
    Response = ComputeDiagnosticBase,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Generates placement scores for Spot VM skus.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SpotPlacementScores_Post")
  @post
  @action("placementScores/spot/generate")
  post is ArmProviderActionAsync<
    Response = SpotPlacementScoresResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Request = SpotPlacementScoresInput
  >;
}
