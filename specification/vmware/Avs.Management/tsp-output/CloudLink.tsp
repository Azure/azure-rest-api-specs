import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A cloud link resource
 */
@parentResource(PrivateCloud)
model CloudLink is ProxyResource<CloudLinkProperties> {
  /**
   * Name of the cloud link resource
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("cloudLinkName")
  @segment("cloudLinks")
  name: string;
}

@armResourceOperations
interface CloudLinks {
  /**
   * Get an cloud link by name in a private cloud
   */
  get is ArmResourceRead<CloudLink>;

  /**
   * Create or update a cloud link in a private cloud
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CloudLink>;

  /**
   * Delete a cloud link in a private cloud
   */
  delete is ArmResourceDeleteAsync<CloudLink>;

  /**
   * List cloud link in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CloudLinks_List")
  list is ArmResourceListByParent<CloudLink>;
}

@@projectedName(CloudLinks.createOrUpdate::parameters.resource,
  "json",
  "cloudLink"
);
@@extension(CloudLinks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cloudLink"
);
@@doc(CloudLinks.createOrUpdate::parameters.resource,
  "A cloud link in the private cloud"
);
