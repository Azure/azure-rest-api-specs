import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Static Site Build ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(StaticSiteARMResource)
model StaticSiteBuildARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteBuildARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteBuildARMResource,
    KeyName = "environmentName",
    SegmentName = "builds",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteBuildARMResources {
  /**
   * Description for Gets the details of a static site build.
   */
  @summary("Gets the details of a static site build.")
  getStaticSiteBuild is ArmResourceRead<
    StaticSiteBuildARMResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a static site build.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a static site build.")
  deleteStaticSiteBuild is ArmResourceDeleteWithoutOkAsync<
    StaticSiteBuildARMResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets all static site builds for a particular static site.
   */
  @summary("Gets all static site builds for a particular static site.")
  getStaticSiteBuilds is ArmResourceListByParent<
    StaticSiteBuildARMResource,
    Response = ArmResponse<StaticSiteBuildCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates the app settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates the app settings of a static site build.")
  @put
  @action("config/appsettings")
  createOrUpdateStaticSiteBuildAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates the function app settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates the function app settings of a static site build.")
  @put
  @action("config/functionappsettings")
  createOrUpdateStaticSiteBuildFunctionAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the functions of a particular static site build.
   */
  @summary("Gets the functions of a particular static site build.")
  @get
  @action("functions")
  @list
  listStaticSiteBuildFunctions is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<StaticSiteFunctionOverviewCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the application settings of a static site build.
   */
  @summary("Gets the application settings of a static site build.")
  @action("listAppSettings")
  listStaticSiteBuildAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the application settings of a static site build.
   */
  @summary("Gets the application settings of a static site build.")
  @action("listFunctionAppSettings")
  listStaticSiteBuildFunctionAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Returns details of database connections for a static site build
   */
  @summary("Returns details of database connections for a static site build")
  @action("showDatabaseConnections")
  @list
  getBuildDatabaseConnectionsWithDetails is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<DatabaseConnectionCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Deploys zipped content to a specific environment of a static site.
   */
  @summary("Deploys zipped content to a specific environment of a static site.")
  @action("zipdeploy")
  createZipDeploymentForStaticSiteBuild is ArmResourceActionAsync<
    StaticSiteBuildARMResource,
    StaticSiteZipDeploymentARMResource,
    {
      @body body: void;
    },
    Error = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(StaticSiteBuildARMResource.name, "The stage site identifier.");
@@doc(StaticSiteBuildARMResource.properties,
  "StaticSiteBuildARMResource resource specific properties"
);
@@doc(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildAppSettings::parameters.body,
  "The dictionary containing the static site app settings to update."
);
@@doc(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildFunctionAppSettings::parameters.body,
  "The dictionary containing the static site function app settings to update."
);
@@doc(StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild::parameters.body,
  "A JSON representation of the StaticSiteZipDeployment properties. See example."
);
