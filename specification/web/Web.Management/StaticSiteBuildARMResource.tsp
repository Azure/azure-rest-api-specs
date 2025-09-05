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
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@parentResource(StaticSiteARMResource)
model StaticSiteBuildARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteBuildARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteBuildARMResource,
    KeyName = "environmentName",
    SegmentName = "builds",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface StaticSiteBuildARMResources {
  /**
   * Description for Gets the details of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetStaticSiteBuild")
  getStaticSiteBuild is ArmResourceRead<StaticSiteBuildARMResource>;

  /**
   * Description for Deletes a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_DeleteStaticSiteBuild")
  deleteStaticSiteBuild is ArmResourceDeleteWithoutOkAsync<
    StaticSiteBuildARMResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Description for Gets all static site builds for a particular static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetStaticSiteBuilds")
  getStaticSiteBuilds is ArmResourceListByParent<
    StaticSiteBuildARMResource,
    Response = ArmResponse<StaticSiteBuildCollection>
  >;

  /**
   * Description for Creates or updates the app settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_CreateOrUpdateStaticSiteBuildAppSettings")
  @put
  @action("config/appsettings")
  createOrUpdateStaticSiteBuildAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Creates or updates the function app settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_CreateOrUpdateStaticSiteBuildFunctionAppSettings")
  @put
  @action("config/functionappsettings")
  createOrUpdateStaticSiteBuildFunctionAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Gets the functions of a particular static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteBuildFunctions")
  @get
  @action("functions")
  @list
  listStaticSiteBuildFunctions is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<StaticSiteFunctionOverviewCollection>
  >;

  /**
   * Description for Gets the application settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteBuildAppSettings")
  @action("listAppSettings")
  listStaticSiteBuildAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Gets the application settings of a static site build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteBuildFunctionAppSettings")
  @action("listFunctionAppSettings")
  listStaticSiteBuildFunctionAppSettings is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Returns details of database connections for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetBuildDatabaseConnectionsWithDetails")
  @action("showDatabaseConnections")
  getBuildDatabaseConnectionsWithDetails is ArmResourceActionSync<
    StaticSiteBuildARMResource,
    void,
    ArmResponse<DatabaseConnectionCollection>
  >;

  /**
   * Description for Deploys zipped content to a specific environment of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_CreateZipDeploymentForStaticSiteBuild")
  @action("zipdeploy")
  createZipDeploymentForStaticSiteBuild is ArmResourceActionAsync<
    StaticSiteBuildARMResource,
    StaticSiteZipDeploymentARMResource,
    OkResponse
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
