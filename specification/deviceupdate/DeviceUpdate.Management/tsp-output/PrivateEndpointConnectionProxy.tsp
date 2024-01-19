import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
@doc("Private endpoint connection proxy details.")
@parentResource(Account)
model PrivateEndpointConnectionProxy
  is ProxyResource<PrivateEndpointConnectionProxyProperties> {
  @doc("The ID of the private endpoint connection proxy object.")
  @path
  @key("privateEndpointConnectionProxyId")
  @segment("privateEndpointConnectionProxies")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnectionProxies {
  @doc("(INTERNAL - DO NOT USE) Get the specified private endpoint connection proxy associated with the device update account.")
  get is ArmResourceRead<PrivateEndpointConnectionProxy>;

  @doc("(INTERNAL - DO NOT USE) Creates or updates the specified private endpoint connection proxy resource associated with the device update account.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrivateEndpointConnectionProxy,
    BaseParameters<PrivateEndpointConnectionProxy>,
    ArmAsyncOperationHeader
  >;

  @doc("(INTERNAL - DO NOT USE) Deletes the specified private endpoint connection proxy associated with the device update account.")
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnectionProxy,
    BaseParameters<PrivateEndpointConnectionProxy>,
    ArmLroLocationHeader
  >;

  @doc("(INTERNAL - DO NOT USE) List all private endpoint connection proxies in a device update account.")
  listByAccount is ArmResourceListByParent<PrivateEndpointConnectionProxy>;

  @doc("(INTERNAL - DO NOT USE) Validates a private endpoint connection proxy object.")
  validate is ArmResourceActionSync<
    PrivateEndpointConnectionProxy,
    PrivateEndpointConnectionProxy,
    void
  >;

  @doc("(INTERNAL - DO NOT USE) Updates a private endpoint inside the private endpoint connection proxy object.")
  updatePrivateEndpointProperties is ArmResourceActionSync<
    PrivateEndpointConnectionProxy,
    PrivateEndpointUpdate,
    void
  >;
}

@@projectedName(PrivateEndpointConnectionProxies.createOrUpdate::parameters.resource,
  "json",
  "privateEndpointConnectionProxy"
);
@@extension(PrivateEndpointConnectionProxies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnectionProxy"
);
@@doc(PrivateEndpointConnectionProxies.createOrUpdate::parameters.resource,
  "The parameters for creating a private endpoint connection proxy."
);
@@projectedName(PrivateEndpointConnectionProxies.validate::parameters.body,
  "json",
  "privateEndpointConnectionProxy"
);
@@extension(PrivateEndpointConnectionProxies.validate::parameters.body,
  "x-ms-client-name",
  "privateEndpointConnectionProxy"
);
@@doc(PrivateEndpointConnectionProxies.validate::parameters.body,
  "The parameters for creating a private endpoint connection proxy."
);
@@projectedName(PrivateEndpointConnectionProxies.updatePrivateEndpointProperties::parameters.body,
  "json",
  "privateEndpointUpdate"
);
@@extension(PrivateEndpointConnectionProxies.updatePrivateEndpointProperties::parameters.body,
  "x-ms-client-name",
  "privateEndpointUpdate"
);
@@doc(PrivateEndpointConnectionProxies.updatePrivateEndpointProperties::parameters.body,
  "The parameters for updating a private endpoint connection proxy."
);
