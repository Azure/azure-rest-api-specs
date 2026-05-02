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
/**
 * A container group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ContainerGroup extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = ContainerGroup,
    KeyName = "containerGroupName",
    SegmentName = "containerGroups",
    NamePattern = ""
  >;

  /**
   * The resource location.
   */
  location?: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  ...Azure.ResourceManager.AvailabilityZonesProperty;
  ...ContainerGroupProperties;
}

@@visibility(ContainerGroup.name, Lifecycle.Read);

@armResourceOperations(#{ omitTags: true })
interface ContainerGroups {
  /**
   * Gets the properties of the specified container group in the specified subscription and resource group. The operation returns the properties of each container group including containers, image registry credentials, restart policy, IP address type, OS type, state, and volumes.
   */
  @summary("Get the properties of the specified container group.")
  get is ArmResourceRead<ContainerGroup, Error = CloudError>;

  /**
   * Create or update container groups with specified configurations.
   */
  @summary("Create or update container groups.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ContainerGroup,
    LroHeaders = ArmLroLocationHeader<FinalResult = ContainerGroup> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Updates container group tags with specified values.
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update container groups.")
  update is ArmCustomPatchSync<
    ContainerGroup,
    PatchModel = Resource,
    Error = CloudError
  >;

  /**
   * Delete the specified container group in the specified subscription and resource group. The operation does not delete other resources provided by the user, such as volumes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @summary("Delete the specified container group.")
  delete is ArmResourceDeleteAsyncBase<
    ContainerGroup,
    ArmResponse<ContainerGroup> | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader<FinalResult = ContainerGroup> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Restarts all containers in a container group in place. If container image has updates, new image will be downloaded.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @summary("Restarts all containers in a container group.")
  restart is ArmResourceActionAsyncBase<
    ContainerGroup,
    void,
    NoContentResponse &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ContainerGroup>,
    Error = CloudError
  >;

  /**
   * Stops all containers in a container group. Compute resources will be deallocated and billing will stop.
   */
  @summary("Stops all containers in a container group.")
  stop is ArmResourceActionSync<
    ContainerGroup,
    void,
    NoContentResponse,
    Error = CloudError
  >;

  /**
   * Starts all containers in a container group. Compute resources will be allocated and billing will start.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
  @summary("Starts all containers in a container group.")
  start is ArmResourceActionAsync<
    ContainerGroup,
    void,
    NoContentResponse,
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Gets all the network dependencies for this container group to allow complete control of network setting and configuration. For container groups, this will always be an empty list.
   */
  @summary("Get all network dependencies for container group.")
  @get
  @action("outboundNetworkDependenciesEndpoints")
  getOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    ContainerGroup,
    void,
    ArmResponse<NetworkDependenciesResponse>,
    Error = CloudError
  >;

  /**
   * Get the logs for a specified container instance in a specified resource group and container group.
   */
  @summary("Get the logs for a specified container instance.")
  @get
  @action("logs")
  listLogs is ArmResourceActionSync<
    ContainerGroup,
    void,
    ArmResponse<Logs>,
    Error = CloudError,
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
  @summary("Executes a command in a specific container instance.")
  @action("exec")
  executeCommand is ArmResourceActionSync<
    ContainerGroup,
    ContainerExecRequest,
    ArmResponse<ContainerExecResponse>,
    Error = CloudError,
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
  @summary("Attach to the output of a specific container instance.")
  attach is ArmResourceActionSync<
    ContainerGroup,
    void,
    ArmResponse<ContainerAttachResponse>,
    Error = CloudError,
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
