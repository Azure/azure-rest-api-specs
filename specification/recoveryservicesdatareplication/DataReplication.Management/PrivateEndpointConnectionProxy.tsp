import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Represents private endpoint connection proxy request.
 */
@parentResource(VaultModel)
model PrivateEndpointConnectionProxy
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProxyProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionProxy,
    KeyName = "privateEndpointConnectionProxyName",
    SegmentName = "privateEndpointConnectionProxies",
    NamePattern = "^[a-zA-Z0-9-.]*$"
  >;

  /**
   * Gets or sets ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(PrivateEndpointConnectionProxies.create::parameters.resource,
  "x-ms-client-name",
  "body"
);

@armResourceOperations
interface PrivateEndpointConnectionProxies {
  /**
   * Gets the private endpoint connection proxy details.
   */
  get is ArmResourceRead<PrivateEndpointConnectionProxy>;

  /**
   * Create a new private endpoint connection proxy which includes both auto and manual approval types. Creating the proxy resource will also create a private endpoint connection resource.
   */
  create is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionProxy>;

  /**
   * Returns the operation to track the deletion of private endpoint connection proxy.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnectionProxy>;

  /**
   * Gets the all private endpoint connections proxies.
   */
  list is ArmResourceListByParent<PrivateEndpointConnectionProxy>;

  /**
   * Returns remote private endpoint connection information after validation.
   */
  validate is ArmResourceActionSync<
    PrivateEndpointConnectionProxy,
    PrivateEndpointConnectionProxy,
    PrivateEndpointConnectionProxy
  >;
}

@@doc(PrivateEndpointConnectionProxy.name,
  "The private endpoint connection proxy name."
);
@@doc(PrivateEndpointConnectionProxies.create::parameters.resource,
  "Private endpoint connection creation input."
);
@@doc(PrivateEndpointConnectionProxies.validate::parameters.body,
  "The private endpoint connection proxy input."
);
