import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ResourceBuilder;

/** Dataset resource */
@parentResource(Workspace)
model Dataset is ProxyResource<DatasetProperties> {
  /** The name of the dataset. */
  @segment("datasets")
  @key("datasetName")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,63}$")
  name: string;

  /**
   * Dataset kind discriminator. Determines which properties are valid for this dataset.
   * - Custom: Custom user-defined dataset.
   * - ArmResource: ARM (Azure Resource Manager) managed resource dataset.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "kind is a valid top-level property for Dataset resource"
  kind?: DatasetKind;

  /**
   * Gets or sets tags of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Suppressing error expected"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress expected ARM error"
  tags?: Record<string>;
}

/** Dataset kind discriminator */
union DatasetKind {
  /** Custom user-defined dataset. */
  Custom: "Custom",

  /** ARM (Azure Resource Manager) managed resource dataset. */
  ArmResource: "ArmResource",

  string,
}

/** Dataset properties */
model DatasetProperties {
  /** Provisioning state of the dataset. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** Custom Dataset schema definition. */
  schema?: DatasetColumn[];

  /** ArmResource ArmResourceDatasetSchema object. */
  armResourceSchema?: ArmResourceDatasetSchema;

  /** Azure regions where the dataset exists. */
  locations?: string[];
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

/** ARM resource dataset schema. */
model ArmResourceDatasetSchema {
  /** The full ARM resource ID. */
  resourceId: string;

  /** The type of the ARM resource. */
  resourceType: string;

  /** The name of the ARM resource. */
  resourceName: string;

  /** The tenant ID where the resource resides. */
  tenantId: string;

  /** The subscription ID where the resource resides. */
  subscriptionId: string;

  /** The resource group where the resource resides. */
  resourceGroup: string;

  /** The kind of the ARM resource (optional). */
  resourceKind?: string;

  /** The Azure region where the resource is located (optional). */
  resourceLocation?: string;

  /** Tags associated with the ARM resource (optional). */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Suppressing error expected"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress expected ARM error"
  resourceTags?: Record<string>;

  /** Additional properties of the ARM resource (optional). */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Suppressing error expected"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress expected ARM error"
  resourceProperties?: Record<string>;

  /** The timestamp when the resource information was captured (optional). */
  resourceTimestamp?: utcDateTime;
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

@armResourceOperations
interface Datasets {
  get is ArmResourceRead<Dataset>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Dataset>;
  delete is ArmResourceDeleteSync<Dataset>;
  list is ArmResourceListByParent<Dataset>;
}
