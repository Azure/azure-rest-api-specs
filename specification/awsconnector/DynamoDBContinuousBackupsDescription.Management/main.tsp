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

//---------------------------------------------- DynamoDBContinuousBackupsDescriptions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Dynamo DB Continuous Backups Description",
    plural: "Dynamo DB Continuous Backups Descriptions",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Dynamo",
    "DB",
    "Continuous",
    "Backups",
    "Description"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model DynamoDBContinuousBackupsDescription
  is TrackedResource<DynamoDBContinuousBackupsDescriptionProperties> {
  @doc("Name of DynamoDBContinuousBackupsDescription")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("dynamoDBContinuousBackupsDescriptions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DynamoDBContinuousBackupsDescription")
model DynamoDBContinuousBackupsDescriptionProperties {
  @doc("AWS Properties")
  awsProperties?: AwsDynamoDBContinuousBackupsDescriptionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsDynamoDBContinuousBackupsDescription")
model AwsDynamoDBContinuousBackupsDescriptionProperties {
  @doc("<p> <code>ContinuousBackupsStatus</code> can be one of the following states: ENABLED, DISABLED</p>")
  continuousBackupsStatus?: ContinuousBackupsStatusEnumValue;

  @doc("<p>The description of the point in time recovery settings applied to the table.</p>")
  pointInTimeRecoveryDescription?: PointInTimeRecoveryDescription;
}

@doc("ContinuousBackupsStatus enum")
union ContinuousBackupsStatus {
  @doc("ContinuousBackupsStatus enum DISABLED")
  DISABLED: "DISABLED",

  @doc("ContinuousBackupsStatus enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContinuousBackupsStatusEnumValue")
model ContinuousBackupsStatusEnumValue {
  @doc("Property value")
  value?: ContinuousBackupsStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PointInTimeRecoveryDescription")
model PointInTimeRecoveryDescription {
  @doc("<p>Specifies the earliest point in time you can restore your table to. You can restore your table to any point in time during the last 35 days. </p>")
  earliestRestorableDateTime?: utcDateTime;

  @doc("<p> <code>LatestRestorableDateTime</code> is typically 5 minutes before the current time. </p>")
  latestRestorableDateTime?: utcDateTime;

  @doc("<p>The current state of point in time recovery:</p> <ul> <li> <p> <code>ENABLED</code> - Point in time recovery is enabled.</p> </li> <li> <p> <code>DISABLED</code> - Point in time recovery is disabled.</p> </li> </ul>")
  pointInTimeRecoveryStatus?: PointInTimeRecoveryStatusEnumValue;
}

@doc("PointInTimeRecoveryStatus enum")
union PointInTimeRecoveryStatus {
  @doc("PointInTimeRecoveryStatus enum DISABLED")
  DISABLED: "DISABLED",

  @doc("PointInTimeRecoveryStatus enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PointInTimeRecoveryStatusEnumValue")
model PointInTimeRecoveryStatusEnumValue {
  @doc("Property value")
  value?: PointInTimeRecoveryStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface DynamoDBContinuousBackupsDescriptions {
  get is ArmResourceRead<DynamoDBContinuousBackupsDescription>;
  @doc("Create a DynamoDBContinuousBackupsDescription. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<DynamoDBContinuousBackupsDescription>;
  update is ArmCustomPatchAsync<
    DynamoDBContinuousBackupsDescription,
    Azure.ResourceManager.Foundations.TagsUpdateModel<DynamoDBContinuousBackupsDescription>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DynamoDBContinuousBackupsDescription>;
  listByResourceGroup is ArmResourceListByParent<DynamoDBContinuousBackupsDescription>;
  listBySubscription is ArmListBySubscription<DynamoDBContinuousBackupsDescription>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\dynamodb\dynamodb-2012-08-10.normal.json
// AWS Shape: ContinuousBackupsDescription
//
// Related information for backend service:
// AWS Servcie : DynamoDB
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.24
//--------------------------------------------------------------------------------------------
