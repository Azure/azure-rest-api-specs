import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Catalog.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents a definition for an Image.")
@parentResource(Catalog)
model ImageDefinition
  is Azure.ResourceManager.ProxyResource<ImageDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = ImageDefinition,
    KeyName = "imageDefinitionName",
    SegmentName = "imageDefinitions",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface ImageDefinitionOps
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

        @doc("The name of the Catalog.")
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      },
      {
        @doc("The name of the Image Definition.")
        @path
        @segment("imageDefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        imageDefinitionName: string,
      }
    > {}

@armResourceOperations
interface ImageDefinitions {
  @doc("Gets an Image Definition from the catalog")
  getByDevCenterCatalog is ImageDefinitionOps.Read<ImageDefinition>;

  @doc("List Image Definitions in the catalog.")
  listByDevCenterCatalog is ImageDefinitionOps.List<
    ImageDefinition,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ImageDefinitionListResult
  >;

  @doc("Gets Image Definition error details.")
  getErrorDetails is ImageDefinitionOps.ActionSync<
    ImageDefinition,
    void,
    ArmResponse<CatalogResourceValidationErrorDetails>
  >;

  @doc("Builds an image for the specified Image Definition.")
  buildImage is ImageDefinitionOps.ActionAsync<
    ImageDefinition,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader>
  >;
}
@armResourceOperations
interface ProjectCatalogImageDefinitionOps
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

        @doc("The name of the Catalog.")
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      },
      {
        @doc("The name of the Image Definition.")
        @path
        @segment("imageDefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        imageDefinitionName: string,
      }
    > {}

@armResourceOperations
interface ProjectCatalogImageDefinitions {
  @doc("Gets an Image Definition from the catalog.")
  getByProjectCatalog is ProjectCatalogImageDefinitionOps.Read<ImageDefinition>;

  @doc("List Image Definitions in the catalog.")
  listByProjectCatalog is ProjectCatalogImageDefinitionOps.List<
    ImageDefinition,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ImageDefinitionListResult
  >;

  @doc("Gets Image Definition error details.")
  getErrorDetails is ProjectCatalogImageDefinitionOps.ActionSync<
    ImageDefinition,
    void,
    ArmResponse<CatalogResourceValidationErrorDetails>
  >;

  @doc("Builds an image for the specified Image Definition.")
  buildImage is ProjectCatalogImageDefinitionOps.ActionAsync<
    ImageDefinition,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader>
  >;
}

@@maxLength(ImageDefinition.name, 63);
@@minLength(ImageDefinition.name, 3);
@@doc(ImageDefinition.name, "The name of the Image Definition.");
@@doc(ImageDefinition.properties, "Image Definition properties");
