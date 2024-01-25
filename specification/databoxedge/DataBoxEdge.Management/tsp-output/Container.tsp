import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Represents a container on the  Data Box Edge/Gateway device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(StorageAccount)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ContainerProperties)
model Container extends ProxyResourceBase {
  /**
   * The container Name
   */
  @path
  @key("containerName")
  @segment("containers")
  @visibility("read")
  name: string;

  /**
   * The container properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ContainerProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Container>;

  /**
   * Deletes the container on the Data Box Edge/Data Box Gateway device.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Container>;

  /**
   * Lists all the containers of a storage Account in a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Containers_ListByStorageAccount")
  listByStorageAccount is ArmResourceListByParent<Container>;

  /**
   * Refreshes the container metadata with the data from the cloud.
   */
  refresh is ArmResourceActionAsync<Container, void, void>;
}

@@projectedName(Containers.createOrUpdate::parameters.resource,
  "json",
  "container"
);
@@extension(Containers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "container"
);
@@doc(Containers.createOrUpdate::parameters.resource,
  "The container properties."
);
