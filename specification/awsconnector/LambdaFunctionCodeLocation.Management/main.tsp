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

//---------------------------------------------- LambdaFunctionCodeLocations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Lambda Function Code Location",
    plural: "Lambda Function Code Locations",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Lambda",
    "Function",
    "Code",
    "Location"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model LambdaFunctionCodeLocation
  is TrackedResource<LambdaFunctionCodeLocationProperties> {
  @doc("Name of LambdaFunctionCodeLocation")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("lambdaFunctionCodeLocations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaFunctionCodeLocation")
model LambdaFunctionCodeLocationProperties {
  @doc("AWS Properties")
  awsProperties?: AwsLambdaFunctionCodeLocationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLambdaFunctionCodeLocation")
model AwsLambdaFunctionCodeLocationProperties {
  @doc("<p>URI of a container image in the Amazon ECR registry.</p>")
  imageUri?: string;

  @doc("<p>A presigned URL that you can use to download the deployment package.</p>")
  location?: string;

  @doc("<p>The service that's hosting the file.</p>")
  repositoryType?: string;

  @doc("<p>The resolved URI for the image.</p>")
  resolvedImageUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LambdaFunctionCodeLocations {
  get is ArmResourceRead<LambdaFunctionCodeLocation>;
  @doc("Create a LambdaFunctionCodeLocation. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<LambdaFunctionCodeLocation>;
  update is ArmCustomPatchAsync<
    LambdaFunctionCodeLocation,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LambdaFunctionCodeLocation>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LambdaFunctionCodeLocation>;
  listByResourceGroup is ArmResourceListByParent<LambdaFunctionCodeLocation>;
  listBySubscription is ArmListBySubscription<LambdaFunctionCodeLocation>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\lambda\lambda-2015-03-31.normal.json
// AWS Shape: FunctionCodeLocation
//
// Related information for backend service:
// AWS Servcie : Lambda
// Product Version : 3.7.798.0
// SDK Version : 3.7.305.15
//--------------------------------------------------------------------------------------------
