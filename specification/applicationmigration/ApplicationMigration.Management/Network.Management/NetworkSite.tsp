import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * A network discovery site resource.
 */
model NetworkSite
  is Azure.ResourceManager.TrackedResource<NetworkSiteProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkSite,
    KeyName = "siteName",
    SegmentName = "networkSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a network site.
 */
model NetworkSiteProperties is AzureResourceProperties {
  /** ARM resource ID of the associated master site. */
  masterSiteId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/masterSites",
    }
  ]>;

  /** ARM resource ID of the associated migrate project. */
  migrateProjectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects",
    }
  ]>;
}

@armResourceOperations
interface NetworkSites {
  /**
   * Gets the NetworkSite resource.
   */
  get is ArmResourceRead<NetworkSite>;

  /**
   * Creates or updates the NetworkSite resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetworkSite>;

  /**
   * Patches the NetworkSite resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkSite, SiteTagsPatch>;

  /**
   * Deletes the NetworkSite resource.
   */
  delete is ArmResourceDeleteSync<NetworkSite>;

  /**
   * Lists NetworkSite resources in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    NetworkSite,
    Response = ArmResponse<NetworkSiteList>
  >;

  /**
   * Lists NetworkSite resources in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    NetworkSite,
    Response = ArmResponse<NetworkSiteList>
  >;
}

model NetworkSiteList is Azure.Core.Page<NetworkSite>;

@@maxLength(NetworkSite.name, 63);
@@minLength(NetworkSite.name, 3);
@@doc(NetworkSite.name, "The name of the network site.");
