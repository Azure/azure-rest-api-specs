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

//---------------------------------------------- SageMakerImages ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model SageMakerImage is TrackedResource<SageMakerImageProperties> {
  @doc("Name of SageMakerImage")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("sageMakerImages")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of SageMakerImage")
model SageMakerImageProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsSageMakerImageProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsSageMakerImage")
model AwsSageMakerImageProperties {
  @doc("Gets and sets the property imageArn. The Amazon Resource Name (ARN) of the image.")
  imageArn?: string;

  @doc("Gets and sets the property imageDescription. A description of the image.")
  imageDescription?: string;

  @doc("Gets and sets the property imageDisplayName. The display name of the image.")
  imageDisplayName?: string;

  @doc("Gets and sets the property imageName. The name of the image.")
  imageName?: string;

  @doc("Gets and sets the property imageRoleArn. The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker to perform tasks on behalf of the customer.")
  imageRoleArn?: string;

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 127 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -. ")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 1 to 255 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -. ")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SageMakerImages {
  get is ArmResourceRead<SageMakerImage>;
  @doc("Create a SageMakerImage. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SageMakerImage>;
  update is ArmCustomPatchAsync<
    SageMakerImage,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SageMakerImage>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SageMakerImage>;
  listByResourceGroup is ArmResourceListByParent<SageMakerImage>;
  listBySubscription is ArmListBySubscription<SageMakerImage>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SageMaker::Image
//--------------------------------------------------------------------------------------------
