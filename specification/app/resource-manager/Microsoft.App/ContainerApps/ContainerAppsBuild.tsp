import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Information pertaining to an individual build.
 */
@parentResource(ContainerApp)
model ContainerAppsBuildResource
  is Azure.ResourceManager.ProxyResource<ContainerAppsBuildProperties> {
  ...ResourceNameParameter<
    Resource = ContainerAppsBuildResource,
    KeyName = "buildName",
    SegmentName = "builds",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias ContainerAppsBuildResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;
  },
  {
    /** Name of the build. */
    @path
    @segment("builds")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    @minLength(2)
    @maxLength(64)
    buildName: string;
  }
>;

@armResourceOperations
interface ContainerAppsBuilds {
  /**
   * Get a Container Apps Build resource
   */
  get is ContainerAppsBuildResourceOps.Read<ContainerAppsBuildResource>;

  /**
   * Delete a Container Apps Build resource
   */
  delete is ContainerAppsBuildResourceOps.DeleteWithoutOkAsync<ContainerAppsBuildResource>;

  /**
   * List Container Apps Build resources by Container App
   */
  list is ContainerAppsBuildResourceOps.List<
    ContainerAppsBuildResource,
    Response = ArmResponse<ContainerAppsBuildCollection>
  >;
}

@@maxLength(ContainerAppsBuildResource.name, 64);
@@minLength(ContainerAppsBuildResource.name, 2);
@@doc(ContainerAppsBuildResource.name, "The name of a build.");
@@doc(ContainerAppsBuildResource.properties,
  "The resource-specific properties for this resource."
);
