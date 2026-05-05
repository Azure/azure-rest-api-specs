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
using TypeSpec.Versioning;

namespace Microsoft.Storage;
/**
 * A Connector is a tracked ARM resource modeled as a sub-resource of a Storage Account.
 */
@parentResource(StorageAccount)
@added(Versions.v2025_08_01)
model Connector
  is Azure.ResourceManager.TrackedResource<StorageConnectorProperties> {
  ...ResourceNameParameter<
    Resource = Connector,
    KeyName = "connectorName",
    SegmentName = "connectors",
    NamePattern = "^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$"
  >;
}

@armResourceOperations
@added(Versions.v2025_08_01)
interface Connectors {
  /**
   * Get the specified Storage Connector.
   */
  get is ArmResourceRead<Connector>;

  /**
   * Create a Storage Connector if it does not already exist; otherwise, error out. This API will not allow you to replace an already existing resource.
   */
  create is ArmResourceCreateOrReplaceAsync<Connector>;

  /**
   * Update a Storage Connector.
   */
  update is ArmResourcePatchAsync<Connector, StorageConnectorProperties>;

  /**
   * Delete a Storage Connector.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Connector>;

  /**
   * List all Storage Connectors in a Storage Account.
   */
  listByStorageAccount is ArmResourceListByParent<Connector>;

  /**
   * This method is used to verify that the connection to the backing data store works.
   * This API is designed to be used for monitoring and debugging purposes. From the caller’s perspective,
   * this method does the following: Calls List on the backing data store, attempting to list up to one blob/object/etc.
   * If the above succeeds, and if a blob/object/etc is found, calls Get on that object, attempting to download one byte.
   */
  testExistingConnection is ArmResourceActionAsync<
    Connector,
    TestExistingConnectionRequest,
    TestConnectionResponse
  >;
}

@@maxLength(Connector.name, 63);
@@minLength(Connector.name, 3);
@@doc(Connector.name, "The name of the Storage Connector.");
@@doc(Connector.properties, "The properties of the Storage Connector.");
@@doc(Connectors.create::parameters.resource,
  "Create a Storage Connector if it does not already exist; otherwise, error out. This API will not allow you to replace an already existing resource."
);
@@doc(Connectors.update::parameters.properties,
  "The updated properties of the Storage Connector."
);
@@doc(Connectors.testExistingConnection::parameters.body,
  "This method is used to verify that the connection to the backing data store works. This API is designed to be used for monitoring and debugging purposes. From the caller’s perspective, this method does the following: Calls List on the backing data store, attempting to list up to one blob/object/etc. If the above succeeds, and if a blob/object/etc is found, calls Get on that object, attempting to download one byte."
);
