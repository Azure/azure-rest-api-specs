import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- LightsailBuckets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LightsailBucket is TrackedResource<LightsailBucketProperties> {
  @doc("Name of LightsailBucket")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("lightsailBuckets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of LightsailBucket")
model LightsailBucketProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLightsailBucketProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsLightsailBucket")
model AwsLightsailBucketProperties {
  @doc("Gets and sets the property ableToUpdateBundle. Indicates whether the bundle that is currently applied to a bucket can be changed to another bundle. You can update a bucket's bundle only one time within a monthly AWS billing cycle.")
  ableToUpdateBundle?: boolean;

  @doc("Gets and sets the property accessRules. An object that sets the public accessibility of objects in the specified bucket.")
  accessRules?: AccessRules;

  @doc("Gets and sets the property bucketArn.")
  bucketArn?: string;

  @doc("Gets and sets the property bucketName. The name for the bucket.")
  bucketName?: string;

  @doc("Gets and sets the property bundleId. The ID of the bundle to use for the bucket.")
  bundleId?: string;

  @doc("Gets and sets the property objectVersioning. Specifies whether to enable or disable versioning of objects in the bucket.")
  objectVersioning?: boolean;

  @doc("Gets and sets the property readOnlyAccessAccounts. An array of strings to specify the AWS account IDs that can access the bucket.")
  @extension("x-ms-identifiers", [])
  readOnlyAccessAccounts?: string[];

  @doc("Gets and sets the property resourcesReceivingAccess. The names of the Lightsail resources for which to set bucket access.")
  @extension("x-ms-identifiers", [])
  resourcesReceivingAccess?: string[];

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property url. The URL of the bucket.")
  url?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of AccessRules")
model AccessRules {
  @doc("Gets and sets the property allowPublicOverrides. A Boolean value that indicates whether the access control list (ACL) permissions that are applied to individual objects override the getObject option that is currently specified.")
  allowPublicOverrides?: boolean;

  @doc("Gets and sets the property getObject. Specifies the anonymous access to all objects in a bucket.")
  getObject?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LightsailBuckets {
  get is ArmResourceRead<LightsailBucket>;
  @doc("Create a LightsailBucket. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LightsailBucket>;
  update is ArmCustomPatchAsync<
    LightsailBucket,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LightsailBucket>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LightsailBucket>;
  listByResourceGroup is ArmResourceListByParent<LightsailBucket>;
  listBySubscription is ArmListBySubscription<LightsailBucket>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Lightsail::Bucket
//--------------------------------------------------------------------------------------------
