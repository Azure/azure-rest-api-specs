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

namespace Microsoft.ContainerInstance;
// FIXME: ContainerGroup has no properties property
/**
 * A container group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model ContainerGroup extends Resource {
  /**
   * The name of the container group.
   */
  @path
  @key("containerGroupName")
  @segment("containerGroups")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: {};
}

@armResourceOperations
interface ContainerGroups {
  /**
   * Gets the properties of the specified container group in the specified subscription and resource group. The operation returns the properties of each container group including containers, image registry credentials, restart policy, IP address type, OS type, state, and volumes.
   */
  get is ArmResourceRead<ContainerGroup>;

  /**
   * Create or update container groups with specified configurations.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ContainerGroup>;

  /**
   * Updates container group tags with specified values.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ContainerGroup, Resource>;

  /**
   * Delete the specified container group in the specified subscription and resource group. The operation does not delete other resources provided by the user, such as volumes.
   */
  delete is ArmResourceDeleteAsync<ContainerGroup>;

  /**
   * Get a list of container groups in a specified subscription and resource group. This operation returns properties of each container group including containers, image registry credentials, restart policy, IP address type, OS type, state, and volumes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerGroups_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ContainerGroup>;

  /**
   * Get a list of container groups in the specified subscription. This operation returns properties of each container group including containers, image registry credentials, restart policy, IP address type, OS type, state, and volumes.
   */
  list is ArmListBySubscription<ContainerGroup>;

  /**
   * Restarts all containers in a container group in place. If container image has updates, new image will be downloaded.
   */
  restart is ArmResourceActionNoResponseContentAsync<ContainerGroup, void>;

  /**
   * Stops all containers in a container group. Compute resources will be deallocated and billing will stop.
   */
  stop is ArmResourceActionNoContentSync<ContainerGroup, void>;

  /**
   * Starts all containers in a container group. Compute resources will be allocated and billing will start.
   */
  start is ArmResourceActionNoResponseContentAsync<ContainerGroup, void>;

  /**
   * Executes a command for a specific container instance in a specified resource group and container group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Containers_ExecuteCommand")
  executeCommand is ArmResourceActionSync<
    ContainerGroup,
    ContainerExecRequest,
    ContainerExecResponse,
    {
      ...BaseParameters<ContainerGroup>;

      /**
       * The name of the container instance.
       */
      @path
      containerName: string;
    }
  >;

  /**
   * Attach to the output stream of a specific container instance in a specified resource group and container group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Containers_Attach")
  attach is ArmResourceActionSync<
    ContainerGroup,
    void,
    ContainerAttachResponse,
    {
      ...BaseParameters<ContainerGroup>;

      /**
       * The name of the container instance.
       */
      @path
      containerName: string;
    }
  >;

  /**
   * Gets all the network dependencies for this container group to allow complete control of network setting and configuration. For container groups, this will always be an empty list.
   */
  // FIXME: ContainerGroups_GetOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @summary("Get all network dependencies for container group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/outboundNetworkDependenciesEndpoints")
  @get
  getOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the container group.
       */
      @path
      containerGroupName: string;
    },
    void
  >;

  /**
   * Get the logs for a specified container instance in a specified resource group and container group.
   */
  // FIXME: Containers_ListLogs could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Containers_ListLogs")
  @summary("Get the logs for a specified container instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/logs")
  @get
  listLogs is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the container group.
       */
      @path
      containerGroupName: string;

      /**
       * The name of the container instance.
       */
      @path
      containerName: string;

      /**
       * The number of lines to show from the tail of the container instance log. If not provided, all available logs are shown up to 4mb.
       */
      @query("tail")
      tail?: int32;

      /**
       * If true, adds a timestamp at the beginning of every line of log output. If not provided, defaults to false.
       */
      @query("timestamps")
      timestamps?: boolean;
    },
    Logs
  >;
}

@@projectedName(ContainerGroups.createOrUpdate::parameters.resource,
  "json",
  "containerGroup"
);
@@extension(ContainerGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "containerGroup"
);
@@doc(ContainerGroups.createOrUpdate::parameters.resource,
  "The properties of the container group to be created or updated."
);
@@projectedName(ContainerGroups.update::parameters.properties,
  "json",
  "Resource"
);
@@extension(ContainerGroups.update::parameters.properties,
  "x-ms-client-name",
  "Resource"
);
@@doc(ContainerGroups.update::parameters.properties,
  "The container group resource with just the tags to be updated."
);
@@projectedName(ContainerGroups.executeCommand::parameters.body,
  "json",
  "containerExecRequest"
);
@@extension(ContainerGroups.executeCommand::parameters.body,
  "x-ms-client-name",
  "containerExecRequest"
);
@@doc(ContainerGroups.executeCommand::parameters.body,
  "The request for the exec command."
);
