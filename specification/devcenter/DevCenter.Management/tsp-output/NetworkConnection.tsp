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

namespace Microsoft.DevCenter;
/**
 * Network related settings
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(NetworkProperties)
@includeInapplicableMetadataInPayload(false)
model NetworkConnection extends TrackedResourceBase {
  /**
   * Name of the Network Connection that can be applied to a Pool.
   */
  @path
  @key("networkConnectionName")
  @segment("networkConnections")
  name: string;

  /**
   * Properties of a Network Connection
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkProperties;
}

@armResourceOperations
interface NetworkConnections {
  /**
   * Gets a network connection resource
   */
  get is ArmResourceRead<NetworkConnection>;

  /**
   * Creates or updates a Network Connections resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkConnection,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Partially updates a Network Connection
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkConnection,
    NetworkConnectionUpdate,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a Network Connections resource
   */
  delete is ArmResourceDeleteAsync<
    NetworkConnection,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists network connections in a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkConnections_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    NetworkConnection,
    {
      ...BaseParameters<NetworkConnection>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists network connections in a subscription
   */
  listBySubscription is ArmListBySubscription<NetworkConnection>;

  /**
   * Triggers a new health check run. The execution and health check result can be tracked via the network Connection health check details
   */
  runHealthChecks is ArmResourceActionAsync<
    NetworkConnection,
    void,
    void,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the endpoints that agents may call as part of Dev Box service administration. These FQDNs should be allowed for outbound access in order for the Dev Box service to function.
   */
  // FIXME: NetworkConnections_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/networkConnections/{networkConnectionName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * Name of the Network Connection that can be applied to a Pool.
       */
      @path
      networkConnectionName: string;
    },
    OutboundEnvironmentEndpointCollection
  >;
}

@@projectedName(NetworkConnections.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(NetworkConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkConnections.createOrUpdate::parameters.resource,
  "Represents network connection"
);
@@projectedName(NetworkConnections.update::parameters.properties,
  "json",
  "body"
);
@@extension(NetworkConnections.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkConnections.update::parameters.properties,
  "Represents network connection"
);
