import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Static Site ARM resource.")
model StaticSiteARMResource is TrackedResource<StaticSite> {
  @doc("Name of the static site.")
  @path
  @key("name")
  @segment("staticSites")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface StaticSiteARMResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the details of a static site.")
  @operationId("StaticSites_GetStaticSite")
  getStaticSite is ArmResourceRead<StaticSiteARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a new static site in an existing resource group, or updates an existing static site.")
  @operationId("StaticSites_CreateOrUpdateStaticSite")
  createOrUpdateStaticSite is ArmResourceCreateOrUpdateAsync<StaticSiteARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a new static site in an existing resource group, or updates an existing static site.")
  @operationId("StaticSites_UpdateStaticSite")
  updateStaticSite is ArmCustomPatchSync<
    StaticSiteARMResource,
    StaticSitePatchResource
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a static site.")
  @operationId("StaticSites_DeleteStaticSite")
  deleteStaticSite is ArmResourceDeleteAsync<StaticSiteARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets all static sites in the specified resource group.")
  @operationId("StaticSites_GetStaticSitesByResourceGroup")
  getStaticSitesByResourceGroup is ArmResourceListByParent<StaticSiteARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get all Static Sites for a subscription.")
  @operationId("StaticSites_List")
  list is ArmListBySubscription<StaticSiteARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the list of users of a static site.")
  @operationId("StaticSites_ListStaticSiteUsers")
  listStaticSiteUsers is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StaticSiteUserCollection,
    {
      ...BaseParameters<StaticSiteARMResource>;

      @doc("The auth provider for the users.")
      @path
      authprovider: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates an invitation link for a user with the role")
  @operationId("StaticSites_CreateUserRolesInvitationLink")
  createUserRolesInvitationLink is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteUserInvitationRequestResource,
    StaticSiteUserInvitationResponseResource
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Detaches a static site.")
  @operationId("StaticSites_DetachStaticSite")
  detachStaticSite is ArmResourceActionAsync<StaticSiteARMResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the application settings of a static site.")
  @operationId("StaticSites_ListStaticSiteAppSettings")
  listStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringDictionary
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Lists the roles configured for the static site.")
  @operationId("StaticSites_ListStaticSiteConfiguredRoles")
  listStaticSiteConfiguredRoles is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the application settings of a static site.")
  @operationId("StaticSites_ListStaticSiteFunctionAppSettings")
  listStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringDictionary
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Lists the secrets for an existing static site.")
  @operationId("StaticSites_ListStaticSiteSecrets")
  listStaticSiteSecrets is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringDictionary
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Resets the api key for an existing static site.")
  @operationId("StaticSites_ResetStaticSiteApiKey")
  resetStaticSiteApiKey is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteResetPropertiesARMResource,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deploys zipped content to a static site.")
  @operationId("StaticSites_CreateZipDeploymentForStaticSite")
  createZipDeploymentForStaticSite is ArmResourceActionAsync<
    StaticSiteARMResource,
    StaticSiteZipDeploymentARMResource,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_ListStaticSiteFunctions")
  @summary("Gets the functions of a static site.")
  @doc("Description for Gets the functions of a static site.")
  // FIXME: StaticSites_ListStaticSiteFunctions could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/functions")
  @get
  listStaticSiteFunctions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StaticSiteFunctionOverviewCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_GetPrivateLinkResources")
  @summary("Gets the private link resources")
  @doc("Description for Gets the private link resources")
  // FIXME: StaticSites_GetPrivateLinkResources could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateLinkResources")
  @get
  getPrivateLinkResources is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesWrapper
  >;
}

@@projectedName(StaticSiteARMResources.createOrUpdateStaticSite::parameters.resource,
  "json",
  "staticSiteEnvelope"
);
@@extension(StaticSiteARMResources.createOrUpdateStaticSite::parameters.resource,
  "x-ms-client-name",
  "staticSiteEnvelope"
);
@@doc(StaticSiteARMResources.createOrUpdateStaticSite::parameters.resource,
  "A JSON representation of the staticsite properties. See example."
);
@@projectedName(StaticSiteARMResources.updateStaticSite::parameters.properties,
  "json",
  "staticSiteEnvelope"
);
@@extension(StaticSiteARMResources.updateStaticSite::parameters.properties,
  "x-ms-client-name",
  "staticSiteEnvelope"
);
@@doc(StaticSiteARMResources.updateStaticSite::parameters.properties,
  "A JSON representation of the staticsite properties. See example."
);
@@projectedName(StaticSiteARMResources.createUserRolesInvitationLink::parameters.body,
  "json",
  "staticSiteUserRolesInvitationEnvelope"
);
@@extension(StaticSiteARMResources.createUserRolesInvitationLink::parameters.body,
  "x-ms-client-name",
  "staticSiteUserRolesInvitationEnvelope"
);
@@doc(StaticSiteARMResources.createUserRolesInvitationLink::parameters.body,
  ""
);
@@projectedName(StaticSiteARMResources.resetStaticSiteApiKey::parameters.body,
  "json",
  "resetPropertiesEnvelope"
);
@@extension(StaticSiteARMResources.resetStaticSiteApiKey::parameters.body,
  "x-ms-client-name",
  "resetPropertiesEnvelope"
);
@@doc(StaticSiteARMResources.resetStaticSiteApiKey::parameters.body, "");
@@projectedName(StaticSiteARMResources.createZipDeploymentForStaticSite::parameters.body,
  "json",
  "staticSiteZipDeploymentEnvelope"
);
@@extension(StaticSiteARMResources.createZipDeploymentForStaticSite::parameters.body,
  "x-ms-client-name",
  "staticSiteZipDeploymentEnvelope"
);
@@doc(StaticSiteARMResources.createZipDeploymentForStaticSite::parameters.body,
  "A JSON representation of the StaticSiteZipDeployment properties. See example."
);
