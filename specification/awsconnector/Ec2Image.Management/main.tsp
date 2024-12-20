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

//---------------------------------------------- Ec2Images ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Image",
    plural: "EC2 Images",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Image"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2Image is TrackedResource<Ec2ImageProperties> {
  @doc("Name of Ec2Image")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Images")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Image")
model Ec2ImageProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2ImageProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Image")
model AwsEc2ImageProperties {
  @doc("<p>The architecture of the image.</p>")
  architecture?: ArchitectureValuesEnumValue;

  @doc("<p>Any block device mapping entries.</p>")
  @extension("x-ms-identifiers", [])
  blockDeviceMappings?: BlockDeviceMapping[];

  @doc("<p>The boot mode of the image. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html'>Boot modes</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  bootMode?: BootModeValuesEnumValue;

  @doc("<p>The date and time the image was created.</p>")
  creationDate?: string;

  @doc("<p>The date and time to deprecate the AMI, in UTC, in the following format: <i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>HH</i>:<i>MM</i>:<i>SS</i>Z. If you specified a value for seconds, Amazon EC2 rounds the seconds to the nearest minute.</p>")
  deprecationTime?: string;

  @doc("<p>Indicates whether deregistration protection is enabled for the AMI.</p>")
  deregistrationProtection?: string;

  @doc("<p>The description of the AMI that was provided during image creation.</p>")
  description?: string;

  @doc("<p>Specifies whether enhanced networking with ENA is enabled.</p>")
  enaSupport?: boolean;

  @doc("<p>The hypervisor type of the image. Only <code>xen</code> is supported. <code>ovm</code> is not supported.</p>")
  hypervisor?: HypervisorTypeEnumValue;

  @doc("<p>The ID of the AMI.</p>")
  imageId?: string;

  @doc("<p>The location of the AMI.</p>")
  imageLocation?: string;

  @doc("<p>The owner alias (<code>amazon</code> | <code>aws-marketplace</code>).</p>")
  imageOwnerAlias?: string;

  @doc("<p>The type of image.</p>")
  imageType?: ImageTypeValuesEnumValue;

  @doc("<p>If <code>v2.0</code>, it indicates that IMDSv2 is specified in the AMI. Instances launched from this AMI will have <code>HttpTokens</code> automatically set to <code>required</code> so that, by default, the instance requires that IMDSv2 is used when requesting instance metadata. In addition, <code>HttpPutResponseHopLimit</code> is set to <code>2</code>. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html#configure-IMDS-new-instances-ami-configuration'>Configure the AMI</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  imdsSupport?: ImdsSupportValuesEnumValue;

  @doc("<p>The kernel associated with the image, if any. Only applicable for machine images.</p>")
  kernelId?: string;

  @doc("<p>The date and time, in <a href='http://www.iso.org/iso/iso8601'>ISO 8601 date-time format</a>, when the AMI was last used to launch an EC2 instance. When the AMI is used to launch an instance, there is a 24-hour delay before that usage is reported.</p> <note> <p> <code>lastLaunchedTime</code> data is available starting April 2017.</p> </note>")
  lastLaunchedTime?: string;

  @doc("<p>The name of the AMI that was provided during image creation.</p>")
  name?: string;

  @doc("<p>The ID of the Amazon Web Services account that owns the image.</p>")
  ownerId?: string;

  @doc("<p>This value is set to <code>windows</code> for Windows AMIs; otherwise, it is blank.</p>")
  platform?: PlatformValuesEnumValue;

  @doc("<p>The platform details associated with the billing code of the AMI. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-billing-info.html'>Understand AMI billing information</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  platformDetails?: string;

  @doc("<p>Any product codes associated with the AMI.</p>")
  @extension("x-ms-identifiers", [])
  productCodes?: ProductCode[];

  @doc("<p>Indicates whether the image has public launch permissions. The value is <code>true</code> if this image has public launch permissions or <code>false</code> if it has only implicit and explicit launch permissions.</p>")
  public?: boolean;

  @doc("<p>The RAM disk associated with the image, if any. Only applicable for machine images.</p>")
  ramdiskId?: string;

  @doc("<p>The device name of the root device volume (for example, <code>/dev/sda1</code>).</p>")
  rootDeviceName?: string;

  @doc("<p>The type of root device used by the AMI. The AMI can use an Amazon EBS volume or an instance store volume.</p>")
  rootDeviceType?: DeviceTypeEnumValue;

  @doc("<p>The ID of the instance that the AMI was created from if the AMI was created using <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateImage.html'>CreateImage</a>. This field only appears if the AMI was created using CreateImage.</p>")
  sourceInstanceId?: string;

  @doc("<p>Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled.</p>")
  sriovNetSupport?: string;

  @doc("<p>The current state of the AMI. If the state is <code>available</code>, the image is successfully registered and can be used to launch an instance.</p>")
  state?: ImageStateEnumValue;

  @doc("<p>The reason for the state change.</p>")
  stateReason?: StateReason;

  @doc("<p>Any tags assigned to the image.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("<p>If the image is configured for NitroTPM support, the value is <code>v2.0</code>. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitrotpm.html'>NitroTPM</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  tpmSupport?: TpmSupportValuesEnumValue;

  @doc("<p>The operation of the Amazon EC2 instance and the billing code that is associated with the AMI. <code>usageOperation</code> corresponds to the <a href='https://docs.aws.amazon.com/cur/latest/userguide/Lineitem-columns.html#Lineitem-details-O-Operation'>lineitem/Operation</a> column on your Amazon Web Services Cost and Usage Report and in the <a href='https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/price-changes.html'>Amazon Web Services Price List API</a>. You can view these fields on the <b>Instances</b> or <b>AMIs</b> pages in the Amazon EC2 console, or in the responses that are returned by the <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeImages.html'>DescribeImages</a> command in the Amazon EC2 API, or the <a href='https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html'>describe-images</a> command in the CLI.</p>")
  usageOperation?: string;

  @doc("<p>The type of virtualization of the AMI.</p>")
  virtualizationType?: VirtualizationTypeEnumValue;
}

@doc("ArchitectureValues enum")
union ArchitectureValues {
  @doc("ArchitectureValues enum arm64")
  Arm64: "arm64",

  @doc("ArchitectureValues enum arm64_mac")
  Arm64_mac: "arm64_mac",

  @doc("ArchitectureValues enum i386")
  I386: "i386",

  @doc("ArchitectureValues enum x86_64")
  X86_64: "x86_64",

  @doc("ArchitectureValues enum x86_64_mac")
  X86_64_mac: "x86_64_mac",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ArchitectureValuesEnumValue")
model ArchitectureValuesEnumValue {
  @doc("Property value")
  value?: ArchitectureValues;
}

@doc("HypervisorType enum")
union HypervisorType {
  @doc("HypervisorType enum ovm")
  Ovm: "ovm",

  @doc("HypervisorType enum xen")
  Xen: "xen",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HypervisorTypeEnumValue")
model HypervisorTypeEnumValue {
  @doc("Property value")
  value?: HypervisorType;
}

@doc("ImdsSupportValues enum")
union ImdsSupportValues {
  @doc("ImdsSupportValues enum v2.0")
  V20: "v2.0",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImdsSupportValuesEnumValue")
model ImdsSupportValuesEnumValue {
  @doc("Property value")
  value?: ImdsSupportValues;
}

@doc("DeviceType enum")
union DeviceType {
  @doc("DeviceType enum ebs")
  Ebs: "ebs",

  @doc("DeviceType enum instance-store")
  InstanceStore: "instance-store",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeviceTypeEnumValue")
model DeviceTypeEnumValue {
  @doc("Property value")
  value?: DeviceType;
}

@doc("TpmSupportValues enum")
union TpmSupportValues {
  @doc("TpmSupportValues enum v2.0")
  V20: "v2.0",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TpmSupportValuesEnumValue")
model TpmSupportValuesEnumValue {
  @doc("Property value")
  value?: TpmSupportValues;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BlockDeviceMapping")
model BlockDeviceMapping {
  @doc("<p>The device name (for example, <code>/dev/sdh</code> or <code>xvdh</code>).</p>")
  deviceName?: string;

  @doc("<p>Parameters used to automatically set up EBS volumes when the instance is launched.</p>")
  ebs?: EbsBlockDevice;

  @doc("<p>To omit the device from the block device mapping, specify an empty string. When this property is specified, the device is removed from the block device mapping regardless of the assigned value.</p>")
  noDevice?: string;

  @doc("<p>The virtual device name (<code>ephemeral</code>N). Instance store volumes are numbered starting from 0. An instance type with 2 available instance store volumes can specify mappings for <code>ephemeral0</code> and <code>ephemeral1</code>. The number of available instance store volumes depends on the instance type. After you connect to the instance, you must mount the volume.</p> <p>NVMe instance store volumes are automatically enumerated and assigned a device name. Including them in your block device mapping has no effect.</p> <p>Constraints: For M3 instances, you must specify instance store volumes in the block device mapping for the instance. When you launch an M3 instance, we ignore any instance store volumes specified in the block device mapping for the AMI.</p>")
  virtualName?: string;
}

@doc("BootModeValues enum")
union BootModeValues {
  @doc("BootModeValues enum legacy-bios")
  LegacyBios: "legacy-bios",

  @doc("BootModeValues enum uefi")
  Uefi: "uefi",

  @doc("BootModeValues enum uefi-preferred")
  UefiPreferred: "uefi-preferred",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BootModeValuesEnumValue")
model BootModeValuesEnumValue {
  @doc("Property value")
  value?: BootModeValues;
}

@doc("PlatformValues enum")
union PlatformValues {
  @doc("PlatformValues enum Windows")
  Windows: "Windows",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlatformValuesEnumValue")
model PlatformValuesEnumValue {
  @doc("Property value")
  value?: PlatformValues;
}

@doc("VirtualizationType enum")
union VirtualizationType {
  @doc("VirtualizationType enum hvm")
  Hvm: "hvm",

  @doc("VirtualizationType enum paravirtual")
  Paravirtual: "paravirtual",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VirtualizationTypeEnumValue")
model VirtualizationTypeEnumValue {
  @doc("Property value")
  value?: VirtualizationType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProductCode")
model ProductCode {
  @doc("<p>The product code.</p>")
  productCodeId?: string;

  @doc("<p>The type of product code.</p>")
  productCodeType?: ProductCodeValuesEnumValue;
}

@doc("ImageTypeValues enum")
union ImageTypeValues {
  @doc("ImageTypeValues enum kernel")
  Kernel: "kernel",

  @doc("ImageTypeValues enum machine")
  Machine: "machine",

  @doc("ImageTypeValues enum ramdisk")
  Ramdisk: "ramdisk",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageTypeValuesEnumValue")
model ImageTypeValuesEnumValue {
  @doc("Property value")
  value?: ImageTypeValues;
}

@doc("ProductCodeValues enum")
union ProductCodeValues {
  @doc("ProductCodeValues enum devpay")
  Devpay: "devpay",

  @doc("ProductCodeValues enum marketplace")
  Marketplace: "marketplace",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProductCodeValuesEnumValue")
model ProductCodeValuesEnumValue {
  @doc("Property value")
  value?: ProductCodeValues;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StateReason")
model StateReason {
  @doc("<p>The reason code for the state change.</p>")
  code?: string;

  @doc("<p>The message for the state change.</p> <ul> <li> <p> <code>Server.InsufficientInstanceCapacity</code>: There was insufficient capacity available to satisfy the launch request.</p> </li> <li> <p> <code>Server.InternalError</code>: An internal error caused the instance to terminate during launch.</p> </li> <li> <p> <code>Server.ScheduledStop</code>: The instance was stopped due to a scheduled retirement.</p> </li> <li> <p> <code>Server.SpotInstanceShutdown</code>: The instance was stopped because the number of Spot requests with a maximum price equal to or higher than the Spot price exceeded available capacity or because of an increase in the Spot price.</p> </li> <li> <p> <code>Server.SpotInstanceTermination</code>: The instance was terminated because the number of Spot requests with a maximum price equal to or higher than the Spot price exceeded available capacity or because of an increase in the Spot price.</p> </li> <li> <p> <code>Client.InstanceInitiatedShutdown</code>: The instance was shut down from the operating system of the instance.</p> </li> <li> <p> <code>Client.InstanceTerminated</code>: The instance was terminated or rebooted during AMI creation.</p> </li> <li> <p> <code>Client.InternalError</code>: A client error caused the instance to terminate during launch.</p> </li> <li> <p> <code>Client.InvalidSnapshot.NotFound</code>: The specified snapshot was not found.</p> </li> <li> <p> <code>Client.UserInitiatedHibernate</code>: Hibernation was initiated on the instance.</p> </li> <li> <p> <code>Client.UserInitiatedShutdown</code>: The instance was shut down using the Amazon EC2 API.</p> </li> <li> <p> <code>Client.VolumeLimitExceeded</code>: The limit on the number of EBS volumes or total storage was exceeded. Decrease usage or request an increase in your account limits.</p> </li> </ul>")
  message?: string;
}

@doc("ImageState enum")
union ImageState {
  @doc("ImageState enum available")
  Available: "available",

  @doc("ImageState enum deregistered")
  Deregistered: "deregistered",

  @doc("ImageState enum disabled")
  Disabled: "disabled",

  @doc("ImageState enum error")
  Error: "error",

  @doc("ImageState enum failed")
  Failed: "failed",

  @doc("ImageState enum invalid")
  Invalid: "invalid",

  @doc("ImageState enum pending")
  Pending: "pending",

  @doc("ImageState enum transient")
  Transient: "transient",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageStateEnumValue")
model ImageStateEnumValue {
  @doc("Property value")
  value?: ImageState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("<p>The key of the tag.</p> <p>Constraints: Tag keys are case-sensitive and accept a maximum of 127 Unicode characters. May not begin with <code>aws:</code>.</p>")
  key?: string;

  @doc("<p>The value of the tag.</p> <p>Constraints: Tag values are case-sensitive and accept a maximum of 256 Unicode characters.</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsBlockDevice")
model EbsBlockDevice {
  @doc("<p>Indicates whether the EBS volume is deleted on instance termination. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#preserving-volumes-on-termination'>Preserving Amazon EBS volumes on instance termination</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  deleteOnTermination?: boolean;

  @doc("<p>Indicates whether the encryption state of an EBS volume is changed while being restored from a backing snapshot. The effect of setting the encryption state to <code>true</code> depends on the volume origin (new or from a snapshot), starting encryption state, ownership, and whether encryption by default is enabled. For more information, see <a href='https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html#encryption-parameters'>Amazon EBS encryption</a> in the <i>Amazon EBS User Guide</i>.</p> <p>In no case can you remove encryption from an encrypted volume.</p> <p>Encrypted volumes can only be attached to instances that support Amazon EBS encryption. For more information, see <a href='https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption-requirements.html#ebs-encryption_supported_instances'>Supported instance types</a>.</p> <p>This parameter is not returned by <a>DescribeImageAttribute</a>.</p> <p>For <a>CreateImage</a> and <a>RegisterImage</a>, whether you can include this parameter, and the allowed values differ depending on the type of block device mapping you are creating.</p> <ul> <li> <p>If you are creating a block device mapping for a <b>new (empty) volume</b>, you can include this parameter, and specify either <code>true</code> for an encrypted volume, or <code>false</code> for an unencrypted volume. If you omit this parameter, it defaults to <code>false</code> (unencrypted).</p> </li> <li> <p>If you are creating a block device mapping from an <b>existing encrypted or unencrypted snapshot</b>, you must omit this parameter. If you include this parameter, the request will fail, regardless of the value that you specify.</p> </li> <li> <p>If you are creating a block device mapping from an <b>existing unencrypted volume</b>, you can include this parameter, but you must specify <code>false</code>. If you specify <code>true</code>, the request will fail. In this case, we recommend that you omit the parameter.</p> </li> <li> <p>If you are creating a block device mapping from an <b>existing encrypted volume</b>, you can include this parameter, and specify either <code>true</code> or <code>false</code>. However, if you specify <code>false</code>, the parameter is ignored and the block device mapping is always encrypted. In this case, we recommend that you omit the parameter.</p> </li> </ul>")
  encrypted?: boolean;

  @doc("<p>The number of I/O operations per second (IOPS). For <code>gp3</code>, <code>io1</code>, and <code>io2</code> volumes, this represents the number of IOPS that are provisioned for the volume. For <code>gp2</code> volumes, this represents the baseline performance of the volume and the rate at which the volume accumulates I/O credits for bursting.</p> <p>The following are the supported values for each volume type:</p> <ul> <li> <p> <code>gp3</code>: 3,000 - 16,000 IOPS</p> </li> <li> <p> <code>io1</code>: 100 - 64,000 IOPS</p> </li> <li> <p> <code>io2</code>: 100 - 256,000 IOPS</p> </li> </ul> <p>For <code>io2</code> volumes, you can achieve up to 256,000 IOPS on <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#ec2-nitro-instances'>instances built on the Nitro System</a>. On other instances, you can achieve performance up to 32,000 IOPS.</p> <p>This parameter is required for <code>io1</code> and <code>io2</code> volumes. The default for <code>gp3</code> volumes is 3,000 IOPS.</p>")
  iops?: int32;

  @doc("<p>Identifier (key ID, key alias, ID ARN, or alias ARN) for a customer managed CMK under which the EBS volume is encrypted.</p> <p>This parameter is only supported on <code>BlockDeviceMapping</code> objects called by <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html'>RunInstances</a>, <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestSpotFleet.html'>RequestSpotFleet</a>, and <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestSpotInstances.html'>RequestSpotInstances</a>.</p>")
  kmsKeyId?: string;

  @doc("<p>The ARN of the Outpost on which the snapshot is stored.</p> <p>This parameter is not supported when using <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateImage.html'>CreateImage</a>.</p>")
  outpostArn?: string;

  @doc("<p>The ID of the snapshot.</p>")
  snapshotId?: string;

  @doc("<p>The throughput that the volume supports, in MiB/s.</p> <p>This parameter is valid only for <code>gp3</code> volumes.</p> <p>Valid Range: Minimum value of 125. Maximum value of 1000.</p>")
  throughput?: int32;

  @doc("<p>The size of the volume, in GiBs. You must specify either a snapshot ID or a volume size. If you specify a snapshot, the default is the snapshot size. You can specify a volume size that is equal to or larger than the snapshot size.</p> <p>The following are the supported sizes for each volume type:</p> <ul> <li> <p> <code>gp2</code> and <code>gp3</code>: 1 - 16,384 GiB</p> </li> <li> <p> <code>io1</code>: 4 - 16,384 GiB</p> </li> <li> <p> <code>io2</code>: 4 - 65,536 GiB</p> </li> <li> <p> <code>st1</code> and <code>sc1</code>: 125 - 16,384 GiB</p> </li> <li> <p> <code>standard</code>: 1 - 1024 GiB</p> </li> </ul>")
  volumeSize?: int32;

  @doc("<p>The volume type. For more information, see <a href='https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volume-types.html'>Amazon EBS volume types</a> in the <i>Amazon EBS User Guide</i>.</p>")
  volumeType?: VolumeTypeEnumValue;
}

@doc("VolumeType enum")
union VolumeType {
  @doc("VolumeType enum gp2")
  Gp2: "gp2",

  @doc("VolumeType enum gp3")
  Gp3: "gp3",

  @doc("VolumeType enum io1")
  Io1: "io1",

  @doc("VolumeType enum io2")
  Io2: "io2",

  @doc("VolumeType enum sc1")
  Sc1: "sc1",

  @doc("VolumeType enum st1")
  St1: "st1",

  @doc("VolumeType enum standard")
  Standard: "standard",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VolumeTypeEnumValue")
model VolumeTypeEnumValue {
  @doc("Property value")
  value?: VolumeType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2Images {
  get is ArmResourceRead<Ec2Image>;
  @doc("Create a Ec2Image. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2Image>;
  update is ArmCustomPatchAsync<
    Ec2Image,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2Image>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Image>;
  listByResourceGroup is ArmResourceListByParent<Ec2Image>;
  listBySubscription is ArmListBySubscription<Ec2Image>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: Image
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
