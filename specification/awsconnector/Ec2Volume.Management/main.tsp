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

//---------------------------------------------- Ec2Volumes ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Volume",
    plural: "EC2 Volumes",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Volume"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2Volume is TrackedResource<Ec2VolumeProperties> {
  @doc("Name of Ec2Volume")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Volumes")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Volume")
model Ec2VolumeProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2VolumeProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Volume")
model AwsEc2VolumeProperties {
  @doc("Indicates whether the volume is auto-enabled for I/O operations. By default, Amazon EBS disables I/O to the volume from attached EC2 instances when it determines that a volume's data is potentially inconsistent. If the consistency of the volume is not a concern, and you prefer that the volume be made available immediately if it's impaired, you can configure the volume to automatically enable I/O.")
  autoEnableIO?: boolean;

  @doc("The ID of the Availability Zone in which to create the volume. For example, ``us-east-1a``.")
  availabilityZone?: string;

  @doc("Indicates whether the volume should be encrypted. The effect of setting the encryption state to ``true`` depends on the volume origin (new or from a snapshot), starting encryption state, ownership, and whether encryption by default is enabled. For more information, see [Encryption by default](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#encryption-by-default) in the *Amazon Elastic Compute Cloud User Guide*. Encrypted Amazon EBS volumes must be attached to instances that support Amazon EBS encryption. For more information, see [Supported instance types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#EBSEncryption_supported_instances).")
  encrypted?: boolean;

  @doc("The number of I/O operations per second (IOPS). For ``gp3``, ``io1``, and ``io2`` volumes, this represents the number of IOPS that are provisioned for the volume. For ``gp2`` volumes, this represents the baseline performance of the volume and the rate at which the volume accumulates I/O credits for bursting. The following are the supported values for each volume type:  +   ``gp3``: 3,000 - 16,000 IOPS  +   ``io1``: 100 - 64,000 IOPS  +   ``io2``: 100 - 256,000 IOPS   For ``io2`` volumes, you can achieve up to 256,000 IOPS on [instances built on the Nitro System](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#ec2-nitro-instances). On other instances, you can achieve performance up to 32,000 IOPS. This parameter is required for ``io1`` and ``io2`` volumes. The default for ``gp3`` volumes is 3,000 IOPS. This parameter is not supported for ``gp2``, ``st1``, ``sc1``, or ``standard`` volumes.")
  iops?: int32;

  @doc("The identifier of the kms-key-long to use for Amazon EBS encryption. If ``KmsKeyId`` is specified, the encrypted state must be ``true``. If you omit this property and your account is enabled for encryption by default, or *Encrypted* is set to ``true``, then the volume is encrypted using the default key specified for your account. If your account does not have a default key, then the volume is encrypted using the aws-managed-key. Alternatively, if you want to specify a different key, you can specify one of the following:  +  Key ID. For example, 1234abcd-12ab-34cd-56ef-1234567890ab.  +  Key alias. Specify the alias for the key, prefixed with ``alias/``. For example, for a key with the alias ``my_cmk``, use ``alias/my_cmk``. Or to specify the aws-managed-key, use ``alias/aws/ebs``.  +  Key ARN. For example, arn:aws:kms:us-east-1:012345678910:key/1234abcd-12ab-34cd-56ef-1234567890ab.  +  Alias ARN. For example, arn:aws:kms:us-east-1:012345678910:alias/ExampleAlias.")
  kmsKeyId?: string;

  @doc("Indicates whether Amazon EBS Multi-Attach is enabled. CFNlong does not currently support updating a single-attach volume to be multi-attach enabled, updating a multi-attach enabled volume to be single-attach, or updating the size or number of I/O operations per second (IOPS) of a multi-attach enabled volume.")
  multiAttachEnabled?: boolean;

  @doc("The Amazon Resource Name (ARN) of the Outpost.")
  outpostArn?: string;

  @doc("The size of the volume, in GiBs. You must specify either a snapshot ID or a volume size. If you specify a snapshot, the default is the snapshot size. You can specify a volume size that is equal to or larger than the snapshot size. The following are the supported volumes sizes for each volume type:  +   ``gp2`` and ``gp3``: 1 - 16,384 GiB  +   ``io1``: 4 - 16,384 GiB  +   ``io2``: 4 - 65,536 GiB  +   ``st1`` and ``sc1``: 125 - 16,384 GiB  +   ``standard``: 1 - 1024 GiB")
  size?: int32;

  @doc("The snapshot from which to create the volume. You must specify either a snapshot ID or a volume size.")
  snapshotId?: string;

  @doc("The tags to apply to the volume during creation.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The throughput to provision for a volume, with a maximum of 1,000 MiB/s. This parameter is valid only for ``gp3`` volumes. The default value is 125. Valid Range: Minimum value of 125. Maximum value of 1000.")
  throughput?: int32;

  @doc("Property volumeId")
  volumeId?: string;

  @doc("The volume type. This parameter can be one of the following values:  +  General Purpose SSD: ``gp2`` | ``gp3``   +  Provisioned IOPS SSD: ``io1`` | ``io2``   +  Throughput Optimized HDD: ``st1``   +  Cold HDD: ``sc1``   +  Magnetic: ``standard``    For more information, see [Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html) in the *Amazon Elastic Compute Cloud User Guide*. Default: ``gp2``")
  volumeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The tag key.")
  key?: string;

  @doc("The tag value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2Volumes {
  get is ArmResourceRead<Ec2Volume>;
  @doc("Create a Ec2Volume. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2Volume>;
  update is ArmCustomPatchAsync<
    Ec2Volume,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2Volume>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Volume>;
  listByResourceGroup is ArmResourceListByParent<Ec2Volume>;
  listBySubscription is ArmListBySubscription<Ec2Volume>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::Volume
//--------------------------------------------------------------------------------------------
