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

//---------------------------------------------- LambdaPermissions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LambdaPermission is TrackedResource<LambdaPermissionProperties> {
  @doc("Name of LambdaPermission")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("lambdaPermissions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of LambdaPermission")
model LambdaPermissionProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLambdaPermissionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsLambdaPermission")
model AwsLambdaPermissionProperties {
  @doc("Gets and sets the property action. The action that the principal can use on the function.")
  action?: string;

  @doc("Gets and sets the property eventSourceToken. For Alexa Smart Home functions, a token that must be supplied by the invoker.")
  eventSourceToken?: string;

  @doc("Gets and sets the property functionName. The name of the Lambda function, version, or alias.")
  functionName?: string;

  @doc("Gets and sets the property functionUrlAuthType. The type of authentication that your function URL uses. Set to AWS_IAM if you want to restrict access to authenticated users only. Set to NONE if you want to bypass IAM authentication to create a public endpoint.")
  functionUrlAuthType?: FunctionUrlAuthType;

  @doc("Gets and sets the property id. A statement identifier that differentiates the statement from others in the same policy.")
  id?: string;

  @doc("Gets and sets the property principal. The AWS service or account that invokes the function. If you specify a service, use SourceArn or SourceAccount to limit who can invoke the function through that service.")
  principal?: string;

  @doc("Gets and sets the property principalOrgID. The identifier for your organization in AWS Organizations. Use this to grant permissions to all the AWS accounts under this organization.")
  principalOrgID?: string;

  @doc("Gets and sets the property sourceAccount. For Amazon S3, the ID of the account that owns the resource. Use this together with SourceArn to ensure that the resource is owned by the specified account. It is possible for an Amazon S3 bucket to be deleted by its owner and recreated by another account.")
  sourceAccount?: string;

  @doc("Gets and sets the property sourceArn. For AWS services, the ARN of the AWS resource that invokes the function. For example, an Amazon S3 bucket or Amazon SNS topic.")
  sourceArn?: string;
}

@doc("FunctionUrlAuthType enum")
enum FunctionUrlAuthType {
  @doc("FunctionUrlAuthType enum AWS_IAM")
  AWS_IAM: "AWS_IAM",

  @doc("FunctionUrlAuthType enum NONE")
  NONE: "NONE",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LambdaPermissions {
  get is ArmResourceRead<LambdaPermission>;
  @doc("Create a LambdaPermission. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LambdaPermission>;
  update is ArmCustomPatchAsync<
    LambdaPermission,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LambdaPermission>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LambdaPermission>;
  listByResourceGroup is ArmResourceListByParent<LambdaPermission>;
  listBySubscription is ArmListBySubscription<LambdaPermission>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Lambda::Permission
//--------------------------------------------------------------------------------------------
