import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ArtifactStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("Artifact manifest properties.")
@parentResource(ArtifactStore)
model ArtifactManifest is TrackedResource<ArtifactManifestPropertiesFormat> {
  @doc("The name of the artifact manifest.")
  @maxLength(64)
  @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
  @path
  @key("artifactManifestName")
  @segment("artifactManifests")
  name: string;
}

@armResourceOperations
interface ArtifactManifests {
  @doc("Gets information about a artifact manifest resource.")
  get is ArmResourceRead<ArtifactManifest>;
  @doc("Creates or updates a artifact manifest.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ArtifactManifest>;
  @doc("Updates a artifact manifest resource.")
  update is ArmTagsPatchSync<ArtifactManifest>;
  @doc("Deletes the specified artifact manifest.")
  delete is ArmResourceDeleteWithoutOkAsync<ArtifactManifest>;
  @doc("Gets information about the artifact manifest.")
  listByArtifactStore is ArmResourceListByParent<ArtifactManifest>;
  @doc("List credential for publishing artifacts defined in artifact manifest.")
  listCredential is ArmResourceActionSync<
    ArtifactManifest,
    void,
    ArtifactAccessCredential
  >;
  @doc("Update state for artifact manifest.")
  updateState is ArmResourceActionAsync<
    ArtifactManifest,
    ArtifactManifestUpdateState,
    ArtifactManifestUpdateState
  >;
}
