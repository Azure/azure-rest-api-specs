import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("Properties of an artifact source.")
@parentResource(Lab)
model ArtifactSource is TrackedResource<ArtifactSourceProperties> {
  @doc("The name of the artifact source.")
  @path
  @key("name")
  @segment("artifactsources")
  name: string;
}

@armResourceOperations
interface ArtifactSources {
  @doc("Get artifact source.")
  get is ArmResourceRead<
    ArtifactSource,
    {
      ...BaseParameters<ArtifactSource>;

      @doc("Specify the $expand query. Example: 'properties($select=displayName)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing artifact source.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ArtifactSource>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of artifact sources. All other properties will be ignored.")
  update is ArmCustomPatchSync<ArtifactSource, ArtifactSourceFragment>;
  @doc("Delete artifact source.")
  delete is ArmResourceDeleteSync<ArtifactSource>;
  @doc("List artifact sources in a given lab.")
  list is ArmResourceListByParent<
    ArtifactSource,
    {
      ...BaseParameters<ArtifactSource>;

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
