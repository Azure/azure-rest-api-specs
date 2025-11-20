import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

@doc("Site as ARM Resource")
model Site is ProxyResource<SiteProperties> {
  #suppress "@typespec/http/metadata-ignored" ""
  @doc("Name of Site resource")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
interface Sites {
  get is ArmResourceRead<Site>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;
  update is ArmCustomPatchSync<Site, SiteUpdate>;
  delete is ArmResourceDeleteSync<Site>;
  listByResourceGroup is ArmResourceListByParent<Site>;
}

alias SubscriptionParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of subscription"
interface SitesBySubscription {
  list is ArmListBySubscription<Site>;
  get is ArmResourceRead<Site, BaseParameters = SubscriptionParameters>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters = SubscriptionParameters
  >;
  update is ArmCustomPatchSync<
    Site,
    SiteUpdate,
    BaseParameters = SubscriptionParameters
  >;

  delete is ArmResourceDeleteSync<
    Site,
    BaseParameters = SubscriptionParameters
  >;
}

@doc("ServiceGroup as parameter")
model ServiceGroupParameters {
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  @doc("The name of the service group.")
  servicegroupName: string;

  ...ApiVersionParameter;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of Tenant"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operation for tenant scope"
@route("/providers/Microsoft.Management/serviceGroups")
interface SitesByServiceGroup {
  @doc("list Site at SG scope")
  @operationId("SitesByServiceGroup_ListByServiceGroup")
  list is ArmResourceListByParent<Site, ServiceGroupParameters>;

  @doc("Get Site at SG scope")
  get is ArmResourceRead<Site, ServiceGroupParameters>;

  @doc("create or update Site at SG scope")
  @operationId("SitesByServiceGroup_CreateOrUpdate")
  put is ArmResourceCreateOrUpdateAsync<Site, ServiceGroupParameters>;

  @doc("delete Site at SG scope")
  delete is ArmResourceDeleteSync<Site, ServiceGroupParameters>;

  @doc("update Site at SG scope")
  update is ArmCustomPatchSync<Site, SiteUpdate, ServiceGroupParameters>;
}
