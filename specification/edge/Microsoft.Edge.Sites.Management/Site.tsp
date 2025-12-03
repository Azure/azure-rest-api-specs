import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

@doc("Site as ARM Resource")
model Site is ProxyResource<SiteProperties> {
  ...ResourceNameParameter<
    Resource = Site,
    KeyName = "siteName",
    SegmentName = "sites",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
}

alias SiteOps = Azure.ResourceManager.Legacy.LegacyOperations<
  ResourceInstanceParameters<Extension.ResourceGroup>,
  KeysOf<Site>
>;

@armResourceOperations
interface Sites {
  get is Extension.Read<Extension.ResourceGroup, Site>;
  createOrUpdate is Extension.CreateOrUpdateAsync<
    Extension.ResourceGroup,
    Site
  >;
  update is Extension.CustomPatchSync<
    Extension.ResourceGroup,
    Site,
    SiteUpdate
  >;
  delete is Extension.DeleteSync<Extension.ResourceGroup, Site>;
  /** List a Site */
  listByResourceGroup is Extension.ListByTarget<Extension.ResourceGroup, Site>;
}

@armResourceOperations(#{ omitTags: true })
interface SitesBySubscription {
  /** List Site resources by subscription ID */
  list is Extension.ListByTarget<Extension.Subscription, Site>;
  get is Extension.Read<Extension.Subscription, Site>;
  createOrUpdate is Extension.CreateOrUpdateAsync<Extension.Subscription, Site>;
  update is Extension.CustomPatchSync<Extension.Subscription, Site, SiteUpdate>;
  delete is Extension.DeleteSync<Extension.Subscription, Site>;
}

alias ServiceGroup = Extension.ExternalResource<
  "Microsoft.Management",
  "serviceGroups",
  "servicegroupName",
  NamePattern = "^[a-zA-Z0-9\\-_().]{1,90}$",
  ParentType = "Tenant"
>;

@armResourceOperations(#{ omitTags: true })
interface SitesByServiceGroup {
  @doc("list Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  @list
  listByServiceGroup is Extension.ListByTarget<ServiceGroup, Site>;

  @doc("Get Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  get is Extension.Read<ServiceGroup, Site>;

  @doc("create or update Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  createOrUpdate is Extension.CreateOrUpdateAsync<ServiceGroup, Site>;

  @doc("update Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  update is Extension.CustomPatchSync<ServiceGroup, Site, SiteUpdate>;

  @doc("delete Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  delete is Extension.DeleteSync<ServiceGroup, Site>;
}
