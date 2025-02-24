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

//---------------------------------------------- Ec2Snapshots ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Snapshot",
    plural: "EC2 Snapshots",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Snapshot"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2Snapshot is TrackedResource<Ec2SnapshotProperties> {
  @doc("Name of Ec2Snapshot")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Snapshots")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Snapshot")
model Ec2SnapshotProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2SnapshotProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Snapshot")
model AwsEc2SnapshotProperties {
  @doc("<p>The data encryption key identifier for the snapshot. This value is a unique identifier that corresponds to the data encryption key that was used to encrypt the original volume or snapshot copy. Because data encryption keys are inherited by volumes created from snapshots, and vice versa, if snapshots share the same data encryption key identifier, then they belong to the same volume/snapshot lineage. This parameter is only returned by <a>DescribeSnapshots</a>.</p>")
  dataEncryptionKeyId?: string;

  @doc("<p>The description for the snapshot.</p>")
  description?: string;

  @doc("<p>Indicates whether the snapshot is encrypted.</p>")
  encrypted?: boolean;

  @doc("<p>The Amazon Resource Name (ARN) of the Key Management Service (KMS) KMS key that was used to protect the volume encryption key for the parent volume.</p>")
  kmsKeyId?: string;

  @doc("<p>The ARN of the Outpost on which the snapshot is stored. For more information, see <a href='https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html'>Amazon EBS local snapshots on Outposts</a> in the <i>Amazon EBS User Guide</i>.</p>")
  outpostArn?: string;

  @doc("<p>The Amazon Web Services owner alias, from an Amazon-maintained list (<code>amazon</code>). This is not the user-configured Amazon Web Services account alias set using the IAM console.</p>")
  ownerAlias?: string;

  @doc("<p>The ID of the Amazon Web Services account that owns the EBS snapshot.</p>")
  ownerId?: string;

  @doc("<p>The progress of the snapshot, as a percentage.</p>")
  progress?: string;

  @doc("<p>Only for archived snapshots that are temporarily restored. Indicates the date and time when a temporarily restored snapshot will be automatically re-archived.</p>")
  restoreExpiryTime?: utcDateTime;

  @doc("<p>The ID of the snapshot. Each snapshot receives a unique identifier when it is created.</p>")
  snapshotId?: string;

  @doc("<p>Reserved for future use.</p>")
  sseType?: SSETypeEnumValue;

  @doc("<p>The time stamp when the snapshot was initiated.</p>")
  startTime?: utcDateTime;

  @doc("<p>The snapshot state.</p>")
  state?: SnapshotStateEnumValue;

  @doc("<p>Encrypted Amazon EBS snapshots are copied asynchronously. If a snapshot copy operation fails (for example, if the proper Key Management Service (KMS) permissions are not obtained) this field displays error state details to help you diagnose why the error occurred. This parameter is only returned by <a>DescribeSnapshots</a>.</p>")
  stateMessage?: string;

  @doc("<p>The storage tier in which the snapshot is stored. <code>standard</code> indicates that the snapshot is stored in the standard snapshot storage tier and that it is ready for use. <code>archive</code> indicates that the snapshot is currently archived and that it must be restored before it can be used.</p>")
  storageTier?: StorageTierEnumValue;

  @doc("<p>Any tags assigned to the snapshot.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("<p>The ID of the volume that was used to create the snapshot. Snapshots created by the <a>CopySnapshot</a> action have an arbitrary volume ID that should not be used for any purpose.</p>")
  volumeId?: string;

  @doc("<p>The size of the volume, in GiB.</p>")
  volumeSize?: int32;
}

@doc("SSEType enum")
union SSEType {
  @doc("SSEType enum none")
  None: "none",

  @doc("SSEType enum sse-ebs")
  SseEbs: "sse-ebs",

  @doc("SSEType enum sse-kms")
  SseKms: "sse-kms",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SSETypeEnumValue")
model SSETypeEnumValue {
  @doc("Property value")
  value?: SSEType;
}

@doc("StorageTier enum")
union StorageTier {
  @doc("StorageTier enum archive")
  Archive: "archive",

  @doc("StorageTier enum standard")
  Standard: "standard",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StorageTierEnumValue")
model StorageTierEnumValue {
  @doc("Property value")
  value?: StorageTier;
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

@doc("SnapshotState enum")
union SnapshotState {
  @doc("SnapshotState enum completed")
  Completed: "completed",

  @doc("SnapshotState enum error")
  Error: "error",

  @doc("SnapshotState enum pending")
  Pending: "pending",

  @doc("SnapshotState enum recoverable")
  Recoverable: "recoverable",

  @doc("SnapshotState enum recovering")
  Recovering: "recovering",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnapshotStateEnumValue")
model SnapshotStateEnumValue {
  @doc("Property value")
  value?: SnapshotState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2Snapshots {
  get is ArmResourceRead<Ec2Snapshot>;
  @doc("Create a Ec2Snapshot. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2Snapshot>;
  update is ArmCustomPatchAsync<
    Ec2Snapshot,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2Snapshot>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Snapshot>;
  listByResourceGroup is ArmResourceListByParent<Ec2Snapshot>;
  listBySubscription is ArmListBySubscription<Ec2Snapshot>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: Snapshot
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
