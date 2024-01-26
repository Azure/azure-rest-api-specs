import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the NetworkInterface resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(NetworkDevice)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(NetworkInterfaceProperties)
model NetworkInterface extends ProxyResourceBase {
  /**
   * Name of the Network Interface.
   */
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: NetworkInterfaceProperties;
}

@armResourceOperations
interface NetworkInterfaces {
  /**
   * Get the Network Interface resource details.
   */
  get is ArmResourceRead<NetworkInterface>;

  /**
   * Create a Network Interface resource.
   */
  create is ArmResourceCreateOrReplaceAsync<
    NetworkInterface,
    BaseParameters<NetworkInterface>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update certain properties of the Network Interface resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkInterface,
    NetworkInterfacePatch,
    BaseParameters<NetworkInterface>,
    ArmLroLocationHeader
  >;

  /**
   * Delete the Network Interface resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkInterface,
    BaseParameters<NetworkInterface>,
    ArmLroLocationHeader
  >;

  /**
   * List all the Network Interface resources in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkInterfaces_ListByNetworkDevice")
  listByNetworkDevice is ArmResourceListByParent<NetworkInterface>;

  /**
   * Update the admin state of the Network Interface.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkInterface,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkInterface>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkInterfaces.create::parameters.resource, "json", "body");
@@extension(NetworkInterfaces.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkInterfaces.create::parameters.resource, "Request payload.");
@@projectedName(NetworkInterfaces.update::parameters.properties,
  "json",
  "body"
);
@@extension(NetworkInterfaces.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkInterfaces.update::parameters.properties,
  "NetworkInterface properties to update. Only tags are supported."
);
@@doc(NetworkInterfaces.updateAdministrativeState::parameters.body,
  "Request payload."
);
