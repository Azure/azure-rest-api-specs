import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.ComputeLimit;

/** Compute limit feature. */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_03_20)
model Feature is Azure.ResourceManager.ProxyResource<FeatureProperties> {
  ...ResourceNameParameter<
    Resource = Feature,
    KeyName = "featureName",
    SegmentName = "features"
  >;
}

/** Properties of the compute limit feature. */
@added(Versions.v2026_03_20)
model FeatureProperties {
  /** The current state of the feature (for example, Enabled, Disabled). */
  state?: FeatureState;

  ...DefaultProvisioningStateProperty;
}

/** The allowed states for a compute limit feature. */
@added(Versions.v2026_03_20)
union FeatureState {
  /** The feature is enabled. */
  Enabled: "Enabled",

  /** The feature is disabled. */
  Disabled: "Disabled",

  /** Future-proof extensible value. */
  string,
}

/** Request body for feature enable action. */
@added(Versions.v2026_06_01)
model FeatureEnableRequest {
  /** The Service Tree identifier associated with this feature action. */
  serviceTreeId?: Azure.Core.uuid;
}

/** Location-scoped operations for compute limit features. */
@armResourceOperations
@added(Versions.v2026_03_20)
interface Features {
  /** Gets the properties of a compute limit feature. */
  get is ArmResourceRead<Feature>;

  /** Lists all compute limit features for the subscription at the specified location. */
  list is ArmResourceListAtScope<Feature>;

  /** Enables a compute limit feature for the subscription at the specified location. */
  @removed(Versions.v2026_06_01)
  @sharedRoute
  @action("enable")
  enable is ArmResourceActionAsync<
    Feature,
    void,
    Azure.ResourceManager.Foundations.OperationStatusResult,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Feature>,
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Enables a compute limit feature for the subscription at the specified location. */
  @added(Versions.v2026_06_01)
  @renamedFrom(Versions.v2026_06_01, "enable")
  @sharedRoute
  @action("enable")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId needed to match renamed operation"
  @operationId("Features_Enable")
  enableV2 is ArmResourceActionAsync<
    Feature,
    FeatureEnableRequest,
    Azure.ResourceManager.Foundations.OperationStatusResult,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Feature>,
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Disables a compute limit feature for the subscription at the specified location. */
  @added(Versions.v2026_04_30)
  @action("disable")
  disable is ArmResourceActionAsync<
    Feature,
    void,
    Azure.ResourceManager.Foundations.OperationStatusResult,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Feature>,
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;
}
