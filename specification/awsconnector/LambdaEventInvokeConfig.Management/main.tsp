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

//---------------------------------------------- LambdaEventInvokeConfigs ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LambdaEventInvokeConfig
  is TrackedResource<LambdaEventInvokeConfigProperties> {
  @doc("Name of LambdaEventInvokeConfig")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("lambdaEventInvokeConfigs")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of LambdaEventInvokeConfig")
model LambdaEventInvokeConfigProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLambdaEventInvokeConfigProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsLambdaEventInvokeConfig")
model AwsLambdaEventInvokeConfigProperties {
  @doc("Gets and sets the property destinationConfig. A destination for events after they have been sent to a function for processing.")
  destinationConfig?: DestinationConfig;

  @doc("Gets and sets the property functionName. The name of the Lambda function.")
  functionName?: string;

  @doc("Gets and sets the property maximumEventAgeInSeconds. The maximum age of a request that Lambda sends to a function for processing.")
  maximumEventAgeInSeconds?: int32;

  @doc("Gets and sets the property maximumRetryAttempts. The maximum number of times to retry when the function returns an error.")
  maximumRetryAttempts?: int32;

  @doc("Gets and sets the property qualifier. The identifier of a version or alias.")
  qualifier?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of DestinationConfig")
model DestinationConfig {
  @doc("Gets and sets the property onFailure. The destination configuration for failed invocations.")
  onFailure?: OnFailure;

  @doc("Gets and sets the property onSuccess. The destination configuration for successful invocations.")
  onSuccess?: OnSuccess;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of OnFailure")
model OnFailure {
  @doc("Gets and sets the property destination. The Amazon Resource Name (ARN) of the destination resource.")
  destination?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of OnSuccess")
model OnSuccess {
  @doc("Gets and sets the property destination. The Amazon Resource Name (ARN) of the destination resource.")
  destination?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LambdaEventInvokeConfigs {
  get is ArmResourceRead<LambdaEventInvokeConfig>;
  @doc("Create a LambdaEventInvokeConfig. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LambdaEventInvokeConfig>;
  update is ArmCustomPatchAsync<
    LambdaEventInvokeConfig,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LambdaEventInvokeConfig>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LambdaEventInvokeConfig>;
  listByResourceGroup is ArmResourceListByParent<LambdaEventInvokeConfig>;
  listBySubscription is ArmListBySubscription<LambdaEventInvokeConfig>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Lambda::EventInvokeConfig
//--------------------------------------------------------------------------------------------
