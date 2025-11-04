import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ResourceBuilder;

/** Dataset resource */
@parentResource(Workspace)
model Dataset is ProxyResource<DatasetProperties> {
  @segment("datasets")
  /** The name of the dataset. */
  @key("datasetName")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,63}$")
  name: string;
}

/** Dataset properties */
model DatasetProperties {
  /** Provisioning state of the dataset. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** Dataset type, e.g. Snapshot or Delta. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property 'type' is at different level than envelope 'type' (resource type identifier)"
  type?: DatasetType;

  /** Dataset schema definition. */
  schema?: DatasetColumn[];

  /** Azure regions where the dataset exists. */
  locations?: string[];

  /** Source from which data will be ingested for the dataset. */
  source?: Datastore;
}

/** Dataset type */
union DatasetType {
  /** Snapshot dataset type. */
  Snapshot: "Snapshot",
  /** Delta dataset type. */
  Delta: "Delta",
  string,
}

/** Dataset column */
model DatasetColumn {
  /** Name of the column. */
  name: string;

  /** Data type of the column. */
  type: DatasetColumnType;

  /** Description of the column. */
  description?: string;
}

/** Dataset column type */
union DatasetColumnType {
  /** String column type. */
  String: "String",
  /** Integer column type. */
  Integer: "Integer",
  /** Boolean column type. */
  Boolean: "Boolean",
  /** DateTime column type. */
  DateTime: "DateTime",
  /** Dynamic column type. */
  Dynamic: "Dynamic",
  /** Guid column type. */
  Guid: "Guid",
  /** Long column type. */
  Long: "Long",
  /** Real column type. */
  Real: "Real",
  /** Timespan column type. */
  Timespan: "Timespan",
  /** Decimal column type. */
  Decimal: "Decimal",
  string,
}

/** Datastore */
model Datastore {
  /** Datastore type discriminator */
  type: DatastoreType;
  /** Datastore name */
  name: string;
}

/** Datastore type */
union DatastoreType {
  /** Azure Storage Account datastore type. */
  AzureStorageAccountDatastore: "AzureStorageAccountDatastore",
  /** Azure Data Explorer datastore type. */
  AzureDataExplorerDatastore: "AzureDataExplorerDatastore",
  /** Azure Resource Notification datastore type. */
  AzureResourceNotificationDatastore: "AzureResourceNotificationDatastore",
  string,
}

@armResourceOperations
interface Datasets {
  get is ArmResourceRead<Dataset>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Dataset>;
  delete is ArmResourceDeleteWithoutOkAsync<Dataset>;
}

