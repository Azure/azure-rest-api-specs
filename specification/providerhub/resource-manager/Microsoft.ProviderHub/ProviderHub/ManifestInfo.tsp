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
  createOrUpdate is ManifestOps.CreateOrUpdateSync<
    ManifestInfo,
    Response = ArmResponse<ManifestInfo>
  >;
}

@@doc(ManifestInfo.name, "");
@@doc(ManifestInfo.properties, "The manifest properties.");
@@doc(
  Manifests.createOrUpdate::parameters.resource,
  "The manifest supplied to the CreateOrUpdate manifests operation."
);
