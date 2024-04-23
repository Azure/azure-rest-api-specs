import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- IamGroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model IamGroup is TrackedResource<IamGroupProperties> {
  @doc("Name of IamGroup")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamGroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamGroup")
model IamGroupProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsIamGroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamGroup")
model AwsIamGroupProperties {
  @doc("Gets and sets the property arn. The Arn of the group to create")
  arn?: string;

  @doc("Gets and sets the property groupName. The name of the group to create")
  groupName?: string;

  @doc("Gets and sets the property managedPolicyArns. A list of Amazon Resource Names (ARNs) of the IAM managed policies that you want to attach to the role. ")
  @extension("x-ms-identifiers", [])
  managedPolicyArns?: string[];

  @doc("Gets and sets the property path. The path to the group")
  path?: string;

  @doc("Gets and sets the property policies. Adds or updates an inline policy document that is embedded in the specified IAM group")
  @extension("x-ms-identifiers", [])
  policies?: Policy[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Policy")
model Policy {
  @doc("Gets and sets the property policyDocument. The policy document.")
  policyDocument?: string;

  @doc("Gets and sets the property policyName. The friendly name (not ARN) identifying the policy.")
  policyName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamGroups {
  get is ArmResourceRead<IamGroup>;
  @doc("Create a IamGroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IamGroup>;
  update is ArmCustomPatchAsync<
    IamGroup,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamGroup>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamGroup>;
  listByResourceGroup is ArmResourceListByParent<IamGroup>;
  listBySubscription is ArmListBySubscription<IamGroup>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::IAM::Group
//--------------------------------------------------------------------------------------------
