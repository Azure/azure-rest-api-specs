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

//---------------------------------------------- RdsDBSnapshotAttributesResults ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "RDS DBSnapshot Attributes Result",
    plural: "RDS DBSnapshot Attributes Results",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "RDS",
    "DBSnapshot",
    "Attributes",
    "Result"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model RdsDBSnapshotAttributesResult
  is TrackedResource<RdsDBSnapshotAttributesResultProperties> {
  @doc("Name of RdsDBSnapshotAttributesResult")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("rdsDBSnapshotAttributesResults")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RdsDBSnapshotAttributesResult")
model RdsDBSnapshotAttributesResultProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRdsDBSnapshotAttributesResultProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRdsDBSnapshotAttributesResult")
model AwsRdsDBSnapshotAttributesResultProperties {
  @doc("<p>The list of attributes and values for the manual DB snapshot.</p>")
  @extension("x-ms-identifiers", [])
  dbSnapshotAttributes?: DBSnapshotAttribute[];

  @doc("<p>The identifier of the manual DB snapshot that the attributes apply to.</p>")
  dbSnapshotIdentifier?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DBSnapshotAttribute")
model DBSnapshotAttribute {
  @doc("<p>The name of the manual DB snapshot attribute.</p> <p>The attribute named <code>restore</code> refers to the list of Amazon Web Services accounts that have permission to copy or restore the manual DB cluster snapshot. For more information, see the <code>ModifyDBSnapshotAttribute</code> API action.</p>")
  attributeName?: string;

  @doc("<p>The value or values for the manual DB snapshot attribute.</p> <p>If the <code>AttributeName</code> field is set to <code>restore</code>, then this element returns a list of IDs of the Amazon Web Services accounts that are authorized to copy or restore the manual DB snapshot. If a value of <code>all</code> is in the list, then the manual DB snapshot is public and available for any Amazon Web Services account to copy or restore.</p>")
  @extension("x-ms-identifiers", [])
  attributeValues?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface RdsDBSnapshotAttributesResults {
  get is ArmResourceRead<RdsDBSnapshotAttributesResult>;
  @doc("Create a RdsDBSnapshotAttributesResult. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RdsDBSnapshotAttributesResult>;
  update is ArmCustomPatchAsync<
    RdsDBSnapshotAttributesResult,
    Azure.ResourceManager.Foundations.TagsUpdateModel<RdsDBSnapshotAttributesResult>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<RdsDBSnapshotAttributesResult>;
  listByResourceGroup is ArmResourceListByParent<RdsDBSnapshotAttributesResult>;
  listBySubscription is ArmListBySubscription<RdsDBSnapshotAttributesResult>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\rds\rds-2014-10-31.normal.json
// AWS Shape: DBSnapshotAttributesResult
//
// Related information for backend service:
// AWS Servcie : RDS
// Product Version : 3.7.798.0
// SDK Version : 3.7.312.0
//--------------------------------------------------------------------------------------------
