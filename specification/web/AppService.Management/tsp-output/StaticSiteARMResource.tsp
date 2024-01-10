import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Static Site ARM resource.")
model StaticSiteARMResource is TrackedResource<StaticSite> {
  @doc("Name of the static site.")
  @key("name")
  @segment("staticSites")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
@projectedName("client", "StaticSites")
interface StaticSiteARMResources_StaticSites {
  @doc("Description for Gets the details of a static site.")
  getStaticSite is ArmResourceRead<StaticSiteARMResource>;

  @doc("Description for Creates a new static site in an existing resource group, or updates an existing static site.")
  createOrUpdateStaticSite is ArmResourceCreateOrUpdateAsync<StaticSiteARMResource>;

  @doc("Description for Creates a new static site in an existing resource group, or updates an existing static site.")
  updateStaticSite is ArmCustomPatchSync<
    StaticSiteARMResource,
    StaticSitePatchResource
  >;

  @doc("Description for Deletes a static site.")
  deleteStaticSite is ArmResourceDeleteAsync<StaticSiteARMResource>;

  @doc("Description for Gets all static sites in the specified resource group.")
  getStaticSitesByResourceGroup is ArmResourceListByParent<StaticSiteARMResource>;

  @doc("Description for Get all Static Sites for a subscription.")
  list is ArmListBySubscription<StaticSiteARMResource>;

  @doc("Description for Gets the list of users of a static site.")
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

  @doc("Description for Creates an invitation link for a user with the role")
  createUserRolesInvitationLink is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteUserInvitationRequestResource,
    StaticSiteUserInvitationResponseResource
  >;

  @doc("Description for Detaches a static site.")
  detachStaticSite is ArmResourceActionAsync<StaticSiteARMResource, void, void>;

  @doc("Description for Gets the application settings of a static site.")
  listStaticSiteAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringDictionary
  >;

  @doc("Description for Lists the roles configured for the static site.")
  listStaticSiteConfiguredRoles is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringList
  >;

  @doc("Description for Gets the application settings of a static site.")
  listStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringDictionary
  >;

  @doc("Description for Lists the secrets for an existing static site.")
  listStaticSiteSecrets is ArmResourceActionSync<
    StaticSiteARMResource,
    void,
    StringDictionary
  >;

  @doc("Description for Resets the api key for an existing static site.")
  resetStaticSiteApiKey is ArmResourceActionSync<
    StaticSiteARMResource,
    StaticSiteResetPropertiesARMResource,
    void
  >;

  @doc("Description for Deploys zipped content to a static site.")
  createZipDeploymentForStaticSite is ArmResourceActionAsync<
    StaticSiteARMResource,
    StaticSiteZipDeploymentARMResource,
    void
  >;

  @summary("Gets the functions of a static site.")
  @doc("Description for Gets the functions of a static site.")
  // FIXME: StaticSites_ListStaticSiteFunctions could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/functions")
  @get
  ListStaticSiteFunctions is Azure.Core.Foundations.Operation<
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

  @summary("Gets the private link resources")
  @doc("Description for Gets the private link resources")
  // FIXME: StaticSites_GetPrivateLinkResources could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateLinkResources")
  @get
  GetPrivateLinkResources is Azure.Core.Foundations.Operation<
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
