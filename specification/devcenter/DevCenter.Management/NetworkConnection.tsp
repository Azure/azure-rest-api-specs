import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Network related settings.")
model NetworkConnection
  is Azure.ResourceManager.TrackedResource<NetworkProperties> {
  ...ResourceNameParameter<
    Resource = NetworkConnection,
    KeyName = "networkConnectionName",
    SegmentName = "networkConnections",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface NetworkConnections {
  @doc("Gets a network connection resource.")
  get is ArmResourceRead<NetworkConnection>;

  @doc("Creates or updates a Network Connections resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetworkConnection>;

  @doc("Partially updates a Network Connection.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkConnection,
    PatchModel = NetworkConnectionUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = NetworkConnection | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = NetworkConnection>
    >
  >;

  @doc("Deletes a Network Connections resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkConnection,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists network connections in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    NetworkConnection,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = NetworkConnectionListResult
  >;

  @doc("Lists network connections in a subscription.")
  listBySubscription is ArmListBySubscription<
    NetworkConnection,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = NetworkConnectionListResult
  >;

  @doc("Triggers a new health check run. The execution and health check result can be tracked via the network Connection health check details.")
  runHealthChecks is ArmResourceActionAsyncBase<
    NetworkConnection,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkConnection>
  >;

  @doc("Lists the endpoints that agents may call as part of Dev Box service administration. These FQDNs should be allowed for outbound access in order for the Dev Box service to function.")
  @list
  @get
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    NetworkConnection,
    void,
    ArmResponse<OutboundEnvironmentEndpointCollection>,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

@@maxLength(NetworkConnection.name, 63);
@@minLength(NetworkConnection.name, 3);
@@doc(NetworkConnection.name,
  "Name of the Network Connection that can be applied to a Pool."
);
@@doc(NetworkConnection.properties, "Properties of a Network Connection");
@@doc(NetworkConnections.createOrUpdate::parameters.resource,
  "Represents network connection"
);
@@doc(NetworkConnections.update::parameters.properties,
  "Represents network connection"
);
