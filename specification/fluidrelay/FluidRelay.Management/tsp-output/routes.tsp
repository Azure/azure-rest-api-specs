import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FluidRelayManagementClient;

interface FluidRelayOperationsOperations {
  @summary("List all operations provided by Microsoft.FluidRelay.")
  @doc("List all operations provided by Microsoft.FluidRelay.")
  @route("/providers/Microsoft.FluidRelay/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface FluidRelayServersOperations {
  @summary("Get a Fluid Relay server.")
  @doc("Get a Fluid Relay server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;
    },
    FluidRelayServer
  >;

  @summary("Create or Update a Fluid Relay server.")
  @doc("Create or Update a Fluid Relay server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;

      @doc("The details of the Fluid Relay server resource.")
      @body
      resource: FluidRelayServer;
    },
    FluidRelayServer
  >;

  @summary("Update a Fluid Relay server.")
  @doc("Update a Fluid Relay server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;

      @doc("The details of the Fluid Relay server resource included in update calls.")
      @body
      resource: FluidRelayServerUpdate;
    },
    FluidRelayServer
  >;

  @summary("Delete a Fluid Relay server.")
  @doc("Delete a Fluid Relay server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;
    },
    void
  >;

  @summary("Regenerate the primary or secondary key for this server.")
  @doc("Regenerate the primary or secondary key for this server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}/regenerateKey")
  @post
  RegenerateKey is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;

      @doc("The details of which keys to generate.")
      @body
      parameters: RegenerateKeyRequest;
    },
    FluidRelayServerKeys
  >;

  @summary("Get primary and secondary key for this server.")
  @doc("Get primary and secondary key for this server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;
    },
    FluidRelayServerKeys
  >;

  @summary("List all Fluid Relay servers in a subscription.")
  @doc("List all Fluid Relay servers in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.FluidRelay/fluidRelayServers")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;
    },
    FluidRelayServerList
  >;

  @summary("List all Fluid Relay servers in a resource group.")
  @doc("List all Fluid Relay servers in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;
    },
    FluidRelayServerList
  >;
}

interface FluidRelayContainersOperations {
  @summary("Get a Fluid Relay container.")
  @doc("Get a Fluid Relay container.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}/fluidRelayContainers/{fluidRelayContainerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;

      @doc("The Fluid Relay container resource name.")
      @path
      fluidRelayContainerName: string;
    },
    FluidRelayContainer
  >;

  @summary("Delete a Fluid Relay container.")
  @doc("Delete a Fluid Relay container.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}/fluidRelayContainers/{fluidRelayContainerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;

      @doc("The Fluid Relay container resource name.")
      @path
      fluidRelayContainerName: string;
    },
    void
  >;

  @summary("""
List all Fluid Relay containers which are children of a given Fluid Relay
server.
""")
  @doc("""
List all Fluid Relay containers which are children of a given Fluid Relay
server.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.FluidRelay/fluidRelayServers/{fluidRelayServerName}/fluidRelayContainers")
  @get
  ListByFluidRelayServers is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id (GUID) for this resource.")
      @path
      subscriptionId: string;

      @doc("The resource group containing the resource.")
      @path
      resourceGroup: string;

      @doc("The Fluid Relay server resource name.")
      @path
      fluidRelayServerName: string;
    },
    FluidRelayContainerList
  >;
}
