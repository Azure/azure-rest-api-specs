import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Static Site ARM resource.")
model StaticSite is TrackedResource<StaticSite> {
  @doc("Name of the static site.")
  @path
  @key("name")
  @segment("staticSites")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface StaticSites {
  @doc("Description for Gets the details of a static site.")
  getStaticSite is ArmResourceRead<StaticSite>;
  @doc("Description for Creates a new static site in an existing resource group, or updates an existing static site.")
  createOrUpdateStaticSite is ArmResourceCreateOrUpdateAsync<StaticSite>;
  @doc("Description for Creates a new static site in an existing resource group, or updates an existing static site.")
  updateStaticSite is ArmResourcePatchSync<StaticSite, StaticSite>;
  @doc("Description for Deletes a static site.")
  deleteStaticSite is ArmResourceDeleteAsync<StaticSite>;
  @doc("Description for Gets all static sites in the specified resource group.")
  getStaticSitesByResourceGroup is ArmResourceListByParent<StaticSite>;
  @doc("Description for Get all Static Sites for a subscription.")
  list is ArmListBySubscription<StaticSite>;
  @doc("Description for Gets the list of users of a static site.")
  listStaticSiteUsers is ArmResourceActionSync<
    StaticSite,
    {},
    StaticSiteUserCollection,
    {
      ...BaseParameters<StaticSite>;

      @doc("The auth provider for the users.")
      @path
      authprovider: string;
    }
  >;
  @doc("Description for Creates an invitation link for a user with the role")
  createUserRolesInvitationLink is ArmResourceActionSync<
    StaticSite,
    StaticSiteUserInvitationRequestResource,
    StaticSiteUserInvitationResponseResource
  >;
  @doc("Description for Detaches a static site.")
  detachStaticSite is ArmResourceActionAsync<StaticSite, {}, {}>;
  @doc("Description for Gets the application settings of a static site.")
  listStaticSiteAppSettings is ArmResourceActionSync<
    StaticSite,
    {},
    StringDictionary
  >;
  @doc("Description for Lists the roles configured for the static site.")
  listStaticSiteConfiguredRoles is ArmResourceActionSync<
    StaticSite,
    {},
    StringList
  >;
  @doc("Description for Gets the application settings of a static site.")
  listStaticSiteFunctionAppSettings is ArmResourceActionSync<
    StaticSite,
    {},
    StringDictionary
  >;
  @doc("Description for Lists the secrets for an existing static site.")
  listStaticSiteSecrets is ArmResourceActionSync<
    StaticSite,
    {},
    StringDictionary
  >;
  @doc("Description for Resets the api key for an existing static site.")
  resetStaticSiteApiKey is ArmResourceActionSync<
    StaticSite,
    StaticSiteResetPropertiesARMResource,
    {}
  >;
  @doc("Description for Deploys zipped content to a static site.")
  createZipDeploymentForStaticSite is ArmResourceActionAsync<
    StaticSite,
    StaticSiteZipDeploymentARMResource,
    {}
  >;
  @summary("Gets the functions of a static site.")
  @doc("Description for Gets the functions of a static site.")
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
