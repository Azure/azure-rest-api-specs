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

namespace Microsoft.AzureStackHCI;
/**
 * The network interface resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(NetworkInterfaceProperties)
model NetworkInterfaces extends TrackedResourceBase {
  /**
   * Name of the network interface
   */
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  @visibility("read")
  name: string;

  /**
   * The extendedLocation of the resource.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties under the network interface resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkInterfaceProperties;
}

@armResourceOperations
@projectedName("client", "NetworkInterfaces")
interface NetworkInterfacesOperationGroup {
  /**
   * Gets a network interface
   */
  get is ArmResourceRead<NetworkInterfaces>;

  /**
   * The operation to create or update a network interface. Please note some properties can be set only during network interface creation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkInterfaces,
    BaseParameters<NetworkInterfaces>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to update a network interface.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkInterfaces,
    NetworkInterfacesUpdateRequest,
    BaseParameters<NetworkInterfaces>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to delete a network interface.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkInterfaces,
    BaseParameters<NetworkInterfaces>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the network interfaces in the specified resource group. Use the nextLink property in the response to get the next page of network interfaces.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkInterfaces_List")
  list is ArmResourceListByParent<NetworkInterfaces>;

  /**
   * Lists all of the network interfaces in the specified subscription. Use the nextLink property in the response to get the next page of network interfaces.
   */
  listAll is ArmListBySubscription<NetworkInterfaces>;
}

@@projectedName(NetworkInterfacesOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "networkInterfaces"
);
@@extension(NetworkInterfacesOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "networkInterfaces"
);
@@doc(NetworkInterfacesOperationGroup.createOrUpdate::parameters.resource, "");
@@projectedName(NetworkInterfacesOperationGroup.update::parameters.properties,
  "json",
  "networkInterfaces"
);
@@extension(NetworkInterfacesOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "networkInterfaces"
);
@@doc(NetworkInterfacesOperationGroup.update::parameters.properties, "");
