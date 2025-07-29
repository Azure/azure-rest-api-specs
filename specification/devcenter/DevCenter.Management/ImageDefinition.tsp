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
/**
 * Represents a definition for an Image.
 */
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

        /** The name of the devcenter. */
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,

        /** The name of the Catalog. */
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      },
      {
        /** The name of the Image Definition. */
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
  /**
   * Gets an Image Definition from the catalog
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitions_GetByDevCenterCatalog")
  getByDevCenterCatalog is ImageDefinitionOps.Read<ImageDefinition>;

  /**
   * List Image Definitions in the catalog.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitions_ListByDevCenterCatalog")
  listByDevCenterCatalog is ImageDefinitionOps.List<
    ImageDefinition,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets Image Definition error details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitions_GetErrorDetails")
  getErrorDetails is ImageDefinitionOps.ActionSync<
    ImageDefinition,
    void,
    ArmResponse<CatalogResourceValidationErrorDetails>
  >;

  /**
   * Builds an image for the specified Image Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitions_BuildImage")
  buildImage is ImageDefinitionOps.ActionAsync<
    ImageDefinition,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
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

        /** The name of the project. */
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,

        /** The name of the Catalog. */
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      },
      {
        /** The name of the Image Definition. */
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
  /**
   * Gets an Image Definition from the catalog
   */
  getByProjectCatalog is ProjectCatalogImageDefinitionOps.Read<ImageDefinition>;

  /**
   * List Image Definitions in the catalog.
   */
  listByProjectCatalog is ProjectCatalogImageDefinitionOps.List<
    ImageDefinition,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets Image Definition error details
   */
  getErrorDetails is ProjectCatalogImageDefinitionOps.ActionSync<
    ImageDefinition,
    void,
    ArmResponse<CatalogResourceValidationErrorDetails>
  >;

  /**
   * Builds an image for the specified Image Definition.
   */
  buildImage is ProjectCatalogImageDefinitionOps.ActionAsync<
    ImageDefinition,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@maxLength(ImageDefinition.name, 63);
@@minLength(ImageDefinition.name, 3);
@@doc(ImageDefinition.name, "The name of the Image Definition.");
@@doc(ImageDefinition.properties, "Image Definition properties");
