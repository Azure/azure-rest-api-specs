import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ArtifactStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Artifact manifest properties.
 */
@parentResource(ArtifactStore)
model ArtifactManifest
  is Azure.ResourceManager.TrackedResource<ArtifactManifestPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ArtifactManifest,
    KeyName = "artifactManifestName",
    SegmentName = "artifactManifests",
    NamePattern = "^[^\\s]*[^\\s]+[^\\s]*$"
  >;
}

@armResourceOperations
interface ArtifactManifests {
  /**
   * Gets information about a artifact manifest resource.
   */
  get is ArmResourceRead<ArtifactManifest>;

  /**
   * Creates or updates a artifact manifest.
   */
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @extension("x-ms-long-running-operation", true)
  createOrUpdate is ArmResourceCreateOrReplaceSync<ArtifactManifest>;

  /**
   * Updates a artifact manifest resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ArtifactManifest, PatchModel = TagsObject>;

  /**
   * Deletes the specified artifact manifest.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ArtifactManifest,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Gets information about the artifact manifest.
   */
  listByArtifactStore is ArmResourceListByParent<ArtifactManifest>;

  /**
   * List credential for publishing artifacts defined in artifact manifest.
   */
  listCredential is ArmResourceActionSync<
    ArtifactManifest,
    void,
    ArmResponse<ArtifactAccessCredential>
  >;

  /**
   * Update state for artifact manifest.
   */
  updateState is ArmResourceActionAsync<
    ArtifactManifest,
    ArtifactManifestUpdateState,
    ArmResponse<ArtifactManifestUpdateState>,
    LroHeaders = ArmLroLocationHeader
  >;
}

@@maxLength(ArtifactManifest.name, 64);
@@doc(ArtifactManifest.name, "The name of the artifact manifest.");
@@doc(ArtifactManifest.properties, "Artifact manifest properties.");
@@doc(ArtifactManifests.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update artifact manifest operation."
);
@@doc(ArtifactManifests.update::parameters.properties,
  "Parameters supplied to the create or update artifact manifest operation."
);
@@doc(ArtifactManifests.updateState::parameters.body,
  "Parameters supplied to update the state of artifact manifest."
);
