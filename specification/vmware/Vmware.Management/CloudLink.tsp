import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A cloud link resource
 */
@parentResource(PrivateCloud)
model CloudLink is Azure.ResourceManager.ProxyResource<CloudLinkProperties> {
  ...ResourceNameParameter<
    Resource = CloudLink,
    KeyName = "cloudLinkName",
    SegmentName = "cloudLinks",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface CloudLinks {
  /**
   * Get a CloudLink
   */
  get is ArmResourceRead<CloudLink>;

  /**
   * Create a CloudLink
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CloudLink>;

  /**
   * Delete a CloudLink
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    CloudLink,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List CloudLink resources by PrivateCloud
   */
  list is ArmResourceListByParent<
    CloudLink,
    Response = ArmResponse<CloudLinkList>
  >;
}

@@doc(CloudLink.name, "Name of the cloud link.");
@@doc(CloudLink.properties,
  "The resource-specific properties for this resource."
);
