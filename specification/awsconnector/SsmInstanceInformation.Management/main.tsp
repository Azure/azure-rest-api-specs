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

//---------------------------------------------- SsmInstanceInformations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "SSM Instance Information",
    plural: "SSM Instance Informations",
  },
  keywords: ["Microsoft.AwsConnector", "SSM", "Instance", "Information"],
})
@doc("A Microsoft.AwsConnector resource")
model SsmInstanceInformation
  is TrackedResource<SsmInstanceInformationProperties> {
  @doc("Name of SsmInstanceInformation")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ssmInstanceInformations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SsmInstanceInformation")
model SsmInstanceInformationProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSsmInstanceInformationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSsmInstanceInformation")
model AwsSsmInstanceInformationProperties {
  @doc("<p>The activation ID created by Amazon Web Services Systems Manager when the server or virtual machine (VM) was registered.</p>")
  activationId?: string;

  @doc("<p>The version of SSM Agent running on your Linux managed node. </p>")
  agentVersion?: string;

  @doc("<p>Information about the association.</p>")
  associationOverview?: InstanceAggregatedAssociationOverview;

  @doc("<p>The status of the association.</p>")
  associationStatus?: string;

  @doc("<p>The fully qualified host name of the managed node.</p>")
  computerName?: string;

  @doc("<p>The IP address of the managed node.</p>")
  ipAddress?: string;

  @doc("<p>The Identity and Access Management (IAM) role assigned to the on-premises Systems Manager managed node. This call doesn't return the IAM role for Amazon Elastic Compute Cloud (Amazon EC2) instances. To retrieve the IAM role for an EC2 instance, use the Amazon EC2 <code>DescribeInstances</code> operation. For information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html'>DescribeInstances</a> in the <i>Amazon EC2 API Reference</i> or <a href='https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html'>describe-instances</a> in the <i>Amazon Web Services CLI Command Reference</i>.</p>")
  iamRole?: string;

  @doc("<p>The managed node ID. </p>")
  instanceId?: string;

  @doc("<p>Indicates whether the latest version of SSM Agent is running on your Linux managed node. This field doesn't indicate whether or not the latest version is installed on Windows managed nodes, because some older versions of Windows Server use the EC2Config service to process Systems Manager requests.</p>")
  isLatestVersion?: boolean;

  @doc("<p>The date the association was last run.</p>")
  lastAssociationExecutionDate?: utcDateTime;

  @doc("<p>The date and time when the agent last pinged the Systems Manager service. </p>")
  lastPingDateTime?: utcDateTime;

  @doc("<p>The last date the association was successfully run.</p>")
  lastSuccessfulAssociationExecutionDate?: utcDateTime;

  @doc("<p>The name assigned to an on-premises server, edge device, or virtual machine (VM) when it is activated as a Systems Manager managed node. The name is specified as the <code>DefaultInstanceName</code> property using the <a>CreateActivation</a> command. It is applied to the managed node by specifying the Activation Code and Activation ID when you install SSM Agent on the node, as explained in <a href='https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-managed-linux.html'>Install SSM Agent for a hybrid and multicloud environment (Linux)</a> and <a href='https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-managed-win.html'>Install SSM Agent for a hybrid and multicloud environment (Windows)</a>. To retrieve the <code>Name</code> tag of an EC2 instance, use the Amazon EC2 <code>DescribeInstances</code> operation. For information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html'>DescribeInstances</a> in the <i>Amazon EC2 API Reference</i> or <a href='https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html'>describe-instances</a> in the <i>Amazon Web Services CLI Command Reference</i>.</p>")
  name?: string;

  @doc("<p>Connection status of SSM Agent. </p> <note> <p>The status <code>Inactive</code> has been deprecated and is no longer in use.</p> </note>")
  pingStatus?: PingStatusEnumValue;

  @doc("<p>The name of the operating system platform running on your managed node. </p>")
  platformName?: string;

  @doc("<p>The operating system platform type. </p>")
  platformType?: PlatformTypeEnumValue;

  @doc("<p>The version of the OS platform running on your managed node. </p>")
  platformVersion?: string;

  @doc("<p>The date the server or VM was registered with Amazon Web Services as a managed node.</p>")
  registrationDate?: utcDateTime;

  @doc("<p>The type of instance. Instances are either EC2 instances or managed instances. </p>")
  resourceType?: ResourceTypeEnumValue;

  @doc("<p>The ID of the source resource. For IoT Greengrass devices, <code>SourceId</code> is the Thing name. </p>")
  sourceId?: string;

  @doc("<p>The type of the source resource. For IoT Greengrass devices, <code>SourceType</code> is <code>AWS::IoT::Thing</code>. </p>")
  sourceType?: SourceTypeEnumValue;
}

@doc("PingStatus enum")
union PingStatus {
  @doc("PingStatus enum ConnectionLost")
  ConnectionLost: "ConnectionLost",

  @doc("PingStatus enum Inactive")
  Inactive: "Inactive",

  @doc("PingStatus enum Online")
  Online: "Online",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PingStatusEnumValue")
model PingStatusEnumValue {
  @doc("Property value")
  value?: PingStatus;
}

@doc("ResourceType enum")
union ResourceType {
  @doc("ResourceType enum EC2Instance")
  EC2Instance: "EC2Instance",

  @doc("ResourceType enum ManagedInstance")
  ManagedInstance: "ManagedInstance",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceTypeEnumValue")
model ResourceTypeEnumValue {
  @doc("Property value")
  value?: ResourceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceAggregatedAssociationOverview")
model InstanceAggregatedAssociationOverview {
  @doc("<p>Detailed status information about the aggregated associations.</p>")
  detailedStatus?: string;

  @doc("<p>The number of associations for the managed nodes.</p>")
  instanceAssociationStatusAggregatedCount?: Record<int32>;
}

@doc("PlatformType enum")
union PlatformType {
  @doc("PlatformType enum Linux")
  Linux: "Linux",

  @doc("PlatformType enum MacOS")
  MacOS: "MacOS",

  @doc("PlatformType enum Windows")
  Windows: "Windows",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlatformTypeEnumValue")
model PlatformTypeEnumValue {
  @doc("Property value")
  value?: PlatformType;
}

@doc("SourceType enum")
union SourceType {
  @doc("SourceType enum AWS::EC2::Instance")
  AWSEC2Instance: "AWS::EC2::Instance",

  @doc("SourceType enum AWS::IoT::Thing")
  AWSIoTThing: "AWS::IoT::Thing",

  @doc("SourceType enum AWS::SSM::ManagedInstance")
  AWSSSMManagedInstance: "AWS::SSM::ManagedInstance",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceTypeEnumValue")
model SourceTypeEnumValue {
  @doc("Property value")
  value?: SourceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SsmInstanceInformations {
  get is ArmResourceRead<SsmInstanceInformation>;
  @doc("Create a SsmInstanceInformation. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SsmInstanceInformation>;
  update is ArmCustomPatchAsync<
    SsmInstanceInformation,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SsmInstanceInformation>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SsmInstanceInformation>;
  listByResourceGroup is ArmResourceListByParent<SsmInstanceInformation>;
  listBySubscription is ArmListBySubscription<SsmInstanceInformation>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ssm\ssm-2014-11-06.normal.json
// AWS Shape: InstanceInformation
//
// Related information for backend service:
// AWS Servcie : SSM
// Product Version : 3.7.798.0
// SDK Version : 3.7.304.2
//--------------------------------------------------------------------------------------------
