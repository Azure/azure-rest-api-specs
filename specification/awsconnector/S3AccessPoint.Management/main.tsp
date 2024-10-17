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

//---------------------------------------------- S3AccessPoints ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "S3 Access Point",
    plural: "S3 Access Points",
  },
  keywords: ["Microsoft.AwsConnector", "S3", "Access", "Point"],
})
@doc("A Microsoft.AwsConnector resource")
model S3AccessPoint is TrackedResource<S3AccessPointProperties> {
  @doc("Name of S3AccessPoint")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3AccessPoints")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3AccessPoint")
model S3AccessPointProperties {
  @doc("AWS Properties")
  awsProperties?: AwsS3AccessPointProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3AccessPoint")
model AwsS3AccessPointProperties {
  @doc("The alias of this Access Point. This alias can be used for compatibility purposes with other AWS services and third-party applications.")
  `alias`?: string;

  @doc("The Amazon Resource Name (ARN) of the specified accesspoint. the Amazon Resource Name (ARN) of the specified accesspoint.")
  arn?: string;

  @doc("The name of the bucket that you want to associate this Access Point with.")
  bucket?: string;

  @doc("The AWS account ID associated with the S3 bucket associated with this access point.")
  bucketAccountId?: string;

  @doc("The name you want to assign to this Access Point. If you don't specify a name, AWS CloudFormation generates a unique ID and uses that ID for the access point name.")
  name?: string;

  @doc("Indicates whether this Access Point allows access from the public Internet. If VpcConfiguration is specified for this Access Point, then NetworkOrigin is VPC, and the Access Point doesn't allow access from the public Internet. Otherwise, NetworkOrigin is Internet, and the Access Point allows access from the public Internet, subject to the Access Point and bucket access policies.")
  networkOrigin?: NetworkOrigin;

  @doc("The Access Point Policy you want to apply to this access point.")
  policy?: unknown;

  @doc("The PublicAccessBlock configuration that you want to apply to this Access Point. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status 'The Meaning of Public' in the Amazon Simple Storage Service Developer Guide.")
  publicAccessBlockConfiguration?: PublicAccessBlockConfiguration;

  @doc("If you include this field, Amazon S3 restricts access to this Access Point to requests from the specified Virtual Private Cloud (VPC). The Virtual Private Cloud (VPC) configuration for a bucket access point.")
  vpcConfiguration?: VpcConfiguration;
}

@doc("NetworkOrigin enum")
union NetworkOrigin {
  @doc("NetworkOrigin enum Internet")
  Internet: "Internet",

  @doc("NetworkOrigin enum VPC")
  VPC: "VPC",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PublicAccessBlockConfiguration")
model PublicAccessBlockConfiguration {
  @doc("Specifies whether Amazon S3 should block public access control lists (ACLs) for buckets in this account. Setting this element to TRUE causes the following behavior:- PUT Bucket acl and PUT Object acl calls fail if the specified ACL is public. - PUT Object calls fail if the request includes a public ACL.. - PUT Bucket calls fail if the request includes a public ACL.Enabling this setting doesn't affect existing policies or ACLs.")
  blockPublicAcls?: boolean;

  @doc("Specifies whether Amazon S3 should block public bucket policies for buckets in this account. Setting this element to TRUE causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access. Enabling this setting doesn't affect existing bucket policies.")
  blockPublicPolicy?: boolean;

  @doc("Specifies whether Amazon S3 should ignore public ACLs for buckets in this account. Setting this element to TRUE causes Amazon S3 to ignore all public ACLs on buckets in this account and any objects that they contain. Enabling this setting doesn't affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set.")
  ignorePublicAcls?: boolean;

  @doc("Specifies whether Amazon S3 should restrict public bucket policies for this bucket. Setting this element to TRUE restricts access to this bucket to only AWS services and authorized users within this account if the bucket has a public policy.Enabling this setting doesn't affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked.")
  restrictPublicBuckets?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VpcConfiguration")
model VpcConfiguration {
  @doc("If this field is specified, this access point will only allow connections from the specified VPC ID.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3AccessPoints {
  get is ArmResourceRead<S3AccessPoint>;
  @doc("Create a S3AccessPoint. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<S3AccessPoint>;
  update is ArmCustomPatchAsync<
    S3AccessPoint,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3AccessPoint>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<S3AccessPoint>;
  listByResourceGroup is ArmResourceListByParent<S3AccessPoint>;
  listBySubscription is ArmListBySubscription<S3AccessPoint>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::S3::AccessPoint
//--------------------------------------------------------------------------------------------
