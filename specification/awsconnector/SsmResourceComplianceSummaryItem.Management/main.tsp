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

//---------------------------------------------- SsmResourceComplianceSummaryItems ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "SSM Resource Compliance Summary Item",
    plural: "SSM Resource Compliance Summary Items",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "SSM",
    "Resource",
    "Compliance",
    "Summary",
    "Item"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model SsmResourceComplianceSummaryItem
  is TrackedResource<SsmResourceComplianceSummaryItemProperties> {
  @doc("Name of SsmResourceComplianceSummaryItem")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ssmResourceComplianceSummaryItems")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SsmResourceComplianceSummaryItem")
model SsmResourceComplianceSummaryItemProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSsmResourceComplianceSummaryItemProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSsmResourceComplianceSummaryItem")
model AwsSsmResourceComplianceSummaryItemProperties {
  @doc("<p>The compliance type.</p>")
  complianceType?: string;

  @doc("<p>A list of items that are compliant for the resource.</p>")
  compliantSummary?: CompliantSummary;

  @doc("<p>Information about the execution.</p>")
  executionSummary?: ComplianceExecutionSummary;

  @doc("<p>A list of items that aren't compliant for the resource.</p>")
  nonCompliantSummary?: NonCompliantSummary;

  @doc("<p>The highest severity item found for the resource. The resource is compliant for this item.</p>")
  overallSeverity?: ComplianceSeverityEnumValue;

  @doc("<p>The resource ID.</p>")
  resourceId?: string;

  @doc("<p>The resource type.</p>")
  resourceType?: string;

  @doc("<p>The compliance status for the resource.</p>")
  status?: ComplianceStatusEnumValue;
}

@doc("ComplianceSeverity enum")
union ComplianceSeverity {
  @doc("ComplianceSeverity enum CRITICAL")
  CRITICAL: "CRITICAL",

  @doc("ComplianceSeverity enum HIGH")
  HIGH: "HIGH",

  @doc("ComplianceSeverity enum INFORMATIONAL")
  INFORMATIONAL: "INFORMATIONAL",

  @doc("ComplianceSeverity enum LOW")
  LOW: "LOW",

  @doc("ComplianceSeverity enum MEDIUM")
  MEDIUM: "MEDIUM",

  @doc("ComplianceSeverity enum UNSPECIFIED")
  UNSPECIFIED: "UNSPECIFIED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ComplianceSeverityEnumValue")
model ComplianceSeverityEnumValue {
  @doc("Property value")
  value?: ComplianceSeverity;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CompliantSummary")
model CompliantSummary {
  @doc("<p>The total number of resources that are compliant.</p>")
  compliantCount?: int32;

  @doc("<p>A summary of the compliance severity by compliance type.</p>")
  severitySummary?: SeveritySummary;
}

@doc("ComplianceStatus enum")
union ComplianceStatus {
  @doc("ComplianceStatus enum COMPLIANT")
  COMPLIANT: "COMPLIANT",

  @doc("ComplianceStatus enum NON_COMPLIANT")
  NON_COMPLIANT: "NON_COMPLIANT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ComplianceStatusEnumValue")
model ComplianceStatusEnumValue {
  @doc("Property value")
  value?: ComplianceStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ComplianceExecutionSummary")
model ComplianceExecutionSummary {
  @doc("<p>An ID created by the system when <code>PutComplianceItems</code> was called. For example, <code>CommandID</code> is a valid execution ID. You can use this ID in subsequent calls.</p>")
  executionId?: string;

  @doc("<p>The time the execution ran as a datetime object that is saved in the following format: <code>yyyy-MM-dd'T'HH:mm:ss'Z'</code> </p>")
  executionTime?: utcDateTime;

  @doc("<p>The type of execution. For example, <code>Command</code> is a valid execution type.</p>")
  executionType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NonCompliantSummary")
model NonCompliantSummary {
  @doc("<p>The total number of compliance items that aren't compliant.</p>")
  nonCompliantCount?: int32;

  @doc("<p>A summary of the non-compliance severity by compliance type</p>")
  severitySummary?: SeveritySummary;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SeveritySummary")
model SeveritySummary {
  @doc("<p>The total number of resources or compliance items that have a severity level of <code>Critical</code>. Critical severity is determined by the organization that published the compliance items.</p>")
  criticalCount?: int32;

  @doc("<p>The total number of resources or compliance items that have a severity level of high. High severity is determined by the organization that published the compliance items.</p>")
  highCount?: int32;

  @doc("<p>The total number of resources or compliance items that have a severity level of informational. Informational severity is determined by the organization that published the compliance items.</p>")
  informationalCount?: int32;

  @doc("<p>The total number of resources or compliance items that have a severity level of low. Low severity is determined by the organization that published the compliance items.</p>")
  lowCount?: int32;

  @doc("<p>The total number of resources or compliance items that have a severity level of medium. Medium severity is determined by the organization that published the compliance items.</p>")
  mediumCount?: int32;

  @doc("<p>The total number of resources or compliance items that have a severity level of unspecified. Unspecified severity is determined by the organization that published the compliance items.</p>")
  unspecifiedCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SsmResourceComplianceSummaryItems {
  get is ArmResourceRead<SsmResourceComplianceSummaryItem>;
  @doc("Create a SsmResourceComplianceSummaryItem. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SsmResourceComplianceSummaryItem>;
  update is ArmCustomPatchAsync<
    SsmResourceComplianceSummaryItem,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SsmResourceComplianceSummaryItem>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SsmResourceComplianceSummaryItem>;
  listByResourceGroup is ArmResourceListByParent<SsmResourceComplianceSummaryItem>;
  listBySubscription is ArmListBySubscription<SsmResourceComplianceSummaryItem>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ssm\ssm-2014-11-06.normal.json
// AWS Shape: ResourceComplianceSummaryItem
//
// Related information for backend service:
// AWS Servcie : SSM
// Product Version : 3.7.798.0
// SDK Version : 3.7.304.2
//--------------------------------------------------------------------------------------------
