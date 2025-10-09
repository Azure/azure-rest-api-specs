import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Suppress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.GcpConnector" })
@doc("Microsoft.GcpConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.GcpConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  `2025-12-01-preview`,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@about({
  displayNames: {
    singular: "BigQuery Dataset",
    plural: "BigQuery Datasets",
  },
  keywords: ["Microsoft.GcpConnector", "BigQuery", "Dataset"],
})
@doc("A Microsoft.GcpConnector resource")
model BigQueryDataset is TrackedResource<BigQueryDatasetProperties> {
  @doc("Name of BigQueryDataset")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bigQueryDatasets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "GCPConnector will not generate SDK. So, Suppressing this error"
@doc("Definition of BigQueryDatasetProperties")
model BigQueryDatasetProperties {
  @doc("GCP Properties")
  gcpProperties?: GcpBigQueryDatasetProperties;

  ...GcpCommonProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
@doc("Definition of GcpBigQueryDatasetProperties")
model GcpBigQueryDatasetProperties {
  /**
   * The resource type
   */
  kind?: string = "bigquery#dataset";

  /**
   * A hash of this resource
   */
  etag?: string;

  /**
   * The fully-qualified, unique ID of the dataset
   */
  id?: string;

  /**
   * A URL that can be used to access this resource again
   */
  selfLink?: string;

  /**
   * The reference to the dataset
   */
  datasetReference: DatasetReference;

  /**
   * A descriptive name for the dataset
   */
  friendlyName?: string;

  /**
   * A user-friendly description of the dataset
   */
  description?: string;

  /**
   * The labels associated with this dataset
   */
  labels?: Record<string>;

  /**
   * The geographic location where the dataset resides
   */
  location?: string;

  /**
   * Default expiration time for tables in milliseconds
   */
  defaultTableExpirationMs?: string;

  /**
   * Default partition expiration time in milliseconds
   */
  defaultPartitionExpirationMs?: string;

  /**
   * The default encryption configuration for the dataset
   */
  defaultEncryptionConfiguration?: EncryptionConfiguration;

  /**
   * Default collation for new string fields
   */
  defaultCollation?: string;

  /**
   * Default rounding mode for decimal fields
   */
  defaultRoundingMode?: string;

  /**
   * An array of objects that define dataset access for one or more entities
   */
  @extension("x-ms-identifiers", #[])
  access?: DatasetAccess[];

  /**
   * The time when this dataset was created
   */
  creationTime?: string;

  /**
   * The time when this dataset was last modified
   */
  lastModifiedTime?: string;

  /**
   * The type of the dataset
   */
  type?: string;

  /**
   * The linked dataset source
   */
  linkedDatasetSource?: LinkedDatasetSource;

  /**
   * The linked dataset metadata
   */
  linkedDatasetMetadata?: LinkedDatasetMetadata;

  /**
   * The external dataset reference
   */
  externalDatasetReference?: ExternalDatasetReference;

  /**
   * The external catalog dataset options
   */
  externalCatalogDatasetOptions?: ExternalCatalogDatasetOptions;

  /**
   * Whether this dataset satisfies Protected Zone Shared requirements
   */
  satisfiesPzs?: boolean;

  /**
   * Whether this dataset satisfies Protected Zone Isolated requirements
   */
  satisfiesPzi?: boolean;

  /**
   * Whether this dataset is case insensitive
   */
  isCaseInsensitive?: boolean;

  /**
   * The maximum time travel hours for this dataset
   */
  maxTimeTravelHours?: string;

  /**
   * The resource tags associated with this dataset
   */
  @extension("x-ms-identifiers", #[])
  tags?: GcpTag[];

  /**
   * The storage billing model for this dataset
   */
  storageBillingModel?: string;

  /**
   * The resource tags associated with this dataset
   */
  resourceTags?: Record<string>;
}

@doc("Definition of DatasetReference")
model DatasetReference {
  /**
   * The ID of the dataset
   */
  datasetId: string;

  /**
   * The ID of the project containing this dataset
   */
  projectId: string;
}

/**
 * Grants all resources of particular types in a particular dataset read access to the current dataset. Similar to how individually authorized views work, updates to any resource granted through its dataset (including creation of new resources) requires read permission to referenced resources, plus write permission to the authorizing dataset.
 */
@doc("Definition of DatasetAccessEntry")
model DatasetAccessEntry {
  /**
   * The dataset this entry applies to
   */
  dataset?: DatasetReference;

  /**
   * Which resources in the dataset this entry applies to. Currently, only views are supported, but additional target types may be added in the future.
   */
  targetTypes?: string[];
}

@doc("Definition of DatasetAccess")
model DatasetAccess {
  /**
   * Access role granted to the entity
   */
  role?: string;

  /**
   * User email address to grant access to
   */
  userByEmail?: string;

  /**
   * Group email address to grant access to
   */
  groupByEmail?: string;

  /**
   * Domain to grant access to
   */
  domain?: string;

  /**
   * Special group to grant access to
   */
  specialGroup?: string;

  /**
   * IAM member to grant access to
   */
  iamMember?: string;

  /**
   * A view defined in a different dataset to grant access to
   */
  view?: TableReference;

  /**
   * The dataset this entry applies to
   */
  dataset?: DatasetAccessEntry;

  /**
   * The routine this entry applies to
   */
  routine?: RoutineReference;

  /**
   * An IAM Condition for this access entry
   */
  condition?: Expr;
}

@doc("Definition of EncryptionConfiguration")
model EncryptionConfiguration {
  /**
   * Cloud KMS key name used for encryption
   */
  kmsKeyName?: string;
}

@doc("Definition of LinkedDatasetSource")
model LinkedDatasetSource {
  /**
   * Reference to the source dataset
   */
  sourceDataset?: DatasetReference;
}

@doc("Definition of TableReference")
model TableReference {
  /**
   * The ID of the project containing this table
   */
  projectId: string;

  /**
   * The ID of the dataset containing this table
   */
  datasetId: string;

  /**
   * The ID of the table
   */
  tableId: string;
}

@doc("Definition of RoutineReference")
model RoutineReference {
  /**
   * The ID of the project containing this routine
   */
  projectId: string;

  /**
   * The ID of the dataset containing this routine
   */
  datasetId: string;

  /**
   * The ID of the routine
   */
  routineId: string;
}

@doc("Definition of LinkedDatasetMetadata")
model LinkedDatasetMetadata {
  /**
   * Status of the linked dataset
   */
  status?: string;
}

@doc("Definition of ExternalDatasetReference")
model ExternalDatasetReference {
  /**
   * Source of the external dataset
   */
  source?: string;

  /**
   * External source identifier
   */
  externalSource?: string;
}

@doc("Definition of ExternalCatalogDatasetOptions")
model ExternalCatalogDatasetOptions {
  /**
   * The catalog name
   */
  catalog?: string;

  /**
   * The schema name
   */
  schema?: string;
}

@doc("Definition of GcpTag")
model GcpTag {
  /**
   * Tag key in format tag_key_id/tag_key_name
   */
  key?: string;

  /**
   * Tag value short name
   */
  value?: string;
}

@doc("Definition of Expr")
model Expr {
  /**
   * Textual representation of an expression
   */
  expression?: string;

  /**
   * Optional title for the expression
   */
  title?: string;

  /**
   * Optional description of the expression
   */
  description?: string;

  /**
   * Optional location of the expression
   */
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@armResourceOperations
interface BigQueryDatasets {
  get is ArmResourceRead<BigQueryDataset>;
  @doc("Create a big query dataset. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BigQueryDataset>;
  update is ArmCustomPatchAsync<
    BigQueryDataset,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BigQueryDataset>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BigQueryDataset>;
  listByResourceGroup is ArmResourceListByParent<BigQueryDataset>;
  listBySubscription is ArmListBySubscription<BigQueryDataset>;
}
