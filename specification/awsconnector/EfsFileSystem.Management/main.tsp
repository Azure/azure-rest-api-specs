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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- EfsFileSystems ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model EfsFileSystem is TrackedResource<EfsFileSystemProperties> {
  @doc("Name of EfsFileSystem")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("efsFileSystems")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EfsFileSystem")
model EfsFileSystemProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEfsFileSystemProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEfsFileSystem")
model AwsEfsFileSystemProperties {
  @doc("Gets and sets the property arn.")
  arn?: string;

  @doc("Gets and sets the property availabilityZoneName.")
  availabilityZoneName?: string;

  @doc("Gets and sets the property backupPolicy.")
  backupPolicy?: BackupPolicy;

  @doc("Gets and sets the property bypassPolicyLockoutSafetyCheck. Whether to bypass the FileSystemPolicy lockout safety check. The policy lockout safety check determines whether the policy in the request will prevent the principal making the request to be locked out from making future PutFileSystemPolicy requests on the file system. Set BypassPolicyLockoutSafetyCheck to True only when you intend to prevent the principal that is making the request from making a subsequent PutFileSystemPolicy request on the file system. Defaults to false")
  bypassPolicyLockoutSafetyCheck?: boolean;

  @doc("Gets and sets the property encrypted.")
  encrypted?: boolean;

  @doc("Gets and sets the property fileSystemId.")
  fileSystemId?: string;

  @doc("Gets and sets the property fileSystemPolicy.")
  fileSystemPolicy?: unknown;

  @doc("Gets and sets the property fileSystemProtection.")
  fileSystemProtection?: FileSystemProtection;

  @doc("Gets and sets the property fileSystemTags.")
  @extension("x-ms-identifiers", [])
  fileSystemTags?: ElasticFileSystemTag[];

  @doc("Gets and sets the property kmsKeyId.")
  kmsKeyId?: string;

  @doc("Gets and sets the property lifecyclePolicies.")
  @extension("x-ms-identifiers", [])
  lifecyclePolicies?: LifecyclePolicy[];

  @doc("Gets and sets the property performanceMode.")
  performanceMode?: string;

  @doc("Gets and sets the property provisionedThroughputInMibps.")
  provisionedThroughputInMibps?: int32;

  @doc("Gets and sets the property replicationConfiguration.")
  replicationConfiguration?: ReplicationConfiguration;

  @doc("Gets and sets the property throughputMode.")
  throughputMode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BackupPolicy")
model BackupPolicy {
  @doc("Gets and sets the property status.")
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FileSystemProtection")
model FileSystemProtection {
  @doc("Gets and sets the property replicationOverwriteProtection.")
  replicationOverwriteProtection?: FileSystemProtectionReplicationOverwriteProtection;
}

@doc("FileSystemProtectionReplicationOverwriteProtection enum")
union FileSystemProtectionReplicationOverwriteProtection {
  @doc("FileSystemProtectionReplicationOverwriteProtection enum DISABLED")
  DISABLED: "DISABLED",

  @doc("FileSystemProtectionReplicationOverwriteProtection enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticFileSystemTag")
model ElasticFileSystemTag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LifecyclePolicy")
model LifecyclePolicy {
  @doc("Gets and sets the property transitionToArchive.")
  transitionToArchive?: string;

  @doc("Gets and sets the property transitionToIA.")
  transitionToIA?: string;

  @doc("Gets and sets the property transitionToPrimaryStorageClass.")
  transitionToPrimaryStorageClass?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationConfiguration")
model ReplicationConfiguration {
  @doc("Gets and sets the property destinations.")
  @extension("x-ms-identifiers", [])
  destinations?: ReplicationDestination[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationDestination")
model ReplicationDestination {
  @doc("Gets and sets the property availabilityZoneName.")
  availabilityZoneName?: string;

  @doc("Gets and sets the property fileSystemId.")
  fileSystemId?: string;

  @doc("Gets and sets the property kmsKeyId.")
  kmsKeyId?: string;

  @doc("Gets and sets the property region.")
  region?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EfsFileSystems {
  get is ArmResourceRead<EfsFileSystem>;
  @doc("Create a EfsFileSystem. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EfsFileSystem>;
  update is ArmCustomPatchAsync<
    EfsFileSystem,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EfsFileSystem>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EfsFileSystem>;
  listByResourceGroup is ArmResourceListByParent<EfsFileSystem>;
  listBySubscription is ArmListBySubscription<EfsFileSystem>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EFS::FileSystem
//--------------------------------------------------------------------------------------------
