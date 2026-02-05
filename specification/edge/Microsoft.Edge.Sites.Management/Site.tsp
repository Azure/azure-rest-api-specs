import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
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
  get is SiteOps.Read<Site>;
  createOrUpdate is SiteOps.CreateOrUpdateAsync<Site>;
  update is SiteOps.CustomPatchSync<Site, SiteUpdate>;
  delete is SiteOps.DeleteSync<Site>;
  listByResourceGroup is SiteOps.List<Site>;
}

alias SiteBySubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  ResourceInstanceParameters<Extension.Subscription>,
  KeysOf<Site>
>;

@armResourceOperations(#{ omitTags: true })
interface SitesBySubscription {
  /** List Site resources by subscription ID */
  list is SiteBySubscriptionOps.List<Site>;
  get is SiteBySubscriptionOps.Read<Site>;
  createOrUpdate is SiteBySubscriptionOps.CreateOrUpdateAsync<Site>;
  update is SiteBySubscriptionOps.CustomPatchSync<Site, SiteUpdate>;
  delete is SiteBySubscriptionOps.DeleteSync<Site>;
}

alias SiteByServiceGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    /**
     * The name of the service group
     */
    @segment("serviceGroups")
    @pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
    @key
    @path
    servicegroupName: string;
  },
  Extension.ExtensionProviderNamespace<Site>,
  {
    ...Extension.ExtensionProviderNamespace<Site>;
    ...KeysOf<Site>;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface SitesByServiceGroup {
  @doc("list Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  @list
  listByServiceGroup is SiteByServiceGroupOps.List<Site>;

  @doc("Get Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  get is SiteByServiceGroupOps.Read<Site>;

  @doc("create or update Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  createOrUpdate is SiteByServiceGroupOps.CreateOrUpdateAsync<Site>;

  @doc("update Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  update is SiteByServiceGroupOps.CustomPatchSync<Site, SiteUpdate>;

  @doc("delete Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  delete is SiteByServiceGroupOps.DeleteSync<Site>;
}
