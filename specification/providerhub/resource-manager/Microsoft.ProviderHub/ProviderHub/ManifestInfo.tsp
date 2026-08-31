import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@added(Versions.v2025_10_01)
@parentResource(ProviderRegistration)
model ManifestInfo
  is Azure.ResourceManager.ProxyResource<ManifestInfoProperties> {
  ...ResourceNameParameter<
    Resource = ManifestInfo,
    KeyName = "environment",
    SegmentName = "manifests",
    NamePattern = ""
  >;
}

/**
 * The manifest content supplied to the create or update operation.
 */
@added(Versions.v2026_09_01_preview)
model ManifestPutContent {
  /**
   * The manifest.
   */
  manifest?: string;

  /**
   * The manifest URI.
   */
  manifestUri?: url;

  /**
   * The optional comment included in the manifest repository commit or pull request.
   */
  @maxLength(200)
  @pattern("^[\\u0020-\\u007E\\u00A0-\\uFFFF]*$")
  checkinComment?: string;
}

@added(Versions.v2025_10_01)
@armResourceOperations
interface ManifestOps
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
        /** The environment supplied to the manifests operation. */
        @path
        @segment("manifests")
        @key
        environment: string,
      }
    > {}

@added(Versions.v2025_10_01)
@armResourceOperations
interface Manifests {
  /**
   * Gets the manifest from the manifest repository.
   */
  get is ManifestOps.Read<ManifestInfo>;

  /**
   * Creates or Updates a manifest in manifest repository.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The manifest is checked in to the manifest repository rather than persisted as an ARM resource, so the service only ever returns 200; it never returns 201."
  @removed(Versions.v2026_09_01_preview)
  @renamedFrom(Versions.v2026_09_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateV1 is ManifestOps.CreateOrUpdateSync<
    ManifestInfo,
    Response = ArmResponse<ManifestInfo>
  >;

  /**
   * Creates or Updates a manifest in manifest repository.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The manifest is checked in to the manifest repository rather than persisted as an ARM resource, so the service only ever returns 200; it never returns 201."
  @added(Versions.v2026_09_01_preview)
  @sharedRoute
  createOrUpdate is ManifestOps.CreateOrUpdateSync<
    ManifestInfo,
    Request = ManifestPutContent,
    Response = ArmResponse<ManifestInfo>
  >;
}

@@doc(ManifestInfo.name, "");
@@doc(ManifestInfo.properties, "The manifest properties.");
@@doc(
  Manifests.createOrUpdateV1::parameters.resource,
  "The manifest supplied to the CreateOrUpdate manifests operation."
);
@@doc(
  Manifests.createOrUpdate::parameters.resource,
  "The manifest supplied to the CreateOrUpdate manifests operation."
);
