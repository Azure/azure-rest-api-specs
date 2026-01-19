import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Gallery.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents an image.")
@parentResource(Gallery)
model Image is Azure.ResourceManager.ProxyResource<ImageProperties> {
  ...ResourceNameParameter<
    Resource = Image,
    KeyName = "imageName",
    SegmentName = "images",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-.]{0,78}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface ImageOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the devcenter.")
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,

        @doc("The name of the gallery.")
        @path
        @segment("galleries")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        galleryName: string,
      },
      {
        @doc("The name of the image.")
        @path
        @segment("images")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-.]{0,78}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(80)
        imageName: string,
      }
    > {}

@armResourceOperations
interface Images {
  @doc("Gets a gallery image.")
  get is ImageOps.Read<Image>;

  @doc("Lists images for a gallery.")
  listByGallery is ImageOps.List<
    Image,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ImageListResult
  >;
}
@armResourceOperations
interface ImageOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the project.")
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,
      },
      {
        @doc("The name of the image.")
        @path
        @segment("images")
        @key
        @pattern("^[a-zA-Z0-9~][a-zA-Z0-9-.~]{0,151}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(153)
        imageName: string,
      }
    > {}

@armResourceOperations
interface ImageOperationGroup {
  @doc("Gets an image.")
  getByProject is ImageOperationGroupOps.Read<Image>;

  @doc("Lists images for a project.")
  listByProject is ImageOperationGroupOps.List<
    Image,
    Response = ImageListResult
  >;
}

@@maxLength(Image.name, 80);
@@minLength(Image.name, 3);
@@doc(Image.name, "The name of the image.");
@@doc(Image.properties, "Image properties.");
