import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteARMResource
  is Azure.ResourceManager.TrackedResource<StaticSite> {
  ...ResourceNameParameter<
    Resource = StaticSiteARMResource,
    KeyName = "name",
    SegmentName = "staticSites",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Description of a SKU for a scalable resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: SkuDescription;

  /**
   * Managed service identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

alias StaticSiteUserOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("staticSites")
    @key
    name: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/staticSites",
  }
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ allowStaticRoutes: true })
interface StaticSiteARMResources {
  /**
   * Description for Gets the details of a static site.
   */
  @summary("Gets the details of a static site.")
  getStaticSite is ArmResourceRead<
    StaticSiteARMResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new static site in an existing resource group, or updates an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new static site in an existing resource group, or updates an existing static site.")
  createOrUpdateStaticSite is ArmResourceCreateOrReplaceAsync<
    StaticSiteARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteARMResource>> & {
      @bodyRoot
      _: StaticSiteARMResource;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new static site in an existing resource group, or updates an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new static site in an existing resource group, or updates an existing static site.")
  @patch(#{ implicitOptionality: false })
  updateStaticSite is ArmCustomPatchSync<
    StaticSiteARMResource,
    PatchModel = StaticSitePatchResource,
    Response = ArmResponse<StaticSiteARMResource> | (AcceptedResponse & {
      @bodyRoot
      _: StaticSiteARMResource;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a static site.")
  deleteStaticSite is ArmResourceDeleteWithoutOkAsync<
    StaticSiteARMResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets all static sites in the specified resource group.
   */
  @summary("Gets all static sites in the specified resource group.")
  getStaticSitesByResourceGroup is ArmResourceListByParent<
    StaticSiteARMResource,
    Response = ArmResponse<StaticSiteCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all Static Sites for a subscription.
   */
  @summary("Get all Static Sites for a subscription.")
  list is ArmListBySubscription<
    StaticSiteARMResource,
    Response = ArmResponse<StaticSiteCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the list of users of a static site.
   */
  @summary("Gets the list of users of a static site.")
  @action("listUsers")
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/staticSites/{name}/authproviders/{authprovider}/listUsers")
  listStaticSiteUsers is StaticSiteUserOps.ActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StaticSiteUserCollection>,
    Parameters = {
      /**
       * The auth provider for the users.
       */
      @path
      authprovider: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes the user entry from the static site.
   */
  @summary("Deletes the user entry from the static site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/staticSites/{name}/authproviders/{authprovider}/users/{userid}")
  @delete
  deleteStaticSiteUser is StaticSiteUserOps.ActionSync<
    StaticSiteARMResource,
    void,
    Response = {
      @body body: void;
    },
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      authprovider: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      userid: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates a user entry with the listed roles
   */
  @summary("Updates a user entry with the listed roles")
  @patch(#{ implicitOptionality: true })
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/staticSites/{name}/authproviders/{authprovider}/users/{userid}")
  updateStaticSiteUser is StaticSiteUserOps.ActionSync<
    StaticSiteARMResource,
    StaticSiteUserARMResource,
    ArmResponse<StaticSiteUserARMResource>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      authprovider: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      userid: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates the app settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates the app settings of a static site.")
  @put
  @action("config/appsettings")
  createOrUpdateStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates the function app settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates the function app settings of a static site.")
  @put
  @action("config/functionappsettings")
  createOrUpdateStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates an invitation link for a user with the role
   */
  @summary("Creates an invitation link for a user with the role")
  @action("createUserInvitation")
  createUserRolesInvitationLink is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteUserInvitationRequestResource,
    ArmResponse<StaticSiteUserInvitationResponseResource>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Detaches a static site.
   */
  @summary("Detaches a static site.")
  @action("detach")
  detachStaticSite is ArmResourceActionAsync<
    StaticSiteARMResource,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the functions of a static site.
   */
  @summary("Gets the functions of a static site.")
  @get
  @action("functions")
  @list
  listStaticSiteFunctions is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StaticSiteFunctionOverviewCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the application settings of a static site.
   */
  @summary("Gets the application settings of a static site.")
  @action("listAppSettings")
  listStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Lists the roles configured for the static site.
   */
  @summary("Lists the roles configured for the static site.")
  @action("listConfiguredRoles")
  listStaticSiteConfiguredRoles is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringList>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the application settings of a static site.
   */
  @summary("Gets the application settings of a static site.")
  @action("listFunctionAppSettings")
  listStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Lists the secrets for an existing static site.
   */
  @summary("Lists the secrets for an existing static site.")
  @action("listSecrets")
  listStaticSiteSecrets is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the private link resources
   */
  @summary("Gets the private link resources")
  @get
  @action("privateLinkResources")
  getPrivateLinkResources is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<PrivateLinkResourcesWrapper>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Resets the api key for an existing static site.
   */
  @summary("Resets the api key for an existing static site.")
  @action("resetapikey")
  resetStaticSiteApiKey is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteResetPropertiesARMResource,
    {
      @body body: void;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Returns details of database connections for a static site
   */
  @summary("Returns details of database connections for a static site")
  @action("showDatabaseConnections")
  @list
  getDatabaseConnectionsWithDetails is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<DatabaseConnectionCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Deploys zipped content to a static site.
   */
  @summary("Deploys zipped content to a static site.")
  @action("zipdeploy")
  createZipDeploymentForStaticSite is ArmResourceActionAsync<
    StaticSiteARMResource,
    StaticSiteZipDeploymentARMResource,
    {
      @body body: void;
    },
    Error = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(StaticSiteARMResource.name, "Name of the static site.");
@@doc(StaticSiteARMResource.properties, "Core resource properties");
@@doc(StaticSiteARMResources.createOrUpdateStaticSite::parameters.resource,
  "A JSON representation of the staticsite properties. See example."
);
@@doc(StaticSiteARMResources.updateStaticSite::parameters.properties,
  "A JSON representation of the staticsite properties. See example."
);
@@doc(StaticSiteARMResources.updateStaticSiteUser::parameters.body,
  "A JSON representation of the StaticSiteUser properties. See example."
);
@@doc(StaticSiteARMResources.createOrUpdateStaticSiteAppSettings::parameters.body,
  "The dictionary containing the static site app settings to update."
);
@@doc(StaticSiteARMResources.createOrUpdateStaticSiteFunctionAppSettings::parameters.body,
  "The dictionary containing the static site function app settings to update."
);
@@doc(StaticSiteARMResources.createUserRolesInvitationLink::parameters.body,
  ""
);
@@doc(StaticSiteARMResources.resetStaticSiteApiKey::parameters.body, "");
@@doc(StaticSiteARMResources.createZipDeploymentForStaticSite::parameters.body,
  "A JSON representation of the StaticSiteZipDeployment properties. See example."
);
