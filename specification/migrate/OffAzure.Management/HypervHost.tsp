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

@armResourceOperations(#{ omitTags: true })
interface HypervHosts {
  /**
   * Get a HypervHost
   */
  @tag("HypervHostController")
  get is ArmResourceRead<HypervHost>;

  /**
   * Create a HypervHost
   */
  @tag("HypervHostController")
  create is ArmResourceCreateOrReplaceAsync<
    HypervHost,
    LroHeaders = ArmLroLocationHeader<FinalResult = HypervHost> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a HypervHost
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("HypervHostController")
  delete is ArmResourceDeleteWithoutOkAsync<
    HypervHost,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List HypervHost resources by HypervSite
   */
  @tag("HypervHostController")
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
