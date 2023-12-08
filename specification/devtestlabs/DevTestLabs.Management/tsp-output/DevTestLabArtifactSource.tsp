import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("Properties of an artifact source.")
@parentResource(DevTestLab)
model DevTestLabArtifactSource is TrackedResource<ArtifactSourceProperties> {
  @doc("The name of the artifact source.")
  @path
  @key("name")
  @segment("artifactsources")
  name: string;
}

@armResourceOperations
interface DevTestLabArtifactSources {
  @doc("Get artifact source.")
  get is ArmResourceRead<
    DevTestLabArtifactSource,
    {
      ...BaseParameters<DevTestLabArtifactSource>;

      @doc("Specify the $expand query. Example: 'properties($select=displayName)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing artifact source.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevTestLabArtifactSource>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of artifact sources. All other properties will be ignored.")
  update is ArmCustomPatchSync<
    DevTestLabArtifactSource,
    ArtifactSourceFragment
  >;
  @doc("Delete artifact source.")
  delete is ArmResourceDeleteSync<DevTestLabArtifactSource>;
  @doc("List artifact sources in a given lab.")
  list is ArmResourceListByParent<
    DevTestLabArtifactSource,
    {
      ...BaseParameters<DevTestLabArtifactSource>;

      @doc("Specify the $expand query. Example: 'properties($select=displayName)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}
