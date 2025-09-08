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
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model StaticSiteARMResource
  is Azure.ResourceManager.TrackedResource<StaticSite> {
  ...ResourceNameParameter<
    Resource = StaticSiteARMResource,
    KeyName = "name",
    SegmentName = "staticSites",
    NamePattern = ""
  >;

  /**
   * Description of a SKU for a scalable resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: SkuDescription;

  /**
   * Managed service identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface StaticSiteARMResources {
  /**
   * Description for Gets the details of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetStaticSite")
  getStaticSite is ArmResourceRead<StaticSiteARMResource>;

  /**
   * Description for Creates a new static site in an existing resource group, or updates an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateStaticSite")
  createOrUpdateStaticSite is ArmResourceCreateOrReplaceAsync<
    StaticSiteARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteARMResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: StaticSiteARMResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteARMResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Creates a new static site in an existing resource group, or updates an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @operationId("StaticSites_UpdateStaticSite")
  @patch(#{ implicitOptionality: false })
  updateStaticSite is ArmCustomPatchSync<
    StaticSiteARMResource,
    PatchModel = StaticSitePatchResource,
    Response = ArmResponse<StaticSiteARMResource> | (AcceptedResponse & {
      @bodyRoot
      _: StaticSiteARMResource;
    })
  >;

  /**
   * Description for Deletes a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_DeleteStaticSite")
  deleteStaticSite is ArmResourceDeleteWithoutOkAsync<
    StaticSiteARMResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Description for Gets all static sites in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetStaticSitesByResourceGroup")
  getStaticSitesByResourceGroup is ArmResourceListByParent<
    StaticSiteARMResource,
    Response = ArmResponse<StaticSiteCollection>
  >;

  /**
   * Description for Get all Static Sites for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_List")
  list is ArmListBySubscription<
    StaticSiteARMResource,
    Response = ArmResponse<StaticSiteCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the list of users of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteUsers")
  @action("listUsers")
  @list
  listStaticSiteUsers is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StaticSiteUserCollection>,
    Parameters = {
      /**
       * The auth provider for the users.
       */
      @path
      @segment("authprovider")
      authprovider: string;
    }
  >;

  /**
   * Description for Deletes the user entry from the static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_DeleteStaticSiteUser")
  @delete
  @action("{userid}")
  deleteStaticSiteUser is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * The auth provider for this user.
       */
      @path
      authprovider: string;

      /**
       * The user id of the user.
       */
      @path
      userid: string;
    }
  >;

  /**
   * Description for Updates a user entry with the listed roles
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_UpdateStaticSiteUser")
  @patch(#{ implicitOptionality: true })
  updateStaticSiteUser(
    ...ResourceInstanceParameters<StaticSiteARMResource>,

    /**
     * The auth provider for this user.
     */
    @path
    @segment("authprovider")
    authprovider: string,

    /**
     * The user id of the user.
     */
    @path
    @segment("users")
    userid: string,

    @body
    staticSiteUserEnvelope: StaticSiteUserARMResource,
  ): ArmResponse<StaticSiteUserARMResource>;

  /**
   * Description for Creates or updates the app settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_CreateOrUpdateStaticSiteAppSettings")
  @put
  @action("appsettings")
  createOrUpdateStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Creates or updates the function app settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_CreateOrUpdateStaticSiteFunctionAppSettings")
  @put
  @action("functionappsettings")
  createOrUpdateStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Creates an invitation link for a user with the role
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_CreateUserRolesInvitationLink")
  @action("createUserInvitation")
  createUserRolesInvitationLink is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteUserInvitationRequestResource,
    ArmResponse<StaticSiteUserInvitationResponseResource>
  >;

  /**
   * Description for Detaches a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_DetachStaticSite")
  @action("detach")
  detachStaticSite is ArmResourceActionAsync<
    StaticSiteARMResource,
    void,
    OkResponse
  >;

  /**
   * Description for Gets the functions of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteFunctions")
  @get
  @action("functions")
  listStaticSiteFunctions is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StaticSiteFunctionOverviewCollection>
  >;

  /**
   * Description for Gets the application settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteAppSettings")
  @action("listAppSettings")
  listStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Lists the roles configured for the static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteConfiguredRoles")
  @action("listConfiguredRoles")
  listStaticSiteConfiguredRoles is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringList>
  >;

  /**
   * Description for Gets the application settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteFunctionAppSettings")
  @action("listFunctionAppSettings")
  listStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Lists the secrets for an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteSecrets")
  @action("listSecrets")
  listStaticSiteSecrets is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Gets the private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetPrivateLinkResources")
  @get
  @action("privateLinkResources")
  getPrivateLinkResources is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<PrivateLinkResourcesWrapper>
  >;

  /**
   * Description for Resets the api key for an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ResetStaticSiteApiKey")
  @action("resetapikey")
  resetStaticSiteApiKey is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteResetPropertiesARMResource,
    OkResponse
  >;

  /**
   * Returns details of database connections for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetDatabaseConnectionsWithDetails")
  @action("showDatabaseConnections")
  getDatabaseConnectionsWithDetails is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<DatabaseConnectionCollection>
  >;

  /**
   * Description for Deploys zipped content to a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_CreateZipDeploymentForStaticSite")
  @action("zipdeploy")
  createZipDeploymentForStaticSite is ArmResourceActionAsync<
    StaticSiteARMResource,
    StaticSiteZipDeploymentARMResource,
    OkResponse
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
@@doc(StaticSiteARMResources.updateStaticSiteUser::parameters.staticSiteUserEnvelope,
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
