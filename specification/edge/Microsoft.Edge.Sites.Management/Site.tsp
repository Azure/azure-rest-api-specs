import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

@doc("Site as ARM Resource")
@subscriptionResource
model Site is ProxyResource<SiteProperties> {
  @doc("Name of Site resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility("read")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Sites {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List Site resources by Subscription")
  @operationId("listSitesAtSubscription")
  listSitesAtSubscription is ArmResourceListByParent<Site>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Site at Subscription scope")
  @operationId("sitesGetAtSubscription")
  sitesGetAtSubscription is ArmResourceRead<Site>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a Site at Subscription scope")
  @operationId("sitesCreateAtSubscription")
  sitesCreateAtSubscription is ArmResourceCreateOrReplaceAsync<Site, BaseParameters<Site>, ArmAsyncOperationHeader>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a Site at Subscription Scope")
  @parameterVisibility("read")
  @operationId("sitesUpdateAtSubscription")
  sitesUpdateAtSubscription is ArmCustomPatchSync<Site, SiteUpdate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Site at Subscription scope")
  @operationId("sitesDeleteAtSubscription")
  sitesDeleteAtSubscription is ArmResourceDeleteSync<Site>;
}
