import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Contains metadata of a diagnostic type
 */
@singleton("spot")
@subscriptionResource
model ComputeDiagnosticBase
  is Azure.ResourceManager.ProxyResource<DiagnosticProperties> {
  ...ResourceNameParameter<
    Resource = ComputeDiagnosticBase,
    KeyName = "placementScore",
    SegmentName = "placementScores",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComputeDiagnosticBases {
  /**
   * Gets Spot Placement Scores metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SpotPlacementScores_Get")
  get is ArmResourceRead<
    ComputeDiagnosticBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Generates placement scores for Spot VM skus.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SpotPlacementScores_Post")
  @action("generate")
  post is ArmResourceActionSync<
    ComputeDiagnosticBase,
    SpotPlacementScoresInput,
    ArmResponse<SpotPlacementScoresResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(ComputeDiagnosticBase.name, "");
@@doc(ComputeDiagnosticBase.properties,
  "Contains additional properties of a diagnostic"
);
@@doc(ComputeDiagnosticBases.post::parameters.body,
  "SpotPlacementScores object supplied in the body of the Post spot placement scores operation."
);
