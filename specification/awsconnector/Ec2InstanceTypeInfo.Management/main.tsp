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

//---------------------------------------------- Ec2InstanceTypeInfos ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Instance Type Info",
    plural: "EC2 Instance Type Infos",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Instance", "Type", "Info"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2InstanceTypeInfo is TrackedResource<Ec2InstanceTypeInfoProperties> {
  @doc("Name of Ec2InstanceTypeInfo")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2InstanceTypeInfos")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2InstanceTypeInfo")
model Ec2InstanceTypeInfoProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2InstanceTypeInfoProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2InstanceTypeInfo")
model AwsEc2InstanceTypeInfoProperties {
  @doc("<p>Indicates whether Amazon CloudWatch action based recovery is supported.</p>")
  autoRecoverySupported?: boolean;

  @doc("<p>Indicates whether the instance is a bare metal instance type.</p>")
  bareMetal?: boolean;

  @doc("<p>Indicates whether the instance type is a burstable performance T instance type. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html'>Burstable performance instances</a>.</p>")
  burstablePerformanceSupported?: boolean;

  @doc("<p>Indicates whether the instance type is current generation.</p>")
  currentGeneration?: boolean;

  @doc("<p>Indicates whether Dedicated Hosts are supported on the instance type.</p>")
  dedicatedHostsSupported?: boolean;

  @doc("<p>Describes the Amazon EBS settings for the instance type.</p>")
  ebsInfo?: EbsInfo;

  @doc("<p>Describes the FPGA accelerator settings for the instance type.</p>")
  fpgaInfo?: FpgaInfo;

  @doc("<p>Indicates whether the instance type is eligible for the free tier.</p>")
  freeTierEligible?: boolean;

  @doc("<p>Describes the GPU accelerator settings for the instance type.</p>")
  gpuInfo?: GpuInfo;

  @doc("<p>Indicates whether On-Demand hibernation is supported.</p>")
  hibernationSupported?: boolean;

  @doc("<p>The hypervisor for the instance type.</p>")
  hypervisor?: InstanceTypeHypervisorEnumValue;

  @doc("<p>Describes the Inference accelerator settings for the instance type.</p>")
  inferenceAcceleratorInfo?: InferenceAcceleratorInfo;

  @doc("<p>Describes the instance storage for the instance type.</p>")
  instanceStorageInfo?: InstanceStorageInfo;

  @doc("<p>Indicates whether instance storage is supported.</p>")
  instanceStorageSupported?: boolean;

  @doc("<p>The instance type. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html'>Instance types</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  instanceType?: InstanceTypeEnumValue;

  @doc("<p>Describes the media accelerator settings for the instance type.</p>")
  mediaAcceleratorInfo?: MediaAcceleratorInfo;

  @doc("<p>Describes the memory for the instance type.</p>")
  memoryInfo?: MemoryInfo;

  @doc("<p>Describes the network settings for the instance type.</p>")
  networkInfo?: NetworkInfo;

  @doc("<p>Describes the Neuron accelerator settings for the instance type.</p>")
  neuronInfo?: NeuronInfo;

  @doc("<p>Indicates whether Nitro Enclaves is supported.</p>")
  nitroEnclavesSupport?: NitroEnclavesSupportEnumValue;

  @doc("<p>Describes the supported NitroTPM versions for the instance type.</p>")
  nitroTpmInfo?: NitroTpmInfo;

  @doc("<p>Indicates whether NitroTPM is supported.</p>")
  nitroTpmSupport?: NitroTpmSupportEnumValue;

  @doc("<p>Describes the placement group settings for the instance type.</p>")
  placementGroupInfo?: PlacementGroupInfo;

  @doc("<p>Describes the processor.</p>")
  processorInfo?: ProcessorInfo;

  @doc("<p>The supported boot modes. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html'>Boot modes</a> in the <i>Amazon EC2 User Guide</i>.</p>")
  @extension("x-ms-identifiers", [])
  supportedBootModes?: BootModeType[];

  @doc("<p>The supported root device types.</p>")
  @extension("x-ms-identifiers", [])
  supportedRootDeviceTypes?: RootDeviceType[];

  @doc("<p>Indicates whether the instance type is offered for spot or On-Demand.</p>")
  @extension("x-ms-identifiers", [])
  supportedUsageClasses?: UsageClassType[];

  @doc("<p>The supported virtualization types.</p>")
  @extension("x-ms-identifiers", [])
  supportedVirtualizationTypes?: VirtualizationType[];

  @doc("<p>Describes the vCPU configurations for the instance type.</p>")
  vCpuInfo?: VCpuInfo;
}

@doc("InstanceTypeHypervisor enum")
union InstanceTypeHypervisor {
  @doc("InstanceTypeHypervisor enum nitro")
  Nitro: "nitro",

  @doc("InstanceTypeHypervisor enum xen")
  Xen: "xen",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceTypeHypervisorEnumValue")
model InstanceTypeHypervisorEnumValue {
  @doc("Property value")
  value?: InstanceTypeHypervisor;
}

@doc("NitroEnclavesSupport enum")
union NitroEnclavesSupport {
  @doc("NitroEnclavesSupport enum supported")
  Supported: "supported",

  @doc("NitroEnclavesSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NitroEnclavesSupportEnumValue")
model NitroEnclavesSupportEnumValue {
  @doc("Property value")
  value?: NitroEnclavesSupport;
}

@doc("BootModeType enum")
union BootModeType {
  @doc("BootModeType enum legacy-bios")
  LegacyBios: "legacy-bios",

  @doc("BootModeType enum uefi")
  Uefi: "uefi",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BootModeTypeEnumValue")
model BootModeTypeEnumValue {
  @doc("Property value")
  value?: BootModeType;
}

@doc("UsageClassType enum")
union UsageClassType {
  @doc("UsageClassType enum capacity-block")
  CapacityBlock: "capacity-block",

  @doc("UsageClassType enum on-demand")
  OnDemand: "on-demand",

  @doc("UsageClassType enum spot")
  Spot: "spot",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of UsageClassTypeEnumValue")
model UsageClassTypeEnumValue {
  @doc("Property value")
  value?: UsageClassType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsInfo")
model EbsInfo {
  @doc("<p>Describes the optimized EBS performance for the instance type.</p>")
  ebsOptimizedInfo?: EbsOptimizedInfo;

  @doc("<p>Indicates whether the instance type is Amazon EBS-optimized. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSOptimized.html'>Amazon EBS-optimized instances</a> in <i>Amazon EC2 User Guide</i>.</p>")
  ebsOptimizedSupport?: EbsOptimizedSupportEnumValue;

  @doc("<p>Indicates whether Amazon EBS encryption is supported.</p>")
  encryptionSupport?: EbsEncryptionSupportEnumValue;

  @doc("<p>Indicates whether non-volatile memory express (NVMe) is supported.</p>")
  nvmeSupport?: EbsNvmeSupportEnumValue;
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

@doc("RootDeviceType enum")
union RootDeviceType {
  @doc("RootDeviceType enum ebs")
  Ebs: "ebs",

  @doc("RootDeviceType enum instance-store")
  InstanceStore: "instance-store",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RootDeviceTypeEnumValue")
model RootDeviceTypeEnumValue {
  @doc("Property value")
  value?: RootDeviceType;
}

@doc("EbsOptimizedSupport enum")
union EbsOptimizedSupport {
  @doc("EbsOptimizedSupport enum default")
  Default: "default",

  @doc("EbsOptimizedSupport enum supported")
  Supported: "supported",

  @doc("EbsOptimizedSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsOptimizedSupportEnumValue")
model EbsOptimizedSupportEnumValue {
  @doc("Property value")
  value?: EbsOptimizedSupport;
}

@doc("EbsNvmeSupport enum")
union EbsNvmeSupport {
  @doc("EbsNvmeSupport enum required")
  Required: "required",

  @doc("EbsNvmeSupport enum supported")
  Supported: "supported",

  @doc("EbsNvmeSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsNvmeSupportEnumValue")
model EbsNvmeSupportEnumValue {
  @doc("Property value")
  value?: EbsNvmeSupport;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FpgaInfo")
model FpgaInfo {
  @doc("<p>Describes the FPGAs for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  fpgas?: FpgaDeviceInfo[];

  @doc("<p>The total memory of all FPGA accelerators for the instance type.</p>")
  totalFpgaMemoryInMiB?: int32;
}

@doc("NitroTpmSupport enum")
union NitroTpmSupport {
  @doc("NitroTpmSupport enum supported")
  Supported: "supported",

  @doc("NitroTpmSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NitroTpmSupportEnumValue")
model NitroTpmSupportEnumValue {
  @doc("Property value")
  value?: NitroTpmSupport;
}

@doc("EbsEncryptionSupport enum")
union EbsEncryptionSupport {
  @doc("EbsEncryptionSupport enum supported")
  Supported: "supported",

  @doc("EbsEncryptionSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsEncryptionSupportEnumValue")
model EbsEncryptionSupportEnumValue {
  @doc("Property value")
  value?: EbsEncryptionSupport;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GpuInfo")
model GpuInfo {
  @doc("<p>Describes the GPU accelerators for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  gpus?: GpuDeviceInfo[];

  @doc("<p>The total size of the memory for the GPU accelerators for the instance type, in MiB.</p>")
  totalGpuMemoryInMiB?: int32;
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
@doc("Definition of InferenceAcceleratorInfo")
model InferenceAcceleratorInfo {
  @doc("<p>Describes the Inference accelerators for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  accelerators?: InferenceDeviceInfo[];

  @doc("<p>The total size of the memory for the inference accelerators for the instance type, in MiB.</p>")
  totalInferenceMemoryInMiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceStorageInfo")
model InstanceStorageInfo {
  @doc("<p>Describes the disks that are available for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  disks?: DiskInfo[];

  @doc("<p>Indicates whether data is encrypted at rest.</p>")
  encryptionSupport?: InstanceStorageEncryptionSupportEnumValue;

  @doc("<p>Indicates whether non-volatile memory express (NVMe) is supported.</p>")
  nvmeSupport?: EphemeralNvmeSupportEnumValue;

  @doc("<p>The total size of the disks, in GB.</p>")
  totalSizeInGB?: int64;
}

@doc("InstanceStorageEncryptionSupport enum")
union InstanceStorageEncryptionSupport {
  @doc("InstanceStorageEncryptionSupport enum required")
  Required: "required",

  @doc("InstanceStorageEncryptionSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceStorageEncryptionSupportEnumValue")
model InstanceStorageEncryptionSupportEnumValue {
  @doc("Property value")
  value?: InstanceStorageEncryptionSupport;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MediaAcceleratorInfo")
model MediaAcceleratorInfo {
  @doc("<p>Describes the media accelerators for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  accelerators?: MediaDeviceInfo[];

  @doc("<p>The total size of the memory for the media accelerators for the instance type, in MiB.</p>")
  totalMediaMemoryInMiB?: int32;
}

@doc("EphemeralNvmeSupport enum")
union EphemeralNvmeSupport {
  @doc("EphemeralNvmeSupport enum required")
  Required: "required",

  @doc("EphemeralNvmeSupport enum supported")
  Supported: "supported",

  @doc("EphemeralNvmeSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EphemeralNvmeSupportEnumValue")
model EphemeralNvmeSupportEnumValue {
  @doc("Property value")
  value?: EphemeralNvmeSupport;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MemoryInfo")
model MemoryInfo {
  @doc("<p>The size of the memory, in MiB.</p>")
  sizeInMiB?: int64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkInfo")
model NetworkInfo {
  @doc("<p>The index of the default network card, starting at 0.</p>")
  defaultNetworkCardIndex?: int32;

  @doc("<p>Describes the Elastic Fabric Adapters for the instance type.</p>")
  efaInfo?: EfaInfo;

  @doc("<p>Indicates whether Elastic Fabric Adapter (EFA) is supported.</p>")
  efaSupported?: boolean;

  @doc("<p>Indicates whether the instance type supports ENA Express. ENA Express uses Amazon Web Services Scalable Reliable Datagram (SRD) technology to increase the maximum bandwidth used per stream and minimize tail latency of network traffic between EC2 instances.</p>")
  enaSrdSupported?: boolean;

  @doc("<p>Indicates whether Elastic Network Adapter (ENA) is supported.</p>")
  enaSupport?: EnaSupportEnumValue;

  @doc("<p>Indicates whether the instance type automatically encrypts in-transit traffic between instances.</p>")
  encryptionInTransitSupported?: boolean;

  @doc("<p>The maximum number of IPv4 addresses per network interface.</p>")
  ipv4AddressesPerInterface?: int32;

  @doc("<p>The maximum number of IPv6 addresses per network interface.</p>")
  ipv6AddressesPerInterface?: int32;

  @doc("<p>Indicates whether IPv6 is supported.</p>")
  ipv6Supported?: boolean;

  @doc("<p>The maximum number of physical network cards that can be allocated to the instance.</p>")
  maximumNetworkCards?: int32;

  @doc("<p>The maximum number of network interfaces for the instance type.</p>")
  maximumNetworkInterfaces?: int32;

  @doc("<p>Describes the network cards for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  networkCards?: NetworkCardInfo[];

  @doc("<p>The network performance.</p>")
  networkPerformance?: string;
}

@doc("EnaSupport enum")
union EnaSupport {
  @doc("EnaSupport enum required")
  Required: "required",

  @doc("EnaSupport enum supported")
  Supported: "supported",

  @doc("EnaSupport enum unsupported")
  Unsupported: "unsupported",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnaSupportEnumValue")
model EnaSupportEnumValue {
  @doc("Property value")
  value?: EnaSupport;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NeuronInfo")
model NeuronInfo {
  @doc("<p>Describes the neuron accelerators for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  neuronDevices?: NeuronDeviceInfo[];

  @doc("<p>The total size of the memory for the neuron accelerators for the instance type, in MiB.</p>")
  totalNeuronDeviceMemoryInMiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NitroTpmInfo")
model NitroTpmInfo {
  @doc("<p>Indicates the supported NitroTPM versions.</p>")
  @extension("x-ms-identifiers", [])
  supportedVersions?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementGroupInfo")
model PlacementGroupInfo {
  @doc("<p>The supported placement group types.</p>")
  @extension("x-ms-identifiers", [])
  supportedStrategies?: PlacementGroupStrategy[];
}

@doc("PlacementGroupStrategy enum")
union PlacementGroupStrategy {
  @doc("PlacementGroupStrategy enum cluster")
  Cluster: "cluster",

  @doc("PlacementGroupStrategy enum partition")
  Partition: "partition",

  @doc("PlacementGroupStrategy enum spread")
  Spread: "spread",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementGroupStrategyEnumValue")
model PlacementGroupStrategyEnumValue {
  @doc("Property value")
  value?: PlacementGroupStrategy;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProcessorInfo")
model ProcessorInfo {
  @doc("<p>The manufacturer of the processor.</p>")
  manufacturer?: string;

  @doc("<p>The architectures supported by the instance type.</p>")
  @extension("x-ms-identifiers", [])
  supportedArchitectures?: ArchitectureType[];

  @doc("<p>Indicates whether the instance type supports AMD SEV-SNP. If the request returns <code>amd-sev-snp</code>, AMD SEV-SNP is supported. Otherwise, it is not supported. For more information, see <a href='https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/sev-snp.html'> AMD SEV-SNP</a>.</p>")
  @extension("x-ms-identifiers", [])
  supportedFeatures?: SupportedAdditionalProcessorFeature[];

  @doc("<p>The speed of the processor, in GHz.</p>")
  sustainedClockSpeedInGhz?: float64;
}

@doc("ArchitectureType enum")
union ArchitectureType {
  @doc("ArchitectureType enum arm64")
  Arm64: "arm64",

  @doc("ArchitectureType enum arm64_mac")
  Arm64_mac: "arm64_mac",

  @doc("ArchitectureType enum i386")
  I386: "i386",

  @doc("ArchitectureType enum x86_64")
  X86_64: "x86_64",

  @doc("ArchitectureType enum x86_64_mac")
  X86_64_mac: "x86_64_mac",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ArchitectureTypeEnumValue")
model ArchitectureTypeEnumValue {
  @doc("Property value")
  value?: ArchitectureType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VCpuInfo")
model VCpuInfo {
  @doc("<p>The default number of cores for the instance type.</p>")
  defaultCores?: int32;

  @doc("<p>The default number of threads per core for the instance type.</p>")
  defaultThreadsPerCore?: int32;

  @doc("<p>The default number of vCPUs for the instance type.</p>")
  defaultVCpus?: int32;

  @doc("<p>The valid number of cores that can be configured for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  validCores?: CoreCount[];

  @doc("<p>The valid number of threads per core that can be configured for the instance type.</p>")
  @extension("x-ms-identifiers", [])
  validThreadsPerCore?: ThreadsPerCore[];
}

@doc("SupportedAdditionalProcessorFeature enum")
union SupportedAdditionalProcessorFeature {
  @doc("SupportedAdditionalProcessorFeature enum amd-sev-snp")
  AmdSevSnp: "amd-sev-snp",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SupportedAdditionalProcessorFeatureEnumValue")
model SupportedAdditionalProcessorFeatureEnumValue {
  @doc("Property value")
  value?: SupportedAdditionalProcessorFeature;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsOptimizedInfo")
model EbsOptimizedInfo {
  @doc("<p>The baseline bandwidth performance for an EBS-optimized instance type, in Mbps.</p>")
  baselineBandwidthInMbps?: int32;

  @doc("<p>The baseline input/output storage operations per seconds for an EBS-optimized instance type.</p>")
  baselineIops?: int32;

  @doc("<p>The baseline throughput performance for an EBS-optimized instance type, in MB/s.</p>")
  baselineThroughputInMBps?: float64;

  @doc("<p>The maximum bandwidth performance for an EBS-optimized instance type, in Mbps.</p>")
  maximumBandwidthInMbps?: int32;

  @doc("<p>The maximum input/output storage operations per second for an EBS-optimized instance type.</p>")
  maximumIops?: int32;

  @doc("<p>The maximum throughput performance for an EBS-optimized instance type, in MB/s.</p>")
  maximumThroughputInMBps?: float64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FpgaDeviceInfo")
model FpgaDeviceInfo {
  @doc("<p>The count of FPGA accelerators for the instance type.</p>")
  count?: int32;

  @doc("<p>The manufacturer of the FPGA accelerator.</p>")
  manufacturer?: string;

  @doc("<p>Describes the memory for the FPGA accelerator for the instance type.</p>")
  memoryInfo?: FpgaDeviceMemoryInfo;

  @doc("<p>The name of the FPGA accelerator.</p>")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GpuDeviceInfo")
model GpuDeviceInfo {
  @doc("<p>The number of GPUs for the instance type.</p>")
  count?: int32;

  @doc("<p>The manufacturer of the GPU accelerator.</p>")
  manufacturer?: string;

  @doc("<p>Describes the memory available to the GPU accelerator.</p>")
  memoryInfo?: GpuDeviceMemoryInfo;

  @doc("<p>The name of the GPU accelerator.</p>")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InferenceDeviceInfo")
model InferenceDeviceInfo {
  @doc("<p>The number of Inference accelerators for the instance type.</p>")
  count?: int32;

  @doc("<p>The manufacturer of the Inference accelerator.</p>")
  manufacturer?: string;

  @doc("<p>Describes the memory available to the inference accelerator.</p>")
  memoryInfo?: InferenceDeviceMemoryInfo;

  @doc("<p>The name of the Inference accelerator.</p>")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DiskInfo")
model DiskInfo {
  @doc("<p>The number of disks with this configuration.</p>")
  count?: int32;

  @doc("<p>The size of the disk in GB.</p>")
  sizeInGB?: int64;

  @doc("<p>The type of disk.</p>")
  type?: DiskTypeEnumValue;
}

@doc("DiskType enum")
union DiskType {
  @doc("DiskType enum hdd")
  Hdd: "hdd",

  @doc("DiskType enum ssd")
  Ssd: "ssd",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DiskTypeEnumValue")
model DiskTypeEnumValue {
  @doc("Property value")
  value?: DiskType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MediaDeviceInfo")
model MediaDeviceInfo {
  @doc("<p>The number of media accelerators for the instance type.</p>")
  count?: int32;

  @doc("<p>The manufacturer of the media accelerator.</p>")
  manufacturer?: string;

  @doc("<p>Describes the memory available to the media accelerator.</p>")
  memoryInfo?: MediaDeviceMemoryInfo;

  @doc("<p>The name of the media accelerator.</p>")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EfaInfo")
model EfaInfo {
  @doc("<p>The maximum number of Elastic Fabric Adapters for the instance type.</p>")
  maximumEfaInterfaces?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkCardInfo")
model NetworkCardInfo {
  @doc("<p>The baseline network performance of the network card, in Gbps.</p>")
  baselineBandwidthInGbps?: float64;

  @doc("<p>The maximum number of network interfaces for the network card.</p>")
  maximumNetworkInterfaces?: int32;

  @doc("<p>The index of the network card.</p>")
  networkCardIndex?: int32;

  @doc("<p>The network performance of the network card.</p>")
  networkPerformance?: string;

  @doc("<p>The peak (burst) network performance of the network card, in Gbps.</p>")
  peakBandwidthInGbps?: float64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NeuronDeviceInfo")
model NeuronDeviceInfo {
  @doc("<p>Describes the cores available to each neuron accelerator.</p>")
  coreInfo?: NeuronDeviceCoreInfo;

  @doc("<p>The number of neuron accelerators for the instance type.</p>")
  count?: int32;

  @doc("<p>Describes the memory available to each neuron accelerator.</p>")
  memoryInfo?: NeuronDeviceMemoryInfo;

  @doc("<p>The name of the neuron accelerator.</p>")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CoreCount")
model CoreCount {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ThreadsPerCore")
model ThreadsPerCore {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FpgaDeviceMemoryInfo")
model FpgaDeviceMemoryInfo {
  @doc("<p>The size of the memory available to the FPGA accelerator, in MiB.</p>")
  sizeInMiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GpuDeviceMemoryInfo")
model GpuDeviceMemoryInfo {
  @doc("<p>The size of the memory available to the GPU accelerator, in MiB.</p>")
  sizeInMiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InferenceDeviceMemoryInfo")
model InferenceDeviceMemoryInfo {
  @doc("<p>The size of the memory available to the inference accelerator, in MiB.</p>")
  sizeInMiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MediaDeviceMemoryInfo")
model MediaDeviceMemoryInfo {
  @doc("<p>The size of the memory available to each media accelerator, in MiB.</p>")
  sizeInMiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NeuronDeviceCoreInfo")
model NeuronDeviceCoreInfo {
  @doc("<p>The number of cores available to the neuron accelerator.</p>")
  count?: int32;

  @doc("<p>The version of the neuron accelerator.</p>")
  version?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NeuronDeviceMemoryInfo")
model NeuronDeviceMemoryInfo {
  @doc("<p>The size of the memory available to the neuron accelerator, in MiB.</p>")
  sizeInMiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2InstanceTypeInfos {
  get is ArmResourceRead<Ec2InstanceTypeInfo>;
  @doc("Create a Ec2InstanceTypeInfo. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2InstanceTypeInfo>;
  update is ArmCustomPatchAsync<
    Ec2InstanceTypeInfo,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2InstanceTypeInfo>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2InstanceTypeInfo>;
  listByResourceGroup is ArmResourceListByParent<Ec2InstanceTypeInfo>;
  listBySubscription is ArmListBySubscription<Ec2InstanceTypeInfo>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: InstanceTypeInfo
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
