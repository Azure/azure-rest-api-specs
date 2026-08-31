import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Compute;
/**
 * Contains metadata common to placement scoring resources.
 */
alias PlacementScoresBase = Azure.ResourceManager.ProxyResource<PlacementScoresProperties>;

/**
 * Contains metadata of the Spot Placement Scores resource.
 */
@singleton("spot")
@parentResource(SubscriptionLocationResource)
model SpotPlacementScoresBase is PlacementScoresBase {
  ...ResourceNameParameter<
    Resource = SpotPlacementScoresBase,
    KeyName = "placementScore",
    SegmentName = "placementScores",
    NamePattern = ""
  >;
}

/**
 * Contains metadata of the compute placement scoring resource.
 */
@added(Versions.v2026_09_05_preview)
@singleton("regular")
@parentResource(SubscriptionLocationResource)
model ComputePlacementScoresBase is PlacementScoresBase {
  ...ResourceNameParameter<
    Resource = ComputePlacementScoresBase,
    KeyName = "placementScore",
    SegmentName = "placementScores",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SpotPlacementScores {
  /**
   * Gets Spot Placement Scores metadata.
   */
  get is ArmResourceRead<SpotPlacementScoresBase>;

  /**
   * Generates placement scores for Spot VM skus.
   */
  @action("generate")
  post is ArmResourceActionSync<
    SpotPlacementScoresBase,
    SpotPlacementScoresInput,
    ArmResponse<SpotPlacementScoresResponse>
  >;
}

@added(Versions.v2026_09_05_preview)
@armResourceOperations
interface ComputePlacementScores {
  /**
   * Gets Compute Placement Scores metadata.
   */
  get is ArmResourceRead<ComputePlacementScoresBase>;

  /**
   * Generates placement scores for Compute VM skus.
   */
  @action("generate")
  post is ArmResourceActionSync<
    ComputePlacementScoresBase,
    ComputePlacementScoresInput,
    ArmResponse<ComputePlacementScoresResponse>
  >;
}

@@doc(SpotPlacementScoresBase.name, "");
@@doc(
  SpotPlacementScoresBase.properties,
  "Contains additional properties of a placement scores resource."
);
@@doc(
  SpotPlacementScores.post::parameters.body,
  "SpotPlacementScores object supplied in the body of the Post spot placement scores operation."
);
@@doc(ComputePlacementScoresBase.name, "");
@@doc(
  ComputePlacementScoresBase.properties,
  "Contains additional properties of a placement scores resource."
);
@@doc(
  ComputePlacementScores.post::parameters.body,
  "ComputePlacementScores object supplied in the body of the Post compute placement scores operation."
);
