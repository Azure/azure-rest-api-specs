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

//---------------------------------------------- S3BucketPolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "S3 Get Bucket Policy Output",
    plural: "S3 Bucket Policies",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "S3",
    "Get",
    "Bucket",
    "Policy",
    "Output"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model S3BucketPolicy is TrackedResource<S3BucketPolicyProperties> {
  @doc("Name of S3BucketPolicy")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3BucketPolicies")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3BucketPolicy")
model S3BucketPolicyProperties {
  @doc("AWS Properties")
  awsProperties?: AwsS3BucketPolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3BucketPolicy")
model AwsS3BucketPolicyProperties {
  @doc("<p>The bucket policy as a JSON document.</p>")
  policy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3BucketPolicies {
  get is ArmResourceRead<S3BucketPolicy>;
  @doc("Create a S3BucketPolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<S3BucketPolicy>;
  update is ArmCustomPatchAsync<
    S3BucketPolicy,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3BucketPolicy>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<S3BucketPolicy>;
  listByResourceGroup is ArmResourceListByParent<S3BucketPolicy>;
  listBySubscription is ArmListBySubscription<S3BucketPolicy>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\s3\s3-2006-03-01.normal.json
// AWS Shape: GetBucketPolicyOutput
//
// Related information for backend service:
// AWS Servcie : S3
// Product Version : 3.7.798.0
// SDK Version : 3.7.307.24
//--------------------------------------------------------------------------------------------
