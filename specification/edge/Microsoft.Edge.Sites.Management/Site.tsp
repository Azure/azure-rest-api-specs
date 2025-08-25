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
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of Tenant"
interface SitesByServiceGroup {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operation for tenant scope"
  @route("/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites")
  @doc("list Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  @list
  listByServiceGroup(
    ...ApiVersionParameter,

    @path
    @doc("The name of the service group")
    @pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
    servicegroupName: string,
  ): ArmResponse<ResourceListResult<Site>> | ErrorResponse;

  @route("/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @doc("Get Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  get(
    ...ApiVersionParameter,

    @path
    @doc("The name of the service group")
    @pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
    servicegroupName: string,

    @path
    @doc("The name of the site")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
    siteName: string,
  ): ArmResponse<Site> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "custom PUT call"
  @route("/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @put
  @doc("create or update Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  createOrUpdate(
    ...ApiVersionParameter,

    @path
    @doc("The name of the service group")
    @pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
    servicegroupName: string,

    @path
    @doc("The name of the site")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
    siteName: string,

    @body
    @doc("The properties of the site")
    resource: Site,
  ): ArmResourceUpdatedResponse<Site> | ArmResourceCreatedResponse<
    Site,
    ArmAsyncOperationHeader<FinalResult = Site> &
      Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "custom PATCH call"
  @route("/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @patch(#{ implicitOptionality: true })
  @doc("update Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  update(
    ...ApiVersionParameter,

    @path
    @doc("The name of the service group")
    @pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
    servicegroupName: string,

    @path
    @doc("The name of the site")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
    siteName: string,

    @body
    @doc("The properties of the site")
    properties: SiteUpdate,
  ): ArmResponse<Site> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "custom DELETE call"
  @route("/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @delete
  @doc("delete Site at SG scope")
  @added(Versions.v2025_03_01_preview)
  delete(
    ...ApiVersionParameter,

    @path
    @doc("The name of the service group")
    @pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
    servicegroupName: string,

    @path
    @doc("The name of the site")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
    siteName: string,
  ): ArmDeletedResponse | ArmDeletedNoContentResponse | ErrorResponse;
}
