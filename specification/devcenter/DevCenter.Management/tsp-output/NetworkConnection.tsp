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
@doc("Network related settings")
model NetworkConnection is TrackedResource<NetworkProperties> {
  @doc("Name of the Network Connection that can be applied to a Pool.")
  @path
  @key("networkConnectionName")
  @segment("networkConnections")
  name: string;
}

@armResourceOperations
interface NetworkConnections {
  @doc("Gets a network connection resource")
  get is ArmResourceRead<NetworkConnection>;

  @doc("Creates or updates a Network Connections resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NetworkConnection,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Partially updates a Network Connection")
  update is ArmCustomPatchAsync<
    NetworkConnection,
    NetworkConnectionUpdate,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a Network Connections resource")
  delete is ArmResourceDeleteAsync<
    NetworkConnection,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists network connections in a resource group")
  listByResourceGroup is ArmResourceListByParent<
    NetworkConnection,
    {
      ...BaseParameters<NetworkConnection>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Lists network connections in a subscription")
  listBySubscription is ArmListBySubscription<NetworkConnection>;

  @doc("Triggers a new health check run. The execution and health check result can be tracked via the network Connection health check details")
  runHealthChecks is ArmResourceActionAsync<
    NetworkConnection,
    void,
    void,
    BaseParameters<NetworkConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists the endpoints that agents may call as part of Dev Box service administration. These FQDNs should be allowed for outbound access in order for the Dev Box service to function.")
  // FIXME: NetworkConnections_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/networkConnections/{networkConnectionName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;

      @doc("Name of the Network Connection that can be applied to a Pool.")
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
