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

//---------------------------------------------- EmrClusterSummaries ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EMR Cluster Summary",
    plural: "EMR Cluster Summaries",
  },
  keywords: ["Microsoft.AwsConnector", "EMR", "Cluster", "Summary"],
})
@doc("A Microsoft.AwsConnector resource")
model EmrClusterSummary is TrackedResource<EmrClusterSummaryProperties> {
  @doc("Name of EmrClusterSummary")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("emrClusterSummaries")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EmrClusterSummary")
model EmrClusterSummaryProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEmrClusterSummaryProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEmrClusterSummary")
model AwsEmrClusterSummaryProperties {
  @doc("<p>The Amazon Resource Name of the cluster.</p>")
  clusterArn?: string;

  @doc("<p>The unique identifier for the cluster.</p>")
  id?: string;

  @doc("<p>The name of the cluster.</p>")
  name?: string;

  @doc("<p>An approximation of the cost of the cluster, represented in m1.small/hours. This value is incremented one time for every hour an m1.small instance runs. Larger instances are weighted more, so an Amazon EC2 instance that is roughly four times more expensive would result in the normalized instance hours being incremented by four. This result is only an approximation and does not reflect the actual billing rate.</p>")
  normalizedInstanceHours?: int32;

  @doc("<p> The Amazon Resource Name (ARN) of the Outpost where the cluster is launched. </p>")
  outpostArn?: string;

  @doc("<p>The details about the current status of the cluster.</p>")
  status?: ClusterStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStatus")
model ClusterStatus {
  @doc("<p>A list of tuples that provides information about the errors that caused a cluster to terminate. This structure can contain up to 10 different <code>ErrorDetail</code> tuples.</p>")
  @extension("x-ms-identifiers", [])
  errorDetails?: ErrorDetail[];

  @doc("<p>The current state of the cluster.</p>")
  state?: ClusterStateEnumValue;

  @doc("<p>The reason for the cluster status change.</p>")
  stateChangeReason?: ClusterStateChangeReason;

  @doc("<p>A timeline that represents the status of a cluster over the lifetime of the cluster.</p>")
  timeline?: ClusterTimeline;
}

@doc("ClusterState enum")
union ClusterState {
  @doc("ClusterState enum BOOTSTRAPPING")
  BOOTSTRAPPING: "BOOTSTRAPPING",

  @doc("ClusterState enum RUNNING")
  RUNNING: "RUNNING",

  @doc("ClusterState enum STARTING")
  STARTING: "STARTING",

  @doc("ClusterState enum TERMINATED")
  TERMINATED: "TERMINATED",

  @doc("ClusterState enum TERMINATED_WITH_ERRORS")
  TERMINATED_WITH_ERRORS: "TERMINATED_WITH_ERRORS",

  @doc("ClusterState enum TERMINATING")
  TERMINATING: "TERMINATING",

  @doc("ClusterState enum WAITING")
  WAITING: "WAITING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStateEnumValue")
model ClusterStateEnumValue {
  @doc("Property value")
  value?: ClusterState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ErrorDetail")
model ErrorDetail {
  @doc("<p>The name or code associated with the error.</p>")
  errorCode?: string;

  @doc("<p>A list of key value pairs that provides contextual information about why an error occured.</p>")
  @extension("x-ms-identifiers", [])
  errorData?: StringMap[];

  @doc("<p>A message that describes the error.</p>")
  errorMessage?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStateChangeReason")
model ClusterStateChangeReason {
  @doc("<p>The programmatic code for the state change reason.</p>")
  code?: ClusterStateChangeReasonCodeEnumValue;

  @doc("<p>The descriptive message for the state change reason.</p>")
  message?: string;
}

@doc("ClusterStateChangeReasonCode enum")
union ClusterStateChangeReasonCode {
  @doc("ClusterStateChangeReasonCode enum ALL_STEPS_COMPLETED")
  ALL_STEPS_COMPLETED: "ALL_STEPS_COMPLETED",

  @doc("ClusterStateChangeReasonCode enum BOOTSTRAP_FAILURE")
  BOOTSTRAP_FAILURE: "BOOTSTRAP_FAILURE",

  @doc("ClusterStateChangeReasonCode enum INSTANCE_FAILURE")
  INSTANCE_FAILURE: "INSTANCE_FAILURE",

  @doc("ClusterStateChangeReasonCode enum INSTANCE_FLEET_TIMEOUT")
  INSTANCE_FLEET_TIMEOUT: "INSTANCE_FLEET_TIMEOUT",

  @doc("ClusterStateChangeReasonCode enum INTERNAL_ERROR")
  INTERNAL_ERROR: "INTERNAL_ERROR",

  @doc("ClusterStateChangeReasonCode enum STEP_FAILURE")
  STEP_FAILURE: "STEP_FAILURE",

  @doc("ClusterStateChangeReasonCode enum USER_REQUEST")
  USER_REQUEST: "USER_REQUEST",

  @doc("ClusterStateChangeReasonCode enum VALIDATION_ERROR")
  VALIDATION_ERROR: "VALIDATION_ERROR",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStateChangeReasonCodeEnumValue")
model ClusterStateChangeReasonCodeEnumValue {
  @doc("Property value")
  value?: ClusterStateChangeReasonCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterTimeline")
model ClusterTimeline {
  @doc("<p>The creation date and time of the cluster.</p>")
  creationDateTime?: utcDateTime;

  @doc("<p>The date and time when the cluster was terminated.</p>")
  endDateTime?: utcDateTime;

  @doc("<p>The date and time when the cluster was ready to run steps.</p>")
  readyDateTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StringMap")
model StringMap {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EmrClusterSummaries {
  get is ArmResourceRead<EmrClusterSummary>;
  @doc("Create a EmrClusterSummary. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EmrClusterSummary>;
  update is ArmCustomPatchAsync<
    EmrClusterSummary,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EmrClusterSummary>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EmrClusterSummary>;
  listByResourceGroup is ArmResourceListByParent<EmrClusterSummary>;
  listBySubscription is ArmListBySubscription<EmrClusterSummary>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\elasticmapreduce\elasticmapreduce-2009-03-31.normal.json
// AWS Shape: ClusterSummary
//
// Related information for backend service:
// AWS Servcie : EMR
// Product Version : 3.7.798.0
// SDK Version : 3.7.304.31
//--------------------------------------------------------------------------------------------
