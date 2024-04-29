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
  @doc("Gets and sets the property attachmentCount.")
  attachmentCount?: int32;

  @doc("Gets and sets the property createDate.")
  createDate?: string;

  @doc("Gets and sets the property defaultVersionId.")
  defaultVersionId?: string;

  @doc("Gets and sets the property description. A friendly description of the policy. Typically used to store information about the permissions defined in the policy. For example, 'Grants access to production DynamoDB tables.' The policy description is immutable. After a value is assigned, it cannot be changed.")
  description?: string;

  @doc("Gets and sets the property groups. The name (friendly name, not ARN) of the group to attach the policy to. This parameter allows (through its [regex pattern](https://docs.aws.amazon.com/http://wikipedia.org/wiki/regex)) a string of characters consisting of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: _+=,.@-")
  @extension("x-ms-identifiers", [])
  groups?: string[];

  @doc("Gets and sets the property isAttachable.")
  isAttachable?: boolean;

  @doc("Gets and sets the property managedPolicyName. The friendly name of the policy.  If you specify a name, you cannot perform updates that require replacement of this resource. You can perform updates that require no or some interruption. If you must replace the resource, specify a new name.  If you specify a name, you must specify the ``CAPABILITY_NAMED_IAM`` value to acknowledge your template's capabilities. For more information, see [Acknowledging Resources in Templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#using-iam-capabilities).  Naming an IAM resource can cause an unrecoverable error if you reuse the same template in multiple Regions. To prevent this, we recommend using ``Fn::Join`` and ``AWS::Region`` to create a Region-specific name, as in the following example: ``{'Fn::Join': ['', [{'Ref': 'AWS::Region'}, {'Ref': 'MyResourceName'}]]}``.")
  managedPolicyName?: string;

  @doc("Gets and sets the property path. The path for the policy. For more information about paths, see [IAM identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*. This parameter is optional. If it is not included, it defaults to a slash (/). This parameter allows (through its [regex pattern](https://docs.aws.amazon.com/http://wikipedia.org/wiki/regex)) a string of characters consisting of either a forward slash (/) by itself or a string that must begin and end with forward slashes. In addition, it can contain any ASCII character from the ! (``\\u0021``) through the DEL character (``\\u007F``), including most punctuation characters, digits, and upper and lowercased letters.  You cannot use an asterisk (*) in the path name.")
  path?: string = "/";

  @doc("Gets and sets the property permissionsBoundaryUsageCount.")
  permissionsBoundaryUsageCount?: int32;

  @doc("Gets and sets the property policyArn.")
  policyArn?: string;

  @doc("Gets and sets the property policyDocument. The JSON policy document that you want to use as the content for the new policy. You must provide policies in JSON format in IAM. However, for CFN templates formatted in YAML, you can provide the policy in JSON or YAML format. CFN always converts a YAML policy to JSON format before submitting it to IAM. The maximum length of the policy document that you can pass in this operation, including whitespace, is listed below. To view the maximum character counts of a managed policy with no whitespaces, see [IAM and character quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html#reference_iam-quotas-entity-length). To learn more about JSON policy grammar, see [Grammar of the IAM JSON policy language](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_grammar.html) in the *IAM User Guide*.  The [regex pattern](https://docs.aws.amazon.com/http://wikipedia.org/wiki/regex) used to validate this parameter is a string of characters consisting of the following:  +  Any printable ASCII character ranging from the space character (``\\u0020``) through the end of the ASCII character range  +  The printable characters in the Basic Latin and Latin-1 Supplement character set (through ``\\u00FF``)  +  The special characters tab (``\\u0009``), line feed (``\\u000A``), and carriage return (``\\u000D``)")
  policyDocument?: string;

  @doc("Gets and sets the property policyId.")
  policyId?: string;

  @doc("Gets and sets the property roles. The name (friendly name, not ARN) of the role to attach the policy to. This parameter allows (per its [regex pattern](https://docs.aws.amazon.com/http://wikipedia.org/wiki/regex)) a string of characters consisting of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: _+=,.@-  If an external policy (such as ``AWS::IAM::Policy`` or ``AWS::IAM::ManagedPolicy``) has a ``Ref`` to a role and if a resource (such as ``AWS::ECS::Service``) also has a ``Ref`` to the same role, add a ``DependsOn`` attribute to the resource to make the resource depend on the external policy. This dependency ensures that the role's policy is available throughout the resource's lifecycle. For example, when you delete a stack with an ``AWS::ECS::Service`` resource, the ``DependsOn`` attribute ensures that CFN deletes the ``AWS::ECS::Service`` resource before deleting its role's policy.")
  @extension("x-ms-identifiers", [])
  roles?: string[];

  @doc("Gets and sets the property updateDate.")
  updateDate?: string;

  @doc("Gets and sets the property users. The name (friendly name, not ARN) of the IAM user to attach the policy to. This parameter allows (through its [regex pattern](https://docs.aws.amazon.com/http://wikipedia.org/wiki/regex)) a string of characters consisting of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: _+=,.@-")
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
