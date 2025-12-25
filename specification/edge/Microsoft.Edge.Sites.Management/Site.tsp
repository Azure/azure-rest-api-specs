import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ResourceManager;

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
interface SiteOps<Scope extends Azure.ResourceManager.Foundations.SimpleResource> {
  list is Extension.ListByTarget<Scope, Site>;
  get is Extension.Read<Scope, Site>;
  createOrUpdate is Extension.CreateOrUpdateAsync<Scope, Site>;
  update is Extension.CustomPatchSync<Scope, Site, SiteUpdate>;
  delete is Extension.DeleteSync<Scope, Site>;
}

@armResourceOperations
interface Sites extends SiteOps<Extension.ResourceGroup> {}

@armResourceOperations
interface SitesBySubscription extends SiteOps<Extension.Subscription> {}

alias ServiceGroup = Extension.ExternalResource<
  TargetNamespace = "Microsoft.Management",
  ResourceType = "serviceGroups",
  ResourceParameterName = "servicegroupName",
  NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$",
  Description = "The name of the service group",
  ParentType = "Tenant"
>;

@armResourceOperations
interface SitesByServiceGroup extends SiteOps<ServiceGroup> {}
