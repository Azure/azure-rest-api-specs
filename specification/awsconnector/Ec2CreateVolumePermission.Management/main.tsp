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

//---------------------------------------------- Ec2CreateVolumePermissions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Create Volume Permission",
    plural: "EC2 Create Volume Permissions",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Create", "Volume", "Permission"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2CreateVolumePermission
  is TrackedResource<Ec2CreateVolumePermissionProperties> {
  @doc("Name of Ec2CreateVolumePermission")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2CreateVolumePermissions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2CreateVolumePermission")
model Ec2CreateVolumePermissionProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2CreateVolumePermissionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2CreateVolumePermission")
model AwsEc2CreateVolumePermissionProperties {
  @doc("<p>The group to be added or removed. The possible value is <code>all</code>.</p>")
  group?: PermissionGroupEnumValue;

  @doc("<p>The ID of the Amazon Web Services account to be added or removed.</p>")
  userId?: string;
}

@doc("PermissionGroup enum")
union PermissionGroup {
  @doc("PermissionGroup enum all")
  All: "all",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PermissionGroupEnumValue")
model PermissionGroupEnumValue {
  @doc("Property value")
  value?: PermissionGroup;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2CreateVolumePermissions {
  get is ArmResourceRead<Ec2CreateVolumePermission>;
  @doc("Create a Ec2CreateVolumePermission. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2CreateVolumePermission>;
  update is ArmCustomPatchAsync<
    Ec2CreateVolumePermission,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2CreateVolumePermission>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2CreateVolumePermission>;
  listByResourceGroup is ArmResourceListByParent<Ec2CreateVolumePermission>;
  listBySubscription is ArmListBySubscription<Ec2CreateVolumePermission>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: CreateVolumePermission
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
