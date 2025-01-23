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
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- RdsExportTasks ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "RDS Export Task",
    plural: "RDS Export Tasks",
  },
  keywords: ["Microsoft.AwsConnector", "RDS", "Export", "Task"],
})
@doc("A Microsoft.AwsConnector resource")
model RdsExportTask is TrackedResource<RdsExportTaskProperties> {
  @doc("Name of RdsExportTask")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("rdsExportTasks")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RdsExportTask")
model RdsExportTaskProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRdsExportTaskProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRdsExportTask")
model AwsRdsExportTaskProperties {
  @doc("<p>The data exported from the snapshot or cluster.</p> <p>Valid Values:</p> <ul> <li> <p> <code>database</code> - Export all the data from a specified database.</p> </li> <li> <p> <code>database.table</code> <i>table-name</i> - Export a table of the snapshot or cluster. This format is valid only for RDS for MySQL, RDS for MariaDB, and Aurora MySQL.</p> </li> <li> <p> <code>database.schema</code> <i>schema-name</i> - Export a database schema of the snapshot or cluster. This format is valid only for RDS for PostgreSQL and Aurora PostgreSQL.</p> </li> <li> <p> <code>database.schema.table</code> <i>table-name</i> - Export a table of the database schema. This format is valid only for RDS for PostgreSQL and Aurora PostgreSQL.</p> </li> </ul>")
  @extension("x-ms-identifiers", [])
  exportOnly?: string[];

  @doc("<p>A unique identifier for the snapshot or cluster export task. This ID isn't an identifier for the Amazon S3 bucket where the data is exported.</p>")
  exportTaskIdentifier?: string;

  @doc("<p>The reason the export failed, if it failed.</p>")
  failureCause?: string;

  @doc("<p>The name of the IAM role that is used to write to Amazon S3 when exporting a snapshot or cluster.</p>")
  iamRoleArn?: string;

  @doc("<p>The key identifier of the Amazon Web Services KMS key that is used to encrypt the data when it's exported to Amazon S3. The KMS key identifier is its key ARN, key ID, alias ARN, or alias name. The IAM role used for the export must have encryption and decryption permissions to use this KMS key.</p>")
  kmsKeyId?: string;

  @doc("<p>The progress of the snapshot or cluster export task as a percentage.</p>")
  percentProgress?: int32;

  @doc("<p>The Amazon S3 bucket where the snapshot or cluster is exported to.</p>")
  s3Bucket?: string;

  @doc("<p>The Amazon S3 bucket prefix that is the file name and path of the exported data.</p>")
  s3Prefix?: string;

  @doc("<p>The time when the snapshot was created.</p>")
  snapshotTime?: utcDateTime;

  @doc("<p>The Amazon Resource Name (ARN) of the snapshot or cluster exported to Amazon S3.</p>")
  sourceArn?: string;

  @doc("<p>The type of source for the export.</p>")
  sourceType?: ExportSourceTypeEnumValue;

  @doc("<p>The progress status of the export task. The status can be one of the following:</p> <ul> <li> <p> <code>CANCELED</code> </p> </li> <li> <p> <code>CANCELING</code> </p> </li> <li> <p> <code>COMPLETE</code> </p> </li> <li> <p> <code>FAILED</code> </p> </li> <li> <p> <code>IN_PROGRESS</code> </p> </li> <li> <p> <code>STARTING</code> </p> </li> </ul>")
  status?: string;

  @doc("<p>The time when the snapshot or cluster export task ended.</p>")
  taskEndTime?: utcDateTime;

  @doc("<p>The time when the snapshot or cluster export task started.</p>")
  taskStartTime?: utcDateTime;

  @doc("<p>The total amount of data exported, in gigabytes.</p>")
  totalExtractedDataInGB?: int32;

  @doc("<p>A warning about the snapshot or cluster export task.</p>")
  warningMessage?: string;
}

@doc("ExportSourceType enum")
union ExportSourceType {
  @doc("ExportSourceType enum CLUSTER")
  CLUSTER: "CLUSTER",

  @doc("ExportSourceType enum SNAPSHOT")
  SNAPSHOT: "SNAPSHOT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ExportSourceTypeEnumValue")
model ExportSourceTypeEnumValue {
  @doc("Property value")
  value?: ExportSourceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface RdsExportTasks {
  get is ArmResourceRead<RdsExportTask>;
  @doc("Create a RdsExportTask. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RdsExportTask>;
  update is ArmCustomPatchAsync<
    RdsExportTask,
    Azure.ResourceManager.Foundations.TagsUpdateModel<RdsExportTask>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<RdsExportTask>;
  listByResourceGroup is ArmResourceListByParent<RdsExportTask>;
  listBySubscription is ArmListBySubscription<RdsExportTask>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\rds\rds-2014-10-31.normal.json
// AWS Shape: ExportTask
//
// Related information for backend service:
// AWS Servcie : RDS
// Product Version : 3.7.798.0
// SDK Version : 3.7.312.0
//--------------------------------------------------------------------------------------------
