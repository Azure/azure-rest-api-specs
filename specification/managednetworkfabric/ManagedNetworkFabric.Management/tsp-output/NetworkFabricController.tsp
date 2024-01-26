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

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric Controller resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkFabricControllerProperties
)
model NetworkFabricController extends TrackedResourceBase {
  /**
   * Name of the Network Fabric Controller.
   */
  @path
  @key("networkFabricControllerName")
  @segment("networkFabricControllers")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: NetworkFabricControllerProperties;
}

@armResourceOperations
interface NetworkFabricControllers {
  /**
   * Shows the provisioning status of Network Fabric Controller.
   */
  get is ArmResourceRead<NetworkFabricController>;

  /**
   * Creates a Network Fabric Controller.
   */
  create is ArmResourceCreateOrReplaceAsync<
    NetworkFabricController,
    BaseParameters<NetworkFabricController>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates are currently not supported for the Network Fabric Controller resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkFabricController,
    NetworkFabricControllerPatch,
    BaseParameters<NetworkFabricController>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes the Network Fabric Controller resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFabricController,
    BaseParameters<NetworkFabricController>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the NetworkFabricControllers thats available in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFabricControllers_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricController>;

  /**
   * Lists all the NetworkFabricControllers by subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkFabricController>;
}

@@projectedName(NetworkFabricControllers.create::parameters.resource,
  "json",
  "body"
);
@@extension(NetworkFabricControllers.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkFabricControllers.create::parameters.resource, "Request payload.");
@@projectedName(NetworkFabricControllers.update::parameters.properties,
  "json",
  "body"
);
@@extension(NetworkFabricControllers.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkFabricControllers.update::parameters.properties,
  "Network Fabric Controller properties to update."
);
