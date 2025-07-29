import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Image.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents an image version.
 */
@parentResource(Image)
model ImageVersion
  is Azure.ResourceManager.ProxyResource<ImageVersionProperties> {
  ...ResourceNameParameter<
    Resource = ImageVersion,
    KeyName = "versionName",
    SegmentName = "versions",
    NamePattern = "^[0-9]{1,10}[.][0-9]{1,10}[.][0-9]{1,10}$"
  >;
}

@armResourceOperations
interface ImageVersionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the devcenter. */
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,

        /** The name of the gallery. */
        @path
        @segment("galleries")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        galleryName: string,

        /** The name of the image. */
        @path
        @segment("images")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-.]{0,78}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(80)
        imageName: string,
      },
      {
        /** The version of the image. */
        @path
        @segment("versions")
        @key
        @pattern("^[0-9]{1,10}[.][0-9]{1,10}[.][0-9]{1,10}$")
        @minLength(5)
        @maxLength(32)
        versionName: string,
      }
    > {}

@armResourceOperations
interface ImageVersions {
  /**
   * Gets an image version.
   */
  get is ImageVersionOps.Read<ImageVersion>;

  /**
   * Lists versions for an image.
   */
  listByImage is ImageVersionOps.List<ImageVersion>;
}
@armResourceOperations
interface ImageVersionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the project. */
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,

        /** The name of the image. */
        @path
        @segment("images")
        @key
        @pattern("^[a-zA-Z0-9~][a-zA-Z0-9-.~]{0,151}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(153)
        imageName: string,
      },
      {
        /** The version of the image. */
        @path
        @segment("versions")
        @key
        @pattern("^[0-9]{1,10}[.][0-9]{1,10}[.][0-9]{1,10}$")
        @minLength(5)
        @maxLength(32)
        versionName: string,
      }
    > {}

@armResourceOperations
interface ImageVersionOperationGroup {
  /**
   * Gets an image version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ImageVersions_GetByProject")
  getByProject is ImageVersionOperationGroupOps.Read<ImageVersion>;

  /**
   * Lists versions for an image.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ImageVersions_ListByProject")
  listByProject is ImageVersionOperationGroupOps.List<ImageVersion>;
}

@@maxLength(ImageVersion.name, 32);
@@minLength(ImageVersion.name, 5);
@@doc(ImageVersion.name, "The version of the image.");
@@doc(ImageVersion.properties, "Image version properties.");
