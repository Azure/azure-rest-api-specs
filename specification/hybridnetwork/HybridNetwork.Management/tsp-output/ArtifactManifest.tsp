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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ArtifactManifest,
    BaseParameters<ArtifactManifest>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a artifact manifest resource.")
  update is ArmCustomPatchSync<ArtifactManifest, TagsObject>;

  @doc("Deletes the specified artifact manifest.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ArtifactManifest,
    BaseParameters<ArtifactManifest>,
    ArmLroLocationHeader
  >;

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
