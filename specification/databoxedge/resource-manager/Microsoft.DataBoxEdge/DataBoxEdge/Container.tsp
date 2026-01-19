import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Represents a container on the  Data Box Edge/Gateway device.
 */
@parentResource(StorageAccount)
model Container
  is Azure.ResourceManager.ProxyResource<ContainerProperties, false> {
  ...ResourceNameParameter<
    Resource = Container,
    KeyName = "containerName",
    SegmentName = "containers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Containers {
  /**
   * Gets a container by name.
   */
  @summary("Gets a container by name.")
  get is ArmResourceRead<Container, Error = CloudError>;

  /**
   * Creates a new container or updates an existing container on the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new container or updates an existing container on the device.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Container,
    Response = ArmResourceUpdatedResponse<Container> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Container> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the container on the Data Box Edge/Data Box Gateway device.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Container, Error = CloudError>;

  /**
   * Lists all the containers of a storage Account in a Data Box Edge/Data Box Gateway device.
   */
  @summary("Lists all the containers of a storage Account in a Data Box Edge/Data Box Gateway device.")
  listByStorageAccount is ArmResourceListByParent<
    Container,
    Response = ArmResponse<ContainerList>,
    Error = CloudError
  >;

  /**
   * Refreshes the container metadata with the data from the cloud.
   */
  @summary("Refreshes the container metadata with the data from the cloud.")
  refresh is ArmResourceActionAsync<
    Container,
    void,
    OkResponse,
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(Container.name, "The container Name");
@@doc(Container.properties, "The container properties.");
@@doc(Containers.createOrUpdate::parameters.resource,
  "The container properties."
);
