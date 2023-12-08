import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaServicesAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("A Transform encapsulates the rules or instructions for generating desired outputs from input media, such as by transcoding or by extracting insights. After the Transform is created, it can be applied to input media by creating Jobs.")
@parentResource(MediaServicesAccount)
model MediaTransform is ProxyResource<TransformProperties> {
  @doc("The Transform name.")
  @path
  @key("transformName")
  @segment("transforms")
  name: string;
}

@armResourceOperations
interface MediaTransforms {
  @doc("Gets a Transform.")
  get is ArmResourceRead<MediaTransform>;
  @doc("Creates or updates a new Transform.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MediaTransform>;
  @doc("Updates a Transform.")
  update is ArmResourcePatchSync<MediaTransform, TransformProperties>;
  @doc("Deletes a Transform.")
  delete is ArmResourceDeleteSync<MediaTransform>;
  @doc("Lists the Transforms in the account.")
  list is ArmResourceListByParent<
    MediaTransform,
    {
      ...BaseParameters<MediaTransform>;

      @doc("Restricts the set of items returned.")
      @query("$filter")
      $filter?: string;

      @doc("Specifies the key by which the result collection should be ordered.")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}
