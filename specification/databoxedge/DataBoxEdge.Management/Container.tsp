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
  get is ArmResourceRead<Container>;

  /**
   * Creates a new container or updates an existing container on the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Container,
    Response = ArmResourceUpdatedResponse<Container> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = Container> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the container on the Data Box Edge/Data Box Gateway device.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Container>;

  /**
   * Lists all the containers of a storage Account in a Data Box Edge/Data Box Gateway device.
   */
  listByStorageAccount is ArmResourceListByParent<
    Container,
    Response = ArmResponse<ContainerList>
  >;

  /**
   * Refreshes the container metadata with the data from the cloud.
   */
  refresh is ArmResourceActionAsync<Container, void, OkResponse>;
}

@@doc(Container.name, "The container Name");
@@doc(Container.properties, "The container properties.");
@@doc(Containers.createOrUpdate::parameters.resource,
  "The container properties."
);
