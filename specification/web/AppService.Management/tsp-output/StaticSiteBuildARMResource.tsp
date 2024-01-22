import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Static Site Build ARM resource.
 */
@parentResource(StaticSiteARMResource)
model StaticSiteBuildARMResource
  is ProxyResource<StaticSiteBuildARMResourceProperties> {
  /**
   * The stage site identifier.
   */
  @path
  @key("environmentName")
  @segment("builds")
  name: string;
}

@armResourceOperations
interface StaticSiteBuildARMResources {
  /**
   * Description for Gets the details of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_GetStaticSiteBuild")
  getStaticSiteBuild is ArmResourceRead<StaticSiteBuildARMResource>;

  /**
   * Description for Deletes a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_DeleteStaticSiteBuild")
  deleteStaticSiteBuild is ArmResourceDeleteAsync<StaticSiteBuildARMResource>;

  /**
   * Description for Gets all static site builds for a particular static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_GetStaticSiteBuilds")
  getStaticSiteBuilds is ArmResourceListByParent<StaticSiteBuildARMResource>;

  /**
   * Description for Gets the application settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_ListStaticSiteBuildAppSettings")
  listStaticSiteBuildAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    StringDictionary
  >;

  /**
   * Description for Gets the application settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_ListStaticSiteBuildFunctionAppSettings")
  listStaticSiteBuildFunctionAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    StringDictionary
  >;

  /**
   * Description for Deploys zipped content to a specific environment of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_CreateZipDeploymentForStaticSiteBuild")
  createZipDeploymentForStaticSiteBuild is ArmResourceActionAsync<
    StaticSiteBuildARMResource,
    StaticSiteZipDeploymentARMResource,
    void
  >;

  /**
   * Description for Gets the functions of a particular static site build.
   */
  // FIXME: StaticSites_ListStaticSiteBuildFunctions could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_ListStaticSiteBuildFunctions")
  @summary("Gets the functions of a particular static site build.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/builds/{environmentName}/functions")
  @get
  listStaticSiteBuildFunctions is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * The stage site identifier.
       */
      @path
      environmentName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    StaticSiteFunctionOverviewCollection
  >;
}

@@projectedName(StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild::parameters.body,
  "json",
  "staticSiteZipDeploymentEnvelope"
);
@@extension(StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild::parameters.body,
  "x-ms-client-name",
  "staticSiteZipDeploymentEnvelope"
);
@@doc(StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild::parameters.body,
  "A JSON representation of the StaticSiteZipDeployment properties. See example."
);
