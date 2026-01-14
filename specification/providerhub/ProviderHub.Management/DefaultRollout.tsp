import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@parentResource(ProviderRegistration)
model DefaultRollout
  is Azure.ResourceManager.ProxyResource<DefaultRolloutProperties> {
  ...ResourceNameParameter<
    Resource = DefaultRollout,
    KeyName = "rolloutName",
    SegmentName = "defaultRollouts",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface DefaultRolloutOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the resource provider hosted within ProviderHub. */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,
      },
      {},
      {
        /** The rollout name. */
        @path
        @segment("defaultRollouts")
        @key
        @maxLength(260)
        @pattern("^[-\\w\\._\\(\\)]+$")
        rolloutName: string,
      }
    > {}

@armResourceOperations
interface DefaultRollouts {
  /**
   * Gets the default rollout details.
   */
  get is DefaultRolloutOps.Read<DefaultRollout>;

  /**
   * Creates or updates the rollout details.
   */
  createOrUpdate is DefaultRolloutOps.CreateOrUpdateAsync<DefaultRollout>;

  /**
   * Deletes the rollout resource. Rollout must be in terminal state.
   */
  delete is DefaultRolloutOps.DeleteSync<DefaultRollout>;

  /**
   * Gets the list of the rollouts for the given provider.
   */
  listByProviderRegistration is DefaultRolloutOps.List<
    DefaultRollout,
    Response = ArmResponse<DefaultRolloutArrayResponseWithContinuation>
  >;

  /**
   * Stops or cancels the rollout, if in progress.
   */
  stop is DefaultRolloutOps.ActionSync<
    DefaultRollout,
    Request = void,
    Response = OkResponse
  >;
}
@armResourceOperations
interface NewRegionFrontloadReleaseOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the resource provider hosted within ProviderHub. */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,
      },
      {},
      {
        /** The name of the release. */
        @path
        @segment("newRegionFrontloadRelease")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        releaseName: string,
      }
    > {}

@armResourceOperations
interface NewRegionFrontloadRelease {
  /**
   * Gets a new region frontload release.
   */
  get is NewRegionFrontloadReleaseOps.Read<DefaultRollout>;

  /**
   * Creates or updates a new region frontload release.
   */
  createOrUpdate is NewRegionFrontloadReleaseOps.CreateOrUpdateSync<
    FrontloadPayload,
    Response = DefaultRollout | ArmResourceCreatedSyncResponse<DefaultRollout>
  >;

  /**
   * Stops a new region frontload release.
   */
  stop is NewRegionFrontloadReleaseOps.ActionSync<
    DefaultRollout,
    void,
    OkResponse
  >;
}

@@maxLength(DefaultRollout.name, 260);
@@doc(DefaultRollout.name, "The rollout name.");
@@doc(DefaultRollout.properties, "Properties of the rollout.");
@@doc(DefaultRollouts.createOrUpdate::parameters.resource,
  "The Default rollout properties supplied to the CreateOrUpdate operation."
);
@@doc(NewRegionFrontloadRelease.createOrUpdate::parameters.resource, "");
