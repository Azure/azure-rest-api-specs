import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ImageDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a specific build of an Image Definition.
 */
@parentResource(ImageDefinition)
model ImageDefinitionBuild
  is Azure.ResourceManager.ProxyResource<ImageDefinitionBuildProperties> {
  ...ResourceNameParameter<
    Resource = ImageDefinitionBuild,
    KeyName = "buildName",
    SegmentName = "builds",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface ImageDefinitionBuildOps
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

        /** The name of the Image Definition. */
        @path
        @segment("imageDefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        imageDefinitionName: string,
      },
      {
        /** The ID of the Image Definition Build. */
        @path
        @segment("builds")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        buildName: string,
      }
    > {}

@armResourceOperations
interface ImageDefinitionBuilds {
  /**
   * Gets a build for a specified image definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitionBuild_Get")
  get is ImageDefinitionBuildOps.Read<ImageDefinitionBuild>;

  /**
   * Lists builds for a specified image definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitionBuilds_ListByImageDefinition")
  listByImageDefinition is ImageDefinitionBuildOps.List<
    ImageDefinitionBuild,
    Response = ImageDefinitionBuildListResult
  >;

  /**
   * Cancels the specified build for an image definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitionBuild_Cancel")
  cancel is ImageDefinitionBuildOps.ActionAsync<
    ImageDefinitionBuild,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Gets Build details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevCenterCatalogImageDefinitionBuild_GetBuildDetails")
  getBuildDetails is ImageDefinitionBuildOps.ActionSync<
    ImageDefinitionBuild,
    void,
    ArmResponse<ImageDefinitionBuildDetails>
  >;
}
@armResourceOperations
interface ProjectCatalogImageDefinitionBuildOps
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

        /** The name of the Image Definition. */
        @path
        @segment("imageDefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        imageDefinitionName: string,
      },
      {
        /** The ID of the Image Definition Build. */
        @path
        @segment("builds")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        buildName: string,
      }
    > {}

@armResourceOperations
interface ProjectCatalogImageDefinitionBuild {
  /**
   * Gets a build for a specified image definition.
   */
  get is ProjectCatalogImageDefinitionBuildOps.Read<ImageDefinitionBuild>;

  /**
   * Lists builds for a specified image definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProjectCatalogImageDefinitionBuilds_ListByImageDefinition")
  listByImageDefinition is ProjectCatalogImageDefinitionBuildOps.List<
    ImageDefinitionBuild,
    Response = ImageDefinitionBuildListResult
  >;

  /**
   * Cancels the specified build for an image definition.
   */
  cancel is ProjectCatalogImageDefinitionBuildOps.ActionAsync<
    ImageDefinitionBuild,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Gets Build details
   */
  getBuildDetails is ProjectCatalogImageDefinitionBuildOps.ActionSync<
    ImageDefinitionBuild,
    void,
    ArmResponse<ImageDefinitionBuildDetails>
  >;
}

@@maxLength(ImageDefinitionBuild.name, 63);
@@minLength(ImageDefinitionBuild.name, 3);
@@doc(ImageDefinitionBuild.name, "The ID of the Image Definition Build.");
@@doc(ImageDefinitionBuild.properties, "Image Definition Build properties");
