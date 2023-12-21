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
@doc("A custom image.")
@parentResource(Lab)
model CustomImage is TrackedResource<CustomImageProperties> {
  @doc("The name of the custom image.")
  @path
  @key("name")
  @segment("customimages")
  name: string;
}

@armResourceOperations
interface CustomImages {
  @doc("Get custom image.")
  get is ArmResourceRead<
    CustomImage,
    {
      ...BaseParameters<CustomImage>;

      @doc("Specify the $expand query. Example: 'properties($select=vm)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing custom image. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CustomImage>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of custom images. All other properties will be ignored.")
  update is ArmCustomPatchSync<CustomImage, CustomImageFragment>;
  @doc("Delete custom image. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<CustomImage>;
  @doc("List custom images in a given lab.")
  list is ArmResourceListByParent<
    CustomImage,
    {
      ...BaseParameters<CustomImage>;

      @doc("Specify the $expand query. Example: 'properties($select=vm)'")
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
