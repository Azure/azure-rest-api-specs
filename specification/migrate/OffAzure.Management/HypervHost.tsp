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
 * A host resource belonging to a site resource.
 */
@parentResource(HypervSite)
model HypervHost is Azure.ResourceManager.ProxyResource<HypervHostProperties> {
  ...ResourceNameParameter<
    Resource = HypervHost,
    KeyName = "hostName",
    SegmentName = "hosts"
  >;
}

@armResourceOperations
interface HypervHosts {
  /**
   * Get a HypervHost
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervHostController_Get")
  get is ArmResourceRead<HypervHost>;

  /**
   * Create a HypervHost
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervHostController_Create")
  create is ArmResourceCreateOrReplaceAsync<
    HypervHost,
    LroHeaders = ArmLroLocationHeader<FinalResult = HypervHost> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a HypervHost
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("HypervHostController_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    HypervHost,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List HypervHost resources by HypervSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervHostController_ListByHypervSite")
  listByHypervSite is ArmResourceListByParent<
    HypervHost,
    Parameters = {
      /**
       * filter query
       */
      @query("filter")
      filter?: string;
    }
  >;
}

@@doc(HypervHost.name, " Host name");
@@doc(HypervHost.properties,
  "The resource-specific properties for this resource."
);
