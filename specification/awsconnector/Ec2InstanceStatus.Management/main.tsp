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

//---------------------------------------------- Ec2InstanceStatuses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Instance Status",
    plural: "EC2 Instance Statuses",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Instance", "Status"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2InstanceStatus is TrackedResource<Ec2InstanceStatusProperties> {
  @doc("Name of Ec2InstanceStatus")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2InstanceStatuses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2InstanceStatus")
model Ec2InstanceStatusProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2InstanceStatusProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2InstanceStatus")
model AwsEc2InstanceStatusProperties {
  @doc("<p>The Availability Zone of the instance.</p>")
  availabilityZone?: string;

  @doc("<p>Any scheduled events associated with the instance.</p>")
  @extension("x-ms-identifiers", [])
  events?: InstanceStatusEvent[];

  @doc("<p>The ID of the instance.</p>")
  instanceId?: string;

  @doc("<p>The intended state of the instance. <a>DescribeInstanceStatus</a> requires that an instance be in the <code>running</code> state.</p>")
  instanceState?: InstanceState;

  @doc("<p>Reports impaired functionality that stems from issues internal to the instance, such as impaired reachability.</p>")
  instanceStatus?: InstanceStatusSummary;

  @doc("<p>The Amazon Resource Name (ARN) of the Outpost.</p>")
  outpostArn?: string;

  @doc("<p>Reports impaired functionality that stems from issues related to the systems that support an instance, such as hardware failures and network connectivity problems.</p>")
  systemStatus?: InstanceStatusSummary;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceStatusEvent")
model InstanceStatusEvent {
  @doc("<p>The event code.</p>")
  code?: EventCodeEnumValue;

  @doc("<p>A description of the event.</p> <p>After a scheduled event is completed, it can still be described for up to a week. If the event has been completed, this description starts with the following text: [Completed].</p>")
  description?: string;

  @doc("<p>The ID of the event.</p>")
  instanceEventId?: string;

  @doc("<p>The latest scheduled end time for the event.</p>")
  notAfter?: utcDateTime;

  @doc("<p>The earliest scheduled start time for the event.</p>")
  notBefore?: utcDateTime;

  @doc("<p>The deadline for starting the event.</p>")
  notBeforeDeadline?: utcDateTime;
}

@doc("EventCode enum")
union EventCode {
  @doc("EventCode enum instance-reboot")
  InstanceReboot: "instance-reboot",

  @doc("EventCode enum instance-retirement")
  InstanceRetirement: "instance-retirement",

  @doc("EventCode enum instance-stop")
  InstanceStop: "instance-stop",

  @doc("EventCode enum system-maintenance")
  SystemMaintenance: "system-maintenance",

  @doc("EventCode enum system-reboot")
  SystemReboot: "system-reboot",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EventCodeEnumValue")
model EventCodeEnumValue {
  @doc("Property value")
  value?: EventCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceState")
model InstanceState {
  @doc("<p>The state of the instance as a 16-bit unsigned integer. </p> <p>The high byte is all of the bits between 2^8 and (2^16)-1, which equals decimal values between 256 and 65,535. These numerical values are used for internal purposes and should be ignored.</p> <p>The low byte is all of the bits between 2^0 and (2^8)-1, which equals decimal values between 0 and 255. </p> <p>The valid values for instance-state-code will all be in the range of the low byte and they are:</p> <ul> <li> <p> <code>0</code> : <code>pending</code> </p> </li> <li> <p> <code>16</code> : <code>running</code> </p> </li> <li> <p> <code>32</code> : <code>shutting-down</code> </p> </li> <li> <p> <code>48</code> : <code>terminated</code> </p> </li> <li> <p> <code>64</code> : <code>stopping</code> </p> </li> <li> <p> <code>80</code> : <code>stopped</code> </p> </li> </ul> <p>You can ignore the high byte value by zeroing out all of the bits above 2^8 or 256 in decimal.</p>")
  code?: int32;

  @doc("<p>The current state of the instance.</p>")
  name?: InstanceStateNameEnumValue;
}

@doc("InstanceStateName enum")
union InstanceStateName {
  @doc("InstanceStateName enum pending")
  Pending: "pending",

  @doc("InstanceStateName enum running")
  Running: "running",

  @doc("InstanceStateName enum shutting-down")
  ShuttingDown: "shutting-down",

  @doc("InstanceStateName enum stopped")
  Stopped: "stopped",

  @doc("InstanceStateName enum stopping")
  Stopping: "stopping",

  @doc("InstanceStateName enum terminated")
  Terminated: "terminated",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceStateNameEnumValue")
model InstanceStateNameEnumValue {
  @doc("Property value")
  value?: InstanceStateName;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceStatusSummary")
model InstanceStatusSummary {
  @doc("<p>The system instance health or application instance health.</p>")
  @extension("x-ms-identifiers", [])
  details?: InstanceStatusDetails[];

  @doc("<p>The status.</p>")
  status?: SummaryStatusEnumValue;
}

@doc("SummaryStatus enum")
union SummaryStatus {
  @doc("SummaryStatus enum impaired")
  Impaired: "impaired",

  @doc("SummaryStatus enum initializing")
  Initializing: "initializing",

  @doc("SummaryStatus enum insufficient-data")
  InsufficientData: "insufficient-data",

  @doc("SummaryStatus enum not-applicable")
  NotApplicable: "not-applicable",

  @doc("SummaryStatus enum ok")
  Ok: "ok",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SummaryStatusEnumValue")
model SummaryStatusEnumValue {
  @doc("Property value")
  value?: SummaryStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceStatusDetails")
model InstanceStatusDetails {
  @doc("<p>The time when a status check failed. For an instance that was launched and impaired, this is the time when the instance was launched.</p>")
  impairedSince?: utcDateTime;

  @doc("<p>The type of instance status.</p>")
  name?: StatusNameEnumValue;

  @doc("<p>The status.</p>")
  status?: StatusTypeEnumValue;
}

@doc("StatusName enum")
union StatusName {
  @doc("StatusName enum reachability")
  Reachability: "reachability",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatusNameEnumValue")
model StatusNameEnumValue {
  @doc("Property value")
  value?: StatusName;
}

@doc("StatusType enum")
union StatusType {
  @doc("StatusType enum failed")
  Failed: "failed",

  @doc("StatusType enum initializing")
  Initializing: "initializing",

  @doc("StatusType enum insufficient-data")
  InsufficientData: "insufficient-data",

  @doc("StatusType enum passed")
  Passed: "passed",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatusTypeEnumValue")
model StatusTypeEnumValue {
  @doc("Property value")
  value?: StatusType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2InstanceStatuses {
  get is ArmResourceRead<Ec2InstanceStatus>;
  @doc("Create a Ec2InstanceStatus. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2InstanceStatus>;
  update is ArmCustomPatchAsync<
    Ec2InstanceStatus,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2InstanceStatus>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2InstanceStatus>;
  listByResourceGroup is ArmResourceListByParent<Ec2InstanceStatus>;
  listBySubscription is ArmListBySubscription<Ec2InstanceStatus>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: InstanceStatus
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
