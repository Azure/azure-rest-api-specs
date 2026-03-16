import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerInstance;
// FIXME: ContainerGroup has no properties property
/**
 * A container group.
 */
model ContainerGroup
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<{}> {
  ...ResourceNameParameter<
    Resource = ContainerGroup,
    KeyName = "containerGroupName",
    SegmentName = "containerGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the container group, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ContainerGroupIdentity;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ContainerGroup,
    LroHeaders = ArmLroLocationHeader<FinalResult = ContainerGroup> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates container group tags with specified values.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ContainerGroup, PatchModel = Resource>;

  /**
   * Delete the specified container group in the specified subscription and resource group. The operation does not delete other resources provided by the user, such as volumes.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ContainerGroup,
    Response = ArmResponse<ContainerGroup> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Restarts all containers in a container group in place. If container image has updates, new image will be downloaded.
   */
  restart is ArmResourceActionAsyncBase<
    ContainerGroup,
    void,
    NoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ContainerGroup>
  >;

  /**
   * Stops all containers in a container group. Compute resources will be deallocated and billing will stop.
   */
  stop is ArmResourceActionSync<ContainerGroup, void, NoContentResponse>;

  /**
   * Starts all containers in a container group. Compute resources will be allocated and billing will start.
   */
  start is ArmResourceActionAsync<ContainerGroup, void, NoContentResponse>;

  /**
   * Gets all the network dependencies for this container group to allow complete control of network setting and configuration. For container groups, this will always be an empty list.
   */
  @get
  @action("outboundNetworkDependenciesEndpoints")
  getOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    ContainerGroup,
    void,
    ArmResponse<NetworkDependenciesResponse>
  >;

  /**
   * Get the logs for a specified container instance in a specified resource group and container group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Containers_ListLogs")
  @get
  @action("logs")
  listLogs is ArmResourceActionSync<
    ContainerGroup,
    void,
    ArmResponse<Logs>,
    Parameters = {
      /**
       * The name of the container instance.
       */
      @path
      @segment("containers")
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
    }
  >;

  /**
   * Executes a command for a specific container instance in a specified resource group and container group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Containers_ExecuteCommand")
  @action("exec")
  executeCommand is ArmResourceActionSync<
    ContainerGroup,
    ContainerExecRequest,
    ArmResponse<ContainerExecResponse>,
    Parameters = {
      /**
       * The name of the container instance.
       */
      @path
      @segment("containers")
      containerName: string;
    }
  >;

  /**
   * Attach to the output stream of a specific container instance in a specified resource group and container group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Containers_Attach")
  attach is ArmResourceActionSync<
    ContainerGroup,
    void,
    ArmResponse<ContainerAttachResponse>,
    Parameters = {
      /**
       * The name of the container instance.
       */
      @path
      @segment("containers")
      containerName: string;
    }
  >;
}

@@doc(ContainerGroup.name, "The name of the container group.");
@@doc(ContainerGroups.createOrUpdate::parameters.resource,
  "The properties of the container group to be created or updated."
);
@@doc(ContainerGroups.update::parameters.properties,
  "The container group resource with just the tags to be updated."
);
@@doc(ContainerGroups.executeCommand::parameters.body,
  "The request for the exec command."
);
