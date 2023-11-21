import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ContainerInstanceManagementClient;

interface ContainerGroupsOperations {
  @summary("Get a list of container groups in the specified subscription.")
  @doc("""
Get a list of container groups in the specified subscription. This operation
returns properties of each container group including containers, image registry
credentials, restart policy, IP address type, OS type, state, and volumes.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/containerGroups")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ContainerGroupListResult
  >;

  @summary("Get a list of container groups in the specified subscription and resource group.")
  @doc("""
Get a list of container groups in a specified subscription and resource group.
This operation returns properties of each container group including containers,
image registry credentials, restart policy, IP address type, OS type, state,
and volumes.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;
    },
    ContainerGroupListResult
  >;

  @summary("Get the properties of the specified container group.")
  @doc("""
Gets the properties of the specified container group in the specified
subscription and resource group. The operation returns the properties of each
container group including containers, image registry credentials, restart
policy, IP address type, OS type, state, and volumes.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;
    },
    ContainerGroup
  >;

  @summary("Create or update container groups.")
  @doc("Create or update container groups with specified configurations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;

      @doc("The properties of the container group to be created or updated.")
      @body
      containerGroup: ContainerGroup;
    },
    ContainerGroup
  >;

  @summary("Update container groups.")
  @doc("Updates container group tags with specified values.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;

      @doc("The container group resource with just the tags to be updated.")
      @body
      Resource: Resource;
    },
    ContainerGroup
  >;

  @summary("Delete the specified container group.")
  @doc("""
Delete the specified container group in the specified subscription and resource
group. The operation does not delete other resources provided by the user, such
as volumes.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;
    },
    ContainerGroup | void
  >;

  @summary("Restarts all containers in a container group.")
  @doc("""
Restarts all containers in a container group in place. If container image has
updates, new image will be downloaded.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/restart")
  @post
  Restart is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;
    },
    void
  >;

  @summary("Stops all containers in a container group.")
  @doc("""
Stops all containers in a container group. Compute resources will be
deallocated and billing will stop.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/stop")
  @post
  Stop is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;
    },
    void
  >;

  @summary("Starts all containers in a container group.")
  @doc("""
Starts all containers in a container group. Compute resources will be allocated
and billing will start.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/start")
  @post
  Start is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;
    },
    void
  >;

  @summary("Get all network dependencies for container group.")
  @doc("""
Gets all the network dependencies for this container group to allow complete
control of network setting and configuration. For container groups, this will
always be an empty list.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/outboundNetworkDependenciesEndpoints")
  @get
  GetOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;
    },
    void
  >;
}

interface OperationsOperations {
  @doc("List the operations for Azure Container Instance service.")
  @route("/providers/Microsoft.ContainerInstance/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface LocationOperations {
  @doc("Get the usage for a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/usages")
  @get
  ListUsage is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The identifier for the physical azure location.")
      @path
      location: string;
    },
    UsageListResult
  >;

  @summary("Get the list of cached images.")
  @doc("""
Get the list of cached images on specific OS type for a subscription in a
region.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/cachedImages")
  @get
  ListCachedImages is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The identifier for the physical azure location.")
      @path
      location: string;
    },
    CachedImagesListResult
  >;

  @summary("Get the list of capabilities of the location.")
  @doc("Get the list of CPU/memory/GPU capabilities of a region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/capabilities")
  @get
  ListCapabilities is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The identifier for the physical azure location.")
      @path
      location: string;
    },
    CapabilitiesListResult
  >;
}

interface ContainersOperations {
  @summary("Get the logs for a specified container instance.")
  @doc("""
Get the logs for a specified container instance in a specified resource group
and container group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/logs")
  @get
  ListLogs is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;

      @doc("The name of the container instance.")
      @path
      containerName: string;

      @doc("""
The number of lines to show from the tail of the container instance log. If not
provided, all available logs are shown up to 4mb.
""")
      @query
      tail: int32;

      @doc("""
If true, adds a timestamp at the beginning of every line of log output. If not
provided, defaults to false.
""")
      @query
      timestamps: boolean;
    },
    Logs
  >;

  @summary("Executes a command in a specific container instance.")
  @doc("""
Executes a command for a specific container instance in a specified resource
group and container group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/exec")
  @post
  ExecuteCommand is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;

      @doc("The name of the container instance.")
      @path
      containerName: string;

      @doc("The request for the exec command.")
      @body
      containerExecRequest: ContainerExecRequest;
    },
    ContainerExecResponse
  >;

  @summary("Attach to the output of a specific container instance.")
  @doc("""
Attach to the output stream of a specific container instance in a specified
resource group and container group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/attach")
  @post
  Attach is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the container group.")
      @path
      containerGroupName: string;

      @doc("The name of the container instance.")
      @path
      containerName: string;
    },
    ContainerAttachResponse
  >;
}

interface SubnetServiceAssociationLinkOperations {
  @summary("Delete container group virtual network association links.")
  @doc("""
Delete container group virtual network association links. The operation does
not delete other resources provided by the user.
""")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Subscription credentials which uniquely identify Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual network.")
      @path
      virtualNetworkName: string;

      @doc("The name of the subnet.")
      @path
      subnetName: string;
    },
    void
  >;
}
