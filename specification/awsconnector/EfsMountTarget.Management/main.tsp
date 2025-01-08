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

//---------------------------------------------- EfsMountTargets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EFS Mount Target",
    plural: "EFS Mount Targets",
  },
  keywords: ["Microsoft.AwsConnector", "EFS", "Mount", "Target"],
})
@doc("A Microsoft.AwsConnector resource")
model EfsMountTarget is TrackedResource<EfsMountTargetProperties> {
  @doc("Name of EfsMountTarget")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("efsMountTargets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EfsMountTarget")
model EfsMountTargetProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEfsMountTargetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEfsMountTarget")
model AwsEfsMountTargetProperties {
  @doc("The ID of the file system for which to create the mount target.")
  fileSystemId?: string;

  @doc("Property id")
  id?: string;

  @doc("Valid IPv4 address within the address range of the specified subnet.")
  ipAddress?: string;

  @doc("Up to five VPC security group IDs, of the form ``sg-xxxxxxxx``. These must be for the same VPC as subnet specified.")
  @extension("x-ms-identifiers", [])
  securityGroups?: string[];

  @doc("The ID of the subnet to add the mount target in. For One Zone file systems, use the subnet that is associated with the file system's Availability Zone.")
  subnetId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EfsMountTargets {
  get is ArmResourceRead<EfsMountTarget>;
  @doc("Create a EfsMountTarget. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EfsMountTarget>;
  update is ArmCustomPatchAsync<
    EfsMountTarget,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EfsMountTarget>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EfsMountTarget>;
  listByResourceGroup is ArmResourceListByParent<EfsMountTarget>;
  listBySubscription is ArmListBySubscription<EfsMountTarget>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EFS::MountTarget
//--------------------------------------------------------------------------------------------
