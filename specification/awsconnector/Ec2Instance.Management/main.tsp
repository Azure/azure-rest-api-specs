import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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

//---------------------------------------------- Ec2Instances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
@singleton
model Ec2Instance is ExtensionResource<Ec2InstanceProperties> {
  @doc("Name of Ec2Instance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Instances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Instance")
model Ec2InstanceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2InstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Instance")
model AwsEc2InstanceProperties {
  @doc("<p>The AMI launch index, which can be used to find this instance in the launch group.</p>")
  amiLaunchIndex?: int32;

  @doc("<p>The architecture of the image.</p>")
  architecture?: ArchitectureValuesEnumValue;

  @doc("<p>Any block device mapping entries for the instance.</p>")
  @extension("x-ms-identifiers", [])
  blockDeviceMappings?: InstanceBlockDeviceMapping[];

  @doc("<p>The boot mode that was specified by the AMI. If the value is <code>uefi-preferred</code>, the AMI supports both UEFI and Legacy BIOS. The <code>currentInstanceBootMode</code> parameter is the boot mode that is used to boot the instance at launch or start.</p> <note> <p>The operating system contained in the AMI must be configured to support the specified boot mode.</p> </note> <p>For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html'>Boot modes</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  bootMode?: BootModeValuesEnumValue;

  @doc("<p>The ID of the Capacity Reservation.</p>")
  capacityReservationId?: string;

  @doc("<p>Information about the Capacity Reservation targeting option.</p>")
  capacityReservationSpecification?: CapacityReservationSpecificationResponse;

  @doc("<p>The idempotency token you provided when you launched the instance, if applicable.</p>")
  clientToken?: string;

  @doc("<p>The CPU options for the instance.</p>")
  cpuOptions?: CpuOptions;

  @doc("<p>The boot mode that is used to boot the instance at launch or start. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html'>Boot modes</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  currentInstanceBootMode?: InstanceBootModeValuesEnumValue;

  @doc("<p>Indicates whether the instance is optimized for Amazon EBS I/O. This optimization provides dedicated throughput to Amazon EBS and an optimized configuration stack to provide optimal I/O performance. This optimization isn't available with all instance types. Additional usage charges apply when using an EBS Optimized instance.</p>")
  ebsOptimized?: boolean;

  @doc("<p>Deprecated.</p> <note> <p>Amazon Elastic Graphics reached end of life on January 8, 2024. For workloads that require graphics acceleration, we recommend that you use Amazon EC2 G4ad, G4dn, or G5 instances.</p> </note>")
  @extension("x-ms-identifiers", [])
  elasticGpuAssociations?: ElasticGpuAssociation[];

  @doc("<p>The elastic inference accelerator associated with the instance.</p>")
  @extension("x-ms-identifiers", [])
  elasticInferenceAcceleratorAssociations?: ElasticInferenceAcceleratorAssociation[];

  @doc("<p>Specifies whether enhanced networking with ENA is enabled.</p>")
  enaSupport?: boolean;

  @doc("<p>Indicates whether the instance is enabled for Amazon Web Services Nitro Enclaves.</p>")
  enclaveOptions?: EnclaveOptions;

  @doc("<p>Indicates whether the instance is enabled for hibernation.</p>")
  hibernationOptions?: HibernationOptions;

  @doc("<p>The hypervisor type of the instance. The value <code>xen</code> is used for both Xen and Nitro hypervisors.</p>")
  hypervisor?: HypervisorTypeEnumValue;

  @doc("<p>The IAM instance profile associated with the instance, if applicable.</p>")
  iamInstanceProfile?: IamInstanceProfile;

  @doc("<p>The ID of the AMI used to launch the instance.</p>")
  imageId?: string;

  @doc("<p>The ID of the instance.</p>")
  instanceId?: string;

  @doc("<p>Indicates whether this is a Spot Instance or a Scheduled Instance.</p>")
  instanceLifecycle?: InstanceLifecycleTypeEnumValue;

  @doc("<p>The instance type.</p>")
  instanceType?: InstanceTypeEnumValue;

  @doc("<p>The IPv6 address assigned to the instance.</p>")
  ipv6Address?: string;

  @doc("<p>The kernel associated with this instance, if applicable.</p>")
  kernelId?: string;

  @doc("<p>The name of the key pair, if this instance was launched with an associated key pair.</p>")
  keyName?: string;

  @doc("<p>The time the instance was launched.</p>")
  launchTime?: utcDateTime;

  @doc("<p>The license configurations for the instance.</p>")
  @extension("x-ms-identifiers", [])
  licenses?: LicenseConfiguration[];

  @doc("<p>Provides information on the recovery and maintenance options of your instance.</p>")
  maintenanceOptions?: InstanceMaintenanceOptions;

  @doc("<p>The metadata options for the instance.</p>")
  metadataOptions?: InstanceMetadataOptionsResponse;

  @doc("<p>The monitoring for the instance.</p>")
  monitoring?: Monitoring;

  @doc("<p>The network interfaces for the instance.</p>")
  @extension("x-ms-identifiers", [])
  networkInterfaces?: InstanceNetworkInterface[];

  @doc("<p>The Amazon Resource Name (ARN) of the Outpost.</p>")
  outpostArn?: string;

  @doc("<p>The location where the instance launched, if applicable.</p>")
  placement?: Placement;

  @doc("<p>The platform. This value is <code>windows</code> for Windows instances; otherwise, it is empty.</p>")
  platform?: PlatformValuesEnumValue;

  @doc("<p>The platform details value for the instance. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/billing-info-fields.html'>AMI billing information fields</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  platformDetails?: string;

  @doc("<p>[IPv4 only] The private DNS hostname name assigned to the instance. This DNS hostname can only be used inside the Amazon EC2 network. This name is not available until the instance enters the <code>running</code> state. </p> <p>The Amazon-provided DNS server resolves Amazon-provided private DNS hostnames if you've enabled DNS resolution and DNS hostnames in your VPC. If you are not using the Amazon-provided DNS server in your VPC, your custom domain name servers must resolve the hostname as appropriate.</p>")
  privateDnsName?: string;

  @doc("<p>The options for the instance hostname.</p>")
  privateDnsNameOptions?: PrivateDnsNameOptionsResponse;

  @doc("<p>The private IPv4 address assigned to the instance.</p>")
  privateIpAddress?: string;

  @doc("<p>The product codes attached to this instance, if applicable.</p>")
  @extension("x-ms-identifiers", [])
  productCodes?: ProductCode[];

  @doc("<p>[IPv4 only] The public DNS name assigned to the instance. This name is not available until the instance enters the <code>running</code> state. This name is only available if you've enabled DNS hostnames for your VPC.</p>")
  publicDnsName?: string;

  @doc("<p>The public IPv4 address, or the Carrier IP address assigned to the instance, if applicable.</p> <p>A Carrier IP address only applies to an instance launched in a subnet associated with a Wavelength Zone.</p>")
  publicIpAddress?: string;

  @doc("<p>The RAM disk associated with this instance, if applicable.</p>")
  ramdiskId?: string;

  @doc("<p>The device name of the root device volume (for example, <code>/dev/sda1</code>).</p>")
  rootDeviceName?: string;

  @doc("<p>The root device type used by the AMI. The AMI can use an EBS volume or an instance store volume.</p>")
  rootDeviceType?: DeviceTypeEnumValue;

  @doc("<p>The security groups for the instance.</p>")
  @extension("x-ms-identifiers", [])
  securityGroups?: GroupIdentifier[];

  @doc("<p>Indicates whether source/destination checking is enabled.</p>")
  sourceDestCheck?: boolean;

  @doc("<p>If the request is a Spot Instance request, the ID of the request.</p>")
  spotInstanceRequestId?: string;

  @doc("<p>Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled.</p>")
  sriovNetSupport?: string;

  @doc("<p>The current state of the instance.</p>")
  state?: InstanceState;

  @doc("<p>The reason for the most recent state transition.</p>")
  stateReason?: StateReason;

  @doc("<p>The reason for the most recent state transition. This might be an empty string.</p>")
  stateTransitionReason?: string;

  @doc("<p>The ID of the subnet in which the instance is running.</p>")
  subnetId?: string;

  @doc("<p>Any tags assigned to the instance.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("<p>If the instance is configured for NitroTPM support, the value is <code>v2.0</code>. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitrotpm.html'>NitroTPM</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  tpmSupport?: string;

  @doc("<p>The usage operation value for the instance. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/billing-info-fields.html'>AMI billing information fields</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  usageOperation?: string;

  @doc("<p>The time that the usage operation was last updated.</p>")
  usageOperationUpdateTime?: utcDateTime;

  @doc("<p>The virtualization type of the instance.</p>")
  virtualizationType?: VirtualizationTypeEnumValue;

  @doc("<p>The ID of the VPC in which the instance is running.</p>")
  vpcId?: string;
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

@doc("InstanceBootModeValues enum")
union InstanceBootModeValues {
  @doc("InstanceBootModeValues enum legacy-bios")
  LegacyBios: "legacy-bios",

  @doc("InstanceBootModeValues enum uefi")
  Uefi: "uefi",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceBootModeValuesEnumValue")
model InstanceBootModeValuesEnumValue {
  @doc("Property value")
  value?: InstanceBootModeValues;
}

@doc("InstanceLifecycleType enum")
union InstanceLifecycleType {
  @doc("InstanceLifecycleType enum capacity-block")
  CapacityBlock: "capacity-block",

  @doc("InstanceLifecycleType enum scheduled")
  Scheduled: "scheduled",

  @doc("InstanceLifecycleType enum spot")
  Spot: "spot",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceLifecycleTypeEnumValue")
model InstanceLifecycleTypeEnumValue {
  @doc("Property value")
  value?: InstanceLifecycleType;
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
@doc("Definition of InstanceBlockDeviceMapping")
model InstanceBlockDeviceMapping {
  @doc("<p>The device name (for example, <code>/dev/sdh</code> or <code>xvdh</code>).</p>")
  deviceName?: string;

  @doc("<p>Parameters used to automatically set up EBS volumes when the instance is launched.</p>")
  ebs?: EbsInstanceBlockDevice;
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

@doc("InstanceType enum")
union InstanceType {
  @doc("InstanceType enum a1.2xlarge")
  A12xlarge: "a1.2xlarge",

  @doc("InstanceType enum a1.4xlarge")
  A14xlarge: "a1.4xlarge",

  @doc("InstanceType enum a1.large")
  A1Large: "a1.large",

  @doc("InstanceType enum a1.medium")
  A1Medium: "a1.medium",

  @doc("InstanceType enum a1.metal")
  A1Metal: "a1.metal",

  @doc("InstanceType enum a1.xlarge")
  A1Xlarge: "a1.xlarge",

  @doc("InstanceType enum c1.medium")
  C1Medium: "c1.medium",

  @doc("InstanceType enum c1.xlarge")
  C1Xlarge: "c1.xlarge",

  @doc("InstanceType enum c3.2xlarge")
  C32xlarge: "c3.2xlarge",

  @doc("InstanceType enum c3.4xlarge")
  C34xlarge: "c3.4xlarge",

  @doc("InstanceType enum c3.8xlarge")
  C38xlarge: "c3.8xlarge",

  @doc("InstanceType enum c3.large")
  C3Large: "c3.large",

  @doc("InstanceType enum c3.xlarge")
  C3Xlarge: "c3.xlarge",

  @doc("InstanceType enum c4.2xlarge")
  C42xlarge: "c4.2xlarge",

  @doc("InstanceType enum c4.4xlarge")
  C44xlarge: "c4.4xlarge",

  @doc("InstanceType enum c4.8xlarge")
  C48xlarge: "c4.8xlarge",

  @doc("InstanceType enum c4.large")
  C4Large: "c4.large",

  @doc("InstanceType enum c4.xlarge")
  C4Xlarge: "c4.xlarge",

  @doc("InstanceType enum c5.12xlarge")
  C512xlarge: "c5.12xlarge",

  @doc("InstanceType enum c5.18xlarge")
  C518xlarge: "c5.18xlarge",

  @doc("InstanceType enum c5.24xlarge")
  C524xlarge: "c5.24xlarge",

  @doc("InstanceType enum c5.2xlarge")
  C52xlarge: "c5.2xlarge",

  @doc("InstanceType enum c5.4xlarge")
  C54xlarge: "c5.4xlarge",

  @doc("InstanceType enum c5.9xlarge")
  C59xlarge: "c5.9xlarge",

  @doc("InstanceType enum c5.large")
  C5Large: "c5.large",

  @doc("InstanceType enum c5.metal")
  C5Metal: "c5.metal",

  @doc("InstanceType enum c5.xlarge")
  C5Xlarge: "c5.xlarge",

  @doc("InstanceType enum c5a.12xlarge")
  C5a12xlarge: "c5a.12xlarge",

  @doc("InstanceType enum c5a.16xlarge")
  C5a16xlarge: "c5a.16xlarge",

  @doc("InstanceType enum c5a.24xlarge")
  C5a24xlarge: "c5a.24xlarge",

  @doc("InstanceType enum c5a.2xlarge")
  C5a2xlarge: "c5a.2xlarge",

  @doc("InstanceType enum c5a.4xlarge")
  C5a4xlarge: "c5a.4xlarge",

  @doc("InstanceType enum c5a.8xlarge")
  C5a8xlarge: "c5a.8xlarge",

  @doc("InstanceType enum c5a.large")
  C5aLarge: "c5a.large",

  @doc("InstanceType enum c5a.xlarge")
  C5aXlarge: "c5a.xlarge",

  @doc("InstanceType enum c5ad.12xlarge")
  C5ad12xlarge: "c5ad.12xlarge",

  @doc("InstanceType enum c5ad.16xlarge")
  C5ad16xlarge: "c5ad.16xlarge",

  @doc("InstanceType enum c5ad.24xlarge")
  C5ad24xlarge: "c5ad.24xlarge",

  @doc("InstanceType enum c5ad.2xlarge")
  C5ad2xlarge: "c5ad.2xlarge",

  @doc("InstanceType enum c5ad.4xlarge")
  C5ad4xlarge: "c5ad.4xlarge",

  @doc("InstanceType enum c5ad.8xlarge")
  C5ad8xlarge: "c5ad.8xlarge",

  @doc("InstanceType enum c5ad.large")
  C5adLarge: "c5ad.large",

  @doc("InstanceType enum c5ad.xlarge")
  C5adXlarge: "c5ad.xlarge",

  @doc("InstanceType enum c5d.12xlarge")
  C5d12xlarge: "c5d.12xlarge",

  @doc("InstanceType enum c5d.18xlarge")
  C5d18xlarge: "c5d.18xlarge",

  @doc("InstanceType enum c5d.24xlarge")
  C5d24xlarge: "c5d.24xlarge",

  @doc("InstanceType enum c5d.2xlarge")
  C5d2xlarge: "c5d.2xlarge",

  @doc("InstanceType enum c5d.4xlarge")
  C5d4xlarge: "c5d.4xlarge",

  @doc("InstanceType enum c5d.9xlarge")
  C5d9xlarge: "c5d.9xlarge",

  @doc("InstanceType enum c5d.large")
  C5dLarge: "c5d.large",

  @doc("InstanceType enum c5d.metal")
  C5dMetal: "c5d.metal",

  @doc("InstanceType enum c5d.xlarge")
  C5dXlarge: "c5d.xlarge",

  @doc("InstanceType enum c5n.18xlarge")
  C5n18xlarge: "c5n.18xlarge",

  @doc("InstanceType enum c5n.2xlarge")
  C5n2xlarge: "c5n.2xlarge",

  @doc("InstanceType enum c5n.4xlarge")
  C5n4xlarge: "c5n.4xlarge",

  @doc("InstanceType enum c5n.9xlarge")
  C5n9xlarge: "c5n.9xlarge",

  @doc("InstanceType enum c5n.large")
  C5nLarge: "c5n.large",

  @doc("InstanceType enum c5n.metal")
  C5nMetal: "c5n.metal",

  @doc("InstanceType enum c5n.xlarge")
  C5nXlarge: "c5n.xlarge",

  @doc("InstanceType enum c6a.12xlarge")
  C6a12xlarge: "c6a.12xlarge",

  @doc("InstanceType enum c6a.16xlarge")
  C6a16xlarge: "c6a.16xlarge",

  @doc("InstanceType enum c6a.24xlarge")
  C6a24xlarge: "c6a.24xlarge",

  @doc("InstanceType enum c6a.2xlarge")
  C6a2xlarge: "c6a.2xlarge",

  @doc("InstanceType enum c6a.32xlarge")
  C6a32xlarge: "c6a.32xlarge",

  @doc("InstanceType enum c6a.48xlarge")
  C6a48xlarge: "c6a.48xlarge",

  @doc("InstanceType enum c6a.4xlarge")
  C6a4xlarge: "c6a.4xlarge",

  @doc("InstanceType enum c6a.8xlarge")
  C6a8xlarge: "c6a.8xlarge",

  @doc("InstanceType enum c6a.large")
  C6aLarge: "c6a.large",

  @doc("InstanceType enum c6a.metal")
  C6aMetal: "c6a.metal",

  @doc("InstanceType enum c6a.xlarge")
  C6aXlarge: "c6a.xlarge",

  @doc("InstanceType enum c6g.12xlarge")
  C6g12xlarge: "c6g.12xlarge",

  @doc("InstanceType enum c6g.16xlarge")
  C6g16xlarge: "c6g.16xlarge",

  @doc("InstanceType enum c6g.2xlarge")
  C6g2xlarge: "c6g.2xlarge",

  @doc("InstanceType enum c6g.4xlarge")
  C6g4xlarge: "c6g.4xlarge",

  @doc("InstanceType enum c6g.8xlarge")
  C6g8xlarge: "c6g.8xlarge",

  @doc("InstanceType enum c6g.large")
  C6gLarge: "c6g.large",

  @doc("InstanceType enum c6g.medium")
  C6gMedium: "c6g.medium",

  @doc("InstanceType enum c6g.metal")
  C6gMetal: "c6g.metal",

  @doc("InstanceType enum c6g.xlarge")
  C6gXlarge: "c6g.xlarge",

  @doc("InstanceType enum c6gd.12xlarge")
  C6gd12xlarge: "c6gd.12xlarge",

  @doc("InstanceType enum c6gd.16xlarge")
  C6gd16xlarge: "c6gd.16xlarge",

  @doc("InstanceType enum c6gd.2xlarge")
  C6gd2xlarge: "c6gd.2xlarge",

  @doc("InstanceType enum c6gd.4xlarge")
  C6gd4xlarge: "c6gd.4xlarge",

  @doc("InstanceType enum c6gd.8xlarge")
  C6gd8xlarge: "c6gd.8xlarge",

  @doc("InstanceType enum c6gd.large")
  C6gdLarge: "c6gd.large",

  @doc("InstanceType enum c6gd.medium")
  C6gdMedium: "c6gd.medium",

  @doc("InstanceType enum c6gd.metal")
  C6gdMetal: "c6gd.metal",

  @doc("InstanceType enum c6gd.xlarge")
  C6gdXlarge: "c6gd.xlarge",

  @doc("InstanceType enum c6gn.12xlarge")
  C6gn12xlarge: "c6gn.12xlarge",

  @doc("InstanceType enum c6gn.16xlarge")
  C6gn16xlarge: "c6gn.16xlarge",

  @doc("InstanceType enum c6gn.2xlarge")
  C6gn2xlarge: "c6gn.2xlarge",

  @doc("InstanceType enum c6gn.4xlarge")
  C6gn4xlarge: "c6gn.4xlarge",

  @doc("InstanceType enum c6gn.8xlarge")
  C6gn8xlarge: "c6gn.8xlarge",

  @doc("InstanceType enum c6gn.large")
  C6gnLarge: "c6gn.large",

  @doc("InstanceType enum c6gn.medium")
  C6gnMedium: "c6gn.medium",

  @doc("InstanceType enum c6gn.xlarge")
  C6gnXlarge: "c6gn.xlarge",

  @doc("InstanceType enum c6i.12xlarge")
  C6i12xlarge: "c6i.12xlarge",

  @doc("InstanceType enum c6i.16xlarge")
  C6i16xlarge: "c6i.16xlarge",

  @doc("InstanceType enum c6i.24xlarge")
  C6i24xlarge: "c6i.24xlarge",

  @doc("InstanceType enum c6i.2xlarge")
  C6i2xlarge: "c6i.2xlarge",

  @doc("InstanceType enum c6i.32xlarge")
  C6i32xlarge: "c6i.32xlarge",

  @doc("InstanceType enum c6i.4xlarge")
  C6i4xlarge: "c6i.4xlarge",

  @doc("InstanceType enum c6i.8xlarge")
  C6i8xlarge: "c6i.8xlarge",

  @doc("InstanceType enum c6i.large")
  C6iLarge: "c6i.large",

  @doc("InstanceType enum c6i.metal")
  C6iMetal: "c6i.metal",

  @doc("InstanceType enum c6i.xlarge")
  C6iXlarge: "c6i.xlarge",

  @doc("InstanceType enum c6id.12xlarge")
  C6id12xlarge: "c6id.12xlarge",

  @doc("InstanceType enum c6id.16xlarge")
  C6id16xlarge: "c6id.16xlarge",

  @doc("InstanceType enum c6id.24xlarge")
  C6id24xlarge: "c6id.24xlarge",

  @doc("InstanceType enum c6id.2xlarge")
  C6id2xlarge: "c6id.2xlarge",

  @doc("InstanceType enum c6id.32xlarge")
  C6id32xlarge: "c6id.32xlarge",

  @doc("InstanceType enum c6id.4xlarge")
  C6id4xlarge: "c6id.4xlarge",

  @doc("InstanceType enum c6id.8xlarge")
  C6id8xlarge: "c6id.8xlarge",

  @doc("InstanceType enum c6id.large")
  C6idLarge: "c6id.large",

  @doc("InstanceType enum c6id.metal")
  C6idMetal: "c6id.metal",

  @doc("InstanceType enum c6id.xlarge")
  C6idXlarge: "c6id.xlarge",

  @doc("InstanceType enum c6in.12xlarge")
  C6in12xlarge: "c6in.12xlarge",

  @doc("InstanceType enum c6in.16xlarge")
  C6in16xlarge: "c6in.16xlarge",

  @doc("InstanceType enum c6in.24xlarge")
  C6in24xlarge: "c6in.24xlarge",

  @doc("InstanceType enum c6in.2xlarge")
  C6in2xlarge: "c6in.2xlarge",

  @doc("InstanceType enum c6in.32xlarge")
  C6in32xlarge: "c6in.32xlarge",

  @doc("InstanceType enum c6in.4xlarge")
  C6in4xlarge: "c6in.4xlarge",

  @doc("InstanceType enum c6in.8xlarge")
  C6in8xlarge: "c6in.8xlarge",

  @doc("InstanceType enum c6in.large")
  C6inLarge: "c6in.large",

  @doc("InstanceType enum c6in.metal")
  C6inMetal: "c6in.metal",

  @doc("InstanceType enum c6in.xlarge")
  C6inXlarge: "c6in.xlarge",

  @doc("InstanceType enum c7a.12xlarge")
  C7a12xlarge: "c7a.12xlarge",

  @doc("InstanceType enum c7a.16xlarge")
  C7a16xlarge: "c7a.16xlarge",

  @doc("InstanceType enum c7a.24xlarge")
  C7a24xlarge: "c7a.24xlarge",

  @doc("InstanceType enum c7a.2xlarge")
  C7a2xlarge: "c7a.2xlarge",

  @doc("InstanceType enum c7a.32xlarge")
  C7a32xlarge: "c7a.32xlarge",

  @doc("InstanceType enum c7a.48xlarge")
  C7a48xlarge: "c7a.48xlarge",

  @doc("InstanceType enum c7a.4xlarge")
  C7a4xlarge: "c7a.4xlarge",

  @doc("InstanceType enum c7a.8xlarge")
  C7a8xlarge: "c7a.8xlarge",

  @doc("InstanceType enum c7a.large")
  C7aLarge: "c7a.large",

  @doc("InstanceType enum c7a.medium")
  C7aMedium: "c7a.medium",

  @doc("InstanceType enum c7a.metal-48xl")
  C7aMetal48xl: "c7a.metal-48xl",

  @doc("InstanceType enum c7a.xlarge")
  C7aXlarge: "c7a.xlarge",

  @doc("InstanceType enum c7g.12xlarge")
  C7g12xlarge: "c7g.12xlarge",

  @doc("InstanceType enum c7g.16xlarge")
  C7g16xlarge: "c7g.16xlarge",

  @doc("InstanceType enum c7g.2xlarge")
  C7g2xlarge: "c7g.2xlarge",

  @doc("InstanceType enum c7g.4xlarge")
  C7g4xlarge: "c7g.4xlarge",

  @doc("InstanceType enum c7g.8xlarge")
  C7g8xlarge: "c7g.8xlarge",

  @doc("InstanceType enum c7g.large")
  C7gLarge: "c7g.large",

  @doc("InstanceType enum c7g.medium")
  C7gMedium: "c7g.medium",

  @doc("InstanceType enum c7g.metal")
  C7gMetal: "c7g.metal",

  @doc("InstanceType enum c7g.xlarge")
  C7gXlarge: "c7g.xlarge",

  @doc("InstanceType enum c7gd.12xlarge")
  C7gd12xlarge: "c7gd.12xlarge",

  @doc("InstanceType enum c7gd.16xlarge")
  C7gd16xlarge: "c7gd.16xlarge",

  @doc("InstanceType enum c7gd.2xlarge")
  C7gd2xlarge: "c7gd.2xlarge",

  @doc("InstanceType enum c7gd.4xlarge")
  C7gd4xlarge: "c7gd.4xlarge",

  @doc("InstanceType enum c7gd.8xlarge")
  C7gd8xlarge: "c7gd.8xlarge",

  @doc("InstanceType enum c7gd.large")
  C7gdLarge: "c7gd.large",

  @doc("InstanceType enum c7gd.medium")
  C7gdMedium: "c7gd.medium",

  @doc("InstanceType enum c7gd.metal")
  C7gdMetal: "c7gd.metal",

  @doc("InstanceType enum c7gd.xlarge")
  C7gdXlarge: "c7gd.xlarge",

  @doc("InstanceType enum c7gn.12xlarge")
  C7gn12xlarge: "c7gn.12xlarge",

  @doc("InstanceType enum c7gn.16xlarge")
  C7gn16xlarge: "c7gn.16xlarge",

  @doc("InstanceType enum c7gn.2xlarge")
  C7gn2xlarge: "c7gn.2xlarge",

  @doc("InstanceType enum c7gn.4xlarge")
  C7gn4xlarge: "c7gn.4xlarge",

  @doc("InstanceType enum c7gn.8xlarge")
  C7gn8xlarge: "c7gn.8xlarge",

  @doc("InstanceType enum c7gn.large")
  C7gnLarge: "c7gn.large",

  @doc("InstanceType enum c7gn.medium")
  C7gnMedium: "c7gn.medium",

  @doc("InstanceType enum c7gn.xlarge")
  C7gnXlarge: "c7gn.xlarge",

  @doc("InstanceType enum c7i.12xlarge")
  C7i12xlarge: "c7i.12xlarge",

  @doc("InstanceType enum c7i.16xlarge")
  C7i16xlarge: "c7i.16xlarge",

  @doc("InstanceType enum c7i.24xlarge")
  C7i24xlarge: "c7i.24xlarge",

  @doc("InstanceType enum c7i.2xlarge")
  C7i2xlarge: "c7i.2xlarge",

  @doc("InstanceType enum c7i.48xlarge")
  C7i48xlarge: "c7i.48xlarge",

  @doc("InstanceType enum c7i.4xlarge")
  C7i4xlarge: "c7i.4xlarge",

  @doc("InstanceType enum c7i.8xlarge")
  C7i8xlarge: "c7i.8xlarge",

  @doc("InstanceType enum c7i.large")
  C7iLarge: "c7i.large",

  @doc("InstanceType enum c7i.metal-24xl")
  C7iMetal24xl: "c7i.metal-24xl",

  @doc("InstanceType enum c7i.metal-48xl")
  C7iMetal48xl: "c7i.metal-48xl",

  @doc("InstanceType enum c7i.xlarge")
  C7iXlarge: "c7i.xlarge",

  @doc("InstanceType enum cc1.4xlarge")
  Cc14xlarge: "cc1.4xlarge",

  @doc("InstanceType enum cc2.8xlarge")
  Cc28xlarge: "cc2.8xlarge",

  @doc("InstanceType enum cg1.4xlarge")
  Cg14xlarge: "cg1.4xlarge",

  @doc("InstanceType enum cr1.8xlarge")
  Cr18xlarge: "cr1.8xlarge",

  @doc("InstanceType enum d2.2xlarge")
  D22xlarge: "d2.2xlarge",

  @doc("InstanceType enum d2.4xlarge")
  D24xlarge: "d2.4xlarge",

  @doc("InstanceType enum d2.8xlarge")
  D28xlarge: "d2.8xlarge",

  @doc("InstanceType enum d2.xlarge")
  D2Xlarge: "d2.xlarge",

  @doc("InstanceType enum d3.2xlarge")
  D32xlarge: "d3.2xlarge",

  @doc("InstanceType enum d3.4xlarge")
  D34xlarge: "d3.4xlarge",

  @doc("InstanceType enum d3.8xlarge")
  D38xlarge: "d3.8xlarge",

  @doc("InstanceType enum d3.xlarge")
  D3Xlarge: "d3.xlarge",

  @doc("InstanceType enum d3en.12xlarge")
  D3en12xlarge: "d3en.12xlarge",

  @doc("InstanceType enum d3en.2xlarge")
  D3en2xlarge: "d3en.2xlarge",

  @doc("InstanceType enum d3en.4xlarge")
  D3en4xlarge: "d3en.4xlarge",

  @doc("InstanceType enum d3en.6xlarge")
  D3en6xlarge: "d3en.6xlarge",

  @doc("InstanceType enum d3en.8xlarge")
  D3en8xlarge: "d3en.8xlarge",

  @doc("InstanceType enum d3en.xlarge")
  D3enXlarge: "d3en.xlarge",

  @doc("InstanceType enum dl1.24xlarge")
  Dl124xlarge: "dl1.24xlarge",

  @doc("InstanceType enum dl2q.24xlarge")
  Dl2q24xlarge: "dl2q.24xlarge",

  @doc("InstanceType enum f1.16xlarge")
  F116xlarge: "f1.16xlarge",

  @doc("InstanceType enum f1.2xlarge")
  F12xlarge: "f1.2xlarge",

  @doc("InstanceType enum f1.4xlarge")
  F14xlarge: "f1.4xlarge",

  @doc("InstanceType enum g2.2xlarge")
  G22xlarge: "g2.2xlarge",

  @doc("InstanceType enum g2.8xlarge")
  G28xlarge: "g2.8xlarge",

  @doc("InstanceType enum g3.16xlarge")
  G316xlarge: "g3.16xlarge",

  @doc("InstanceType enum g3.4xlarge")
  G34xlarge: "g3.4xlarge",

  @doc("InstanceType enum g3.8xlarge")
  G38xlarge: "g3.8xlarge",

  @doc("InstanceType enum g3s.xlarge")
  G3sXlarge: "g3s.xlarge",

  @doc("InstanceType enum g4ad.16xlarge")
  G4ad16xlarge: "g4ad.16xlarge",

  @doc("InstanceType enum g4ad.2xlarge")
  G4ad2xlarge: "g4ad.2xlarge",

  @doc("InstanceType enum g4ad.4xlarge")
  G4ad4xlarge: "g4ad.4xlarge",

  @doc("InstanceType enum g4ad.8xlarge")
  G4ad8xlarge: "g4ad.8xlarge",

  @doc("InstanceType enum g4ad.xlarge")
  G4adXlarge: "g4ad.xlarge",

  @doc("InstanceType enum g4dn.12xlarge")
  G4dn12xlarge: "g4dn.12xlarge",

  @doc("InstanceType enum g4dn.16xlarge")
  G4dn16xlarge: "g4dn.16xlarge",

  @doc("InstanceType enum g4dn.2xlarge")
  G4dn2xlarge: "g4dn.2xlarge",

  @doc("InstanceType enum g4dn.4xlarge")
  G4dn4xlarge: "g4dn.4xlarge",

  @doc("InstanceType enum g4dn.8xlarge")
  G4dn8xlarge: "g4dn.8xlarge",

  @doc("InstanceType enum g4dn.metal")
  G4dnMetal: "g4dn.metal",

  @doc("InstanceType enum g4dn.xlarge")
  G4dnXlarge: "g4dn.xlarge",

  @doc("InstanceType enum g5.12xlarge")
  G512xlarge: "g5.12xlarge",

  @doc("InstanceType enum g5.16xlarge")
  G516xlarge: "g5.16xlarge",

  @doc("InstanceType enum g5.24xlarge")
  G524xlarge: "g5.24xlarge",

  @doc("InstanceType enum g5.2xlarge")
  G52xlarge: "g5.2xlarge",

  @doc("InstanceType enum g5.48xlarge")
  G548xlarge: "g5.48xlarge",

  @doc("InstanceType enum g5.4xlarge")
  G54xlarge: "g5.4xlarge",

  @doc("InstanceType enum g5.8xlarge")
  G58xlarge: "g5.8xlarge",

  @doc("InstanceType enum g5.xlarge")
  G5Xlarge: "g5.xlarge",

  @doc("InstanceType enum g5g.16xlarge")
  G5g16xlarge: "g5g.16xlarge",

  @doc("InstanceType enum g5g.2xlarge")
  G5g2xlarge: "g5g.2xlarge",

  @doc("InstanceType enum g5g.4xlarge")
  G5g4xlarge: "g5g.4xlarge",

  @doc("InstanceType enum g5g.8xlarge")
  G5g8xlarge: "g5g.8xlarge",

  @doc("InstanceType enum g5g.metal")
  G5gMetal: "g5g.metal",

  @doc("InstanceType enum g5g.xlarge")
  G5gXlarge: "g5g.xlarge",

  @doc("InstanceType enum g6.12xlarge")
  G612xlarge: "g6.12xlarge",

  @doc("InstanceType enum g6.16xlarge")
  G616xlarge: "g6.16xlarge",

  @doc("InstanceType enum g6.24xlarge")
  G624xlarge: "g6.24xlarge",

  @doc("InstanceType enum g6.2xlarge")
  G62xlarge: "g6.2xlarge",

  @doc("InstanceType enum g6.48xlarge")
  G648xlarge: "g6.48xlarge",

  @doc("InstanceType enum g6.4xlarge")
  G64xlarge: "g6.4xlarge",

  @doc("InstanceType enum g6.8xlarge")
  G68xlarge: "g6.8xlarge",

  @doc("InstanceType enum g6.xlarge")
  G6Xlarge: "g6.xlarge",

  @doc("InstanceType enum gr6.4xlarge")
  Gr64xlarge: "gr6.4xlarge",

  @doc("InstanceType enum gr6.8xlarge")
  Gr68xlarge: "gr6.8xlarge",

  @doc("InstanceType enum h1.16xlarge")
  H116xlarge: "h1.16xlarge",

  @doc("InstanceType enum h1.2xlarge")
  H12xlarge: "h1.2xlarge",

  @doc("InstanceType enum h1.4xlarge")
  H14xlarge: "h1.4xlarge",

  @doc("InstanceType enum h1.8xlarge")
  H18xlarge: "h1.8xlarge",

  @doc("InstanceType enum hi1.4xlarge")
  Hi14xlarge: "hi1.4xlarge",

  @doc("InstanceType enum hpc6a.48xlarge")
  Hpc6a48xlarge: "hpc6a.48xlarge",

  @doc("InstanceType enum hpc6id.32xlarge")
  Hpc6id32xlarge: "hpc6id.32xlarge",

  @doc("InstanceType enum hpc7a.12xlarge")
  Hpc7a12xlarge: "hpc7a.12xlarge",

  @doc("InstanceType enum hpc7a.24xlarge")
  Hpc7a24xlarge: "hpc7a.24xlarge",

  @doc("InstanceType enum hpc7a.48xlarge")
  Hpc7a48xlarge: "hpc7a.48xlarge",

  @doc("InstanceType enum hpc7a.96xlarge")
  Hpc7a96xlarge: "hpc7a.96xlarge",

  @doc("InstanceType enum hpc7g.16xlarge")
  Hpc7g16xlarge: "hpc7g.16xlarge",

  @doc("InstanceType enum hpc7g.4xlarge")
  Hpc7g4xlarge: "hpc7g.4xlarge",

  @doc("InstanceType enum hpc7g.8xlarge")
  Hpc7g8xlarge: "hpc7g.8xlarge",

  @doc("InstanceType enum hs1.8xlarge")
  Hs18xlarge: "hs1.8xlarge",

  @doc("InstanceType enum i2.2xlarge")
  I22xlarge: "i2.2xlarge",

  @doc("InstanceType enum i2.4xlarge")
  I24xlarge: "i2.4xlarge",

  @doc("InstanceType enum i2.8xlarge")
  I28xlarge: "i2.8xlarge",

  @doc("InstanceType enum i2.xlarge")
  I2Xlarge: "i2.xlarge",

  @doc("InstanceType enum i3.16xlarge")
  I316xlarge: "i3.16xlarge",

  @doc("InstanceType enum i3.2xlarge")
  I32xlarge: "i3.2xlarge",

  @doc("InstanceType enum i3.4xlarge")
  I34xlarge: "i3.4xlarge",

  @doc("InstanceType enum i3.8xlarge")
  I38xlarge: "i3.8xlarge",

  @doc("InstanceType enum i3.large")
  I3Large: "i3.large",

  @doc("InstanceType enum i3.metal")
  I3Metal: "i3.metal",

  @doc("InstanceType enum i3.xlarge")
  I3Xlarge: "i3.xlarge",

  @doc("InstanceType enum i3en.12xlarge")
  I3en12xlarge: "i3en.12xlarge",

  @doc("InstanceType enum i3en.24xlarge")
  I3en24xlarge: "i3en.24xlarge",

  @doc("InstanceType enum i3en.2xlarge")
  I3en2xlarge: "i3en.2xlarge",

  @doc("InstanceType enum i3en.3xlarge")
  I3en3xlarge: "i3en.3xlarge",

  @doc("InstanceType enum i3en.6xlarge")
  I3en6xlarge: "i3en.6xlarge",

  @doc("InstanceType enum i3en.large")
  I3enLarge: "i3en.large",

  @doc("InstanceType enum i3en.metal")
  I3enMetal: "i3en.metal",

  @doc("InstanceType enum i3en.xlarge")
  I3enXlarge: "i3en.xlarge",

  @doc("InstanceType enum i4g.16xlarge")
  I4g16xlarge: "i4g.16xlarge",

  @doc("InstanceType enum i4g.2xlarge")
  I4g2xlarge: "i4g.2xlarge",

  @doc("InstanceType enum i4g.4xlarge")
  I4g4xlarge: "i4g.4xlarge",

  @doc("InstanceType enum i4g.8xlarge")
  I4g8xlarge: "i4g.8xlarge",

  @doc("InstanceType enum i4g.large")
  I4gLarge: "i4g.large",

  @doc("InstanceType enum i4g.xlarge")
  I4gXlarge: "i4g.xlarge",

  @doc("InstanceType enum i4i.12xlarge")
  I4i12xlarge: "i4i.12xlarge",

  @doc("InstanceType enum i4i.16xlarge")
  I4i16xlarge: "i4i.16xlarge",

  @doc("InstanceType enum i4i.24xlarge")
  I4i24xlarge: "i4i.24xlarge",

  @doc("InstanceType enum i4i.2xlarge")
  I4i2xlarge: "i4i.2xlarge",

  @doc("InstanceType enum i4i.32xlarge")
  I4i32xlarge: "i4i.32xlarge",

  @doc("InstanceType enum i4i.4xlarge")
  I4i4xlarge: "i4i.4xlarge",

  @doc("InstanceType enum i4i.8xlarge")
  I4i8xlarge: "i4i.8xlarge",

  @doc("InstanceType enum i4i.large")
  I4iLarge: "i4i.large",

  @doc("InstanceType enum i4i.metal")
  I4iMetal: "i4i.metal",

  @doc("InstanceType enum i4i.xlarge")
  I4iXlarge: "i4i.xlarge",

  @doc("InstanceType enum im4gn.16xlarge")
  Im4gn16xlarge: "im4gn.16xlarge",

  @doc("InstanceType enum im4gn.2xlarge")
  Im4gn2xlarge: "im4gn.2xlarge",

  @doc("InstanceType enum im4gn.4xlarge")
  Im4gn4xlarge: "im4gn.4xlarge",

  @doc("InstanceType enum im4gn.8xlarge")
  Im4gn8xlarge: "im4gn.8xlarge",

  @doc("InstanceType enum im4gn.large")
  Im4gnLarge: "im4gn.large",

  @doc("InstanceType enum im4gn.xlarge")
  Im4gnXlarge: "im4gn.xlarge",

  @doc("InstanceType enum inf1.24xlarge")
  Inf124xlarge: "inf1.24xlarge",

  @doc("InstanceType enum inf1.2xlarge")
  Inf12xlarge: "inf1.2xlarge",

  @doc("InstanceType enum inf1.6xlarge")
  Inf16xlarge: "inf1.6xlarge",

  @doc("InstanceType enum inf1.xlarge")
  Inf1Xlarge: "inf1.xlarge",

  @doc("InstanceType enum inf2.24xlarge")
  Inf224xlarge: "inf2.24xlarge",

  @doc("InstanceType enum inf2.48xlarge")
  Inf248xlarge: "inf2.48xlarge",

  @doc("InstanceType enum inf2.8xlarge")
  Inf28xlarge: "inf2.8xlarge",

  @doc("InstanceType enum inf2.xlarge")
  Inf2Xlarge: "inf2.xlarge",

  @doc("InstanceType enum is4gen.2xlarge")
  Is4gen2xlarge: "is4gen.2xlarge",

  @doc("InstanceType enum is4gen.4xlarge")
  Is4gen4xlarge: "is4gen.4xlarge",

  @doc("InstanceType enum is4gen.8xlarge")
  Is4gen8xlarge: "is4gen.8xlarge",

  @doc("InstanceType enum is4gen.large")
  Is4genLarge: "is4gen.large",

  @doc("InstanceType enum is4gen.medium")
  Is4genMedium: "is4gen.medium",

  @doc("InstanceType enum is4gen.xlarge")
  Is4genXlarge: "is4gen.xlarge",

  @doc("InstanceType enum m1.large")
  M1Large: "m1.large",

  @doc("InstanceType enum m1.medium")
  M1Medium: "m1.medium",

  @doc("InstanceType enum m1.small")
  M1Small: "m1.small",

  @doc("InstanceType enum m1.xlarge")
  M1Xlarge: "m1.xlarge",

  @doc("InstanceType enum m2.2xlarge")
  M22xlarge: "m2.2xlarge",

  @doc("InstanceType enum m2.4xlarge")
  M24xlarge: "m2.4xlarge",

  @doc("InstanceType enum m2.xlarge")
  M2Xlarge: "m2.xlarge",

  @doc("InstanceType enum m3.2xlarge")
  M32xlarge: "m3.2xlarge",

  @doc("InstanceType enum m3.large")
  M3Large: "m3.large",

  @doc("InstanceType enum m3.medium")
  M3Medium: "m3.medium",

  @doc("InstanceType enum m3.xlarge")
  M3Xlarge: "m3.xlarge",

  @doc("InstanceType enum m4.10xlarge")
  M410xlarge: "m4.10xlarge",

  @doc("InstanceType enum m4.16xlarge")
  M416xlarge: "m4.16xlarge",

  @doc("InstanceType enum m4.2xlarge")
  M42xlarge: "m4.2xlarge",

  @doc("InstanceType enum m4.4xlarge")
  M44xlarge: "m4.4xlarge",

  @doc("InstanceType enum m4.large")
  M4Large: "m4.large",

  @doc("InstanceType enum m4.xlarge")
  M4Xlarge: "m4.xlarge",

  @doc("InstanceType enum m5.12xlarge")
  M512xlarge: "m5.12xlarge",

  @doc("InstanceType enum m5.16xlarge")
  M516xlarge: "m5.16xlarge",

  @doc("InstanceType enum m5.24xlarge")
  M524xlarge: "m5.24xlarge",

  @doc("InstanceType enum m5.2xlarge")
  M52xlarge: "m5.2xlarge",

  @doc("InstanceType enum m5.4xlarge")
  M54xlarge: "m5.4xlarge",

  @doc("InstanceType enum m5.8xlarge")
  M58xlarge: "m5.8xlarge",

  @doc("InstanceType enum m5.large")
  M5Large: "m5.large",

  @doc("InstanceType enum m5.metal")
  M5Metal: "m5.metal",

  @doc("InstanceType enum m5.xlarge")
  M5Xlarge: "m5.xlarge",

  @doc("InstanceType enum m5a.12xlarge")
  M5a12xlarge: "m5a.12xlarge",

  @doc("InstanceType enum m5a.16xlarge")
  M5a16xlarge: "m5a.16xlarge",

  @doc("InstanceType enum m5a.24xlarge")
  M5a24xlarge: "m5a.24xlarge",

  @doc("InstanceType enum m5a.2xlarge")
  M5a2xlarge: "m5a.2xlarge",

  @doc("InstanceType enum m5a.4xlarge")
  M5a4xlarge: "m5a.4xlarge",

  @doc("InstanceType enum m5a.8xlarge")
  M5a8xlarge: "m5a.8xlarge",

  @doc("InstanceType enum m5a.large")
  M5aLarge: "m5a.large",

  @doc("InstanceType enum m5a.xlarge")
  M5aXlarge: "m5a.xlarge",

  @doc("InstanceType enum m5ad.12xlarge")
  M5ad12xlarge: "m5ad.12xlarge",

  @doc("InstanceType enum m5ad.16xlarge")
  M5ad16xlarge: "m5ad.16xlarge",

  @doc("InstanceType enum m5ad.24xlarge")
  M5ad24xlarge: "m5ad.24xlarge",

  @doc("InstanceType enum m5ad.2xlarge")
  M5ad2xlarge: "m5ad.2xlarge",

  @doc("InstanceType enum m5ad.4xlarge")
  M5ad4xlarge: "m5ad.4xlarge",

  @doc("InstanceType enum m5ad.8xlarge")
  M5ad8xlarge: "m5ad.8xlarge",

  @doc("InstanceType enum m5ad.large")
  M5adLarge: "m5ad.large",

  @doc("InstanceType enum m5ad.xlarge")
  M5adXlarge: "m5ad.xlarge",

  @doc("InstanceType enum m5d.12xlarge")
  M5d12xlarge: "m5d.12xlarge",

  @doc("InstanceType enum m5d.16xlarge")
  M5d16xlarge: "m5d.16xlarge",

  @doc("InstanceType enum m5d.24xlarge")
  M5d24xlarge: "m5d.24xlarge",

  @doc("InstanceType enum m5d.2xlarge")
  M5d2xlarge: "m5d.2xlarge",

  @doc("InstanceType enum m5d.4xlarge")
  M5d4xlarge: "m5d.4xlarge",

  @doc("InstanceType enum m5d.8xlarge")
  M5d8xlarge: "m5d.8xlarge",

  @doc("InstanceType enum m5d.large")
  M5dLarge: "m5d.large",

  @doc("InstanceType enum m5d.metal")
  M5dMetal: "m5d.metal",

  @doc("InstanceType enum m5d.xlarge")
  M5dXlarge: "m5d.xlarge",

  @doc("InstanceType enum m5dn.12xlarge")
  M5dn12xlarge: "m5dn.12xlarge",

  @doc("InstanceType enum m5dn.16xlarge")
  M5dn16xlarge: "m5dn.16xlarge",

  @doc("InstanceType enum m5dn.24xlarge")
  M5dn24xlarge: "m5dn.24xlarge",

  @doc("InstanceType enum m5dn.2xlarge")
  M5dn2xlarge: "m5dn.2xlarge",

  @doc("InstanceType enum m5dn.4xlarge")
  M5dn4xlarge: "m5dn.4xlarge",

  @doc("InstanceType enum m5dn.8xlarge")
  M5dn8xlarge: "m5dn.8xlarge",

  @doc("InstanceType enum m5dn.large")
  M5dnLarge: "m5dn.large",

  @doc("InstanceType enum m5dn.metal")
  M5dnMetal: "m5dn.metal",

  @doc("InstanceType enum m5dn.xlarge")
  M5dnXlarge: "m5dn.xlarge",

  @doc("InstanceType enum m5n.12xlarge")
  M5n12xlarge: "m5n.12xlarge",

  @doc("InstanceType enum m5n.16xlarge")
  M5n16xlarge: "m5n.16xlarge",

  @doc("InstanceType enum m5n.24xlarge")
  M5n24xlarge: "m5n.24xlarge",

  @doc("InstanceType enum m5n.2xlarge")
  M5n2xlarge: "m5n.2xlarge",

  @doc("InstanceType enum m5n.4xlarge")
  M5n4xlarge: "m5n.4xlarge",

  @doc("InstanceType enum m5n.8xlarge")
  M5n8xlarge: "m5n.8xlarge",

  @doc("InstanceType enum m5n.large")
  M5nLarge: "m5n.large",

  @doc("InstanceType enum m5n.metal")
  M5nMetal: "m5n.metal",

  @doc("InstanceType enum m5n.xlarge")
  M5nXlarge: "m5n.xlarge",

  @doc("InstanceType enum m5zn.12xlarge")
  M5zn12xlarge: "m5zn.12xlarge",

  @doc("InstanceType enum m5zn.2xlarge")
  M5zn2xlarge: "m5zn.2xlarge",

  @doc("InstanceType enum m5zn.3xlarge")
  M5zn3xlarge: "m5zn.3xlarge",

  @doc("InstanceType enum m5zn.6xlarge")
  M5zn6xlarge: "m5zn.6xlarge",

  @doc("InstanceType enum m5zn.large")
  M5znLarge: "m5zn.large",

  @doc("InstanceType enum m5zn.metal")
  M5znMetal: "m5zn.metal",

  @doc("InstanceType enum m5zn.xlarge")
  M5znXlarge: "m5zn.xlarge",

  @doc("InstanceType enum m6a.12xlarge")
  M6a12xlarge: "m6a.12xlarge",

  @doc("InstanceType enum m6a.16xlarge")
  M6a16xlarge: "m6a.16xlarge",

  @doc("InstanceType enum m6a.24xlarge")
  M6a24xlarge: "m6a.24xlarge",

  @doc("InstanceType enum m6a.2xlarge")
  M6a2xlarge: "m6a.2xlarge",

  @doc("InstanceType enum m6a.32xlarge")
  M6a32xlarge: "m6a.32xlarge",

  @doc("InstanceType enum m6a.48xlarge")
  M6a48xlarge: "m6a.48xlarge",

  @doc("InstanceType enum m6a.4xlarge")
  M6a4xlarge: "m6a.4xlarge",

  @doc("InstanceType enum m6a.8xlarge")
  M6a8xlarge: "m6a.8xlarge",

  @doc("InstanceType enum m6a.large")
  M6aLarge: "m6a.large",

  @doc("InstanceType enum m6a.metal")
  M6aMetal: "m6a.metal",

  @doc("InstanceType enum m6a.xlarge")
  M6aXlarge: "m6a.xlarge",

  @doc("InstanceType enum m6g.12xlarge")
  M6g12xlarge: "m6g.12xlarge",

  @doc("InstanceType enum m6g.16xlarge")
  M6g16xlarge: "m6g.16xlarge",

  @doc("InstanceType enum m6g.2xlarge")
  M6g2xlarge: "m6g.2xlarge",

  @doc("InstanceType enum m6g.4xlarge")
  M6g4xlarge: "m6g.4xlarge",

  @doc("InstanceType enum m6g.8xlarge")
  M6g8xlarge: "m6g.8xlarge",

  @doc("InstanceType enum m6g.large")
  M6gLarge: "m6g.large",

  @doc("InstanceType enum m6g.medium")
  M6gMedium: "m6g.medium",

  @doc("InstanceType enum m6g.metal")
  M6gMetal: "m6g.metal",

  @doc("InstanceType enum m6g.xlarge")
  M6gXlarge: "m6g.xlarge",

  @doc("InstanceType enum m6gd.12xlarge")
  M6gd12xlarge: "m6gd.12xlarge",

  @doc("InstanceType enum m6gd.16xlarge")
  M6gd16xlarge: "m6gd.16xlarge",

  @doc("InstanceType enum m6gd.2xlarge")
  M6gd2xlarge: "m6gd.2xlarge",

  @doc("InstanceType enum m6gd.4xlarge")
  M6gd4xlarge: "m6gd.4xlarge",

  @doc("InstanceType enum m6gd.8xlarge")
  M6gd8xlarge: "m6gd.8xlarge",

  @doc("InstanceType enum m6gd.large")
  M6gdLarge: "m6gd.large",

  @doc("InstanceType enum m6gd.medium")
  M6gdMedium: "m6gd.medium",

  @doc("InstanceType enum m6gd.metal")
  M6gdMetal: "m6gd.metal",

  @doc("InstanceType enum m6gd.xlarge")
  M6gdXlarge: "m6gd.xlarge",

  @doc("InstanceType enum m6i.12xlarge")
  M6i12xlarge: "m6i.12xlarge",

  @doc("InstanceType enum m6i.16xlarge")
  M6i16xlarge: "m6i.16xlarge",

  @doc("InstanceType enum m6i.24xlarge")
  M6i24xlarge: "m6i.24xlarge",

  @doc("InstanceType enum m6i.2xlarge")
  M6i2xlarge: "m6i.2xlarge",

  @doc("InstanceType enum m6i.32xlarge")
  M6i32xlarge: "m6i.32xlarge",

  @doc("InstanceType enum m6i.4xlarge")
  M6i4xlarge: "m6i.4xlarge",

  @doc("InstanceType enum m6i.8xlarge")
  M6i8xlarge: "m6i.8xlarge",

  @doc("InstanceType enum m6i.large")
  M6iLarge: "m6i.large",

  @doc("InstanceType enum m6i.metal")
  M6iMetal: "m6i.metal",

  @doc("InstanceType enum m6i.xlarge")
  M6iXlarge: "m6i.xlarge",

  @doc("InstanceType enum m6id.12xlarge")
  M6id12xlarge: "m6id.12xlarge",

  @doc("InstanceType enum m6id.16xlarge")
  M6id16xlarge: "m6id.16xlarge",

  @doc("InstanceType enum m6id.24xlarge")
  M6id24xlarge: "m6id.24xlarge",

  @doc("InstanceType enum m6id.2xlarge")
  M6id2xlarge: "m6id.2xlarge",

  @doc("InstanceType enum m6id.32xlarge")
  M6id32xlarge: "m6id.32xlarge",

  @doc("InstanceType enum m6id.4xlarge")
  M6id4xlarge: "m6id.4xlarge",

  @doc("InstanceType enum m6id.8xlarge")
  M6id8xlarge: "m6id.8xlarge",

  @doc("InstanceType enum m6id.large")
  M6idLarge: "m6id.large",

  @doc("InstanceType enum m6id.metal")
  M6idMetal: "m6id.metal",

  @doc("InstanceType enum m6id.xlarge")
  M6idXlarge: "m6id.xlarge",

  @doc("InstanceType enum m6idn.12xlarge")
  M6idn12xlarge: "m6idn.12xlarge",

  @doc("InstanceType enum m6idn.16xlarge")
  M6idn16xlarge: "m6idn.16xlarge",

  @doc("InstanceType enum m6idn.24xlarge")
  M6idn24xlarge: "m6idn.24xlarge",

  @doc("InstanceType enum m6idn.2xlarge")
  M6idn2xlarge: "m6idn.2xlarge",

  @doc("InstanceType enum m6idn.32xlarge")
  M6idn32xlarge: "m6idn.32xlarge",

  @doc("InstanceType enum m6idn.4xlarge")
  M6idn4xlarge: "m6idn.4xlarge",

  @doc("InstanceType enum m6idn.8xlarge")
  M6idn8xlarge: "m6idn.8xlarge",

  @doc("InstanceType enum m6idn.large")
  M6idnLarge: "m6idn.large",

  @doc("InstanceType enum m6idn.metal")
  M6idnMetal: "m6idn.metal",

  @doc("InstanceType enum m6idn.xlarge")
  M6idnXlarge: "m6idn.xlarge",

  @doc("InstanceType enum m6in.12xlarge")
  M6in12xlarge: "m6in.12xlarge",

  @doc("InstanceType enum m6in.16xlarge")
  M6in16xlarge: "m6in.16xlarge",

  @doc("InstanceType enum m6in.24xlarge")
  M6in24xlarge: "m6in.24xlarge",

  @doc("InstanceType enum m6in.2xlarge")
  M6in2xlarge: "m6in.2xlarge",

  @doc("InstanceType enum m6in.32xlarge")
  M6in32xlarge: "m6in.32xlarge",

  @doc("InstanceType enum m6in.4xlarge")
  M6in4xlarge: "m6in.4xlarge",

  @doc("InstanceType enum m6in.8xlarge")
  M6in8xlarge: "m6in.8xlarge",

  @doc("InstanceType enum m6in.large")
  M6inLarge: "m6in.large",

  @doc("InstanceType enum m6in.metal")
  M6inMetal: "m6in.metal",

  @doc("InstanceType enum m6in.xlarge")
  M6inXlarge: "m6in.xlarge",

  @doc("InstanceType enum m7a.12xlarge")
  M7a12xlarge: "m7a.12xlarge",

  @doc("InstanceType enum m7a.16xlarge")
  M7a16xlarge: "m7a.16xlarge",

  @doc("InstanceType enum m7a.24xlarge")
  M7a24xlarge: "m7a.24xlarge",

  @doc("InstanceType enum m7a.2xlarge")
  M7a2xlarge: "m7a.2xlarge",

  @doc("InstanceType enum m7a.32xlarge")
  M7a32xlarge: "m7a.32xlarge",

  @doc("InstanceType enum m7a.48xlarge")
  M7a48xlarge: "m7a.48xlarge",

  @doc("InstanceType enum m7a.4xlarge")
  M7a4xlarge: "m7a.4xlarge",

  @doc("InstanceType enum m7a.8xlarge")
  M7a8xlarge: "m7a.8xlarge",

  @doc("InstanceType enum m7a.large")
  M7aLarge: "m7a.large",

  @doc("InstanceType enum m7a.medium")
  M7aMedium: "m7a.medium",

  @doc("InstanceType enum m7a.metal-48xl")
  M7aMetal48xl: "m7a.metal-48xl",

  @doc("InstanceType enum m7a.xlarge")
  M7aXlarge: "m7a.xlarge",

  @doc("InstanceType enum m7g.12xlarge")
  M7g12xlarge: "m7g.12xlarge",

  @doc("InstanceType enum m7g.16xlarge")
  M7g16xlarge: "m7g.16xlarge",

  @doc("InstanceType enum m7g.2xlarge")
  M7g2xlarge: "m7g.2xlarge",

  @doc("InstanceType enum m7g.4xlarge")
  M7g4xlarge: "m7g.4xlarge",

  @doc("InstanceType enum m7g.8xlarge")
  M7g8xlarge: "m7g.8xlarge",

  @doc("InstanceType enum m7g.large")
  M7gLarge: "m7g.large",

  @doc("InstanceType enum m7g.medium")
  M7gMedium: "m7g.medium",

  @doc("InstanceType enum m7g.metal")
  M7gMetal: "m7g.metal",

  @doc("InstanceType enum m7g.xlarge")
  M7gXlarge: "m7g.xlarge",

  @doc("InstanceType enum m7gd.12xlarge")
  M7gd12xlarge: "m7gd.12xlarge",

  @doc("InstanceType enum m7gd.16xlarge")
  M7gd16xlarge: "m7gd.16xlarge",

  @doc("InstanceType enum m7gd.2xlarge")
  M7gd2xlarge: "m7gd.2xlarge",

  @doc("InstanceType enum m7gd.4xlarge")
  M7gd4xlarge: "m7gd.4xlarge",

  @doc("InstanceType enum m7gd.8xlarge")
  M7gd8xlarge: "m7gd.8xlarge",

  @doc("InstanceType enum m7gd.large")
  M7gdLarge: "m7gd.large",

  @doc("InstanceType enum m7gd.medium")
  M7gdMedium: "m7gd.medium",

  @doc("InstanceType enum m7gd.metal")
  M7gdMetal: "m7gd.metal",

  @doc("InstanceType enum m7gd.xlarge")
  M7gdXlarge: "m7gd.xlarge",

  @doc("InstanceType enum m7i-flex.2xlarge")
  M7iFlex2xlarge: "m7i-flex.2xlarge",

  @doc("InstanceType enum m7i-flex.4xlarge")
  M7iFlex4xlarge: "m7i-flex.4xlarge",

  @doc("InstanceType enum m7i-flex.8xlarge")
  M7iFlex8xlarge: "m7i-flex.8xlarge",

  @doc("InstanceType enum m7i-flex.large")
  M7iFlexLarge: "m7i-flex.large",

  @doc("InstanceType enum m7i-flex.xlarge")
  M7iFlexXlarge: "m7i-flex.xlarge",

  @doc("InstanceType enum m7i.12xlarge")
  M7i12xlarge: "m7i.12xlarge",

  @doc("InstanceType enum m7i.16xlarge")
  M7i16xlarge: "m7i.16xlarge",

  @doc("InstanceType enum m7i.24xlarge")
  M7i24xlarge: "m7i.24xlarge",

  @doc("InstanceType enum m7i.2xlarge")
  M7i2xlarge: "m7i.2xlarge",

  @doc("InstanceType enum m7i.48xlarge")
  M7i48xlarge: "m7i.48xlarge",

  @doc("InstanceType enum m7i.4xlarge")
  M7i4xlarge: "m7i.4xlarge",

  @doc("InstanceType enum m7i.8xlarge")
  M7i8xlarge: "m7i.8xlarge",

  @doc("InstanceType enum m7i.large")
  M7iLarge: "m7i.large",

  @doc("InstanceType enum m7i.metal-24xl")
  M7iMetal24xl: "m7i.metal-24xl",

  @doc("InstanceType enum m7i.metal-48xl")
  M7iMetal48xl: "m7i.metal-48xl",

  @doc("InstanceType enum m7i.xlarge")
  M7iXlarge: "m7i.xlarge",

  @doc("InstanceType enum mac1.metal")
  Mac1Metal: "mac1.metal",

  @doc("InstanceType enum mac2-m2.metal")
  Mac2M2Metal: "mac2-m2.metal",

  @doc("InstanceType enum mac2-m2pro.metal")
  Mac2M2proMetal: "mac2-m2pro.metal",

  @doc("InstanceType enum mac2.metal")
  Mac2Metal: "mac2.metal",

  @doc("InstanceType enum p2.16xlarge")
  P216xlarge: "p2.16xlarge",

  @doc("InstanceType enum p2.8xlarge")
  P28xlarge: "p2.8xlarge",

  @doc("InstanceType enum p2.xlarge")
  P2Xlarge: "p2.xlarge",

  @doc("InstanceType enum p3.16xlarge")
  P316xlarge: "p3.16xlarge",

  @doc("InstanceType enum p3.2xlarge")
  P32xlarge: "p3.2xlarge",

  @doc("InstanceType enum p3.8xlarge")
  P38xlarge: "p3.8xlarge",

  @doc("InstanceType enum p3dn.24xlarge")
  P3dn24xlarge: "p3dn.24xlarge",

  @doc("InstanceType enum p4d.24xlarge")
  P4d24xlarge: "p4d.24xlarge",

  @doc("InstanceType enum p4de.24xlarge")
  P4de24xlarge: "p4de.24xlarge",

  @doc("InstanceType enum p5.48xlarge")
  P548xlarge: "p5.48xlarge",

  @doc("InstanceType enum r3.2xlarge")
  R32xlarge: "r3.2xlarge",

  @doc("InstanceType enum r3.4xlarge")
  R34xlarge: "r3.4xlarge",

  @doc("InstanceType enum r3.8xlarge")
  R38xlarge: "r3.8xlarge",

  @doc("InstanceType enum r3.large")
  R3Large: "r3.large",

  @doc("InstanceType enum r3.xlarge")
  R3Xlarge: "r3.xlarge",

  @doc("InstanceType enum r4.16xlarge")
  R416xlarge: "r4.16xlarge",

  @doc("InstanceType enum r4.2xlarge")
  R42xlarge: "r4.2xlarge",

  @doc("InstanceType enum r4.4xlarge")
  R44xlarge: "r4.4xlarge",

  @doc("InstanceType enum r4.8xlarge")
  R48xlarge: "r4.8xlarge",

  @doc("InstanceType enum r4.large")
  R4Large: "r4.large",

  @doc("InstanceType enum r4.xlarge")
  R4Xlarge: "r4.xlarge",

  @doc("InstanceType enum r5.12xlarge")
  R512xlarge: "r5.12xlarge",

  @doc("InstanceType enum r5.16xlarge")
  R516xlarge: "r5.16xlarge",

  @doc("InstanceType enum r5.24xlarge")
  R524xlarge: "r5.24xlarge",

  @doc("InstanceType enum r5.2xlarge")
  R52xlarge: "r5.2xlarge",

  @doc("InstanceType enum r5.4xlarge")
  R54xlarge: "r5.4xlarge",

  @doc("InstanceType enum r5.8xlarge")
  R58xlarge: "r5.8xlarge",

  @doc("InstanceType enum r5.large")
  R5Large: "r5.large",

  @doc("InstanceType enum r5.metal")
  R5Metal: "r5.metal",

  @doc("InstanceType enum r5.xlarge")
  R5Xlarge: "r5.xlarge",

  @doc("InstanceType enum r5a.12xlarge")
  R5a12xlarge: "r5a.12xlarge",

  @doc("InstanceType enum r5a.16xlarge")
  R5a16xlarge: "r5a.16xlarge",

  @doc("InstanceType enum r5a.24xlarge")
  R5a24xlarge: "r5a.24xlarge",

  @doc("InstanceType enum r5a.2xlarge")
  R5a2xlarge: "r5a.2xlarge",

  @doc("InstanceType enum r5a.4xlarge")
  R5a4xlarge: "r5a.4xlarge",

  @doc("InstanceType enum r5a.8xlarge")
  R5a8xlarge: "r5a.8xlarge",

  @doc("InstanceType enum r5a.large")
  R5aLarge: "r5a.large",

  @doc("InstanceType enum r5a.xlarge")
  R5aXlarge: "r5a.xlarge",

  @doc("InstanceType enum r5ad.12xlarge")
  R5ad12xlarge: "r5ad.12xlarge",

  @doc("InstanceType enum r5ad.16xlarge")
  R5ad16xlarge: "r5ad.16xlarge",

  @doc("InstanceType enum r5ad.24xlarge")
  R5ad24xlarge: "r5ad.24xlarge",

  @doc("InstanceType enum r5ad.2xlarge")
  R5ad2xlarge: "r5ad.2xlarge",

  @doc("InstanceType enum r5ad.4xlarge")
  R5ad4xlarge: "r5ad.4xlarge",

  @doc("InstanceType enum r5ad.8xlarge")
  R5ad8xlarge: "r5ad.8xlarge",

  @doc("InstanceType enum r5ad.large")
  R5adLarge: "r5ad.large",

  @doc("InstanceType enum r5ad.xlarge")
  R5adXlarge: "r5ad.xlarge",

  @doc("InstanceType enum r5b.12xlarge")
  R5b12xlarge: "r5b.12xlarge",

  @doc("InstanceType enum r5b.16xlarge")
  R5b16xlarge: "r5b.16xlarge",

  @doc("InstanceType enum r5b.24xlarge")
  R5b24xlarge: "r5b.24xlarge",

  @doc("InstanceType enum r5b.2xlarge")
  R5b2xlarge: "r5b.2xlarge",

  @doc("InstanceType enum r5b.4xlarge")
  R5b4xlarge: "r5b.4xlarge",

  @doc("InstanceType enum r5b.8xlarge")
  R5b8xlarge: "r5b.8xlarge",

  @doc("InstanceType enum r5b.large")
  R5bLarge: "r5b.large",

  @doc("InstanceType enum r5b.metal")
  R5bMetal: "r5b.metal",

  @doc("InstanceType enum r5b.xlarge")
  R5bXlarge: "r5b.xlarge",

  @doc("InstanceType enum r5d.12xlarge")
  R5d12xlarge: "r5d.12xlarge",

  @doc("InstanceType enum r5d.16xlarge")
  R5d16xlarge: "r5d.16xlarge",

  @doc("InstanceType enum r5d.24xlarge")
  R5d24xlarge: "r5d.24xlarge",

  @doc("InstanceType enum r5d.2xlarge")
  R5d2xlarge: "r5d.2xlarge",

  @doc("InstanceType enum r5d.4xlarge")
  R5d4xlarge: "r5d.4xlarge",

  @doc("InstanceType enum r5d.8xlarge")
  R5d8xlarge: "r5d.8xlarge",

  @doc("InstanceType enum r5d.large")
  R5dLarge: "r5d.large",

  @doc("InstanceType enum r5d.metal")
  R5dMetal: "r5d.metal",

  @doc("InstanceType enum r5d.xlarge")
  R5dXlarge: "r5d.xlarge",

  @doc("InstanceType enum r5dn.12xlarge")
  R5dn12xlarge: "r5dn.12xlarge",

  @doc("InstanceType enum r5dn.16xlarge")
  R5dn16xlarge: "r5dn.16xlarge",

  @doc("InstanceType enum r5dn.24xlarge")
  R5dn24xlarge: "r5dn.24xlarge",

  @doc("InstanceType enum r5dn.2xlarge")
  R5dn2xlarge: "r5dn.2xlarge",

  @doc("InstanceType enum r5dn.4xlarge")
  R5dn4xlarge: "r5dn.4xlarge",

  @doc("InstanceType enum r5dn.8xlarge")
  R5dn8xlarge: "r5dn.8xlarge",

  @doc("InstanceType enum r5dn.large")
  R5dnLarge: "r5dn.large",

  @doc("InstanceType enum r5dn.metal")
  R5dnMetal: "r5dn.metal",

  @doc("InstanceType enum r5dn.xlarge")
  R5dnXlarge: "r5dn.xlarge",

  @doc("InstanceType enum r5n.12xlarge")
  R5n12xlarge: "r5n.12xlarge",

  @doc("InstanceType enum r5n.16xlarge")
  R5n16xlarge: "r5n.16xlarge",

  @doc("InstanceType enum r5n.24xlarge")
  R5n24xlarge: "r5n.24xlarge",

  @doc("InstanceType enum r5n.2xlarge")
  R5n2xlarge: "r5n.2xlarge",

  @doc("InstanceType enum r5n.4xlarge")
  R5n4xlarge: "r5n.4xlarge",

  @doc("InstanceType enum r5n.8xlarge")
  R5n8xlarge: "r5n.8xlarge",

  @doc("InstanceType enum r5n.large")
  R5nLarge: "r5n.large",

  @doc("InstanceType enum r5n.metal")
  R5nMetal: "r5n.metal",

  @doc("InstanceType enum r5n.xlarge")
  R5nXlarge: "r5n.xlarge",

  @doc("InstanceType enum r6a.12xlarge")
  R6a12xlarge: "r6a.12xlarge",

  @doc("InstanceType enum r6a.16xlarge")
  R6a16xlarge: "r6a.16xlarge",

  @doc("InstanceType enum r6a.24xlarge")
  R6a24xlarge: "r6a.24xlarge",

  @doc("InstanceType enum r6a.2xlarge")
  R6a2xlarge: "r6a.2xlarge",

  @doc("InstanceType enum r6a.32xlarge")
  R6a32xlarge: "r6a.32xlarge",

  @doc("InstanceType enum r6a.48xlarge")
  R6a48xlarge: "r6a.48xlarge",

  @doc("InstanceType enum r6a.4xlarge")
  R6a4xlarge: "r6a.4xlarge",

  @doc("InstanceType enum r6a.8xlarge")
  R6a8xlarge: "r6a.8xlarge",

  @doc("InstanceType enum r6a.large")
  R6aLarge: "r6a.large",

  @doc("InstanceType enum r6a.metal")
  R6aMetal: "r6a.metal",

  @doc("InstanceType enum r6a.xlarge")
  R6aXlarge: "r6a.xlarge",

  @doc("InstanceType enum r6g.12xlarge")
  R6g12xlarge: "r6g.12xlarge",

  @doc("InstanceType enum r6g.16xlarge")
  R6g16xlarge: "r6g.16xlarge",

  @doc("InstanceType enum r6g.2xlarge")
  R6g2xlarge: "r6g.2xlarge",

  @doc("InstanceType enum r6g.4xlarge")
  R6g4xlarge: "r6g.4xlarge",

  @doc("InstanceType enum r6g.8xlarge")
  R6g8xlarge: "r6g.8xlarge",

  @doc("InstanceType enum r6g.large")
  R6gLarge: "r6g.large",

  @doc("InstanceType enum r6g.medium")
  R6gMedium: "r6g.medium",

  @doc("InstanceType enum r6g.metal")
  R6gMetal: "r6g.metal",

  @doc("InstanceType enum r6g.xlarge")
  R6gXlarge: "r6g.xlarge",

  @doc("InstanceType enum r6gd.12xlarge")
  R6gd12xlarge: "r6gd.12xlarge",

  @doc("InstanceType enum r6gd.16xlarge")
  R6gd16xlarge: "r6gd.16xlarge",

  @doc("InstanceType enum r6gd.2xlarge")
  R6gd2xlarge: "r6gd.2xlarge",

  @doc("InstanceType enum r6gd.4xlarge")
  R6gd4xlarge: "r6gd.4xlarge",

  @doc("InstanceType enum r6gd.8xlarge")
  R6gd8xlarge: "r6gd.8xlarge",

  @doc("InstanceType enum r6gd.large")
  R6gdLarge: "r6gd.large",

  @doc("InstanceType enum r6gd.medium")
  R6gdMedium: "r6gd.medium",

  @doc("InstanceType enum r6gd.metal")
  R6gdMetal: "r6gd.metal",

  @doc("InstanceType enum r6gd.xlarge")
  R6gdXlarge: "r6gd.xlarge",

  @doc("InstanceType enum r6i.12xlarge")
  R6i12xlarge: "r6i.12xlarge",

  @doc("InstanceType enum r6i.16xlarge")
  R6i16xlarge: "r6i.16xlarge",

  @doc("InstanceType enum r6i.24xlarge")
  R6i24xlarge: "r6i.24xlarge",

  @doc("InstanceType enum r6i.2xlarge")
  R6i2xlarge: "r6i.2xlarge",

  @doc("InstanceType enum r6i.32xlarge")
  R6i32xlarge: "r6i.32xlarge",

  @doc("InstanceType enum r6i.4xlarge")
  R6i4xlarge: "r6i.4xlarge",

  @doc("InstanceType enum r6i.8xlarge")
  R6i8xlarge: "r6i.8xlarge",

  @doc("InstanceType enum r6i.large")
  R6iLarge: "r6i.large",

  @doc("InstanceType enum r6i.metal")
  R6iMetal: "r6i.metal",

  @doc("InstanceType enum r6i.xlarge")
  R6iXlarge: "r6i.xlarge",

  @doc("InstanceType enum r6id.12xlarge")
  R6id12xlarge: "r6id.12xlarge",

  @doc("InstanceType enum r6id.16xlarge")
  R6id16xlarge: "r6id.16xlarge",

  @doc("InstanceType enum r6id.24xlarge")
  R6id24xlarge: "r6id.24xlarge",

  @doc("InstanceType enum r6id.2xlarge")
  R6id2xlarge: "r6id.2xlarge",

  @doc("InstanceType enum r6id.32xlarge")
  R6id32xlarge: "r6id.32xlarge",

  @doc("InstanceType enum r6id.4xlarge")
  R6id4xlarge: "r6id.4xlarge",

  @doc("InstanceType enum r6id.8xlarge")
  R6id8xlarge: "r6id.8xlarge",

  @doc("InstanceType enum r6id.large")
  R6idLarge: "r6id.large",

  @doc("InstanceType enum r6id.metal")
  R6idMetal: "r6id.metal",

  @doc("InstanceType enum r6id.xlarge")
  R6idXlarge: "r6id.xlarge",

  @doc("InstanceType enum r6idn.12xlarge")
  R6idn12xlarge: "r6idn.12xlarge",

  @doc("InstanceType enum r6idn.16xlarge")
  R6idn16xlarge: "r6idn.16xlarge",

  @doc("InstanceType enum r6idn.24xlarge")
  R6idn24xlarge: "r6idn.24xlarge",

  @doc("InstanceType enum r6idn.2xlarge")
  R6idn2xlarge: "r6idn.2xlarge",

  @doc("InstanceType enum r6idn.32xlarge")
  R6idn32xlarge: "r6idn.32xlarge",

  @doc("InstanceType enum r6idn.4xlarge")
  R6idn4xlarge: "r6idn.4xlarge",

  @doc("InstanceType enum r6idn.8xlarge")
  R6idn8xlarge: "r6idn.8xlarge",

  @doc("InstanceType enum r6idn.large")
  R6idnLarge: "r6idn.large",

  @doc("InstanceType enum r6idn.metal")
  R6idnMetal: "r6idn.metal",

  @doc("InstanceType enum r6idn.xlarge")
  R6idnXlarge: "r6idn.xlarge",

  @doc("InstanceType enum r6in.12xlarge")
  R6in12xlarge: "r6in.12xlarge",

  @doc("InstanceType enum r6in.16xlarge")
  R6in16xlarge: "r6in.16xlarge",

  @doc("InstanceType enum r6in.24xlarge")
  R6in24xlarge: "r6in.24xlarge",

  @doc("InstanceType enum r6in.2xlarge")
  R6in2xlarge: "r6in.2xlarge",

  @doc("InstanceType enum r6in.32xlarge")
  R6in32xlarge: "r6in.32xlarge",

  @doc("InstanceType enum r6in.4xlarge")
  R6in4xlarge: "r6in.4xlarge",

  @doc("InstanceType enum r6in.8xlarge")
  R6in8xlarge: "r6in.8xlarge",

  @doc("InstanceType enum r6in.large")
  R6inLarge: "r6in.large",

  @doc("InstanceType enum r6in.metal")
  R6inMetal: "r6in.metal",

  @doc("InstanceType enum r6in.xlarge")
  R6inXlarge: "r6in.xlarge",

  @doc("InstanceType enum r7a.12xlarge")
  R7a12xlarge: "r7a.12xlarge",

  @doc("InstanceType enum r7a.16xlarge")
  R7a16xlarge: "r7a.16xlarge",

  @doc("InstanceType enum r7a.24xlarge")
  R7a24xlarge: "r7a.24xlarge",

  @doc("InstanceType enum r7a.2xlarge")
  R7a2xlarge: "r7a.2xlarge",

  @doc("InstanceType enum r7a.32xlarge")
  R7a32xlarge: "r7a.32xlarge",

  @doc("InstanceType enum r7a.48xlarge")
  R7a48xlarge: "r7a.48xlarge",

  @doc("InstanceType enum r7a.4xlarge")
  R7a4xlarge: "r7a.4xlarge",

  @doc("InstanceType enum r7a.8xlarge")
  R7a8xlarge: "r7a.8xlarge",

  @doc("InstanceType enum r7a.large")
  R7aLarge: "r7a.large",

  @doc("InstanceType enum r7a.medium")
  R7aMedium: "r7a.medium",

  @doc("InstanceType enum r7a.metal-48xl")
  R7aMetal48xl: "r7a.metal-48xl",

  @doc("InstanceType enum r7a.xlarge")
  R7aXlarge: "r7a.xlarge",

  @doc("InstanceType enum r7g.12xlarge")
  R7g12xlarge: "r7g.12xlarge",

  @doc("InstanceType enum r7g.16xlarge")
  R7g16xlarge: "r7g.16xlarge",

  @doc("InstanceType enum r7g.2xlarge")
  R7g2xlarge: "r7g.2xlarge",

  @doc("InstanceType enum r7g.4xlarge")
  R7g4xlarge: "r7g.4xlarge",

  @doc("InstanceType enum r7g.8xlarge")
  R7g8xlarge: "r7g.8xlarge",

  @doc("InstanceType enum r7g.large")
  R7gLarge: "r7g.large",

  @doc("InstanceType enum r7g.medium")
  R7gMedium: "r7g.medium",

  @doc("InstanceType enum r7g.metal")
  R7gMetal: "r7g.metal",

  @doc("InstanceType enum r7g.xlarge")
  R7gXlarge: "r7g.xlarge",

  @doc("InstanceType enum r7gd.12xlarge")
  R7gd12xlarge: "r7gd.12xlarge",

  @doc("InstanceType enum r7gd.16xlarge")
  R7gd16xlarge: "r7gd.16xlarge",

  @doc("InstanceType enum r7gd.2xlarge")
  R7gd2xlarge: "r7gd.2xlarge",

  @doc("InstanceType enum r7gd.4xlarge")
  R7gd4xlarge: "r7gd.4xlarge",

  @doc("InstanceType enum r7gd.8xlarge")
  R7gd8xlarge: "r7gd.8xlarge",

  @doc("InstanceType enum r7gd.large")
  R7gdLarge: "r7gd.large",

  @doc("InstanceType enum r7gd.medium")
  R7gdMedium: "r7gd.medium",

  @doc("InstanceType enum r7gd.metal")
  R7gdMetal: "r7gd.metal",

  @doc("InstanceType enum r7gd.xlarge")
  R7gdXlarge: "r7gd.xlarge",

  @doc("InstanceType enum r7i.12xlarge")
  R7i12xlarge: "r7i.12xlarge",

  @doc("InstanceType enum r7i.16xlarge")
  R7i16xlarge: "r7i.16xlarge",

  @doc("InstanceType enum r7i.24xlarge")
  R7i24xlarge: "r7i.24xlarge",

  @doc("InstanceType enum r7i.2xlarge")
  R7i2xlarge: "r7i.2xlarge",

  @doc("InstanceType enum r7i.48xlarge")
  R7i48xlarge: "r7i.48xlarge",

  @doc("InstanceType enum r7i.4xlarge")
  R7i4xlarge: "r7i.4xlarge",

  @doc("InstanceType enum r7i.8xlarge")
  R7i8xlarge: "r7i.8xlarge",

  @doc("InstanceType enum r7i.large")
  R7iLarge: "r7i.large",

  @doc("InstanceType enum r7i.metal-24xl")
  R7iMetal24xl: "r7i.metal-24xl",

  @doc("InstanceType enum r7i.metal-48xl")
  R7iMetal48xl: "r7i.metal-48xl",

  @doc("InstanceType enum r7i.xlarge")
  R7iXlarge: "r7i.xlarge",

  @doc("InstanceType enum r7iz.12xlarge")
  R7iz12xlarge: "r7iz.12xlarge",

  @doc("InstanceType enum r7iz.16xlarge")
  R7iz16xlarge: "r7iz.16xlarge",

  @doc("InstanceType enum r7iz.2xlarge")
  R7iz2xlarge: "r7iz.2xlarge",

  @doc("InstanceType enum r7iz.32xlarge")
  R7iz32xlarge: "r7iz.32xlarge",

  @doc("InstanceType enum r7iz.4xlarge")
  R7iz4xlarge: "r7iz.4xlarge",

  @doc("InstanceType enum r7iz.8xlarge")
  R7iz8xlarge: "r7iz.8xlarge",

  @doc("InstanceType enum r7iz.large")
  R7izLarge: "r7iz.large",

  @doc("InstanceType enum r7iz.metal-16xl")
  R7izMetal16xl: "r7iz.metal-16xl",

  @doc("InstanceType enum r7iz.metal-32xl")
  R7izMetal32xl: "r7iz.metal-32xl",

  @doc("InstanceType enum r7iz.xlarge")
  R7izXlarge: "r7iz.xlarge",

  @doc("InstanceType enum t1.micro")
  T1Micro: "t1.micro",

  @doc("InstanceType enum t2.2xlarge")
  T22xlarge: "t2.2xlarge",

  @doc("InstanceType enum t2.large")
  T2Large: "t2.large",

  @doc("InstanceType enum t2.medium")
  T2Medium: "t2.medium",

  @doc("InstanceType enum t2.micro")
  T2Micro: "t2.micro",

  @doc("InstanceType enum t2.nano")
  T2Nano: "t2.nano",

  @doc("InstanceType enum t2.small")
  T2Small: "t2.small",

  @doc("InstanceType enum t2.xlarge")
  T2Xlarge: "t2.xlarge",

  @doc("InstanceType enum t3.2xlarge")
  T32xlarge: "t3.2xlarge",

  @doc("InstanceType enum t3.large")
  T3Large: "t3.large",

  @doc("InstanceType enum t3.medium")
  T3Medium: "t3.medium",

  @doc("InstanceType enum t3.micro")
  T3Micro: "t3.micro",

  @doc("InstanceType enum t3.nano")
  T3Nano: "t3.nano",

  @doc("InstanceType enum t3.small")
  T3Small: "t3.small",

  @doc("InstanceType enum t3.xlarge")
  T3Xlarge: "t3.xlarge",

  @doc("InstanceType enum t3a.2xlarge")
  T3a2xlarge: "t3a.2xlarge",

  @doc("InstanceType enum t3a.large")
  T3aLarge: "t3a.large",

  @doc("InstanceType enum t3a.medium")
  T3aMedium: "t3a.medium",

  @doc("InstanceType enum t3a.micro")
  T3aMicro: "t3a.micro",

  @doc("InstanceType enum t3a.nano")
  T3aNano: "t3a.nano",

  @doc("InstanceType enum t3a.small")
  T3aSmall: "t3a.small",

  @doc("InstanceType enum t3a.xlarge")
  T3aXlarge: "t3a.xlarge",

  @doc("InstanceType enum t4g.2xlarge")
  T4g2xlarge: "t4g.2xlarge",

  @doc("InstanceType enum t4g.large")
  T4gLarge: "t4g.large",

  @doc("InstanceType enum t4g.medium")
  T4gMedium: "t4g.medium",

  @doc("InstanceType enum t4g.micro")
  T4gMicro: "t4g.micro",

  @doc("InstanceType enum t4g.nano")
  T4gNano: "t4g.nano",

  @doc("InstanceType enum t4g.small")
  T4gSmall: "t4g.small",

  @doc("InstanceType enum t4g.xlarge")
  T4gXlarge: "t4g.xlarge",

  @doc("InstanceType enum trn1.2xlarge")
  Trn12xlarge: "trn1.2xlarge",

  @doc("InstanceType enum trn1.32xlarge")
  Trn132xlarge: "trn1.32xlarge",

  @doc("InstanceType enum trn1n.32xlarge")
  Trn1n32xlarge: "trn1n.32xlarge",

  @doc("InstanceType enum u-12tb1.112xlarge")
  U12tb1112xlarge: "u-12tb1.112xlarge",

  @doc("InstanceType enum u-12tb1.metal")
  U12tb1Metal: "u-12tb1.metal",

  @doc("InstanceType enum u-18tb1.112xlarge")
  U18tb1112xlarge: "u-18tb1.112xlarge",

  @doc("InstanceType enum u-18tb1.metal")
  U18tb1Metal: "u-18tb1.metal",

  @doc("InstanceType enum u-24tb1.112xlarge")
  U24tb1112xlarge: "u-24tb1.112xlarge",

  @doc("InstanceType enum u-24tb1.metal")
  U24tb1Metal: "u-24tb1.metal",

  @doc("InstanceType enum u-3tb1.56xlarge")
  U3tb156xlarge: "u-3tb1.56xlarge",

  @doc("InstanceType enum u-6tb1.112xlarge")
  U6tb1112xlarge: "u-6tb1.112xlarge",

  @doc("InstanceType enum u-6tb1.56xlarge")
  U6tb156xlarge: "u-6tb1.56xlarge",

  @doc("InstanceType enum u-6tb1.metal")
  U6tb1Metal: "u-6tb1.metal",

  @doc("InstanceType enum u-9tb1.112xlarge")
  U9tb1112xlarge: "u-9tb1.112xlarge",

  @doc("InstanceType enum u-9tb1.metal")
  U9tb1Metal: "u-9tb1.metal",

  @doc("InstanceType enum vt1.24xlarge")
  Vt124xlarge: "vt1.24xlarge",

  @doc("InstanceType enum vt1.3xlarge")
  Vt13xlarge: "vt1.3xlarge",

  @doc("InstanceType enum vt1.6xlarge")
  Vt16xlarge: "vt1.6xlarge",

  @doc("InstanceType enum x1.16xlarge")
  X116xlarge: "x1.16xlarge",

  @doc("InstanceType enum x1.32xlarge")
  X132xlarge: "x1.32xlarge",

  @doc("InstanceType enum x1e.16xlarge")
  X1e16xlarge: "x1e.16xlarge",

  @doc("InstanceType enum x1e.2xlarge")
  X1e2xlarge: "x1e.2xlarge",

  @doc("InstanceType enum x1e.32xlarge")
  X1e32xlarge: "x1e.32xlarge",

  @doc("InstanceType enum x1e.4xlarge")
  X1e4xlarge: "x1e.4xlarge",

  @doc("InstanceType enum x1e.8xlarge")
  X1e8xlarge: "x1e.8xlarge",

  @doc("InstanceType enum x1e.xlarge")
  X1eXlarge: "x1e.xlarge",

  @doc("InstanceType enum x2gd.12xlarge")
  X2gd12xlarge: "x2gd.12xlarge",

  @doc("InstanceType enum x2gd.16xlarge")
  X2gd16xlarge: "x2gd.16xlarge",

  @doc("InstanceType enum x2gd.2xlarge")
  X2gd2xlarge: "x2gd.2xlarge",

  @doc("InstanceType enum x2gd.4xlarge")
  X2gd4xlarge: "x2gd.4xlarge",

  @doc("InstanceType enum x2gd.8xlarge")
  X2gd8xlarge: "x2gd.8xlarge",

  @doc("InstanceType enum x2gd.large")
  X2gdLarge: "x2gd.large",

  @doc("InstanceType enum x2gd.medium")
  X2gdMedium: "x2gd.medium",

  @doc("InstanceType enum x2gd.metal")
  X2gdMetal: "x2gd.metal",

  @doc("InstanceType enum x2gd.xlarge")
  X2gdXlarge: "x2gd.xlarge",

  @doc("InstanceType enum x2idn.16xlarge")
  X2idn16xlarge: "x2idn.16xlarge",

  @doc("InstanceType enum x2idn.24xlarge")
  X2idn24xlarge: "x2idn.24xlarge",

  @doc("InstanceType enum x2idn.32xlarge")
  X2idn32xlarge: "x2idn.32xlarge",

  @doc("InstanceType enum x2idn.metal")
  X2idnMetal: "x2idn.metal",

  @doc("InstanceType enum x2iedn.16xlarge")
  X2iedn16xlarge: "x2iedn.16xlarge",

  @doc("InstanceType enum x2iedn.24xlarge")
  X2iedn24xlarge: "x2iedn.24xlarge",

  @doc("InstanceType enum x2iedn.2xlarge")
  X2iedn2xlarge: "x2iedn.2xlarge",

  @doc("InstanceType enum x2iedn.32xlarge")
  X2iedn32xlarge: "x2iedn.32xlarge",

  @doc("InstanceType enum x2iedn.4xlarge")
  X2iedn4xlarge: "x2iedn.4xlarge",

  @doc("InstanceType enum x2iedn.8xlarge")
  X2iedn8xlarge: "x2iedn.8xlarge",

  @doc("InstanceType enum x2iedn.metal")
  X2iednMetal: "x2iedn.metal",

  @doc("InstanceType enum x2iedn.xlarge")
  X2iednXlarge: "x2iedn.xlarge",

  @doc("InstanceType enum x2iezn.12xlarge")
  X2iezn12xlarge: "x2iezn.12xlarge",

  @doc("InstanceType enum x2iezn.2xlarge")
  X2iezn2xlarge: "x2iezn.2xlarge",

  @doc("InstanceType enum x2iezn.4xlarge")
  X2iezn4xlarge: "x2iezn.4xlarge",

  @doc("InstanceType enum x2iezn.6xlarge")
  X2iezn6xlarge: "x2iezn.6xlarge",

  @doc("InstanceType enum x2iezn.8xlarge")
  X2iezn8xlarge: "x2iezn.8xlarge",

  @doc("InstanceType enum x2iezn.metal")
  X2ieznMetal: "x2iezn.metal",

  @doc("InstanceType enum z1d.12xlarge")
  Z1d12xlarge: "z1d.12xlarge",

  @doc("InstanceType enum z1d.2xlarge")
  Z1d2xlarge: "z1d.2xlarge",

  @doc("InstanceType enum z1d.3xlarge")
  Z1d3xlarge: "z1d.3xlarge",

  @doc("InstanceType enum z1d.6xlarge")
  Z1d6xlarge: "z1d.6xlarge",

  @doc("InstanceType enum z1d.large")
  Z1dLarge: "z1d.large",

  @doc("InstanceType enum z1d.metal")
  Z1dMetal: "z1d.metal",

  @doc("InstanceType enum z1d.xlarge")
  Z1dXlarge: "z1d.xlarge",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceTypeEnumValue")
model InstanceTypeEnumValue {
  @doc("Property value")
  value?: InstanceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CapacityReservationSpecificationResponse")
model CapacityReservationSpecificationResponse {
  @doc("<p>Describes the instance's Capacity Reservation preferences. Possible preferences include:</p> <ul> <li> <p> <code>open</code> - The instance can run in any <code>open</code> Capacity Reservation that has matching attributes (instance type, platform, Availability Zone).</p> </li> <li> <p> <code>none</code> - The instance avoids running in a Capacity Reservation even if one is available. The instance runs in On-Demand capacity.</p> </li> </ul>")
  capacityReservationPreference?: CapacityReservationPreferenceEnumValue;

  @doc("<p>Information about the targeted Capacity Reservation or Capacity Reservation group.</p>")
  capacityReservationTarget?: CapacityReservationTargetResponse;
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

@doc("CapacityReservationPreference enum")
union CapacityReservationPreference {
  @doc("CapacityReservationPreference enum none")
  None: "none",

  @doc("CapacityReservationPreference enum open")
  Open: "open",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CapacityReservationPreferenceEnumValue")
model CapacityReservationPreferenceEnumValue {
  @doc("Property value")
  value?: CapacityReservationPreference;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CpuOptions")
model CpuOptions {
  @doc("<p>Indicates whether the instance is enabled for AMD SEV-SNP. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/sev-snp.html'>AMD SEV-SNP</a>.</p>")
  amdSevSnp?: AmdSevSnpSpecificationEnumValue;

  @doc("<p>The number of CPU cores for the instance.</p>")
  coreCount?: int32;

  @doc("<p>The number of threads per CPU core.</p>")
  threadsPerCore?: int32;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticGpuAssociation")
model ElasticGpuAssociation {
  @doc("<p>The ID of the association.</p>")
  elasticGpuAssociationId?: string;

  @doc("<p>The state of the association between the instance and the Elastic Graphics accelerator.</p>")
  elasticGpuAssociationState?: string;

  @doc("<p>The time the Elastic Graphics accelerator was associated with the instance.</p>")
  elasticGpuAssociationTime?: string;

  @doc("<p>The ID of the Elastic Graphics accelerator.</p>")
  elasticGpuId?: string;
}

@doc("AmdSevSnpSpecification enum")
union AmdSevSnpSpecification {
  @doc("AmdSevSnpSpecification enum disabled")
  Disabled: "disabled",

  @doc("AmdSevSnpSpecification enum enabled")
  Enabled: "enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AmdSevSnpSpecificationEnumValue")
model AmdSevSnpSpecificationEnumValue {
  @doc("Property value")
  value?: AmdSevSnpSpecification;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticInferenceAcceleratorAssociation")
model ElasticInferenceAcceleratorAssociation {
  @doc("<p> The Amazon Resource Name (ARN) of the elastic inference accelerator. </p>")
  elasticInferenceAcceleratorArn?: string;

  @doc("<p> The ID of the association. </p>")
  elasticInferenceAcceleratorAssociationId?: string;

  @doc("<p> The state of the elastic inference accelerator. </p>")
  elasticInferenceAcceleratorAssociationState?: string;

  @doc("<p> The time at which the elastic inference accelerator is associated with an instance. </p>")
  elasticInferenceAcceleratorAssociationTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnclaveOptions")
model EnclaveOptions {
  @doc("<p>If this parameter is set to <code>true</code>, the instance is enabled for Amazon Web Services Nitro Enclaves; otherwise, it is not enabled for Amazon Web Services Nitro Enclaves.</p>")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HibernationOptions")
model HibernationOptions {
  @doc("<p>If <code>true</code>, your instance is enabled for hibernation; otherwise, it is not enabled for hibernation.</p>")
  configured?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamInstanceProfile")
model IamInstanceProfile {
  @doc("<p>The Amazon Resource Name (ARN) of the instance profile.</p>")
  arn?: string;

  @doc("<p>The ID of the instance profile.</p>")
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LicenseConfiguration")
model LicenseConfiguration {
  @doc("<p>The Amazon Resource Name (ARN) of the license configuration.</p>")
  licenseConfigurationArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMaintenanceOptions")
model InstanceMaintenanceOptions {
  @doc("<p>Provides information on the current automatic recovery behavior of your instance.</p>")
  autoRecovery?: InstanceAutoRecoveryStateEnumValue;
}

@doc("InstanceAutoRecoveryState enum")
union InstanceAutoRecoveryState {
  @doc("InstanceAutoRecoveryState enum default")
  Default: "default",

  @doc("InstanceAutoRecoveryState enum disabled")
  Disabled: "disabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceAutoRecoveryStateEnumValue")
model InstanceAutoRecoveryStateEnumValue {
  @doc("Property value")
  value?: InstanceAutoRecoveryState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMetadataOptionsResponse")
model InstanceMetadataOptionsResponse {
  @doc("<p>Indicates whether the HTTP metadata endpoint on your instances is enabled or disabled.</p> <p>If the value is <code>disabled</code>, you cannot access your instance metadata.</p>")
  httpEndpoint?: InstanceMetadataEndpointStateEnumValue;

  @doc("<p>Indicates whether the IPv6 endpoint for the instance metadata service is enabled or disabled.</p> <p>Default: <code>disabled</code> </p>")
  httpProtocolIpv6?: InstanceMetadataProtocolStateEnumValue;

  @doc("<p>The maximum number of hops that the metadata token can travel.</p> <p>Possible values: Integers from <code>1</code> to <code>64</code> </p>")
  httpPutResponseHopLimit?: int32;

  @doc("<p>Indicates whether IMDSv2 is required.</p> <ul> <li> <p> <code>optional</code> - IMDSv2 is optional, which means that you can use either IMDSv2 or IMDSv1.</p> </li> <li> <p> <code>required</code> - IMDSv2 is required, which means that IMDSv1 is disabled, and you must use IMDSv2.</p> </li> </ul>")
  httpTokens?: HttpTokensStateEnumValue;

  @doc("<p>Indicates whether access to instance tags from the instance metadata is enabled or disabled. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#work-with-tags-in-IMDS'>Work with instance tags using the instance metadata</a>.</p>")
  instanceMetadataTags?: InstanceMetadataTagsStateEnumValue;

  @doc("<p>The state of the metadata option changes.</p> <p> <code>pending</code> - The metadata options are being updated and the instance is not ready to process metadata traffic with the new selection.</p> <p> <code>applied</code> - The metadata options have been successfully applied on the instance.</p>")
  state?: InstanceMetadataOptionsStateEnumValue;
}

@doc("InstanceMetadataEndpointState enum")
union InstanceMetadataEndpointState {
  @doc("InstanceMetadataEndpointState enum disabled")
  Disabled: "disabled",

  @doc("InstanceMetadataEndpointState enum enabled")
  Enabled: "enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMetadataEndpointStateEnumValue")
model InstanceMetadataEndpointStateEnumValue {
  @doc("Property value")
  value?: InstanceMetadataEndpointState;
}

@doc("HttpTokensState enum")
union HttpTokensState {
  @doc("HttpTokensState enum optional")
  Optional: "optional",

  @doc("HttpTokensState enum required")
  Required: "required",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HttpTokensStateEnumValue")
model HttpTokensStateEnumValue {
  @doc("Property value")
  value?: HttpTokensState;
}

@doc("InstanceMetadataOptionsState enum")
union InstanceMetadataOptionsState {
  @doc("InstanceMetadataOptionsState enum applied")
  Applied: "applied",

  @doc("InstanceMetadataOptionsState enum pending")
  Pending: "pending",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMetadataOptionsStateEnumValue")
model InstanceMetadataOptionsStateEnumValue {
  @doc("Property value")
  value?: InstanceMetadataOptionsState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Monitoring")
model Monitoring {
  @doc("<p>Indicates whether detailed monitoring is enabled. Otherwise, basic monitoring is enabled.</p>")
  state?: MonitoringStateEnumValue;
}

@doc("InstanceMetadataProtocolState enum")
union InstanceMetadataProtocolState {
  @doc("InstanceMetadataProtocolState enum disabled")
  Disabled: "disabled",

  @doc("InstanceMetadataProtocolState enum enabled")
  Enabled: "enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMetadataProtocolStateEnumValue")
model InstanceMetadataProtocolStateEnumValue {
  @doc("Property value")
  value?: InstanceMetadataProtocolState = "disabled";
}

@doc("MonitoringState enum")
union MonitoringState {
  @doc("MonitoringState enum disabled")
  Disabled: "disabled",

  @doc("MonitoringState enum disabling")
  Disabling: "disabling",

  @doc("MonitoringState enum enabled")
  Enabled: "enabled",

  @doc("MonitoringState enum pending")
  Pending: "pending",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MonitoringStateEnumValue")
model MonitoringStateEnumValue {
  @doc("Property value")
  value?: MonitoringState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceNetworkInterface")
model InstanceNetworkInterface {
  @doc("<p>The association information for an Elastic IPv4 associated with the network interface.</p>")
  association?: InstanceNetworkInterfaceAssociation;

  @doc("<p>The network interface attachment.</p>")
  attachment?: InstanceNetworkInterfaceAttachment;

  @doc("<p>A security group connection tracking configuration that enables you to set the timeout for connection tracking on an Elastic network interface. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#connection-tracking-timeouts'>Connection tracking timeouts</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>")
  connectionTrackingConfiguration?: ConnectionTrackingSpecificationResponse;

  @doc("<p>The description.</p>")
  description?: string;

  @doc("<p>The security groups.</p>")
  @extension("x-ms-identifiers", [])
  groups?: GroupIdentifier[];

  @doc("<p>The type of network interface.</p> <p>Valid values: <code>interface</code> | <code>efa</code> | <code>trunk</code> </p>")
  interfaceType?: string;

  @doc("<p>The IPv4 delegated prefixes that are assigned to the network interface.</p>")
  @extension("x-ms-identifiers", [])
  ipv4Prefixes?: InstanceIpv4Prefix[];

  @doc("<p>The IPv6 addresses associated with the network interface.</p>")
  @extension("x-ms-identifiers", [])
  ipv6Addresses?: InstanceIpv6Address[];

  @doc("<p>The IPv6 delegated prefixes that are assigned to the network interface.</p>")
  @extension("x-ms-identifiers", [])
  ipv6Prefixes?: InstanceIpv6Prefix[];

  @doc("<p>The MAC address.</p>")
  macAddress?: string;

  @doc("<p>The ID of the network interface.</p>")
  networkInterfaceId?: string;

  @doc("<p>The ID of the Amazon Web Services account that created the network interface.</p>")
  ownerId?: string;

  @doc("<p>The private DNS name.</p>")
  privateDnsName?: string;

  @doc("<p>The IPv4 address of the network interface within the subnet.</p>")
  privateIpAddress?: string;

  @doc("<p>The private IPv4 addresses associated with the network interface.</p>")
  @extension("x-ms-identifiers", [])
  privateIpAddresses?: InstancePrivateIpAddress[];

  @doc("<p>Indicates whether source/destination checking is enabled.</p>")
  sourceDestCheck?: boolean;

  @doc("<p>The status of the network interface.</p>")
  status?: NetworkInterfaceStatusEnumValue;

  @doc("<p>The ID of the subnet.</p>")
  subnetId?: string;

  @doc("<p>The ID of the VPC.</p>")
  vpcId?: string;
}

@doc("InstanceMetadataTagsState enum")
union InstanceMetadataTagsState {
  @doc("InstanceMetadataTagsState enum disabled")
  Disabled: "disabled",

  @doc("InstanceMetadataTagsState enum enabled")
  Enabled: "enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMetadataTagsStateEnumValue")
model InstanceMetadataTagsStateEnumValue {
  @doc("Property value")
  value?: InstanceMetadataTagsState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Placement")
model Placement {
  @doc("<p>The affinity setting for the instance on the Dedicated Host.</p> <p>This parameter is not supported for <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet'>CreateFleet</a> or <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html'>ImportInstance</a>.</p>")
  affinity?: string;

  @doc("<p>The Availability Zone of the instance.</p> <p>If not specified, an Availability Zone will be automatically chosen for you based on the load balancing criteria for the Region.</p> <p>This parameter is not supported for <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet'>CreateFleet</a>.</p>")
  availabilityZone?: string;

  @doc("<p>The ID of the placement group that the instance is in. If you specify <code>GroupId</code>, you can't specify <code>GroupName</code>.</p>")
  groupId?: string;

  @doc("<p>The name of the placement group that the instance is in. If you specify <code>GroupName</code>, you can't specify <code>GroupId</code>.</p>")
  groupName?: string;

  @doc("<p>The ID of the Dedicated Host on which the instance resides.</p> <p>This parameter is not supported for <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet'>CreateFleet</a> or <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html'>ImportInstance</a>.</p>")
  hostId?: string;

  @doc("<p>The ARN of the host resource group in which to launch the instances.</p> <p>If you specify this parameter, either omit the <b>Tenancy</b> parameter or set it to <code>host</code>.</p> <p>This parameter is not supported for <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet'>CreateFleet</a>.</p>")
  hostResourceGroupArn?: string;

  @doc("<p>The number of the partition that the instance is in. Valid only if the placement group strategy is set to <code>partition</code>.</p> <p>This parameter is not supported for <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet'>CreateFleet</a>.</p>")
  partitionNumber?: int32;

  @doc("<p>Reserved for future use.</p>")
  spreadDomain?: string;

  @doc("<p>The tenancy of the instance. An instance with a tenancy of <code>dedicated</code> runs on single-tenant hardware.</p> <p>This parameter is not supported for <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet'>CreateFleet</a>. The <code>host</code> tenancy is not supported for <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html'>ImportInstance</a> or for T3 instances that are configured for the <code>unlimited</code> CPU credit option.</p>")
  tenancy?: TenancyEnumValue;
}

@doc("NetworkInterfaceStatus enum")
union NetworkInterfaceStatus {
  @doc("NetworkInterfaceStatus enum associated")
  Associated: "associated",

  @doc("NetworkInterfaceStatus enum attaching")
  Attaching: "attaching",

  @doc("NetworkInterfaceStatus enum available")
  Available: "available",

  @doc("NetworkInterfaceStatus enum detaching")
  Detaching: "detaching",

  @doc("NetworkInterfaceStatus enum in-use")
  InUse: "in-use",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkInterfaceStatusEnumValue")
model NetworkInterfaceStatusEnumValue {
  @doc("Property value")
  value?: NetworkInterfaceStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PrivateDnsNameOptionsResponse")
model PrivateDnsNameOptionsResponse {
  @doc("<p>Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records.</p>")
  enableResourceNameDnsAAAARecord?: boolean;

  @doc("<p>Indicates whether to respond to DNS queries for instance hostnames with DNS A records.</p>")
  enableResourceNameDnsARecord?: boolean;

  @doc("<p>The type of hostname to assign to an instance.</p>")
  hostnameType?: HostnameTypeEnumValue;
}

@doc("Tenancy enum")
union Tenancy {
  @doc("Tenancy enum dedicated")
  Dedicated: "dedicated",

  @doc("Tenancy enum default")
  Default: "default",

  @doc("Tenancy enum host")
  Host: "host",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TenancyEnumValue")
model TenancyEnumValue {
  @doc("Property value")
  value?: Tenancy;
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

@doc("HostnameType enum")
union HostnameType {
  @doc("HostnameType enum ip-name")
  IpName: "ip-name",

  @doc("HostnameType enum resource-name")
  ResourceName: "resource-name",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HostnameTypeEnumValue")
model HostnameTypeEnumValue {
  @doc("Property value")
  value?: HostnameType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GroupIdentifier")
model GroupIdentifier {
  @doc("<p>The ID of the security group.</p>")
  groupId?: string;

  @doc("<p>The name of the security group.</p>")
  groupName?: string;
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
@doc("Definition of StateReason")
model StateReason {
  @doc("<p>The reason code for the state change.</p>")
  code?: string;

  @doc("<p>The message for the state change.</p> <ul> <li> <p> <code>Server.InsufficientInstanceCapacity</code>: There was insufficient capacity available to satisfy the launch request.</p> </li> <li> <p> <code>Server.InternalError</code>: An internal error caused the instance to terminate during launch.</p> </li> <li> <p> <code>Server.ScheduledStop</code>: The instance was stopped due to a scheduled retirement.</p> </li> <li> <p> <code>Server.SpotInstanceShutdown</code>: The instance was stopped because the number of Spot requests with a maximum price equal to or higher than the Spot price exceeded available capacity or because of an increase in the Spot price.</p> </li> <li> <p> <code>Server.SpotInstanceTermination</code>: The instance was terminated because the number of Spot requests with a maximum price equal to or higher than the Spot price exceeded available capacity or because of an increase in the Spot price.</p> </li> <li> <p> <code>Client.InstanceInitiatedShutdown</code>: The instance was shut down from the operating system of the instance.</p> </li> <li> <p> <code>Client.InstanceTerminated</code>: The instance was terminated or rebooted during AMI creation.</p> </li> <li> <p> <code>Client.InternalError</code>: A client error caused the instance to terminate during launch.</p> </li> <li> <p> <code>Client.InvalidSnapshot.NotFound</code>: The specified snapshot was not found.</p> </li> <li> <p> <code>Client.UserInitiatedHibernate</code>: Hibernation was initiated on the instance.</p> </li> <li> <p> <code>Client.UserInitiatedShutdown</code>: The instance was shut down using the Amazon EC2 API.</p> </li> <li> <p> <code>Client.VolumeLimitExceeded</code>: The limit on the number of EBS volumes or total storage was exceeded. Decrease usage or request an increase in your account limits.</p> </li> </ul>")
  message?: string;
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
@doc("Definition of EbsInstanceBlockDevice")
model EbsInstanceBlockDevice {
  @doc("<p>The ARN of the Amazon ECS or Fargate task to which the volume is attached.</p>")
  associatedResource?: string;

  @doc("<p>The time stamp when the attachment initiated.</p>")
  attachTime?: utcDateTime;

  @doc("<p>Indicates whether the volume is deleted on instance termination.</p>")
  deleteOnTermination?: boolean;

  @doc("<p>The attachment state.</p>")
  status?: AttachmentStatusEnumValue;

  @doc("<p>The ID of the EBS volume.</p>")
  volumeId?: string;

  @doc("<p>The ID of the Amazon Web Services account that owns the volume.</p> <p>This parameter is returned only for volumes that are attached to Fargate tasks.</p>")
  volumeOwnerId?: string;
}

@doc("AttachmentStatus enum")
union AttachmentStatus {
  @doc("AttachmentStatus enum attached")
  Attached: "attached",

  @doc("AttachmentStatus enum attaching")
  Attaching: "attaching",

  @doc("AttachmentStatus enum detached")
  Detached: "detached",

  @doc("AttachmentStatus enum detaching")
  Detaching: "detaching",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AttachmentStatusEnumValue")
model AttachmentStatusEnumValue {
  @doc("Property value")
  value?: AttachmentStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CapacityReservationTargetResponse")
model CapacityReservationTargetResponse {
  @doc("<p>The ID of the targeted Capacity Reservation.</p>")
  capacityReservationId?: string;

  @doc("<p>The ARN of the targeted Capacity Reservation group.</p>")
  capacityReservationResourceGroupArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceNetworkInterfaceAssociation")
model InstanceNetworkInterfaceAssociation {
  @doc("<p>The carrier IP address associated with the network interface.</p>")
  carrierIp?: string;

  @doc("<p>The customer-owned IP address associated with the network interface.</p>")
  customerOwnedIp?: string;

  @doc("<p>The ID of the owner of the Elastic IP address.</p>")
  ipOwnerId?: string;

  @doc("<p>The public DNS name.</p>")
  publicDnsName?: string;

  @doc("<p>The public IP address or Elastic IP address bound to the network interface.</p>")
  publicIp?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceNetworkInterfaceAttachment")
model InstanceNetworkInterfaceAttachment {
  @doc("<p>The time stamp when the attachment initiated.</p>")
  attachTime?: utcDateTime;

  @doc("<p>The ID of the network interface attachment.</p>")
  attachmentId?: string;

  @doc("<p>Indicates whether the network interface is deleted when the instance is terminated.</p>")
  deleteOnTermination?: boolean;

  @doc("<p>The index of the device on the instance for the network interface attachment.</p>")
  deviceIndex?: int32;

  @doc("<p>Contains the ENA Express settings for the network interface that's attached to the instance.</p>")
  enaSrdSpecification?: InstanceAttachmentEnaSrdSpecification;

  @doc("<p>The index of the network card.</p>")
  networkCardIndex?: int32;

  @doc("<p>The attachment state.</p>")
  status?: AttachmentStatusEnumValue;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConnectionTrackingSpecificationResponse")
model ConnectionTrackingSpecificationResponse {
  @doc("<p>Timeout (in seconds) for idle TCP connections in an established state. Min: 60 seconds. Max: 432000 seconds (5 days). Default: 432000 seconds. Recommended: Less than 432000 seconds.</p>")
  tcpEstablishedTimeout?: int32 = 432000;

  @doc("<p>Timeout (in seconds) for idle UDP flows classified as streams which have seen more than one request-response transaction. Min: 60 seconds. Max: 180 seconds (3 minutes). Default: 180 seconds.</p>")
  udpStreamTimeout?: int32 = 180;

  @doc("<p>Timeout (in seconds) for idle UDP flows that have seen traffic only in a single direction or a single request-response transaction. Min: 30 seconds. Max: 60 seconds. Default: 30 seconds.</p>")
  udpTimeout?: int32 = 30;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceIpv4Prefix")
model InstanceIpv4Prefix {
  @doc("<p>One or more IPv4 prefixes assigned to the network interface.</p>")
  ipv4Prefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceIpv6Address")
model InstanceIpv6Address {
  @doc("<p>The IPv6 address.</p>")
  ipv6Address?: string;

  @doc("<p>Determines if an IPv6 address associated with a network interface is the primary IPv6 address. When you enable an IPv6 GUA address to be a primary IPv6, the first IPv6 GUA will be made the primary IPv6 address until the instance is terminated or the network interface is detached. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html'>RunInstances</a>.</p>")
  isPrimaryIpv6?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceIpv6Prefix")
model InstanceIpv6Prefix {
  @doc("<p>One or more IPv6 prefixes assigned to the network interface.</p>")
  ipv6Prefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstancePrivateIpAddress")
model InstancePrivateIpAddress {
  @doc("<p>The association information for an Elastic IP address for the network interface.</p>")
  association?: InstanceNetworkInterfaceAssociation;

  @doc("<p>Indicates whether this IPv4 address is the primary private IP address of the network interface.</p>")
  primary?: boolean;

  @doc("<p>The private IPv4 DNS name.</p>")
  privateDnsName?: string;

  @doc("<p>The private IPv4 address of the network interface.</p>")
  privateIpAddress?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceAttachmentEnaSrdSpecification")
model InstanceAttachmentEnaSrdSpecification {
  @doc("<p>Indicates whether ENA Express is enabled for the network interface.</p>")
  enaSrdEnabled?: boolean;

  @doc("<p>Configures ENA Express for UDP network traffic.</p>")
  enaSrdUdpSpecification?: InstanceAttachmentEnaSrdUdpSpecification;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceAttachmentEnaSrdUdpSpecification")
model InstanceAttachmentEnaSrdUdpSpecification {
  @doc("<p>Indicates whether UDP traffic to and from the instance uses ENA Express. To specify this setting, you must first enable ENA Express.</p>")
  enaSrdUdpEnabled?: boolean;
}

@doc("Defines the stop action properties.")
model StopEc2InstanceOptions {
  @doc("Forces the instance to stop. The instance does not have an opportunity to flush file system caches or file system metadata. If you use this option, you must perform file system check and repair procedures. This option is not recommended for Windows instances. Defaults to false.")
  force?: boolean = false;

  @doc("Hibernates the instance if the instance was enabled for hibernation at launch. If the instance cannot hibernate successfully, a normal shutdown occurs. Defaults to false.")
  hibernate?: boolean = false;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2Instances {
  get is ArmResourceRead<Ec2Instance>;
  @doc("Create a Ec2Instance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2Instance>;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Instance>;
  list is ArmResourceListByParent<Ec2Instance>;
  Start is ArmResourceActionAsync<
    Ec2Instance,
    void,
    Azure.ResourceManager.Foundations.OperationStatusResult
  >;
  Stop is ArmResourceActionAsync<
    Ec2Instance,
    StopEc2InstanceOptions,
    Azure.ResourceManager.Foundations.OperationStatusResult
  >;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: Instance
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
