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
  version: "2023-12-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AwsConnector;

//---------------------------------------------- S3Buckets ----------------------------------------------
@doc("A Microsoft.AwsConnector resource")
model S3Bucket is TrackedResource<S3BucketProperties> {
  @doc("Name of S3Bucket")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3Buckets")
  name: string;
}

@doc("Definition of S3Bucket")
model S3BucketProperties extends AwsCommonProperties {
  @doc("Gets and sets the property awsProperties. ")
  awsProperties?: AwsS3BucketProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsS3Bucket")
model AwsS3BucketProperties {
  @doc("Gets and sets the property creationDate. <p>Date the bucket was created. This date can change when making changes to your bucket, such as editing its bucket policy.</p>")
  creationDate?: utcDateTime;

  @doc("Gets and sets the property bucketName. <p>The name of the bucket.</p>")
  bucketName?: string;
}

@armResourceOperations
interface S3Buckets {
  get is ArmResourceRead<S3Bucket>;
  @doc("Create a S3Bucket. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<S3Bucket>;
  update is ArmCustomPatchAsync<
    S3Bucket,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3Bucket>
  >;
  delete is ArmResourceDeleteAsync<S3Bucket>;
  listByResourceGroup is ArmResourceListByParent<S3Bucket>;
  listBySubscription is ArmListBySubscription<S3Bucket>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2TypeSpec.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\s3\s3-2006-03-01.normal.json
// AWS Shape: Bucket
//
// Related information for backend service:
// AWS Servcie : S3
// SDK Version : 3.7.200.1
//--------------------------------------------------------------------------------------------
