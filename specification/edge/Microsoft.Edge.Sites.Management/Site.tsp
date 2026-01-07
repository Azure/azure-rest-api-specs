import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Site properties")
model SiteProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @doc("Physical address of the site")
  siteAddress?: SiteAddressProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Key-value pairs for labeling the site resource.")
  labels?: Record<string>;

  @doc("Provisioning state of last operation")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Site address properties")
model SiteAddressProperties {
  @doc("First line of the street address")
  streetAddress1?: string;

  @doc("Second line of the street address")
  streetAddress2?: string;

  @doc("City of the address")
  city?: string;

  @doc("State or province of the address")
  stateOrProvince?: string;

  @doc("Country of the address")
  country?: string;

  @doc("Postal or ZIP code of the address")
  postalCode?: string;
}

@doc("The updatable properties of the Site.")
model SiteUpdateProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @doc("Physical address of the site")
  siteAddress?: SiteAddressProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Key-value pairs for labeling the site resource.")
  labels?: Record<string>;
}

@doc("The type used for update operations of the Site.")
model SiteUpdate {
  @doc("The updatable properties of the Site.")
  properties?: SiteUpdateProperties;
}

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
