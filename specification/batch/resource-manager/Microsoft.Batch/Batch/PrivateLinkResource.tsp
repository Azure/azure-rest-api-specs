import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about a private link resource.
 */
@parentResource(BatchAccount)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = "^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$"
  >;

  /**
   * The ETag of the resource, used for concurrency statements.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
@tag("PrivateLinkResource")
interface PrivateLinkResources {
  /**
   * Gets information about the specified private link resource.
   */
  get is ArmResourceRead<PrivateLinkResource, Error = CloudError>;

  /**
   * Lists all of the private link resources in the specified account.
   */
  listByBatchAccount is ArmResourceListByParent<
    PrivateLinkResource,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListPrivateLinkResourcesResult>,
    Error = CloudError
  >;
}

@@maxLength(PrivateLinkResource.name, 101);
@@minLength(PrivateLinkResource.name, 1);
@@doc(PrivateLinkResource.name,
  "The private link resource name. This must be unique within the account."
);
@@doc(PrivateLinkResource.properties,
  "The properties associated with the private link resource."
);
