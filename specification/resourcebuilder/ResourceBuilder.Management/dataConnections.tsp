import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ResourceBuilder;

/** Data connection resource */
@parentResource(Workspace)
model DataConnection is ProxyResource<DataConnectionProperties> {
  /** The name of the data connection. */
  @segment("dataConnections")
  @key("dataConnectionName")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,63}$")
  name: string;

  /** Data connection kind discriminator. Determines which properties are valid for this data connection. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "kind is a valid top-level property for DataConnection resource"
  kind: DataConnectionKind;

  /**
   * Gets or sets tags of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Suppressing error expected"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress expected ARM error"
  tags?: Record<string>;
}

/** Data connection kind discriminator */
union DataConnectionKind {
  /** Azure Data Explorer data connection. */
  AzureDataExplorer: "AzureDataExplorer",

  /** Storage Account data connection. */
  StorageAccount: "StorageAccount",

  string,
}

/** Data connection properties - properties vary by kind.
 * Each data connection kind has specific required and optional properties as documented below.
 */
model DataConnectionProperties {
  /** Provisioning state of the data connection. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // ============================================
  // AzureDataExplorer specific properties (kind: "AzureDataExplorer")
  // ============================================
  /** URI of the Azure Data Explorer cluster. Required for AzureDataExplorer data connections. */
  clusterUri?: string;

  /** Name of the database within the Azure Data Explorer cluster. Required for AzureDataExplorer data connections. */
  databaseName?: string;

  // ============================================
  // StorageAccount specific properties (kind: "StorageAccount")
  // ============================================
  /** URI of the Azure Storage Account. Required for StorageAccount data connections. */
  storageAccountUri?: string;

  /** Name of the container within the Azure Storage Account. Required for StorageAccount data connections. */
  containerName?: string;
}

/** Data connection reference. Used to link a dataset to an existing data connection resource. */
model DataConnectionReference {
  /** ARM resource ID of the data connection. */
  id: string;
}

@armResourceOperations
interface DataConnections {
  get is ArmResourceRead<DataConnection>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataConnection>;
  delete is ArmResourceDeleteSync<DataConnection>;
  list is ArmResourceListByParent<DataConnection>;
}
