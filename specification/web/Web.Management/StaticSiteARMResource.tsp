import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Static Site ARM resource.
 */
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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Creates a new static site in an existing resource group, or updates an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("StaticSites_UpdateStaticSite")
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
    Response = ArmResponse<StaticSiteCollection>
  >;

  /**
   * Description for Gets the list of users of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listUsers")
  @operationId("StaticSites_ListStaticSiteUsers")
  listStaticSiteUsers is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StaticSiteUserCollection>,
    Parameters = {
      /**
       * The auth provider for the users.
       */
      @path
      authprovider: string;
    }
  >;

  /**
   * Description for Deletes the user entry from the static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{userid}")
  @operationId("StaticSites_DeleteStaticSiteUser")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch
  @action("{userid}")
  @operationId("StaticSites_UpdateStaticSiteUser")
  updateStaticSiteUser is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteUserARMResource,
    ArmResponse<StaticSiteUserARMResource>,
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
   * Description for Creates or updates the app settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @action("appsettings")
  @operationId("StaticSites_CreateOrUpdateStaticSiteAppSettings")
  createOrUpdateStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Creates or updates the function app settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @action("functionappsettings")
  @operationId("StaticSites_CreateOrUpdateStaticSiteFunctionAppSettings")
  createOrUpdateStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    StringDictionary,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Creates an invitation link for a user with the role
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("createUserInvitation")
  @operationId("StaticSites_CreateUserRolesInvitationLink")
  createUserRolesInvitationLink is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteUserInvitationRequestResource,
    ArmResponse<StaticSiteUserInvitationResponseResource>
  >;

  /**
   * Description for Detaches a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("detach")
  @operationId("StaticSites_DetachStaticSite")
  detachStaticSite is ArmResourceActionAsync<
    StaticSiteARMResource,
    void,
    OkResponse
  >;

  /**
   * Description for Gets the functions of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("functions")
  @operationId("StaticSites_ListStaticSiteFunctions")
  listStaticSiteFunctions is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StaticSiteFunctionOverviewCollection>
  >;

  /**
   * Description for Gets the application settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listAppSettings")
  @operationId("StaticSites_ListStaticSiteAppSettings")
  listStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Lists the roles configured for the static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listConfiguredRoles")
  @operationId("StaticSites_ListStaticSiteConfiguredRoles")
  listStaticSiteConfiguredRoles is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringList>
  >;

  /**
   * Description for Gets the application settings of a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listFunctionAppSettings")
  @operationId("StaticSites_ListStaticSiteFunctionAppSettings")
  listStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Lists the secrets for an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listSecrets")
  @operationId("StaticSites_ListStaticSiteSecrets")
  listStaticSiteSecrets is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<StringDictionary>
  >;

  /**
   * Description for Gets the private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("StaticSites_GetPrivateLinkResources")
  getPrivateLinkResources is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<PrivateLinkResourcesWrapper>
  >;

  /**
   * Description for Resets the api key for an existing static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("resetapikey")
  @operationId("StaticSites_ResetStaticSiteApiKey")
  resetStaticSiteApiKey is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteResetPropertiesARMResource,
    OkResponse
  >;

  /**
   * Returns details of database connections for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("showDatabaseConnections")
  @operationId("StaticSites_GetDatabaseConnectionsWithDetails")
  getDatabaseConnectionsWithDetails is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    ArmResponse<DatabaseConnectionCollection>
  >;

  /**
   * Description for Deploys zipped content to a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("zipdeploy")
  @operationId("StaticSites_CreateZipDeploymentForStaticSite")
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
