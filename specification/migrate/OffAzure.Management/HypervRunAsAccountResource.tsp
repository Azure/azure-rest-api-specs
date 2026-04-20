import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HypervSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A machine resource belonging to a site resource.
 */
@parentResource(HypervSite)
model HypervRunAsAccountResource
  is Azure.ResourceManager.ProxyResource<RunAsAccountProperties> {
  ...ResourceNameParameter<
    Resource = HypervRunAsAccountResource,
    KeyName = "accountName",
    SegmentName = "runAsAccounts"
  >;
}

@armResourceOperations
interface HypervRunAsAccountResources {
  /**
   * Get a HypervRunAsAccountResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervRunAsAccountsController_Get")
  get is ArmResourceRead<HypervRunAsAccountResource>;

  /**
   * List HypervRunAsAccountResource resources by HypervSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervRunAsAccountsController_ListByHypervSite")
  listByHypervSite is ArmResourceListByParent<HypervRunAsAccountResource>;
}

@@doc(HypervRunAsAccountResource.name, " RunAsAccounts name");
@@doc(HypervRunAsAccountResource.properties,
  "The resource-specific properties for this resource."
);
