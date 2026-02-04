import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

@doc("Site as Extension Resource")
model Site is ExtensionResource<SiteProperties> {
  ...ResourceNameParameter<
    Resource = Site,
    KeyName = "siteName",
    SegmentName = "sites",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
}

@doc("Site operations as base operations which will be extended for each scopes")
interface SiteOps<
  Scope extends Azure.ResourceManager.Foundations.SimpleResource,
  ResourceName extends valueof string = ""
> {
  list is Extension.ListByTarget<
    Scope,
    Site,
    OverrideResourceName = ResourceName
  >;
  get is Extension.Read<Scope, Site, OverrideResourceName = ResourceName>;
  createOrUpdate is Extension.CreateOrUpdateAsync<
    Scope,
    Site,
    OverrideResourceName = ResourceName
  >;
  update is Extension.CustomPatchSync<
    Scope,
    Site,
    SiteUpdate,
    OverrideResourceName = ResourceName
  >;
  delete is Extension.DeleteSync<
    Scope,
    Site,
    OverrideResourceName = ResourceName
  >;
}

@armResourceOperations
interface Sites extends SiteOps<Extension.ResourceGroup> {}

@armResourceOperations(#{ omitTags: true })
interface SitesBySubscription
  extends SiteOps<Extension.Subscription, "SubscriptionEdgeSite"> {}

alias ServiceGroup = Extension.ExternalResource<
  TargetNamespace = "Microsoft.Management",
  ResourceType = "serviceGroups",
  ResourceParameterName = "servicegroupName",
  NamePattern = "^[a-zA-Z0-9\\-_().]{1,90}$",
  Description = "The name of the service group",
  ParentType = "Tenant"
>;

@armResourceOperations(#{ omitTags: true })
@added(Versions.v2025_03_01_preview)
@added(Versions.v2025_06_01)
interface SitesByServiceGroup
  extends SiteOps<ServiceGroup, "ServiceGroupEdgeSite"> {}
