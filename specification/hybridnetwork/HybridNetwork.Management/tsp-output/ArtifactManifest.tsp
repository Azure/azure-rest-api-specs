import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ArtifactStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Artifact manifest properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ArtifactStore)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ArtifactManifestPropertiesFormat
)
model ArtifactManifest extends TrackedResourceBase {
  /**
   * The name of the artifact manifest.
   */
  @maxLength(64)
  @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
  @path
  @key("artifactManifestName")
  @segment("artifactManifests")
  @visibility("read")
  name: string;

  /**
   * Artifact manifest properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ArtifactManifestPropertiesFormat;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ArtifactManifest,
    BaseParameters<ArtifactManifest>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a artifact manifest resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ArtifactManifest, TagsObject>;

  /**
   * Deletes the specified artifact manifest.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ArtifactManifest,
    BaseParameters<ArtifactManifest>,
    ArmLroLocationHeader
  >;

  /**
   * Gets information about the artifact manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ArtifactManifests_ListByArtifactStore")
  listByArtifactStore is ArmResourceListByParent<ArtifactManifest>;

  /**
   * List credential for publishing artifacts defined in artifact manifest.
   */
  listCredential is ArmResourceActionSync<
    ArtifactManifest,
    void,
    ArtifactAccessCredential
  >;

  /**
   * Update state for artifact manifest.
   */
  updateState is ArmResourceActionAsync<
    ArtifactManifest,
    ArtifactManifestUpdateState,
    ArtifactManifestUpdateState,
    BaseParameters<ArtifactManifest>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ArtifactManifests.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ArtifactManifests.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ArtifactManifests.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update artifact manifest operation."
);
@@projectedName(ArtifactManifests.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ArtifactManifests.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ArtifactManifests.update::parameters.properties,
  "Parameters supplied to the create or update artifact manifest operation."
);
@@projectedName(ArtifactManifests.updateState::parameters.body,
  "json",
  "parameters"
);
@@extension(ArtifactManifests.updateState::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ArtifactManifests.updateState::parameters.body,
  "Parameters supplied to update the state of artifact manifest."
);
