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
/**
 * Site resource
 */
@subscriptionResource
model Site is ProxyResource<SiteProperties> {
  /**
   * Name of Site
   */
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
  /**
   * Get a Site at Subscription scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SitesGet_AtSub")
  sitesGetAtSubscription is ArmResourceRead<Site>;

  /**
   * Create a Site at Subscription scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SitesCreate_AtSub")
  sitesCreate_AtSub is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters<Site>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a Site at Subscription Scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SitesUpdate_AtSub")
  sitesUpdate_AtSub is ArmCustomPatchSync<Site, SiteUpdate>;

  /**
   * Delete a Site at Subscription scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SitesDelete_AtSub")
  sitesDelete_AtSub is ArmResourceDeleteSync<Site>;

  /**
   * List Site resources by Subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ListSites_BySubscription")
  bySubscription is ArmResourceListByParent<Site>;
}
