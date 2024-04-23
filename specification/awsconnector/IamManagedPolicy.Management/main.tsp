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

//---------------------------------------------- IamManagedPolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model IamManagedPolicy is TrackedResource<IamManagedPolicyProperties> {
  @doc("Name of IamManagedPolicy")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamManagedPolicies")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamManagedPolicy")
model IamManagedPolicyProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsIamManagedPolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamManagedPolicy")
model AwsIamManagedPolicyProperties {
  @doc("Gets and sets the property attachmentCount. The number of entities (users, groups, and roles) that the policy is attached to.")
  attachmentCount?: int32;

  @doc("Gets and sets the property createDate. The date and time, in ISO 8601 date-time format, when the policy was created.")
  createDate?: string;

  @doc("Gets and sets the property defaultVersionId. The identifier for the version of the policy that is set as the default version.")
  defaultVersionId?: string;

  @doc("Gets and sets the property description. A friendly description of the policy.")
  description?: string;

  @doc("Gets and sets the property groups. The name (friendly name, not ARN) of the group to attach the policy to.")
  @extension("x-ms-identifiers", [])
  groups?: string[];

  @doc("Gets and sets the property isAttachable. Specifies whether the policy can be attached to an IAM user, group, or role.")
  isAttachable?: boolean;

  @doc("Gets and sets the property managedPolicyName. The friendly name of the policy.")
  managedPolicyName?: string;

  @doc("Gets and sets the property path. The path for the policy.")
  path?: string;

  @doc("Gets and sets the property permissionsBoundaryUsageCount. The number of entities (users and roles) for which the policy is used to set the permissions boundary.")
  permissionsBoundaryUsageCount?: int32;

  @doc("Gets and sets the property policyArn. Amazon Resource Name (ARN) of the managed policy")
  policyArn?: string;

  @doc("Gets and sets the property policyDocument. The JSON policy document that you want to use as the content for the new policy.")
  policyDocument?: string;

  @doc("Gets and sets the property policyId. The stable and unique string identifying the policy.")
  policyId?: string;

  @doc("Gets and sets the property roles. The name (friendly name, not ARN) of the role to attach the policy to.")
  @extension("x-ms-identifiers", [])
  roles?: string[];

  @doc("Gets and sets the property updateDate. The date and time, in ISO 8601 date-time format, when the policy was last updated.")
  updateDate?: string;

  @doc("Gets and sets the property users. The name (friendly name, not ARN) of the IAM user to attach the policy to.")
  @extension("x-ms-identifiers", [])
  users?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamManagedPolicies {
  get is ArmResourceRead<IamManagedPolicy>;
  @doc("Create a IamManagedPolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IamManagedPolicy>;
  update is ArmCustomPatchAsync<
    IamManagedPolicy,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamManagedPolicy>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamManagedPolicy>;
  listByResourceGroup is ArmResourceListByParent<IamManagedPolicy>;
  listBySubscription is ArmListBySubscription<IamManagedPolicy>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::IAM::ManagedPolicy
//--------------------------------------------------------------------------------------------
