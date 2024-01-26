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
/**
 * Private endpoint connection proxy details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Account)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  PrivateEndpointConnectionProxyProperties
)
model PrivateEndpointConnectionProxy extends ProxyResourceBase {
  /**
   * The ID of the private endpoint connection proxy object.
   */
  @path
  @key("privateEndpointConnectionProxyId")
  @segment("privateEndpointConnectionProxies")
  @visibility("read")
  name: string;

  /**
   * Private endpoint connection proxy object property bag.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionProxyProperties;
}

@armResourceOperations
interface PrivateEndpointConnectionProxies {
  /**
   * (INTERNAL - DO NOT USE) Get the specified private endpoint connection proxy associated with the device update account.
   */
  get is ArmResourceRead<PrivateEndpointConnectionProxy>;

  /**
   * (INTERNAL - DO NOT USE) Creates or updates the specified private endpoint connection proxy resource associated with the device update account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnectionProxy,
    BaseParameters<PrivateEndpointConnectionProxy>,
    ArmAsyncOperationHeader
  >;

  /**
   * (INTERNAL - DO NOT USE) Deletes the specified private endpoint connection proxy associated with the device update account.
   */
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnectionProxy,
    BaseParameters<PrivateEndpointConnectionProxy>,
    ArmLroLocationHeader
  >;

  /**
   * (INTERNAL - DO NOT USE) List all private endpoint connection proxies in a device update account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnectionProxies_ListByAccount")
  listByAccount is ArmResourceListByParent<PrivateEndpointConnectionProxy>;

  /**
   * (INTERNAL - DO NOT USE) Validates a private endpoint connection proxy object.
   */
  validate is ArmResourceActionSync<
    PrivateEndpointConnectionProxy,
    PrivateEndpointConnectionProxy,
    void
  >;

  /**
   * (INTERNAL - DO NOT USE) Updates a private endpoint inside the private endpoint connection proxy object.
   */
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
