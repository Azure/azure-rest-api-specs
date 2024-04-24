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

//---------------------------------------------- CloudFormationStackSets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model CloudFormationStackSet
  is TrackedResource<CloudFormationStackSetProperties> {
  @doc("Name of CloudFormationStackSet")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("cloudFormationStackSets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudFormationStackSet")
model CloudFormationStackSetProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsCloudFormationStackSetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCloudFormationStackSet")
model AwsCloudFormationStackSetProperties {
  @doc("Gets and sets the property administrationRoleARN. The Amazon Resource Number (ARN) of the IAM role to use to create this stack set. Specify an IAM role only if you are using customized administrator roles to control which users or groups can manage specific stack sets within the same administrator account.")
  administrationRoleARN?: string;

  @doc("Gets and sets the property autoDeployment. Describes whether StackSets automatically deploys to AWS Organizations accounts that are added to the target organization or organizational unit (OU). Specify only if PermissionModel is SERVICE_MANAGED.")
  autoDeployment?: AutoDeployment;

  @doc("Gets and sets the property callAs. Specifies the AWS account that you are acting from. By default, SELF is specified. For self-managed permissions, specify SELF; for service-managed permissions, if you are signed in to the organization's management account, specify SELF. If you are signed in to a delegated administrator account, specify DELEGATED_ADMIN.")
  callAs?: CallAs;

  @doc("Gets and sets the property capabilities. In some cases, you must explicitly acknowledge that your stack set template contains certain capabilities in order for AWS CloudFormation to create the stack set and related stack instances.")
  @extension("x-ms-identifiers", [])
  capabilities?: string[];

  @doc("Gets and sets the property description. A description of the stack set. You can use the description to identify the stack set's purpose or other important information.")
  description?: string;

  @doc("Gets and sets the property executionRoleName. The name of the IAM execution role to use to create the stack set. If you do not specify an execution role, AWS CloudFormation uses the AWSCloudFormationStackSetExecutionRole role for the stack set operation.")
  executionRoleName?: string;

  @doc("Gets and sets the property managedExecution. Describes whether StackSets performs non-conflicting operations concurrently and queues conflicting operations.")
  managedExecution?: ActiveModel;

  @doc("Gets and sets the property operationPreferences. The user-specified preferences for how AWS CloudFormation performs a stack set operation.")
  operationPreferences?: OperationPreferences;

  @doc("Gets and sets the property parameters. The input parameters for the stack set template.")
  @extension("x-ms-identifiers", [])
  parameters?: Parameter[];

  @doc("Gets and sets the property permissionModel. Describes how the IAM roles required for stack set operations are created. By default, SELF-MANAGED is specified.")
  permissionModel?: PermissionModel;

  @doc("Gets and sets the property stackInstancesGroup. A group of stack instances with parameters in some specific accounts and regions.")
  @extension("x-ms-identifiers", [])
  stackInstancesGroup?: StackInstances[];

  @doc("Gets and sets the property stackSetId. The ID of the stack set that you're creating.")
  stackSetId?: string;

  @doc("Gets and sets the property stackSetName. The name to associate with the stack set. The name must be unique in the Region where you create your stack set.")
  stackSetName?: string;

  @doc("Gets and sets the property tags. The key-value pairs to associate with this stack set and the stacks created from it. AWS CloudFormation also propagates these tags to supported resources that are created in the stacks. A maximum number of 50 tags can be specified.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property templateBody. The structure that contains the template body, with a minimum length of 1 byte and a maximum length of 51,200 bytes.")
  templateBody?: string;

  @doc("Gets and sets the property templateURL. Location of file containing the template body. The URL must point to a template (max size: 460,800 bytes) that is located in an Amazon S3 bucket.")
  templateURL?: string;
}

@doc("CallAs enum")
union CallAs {
  @doc("CallAs enum DELEGATED_ADMIN")
  DELEGATED_ADMIN: "DELEGATED_ADMIN",

  @doc("CallAs enum SELF")
  SELF: "SELF",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoDeployment")
model AutoDeployment {
  @doc("Gets and sets the property enabled. If set to true, StackSets automatically deploys additional stack instances to AWS Organizations accounts that are added to a target organization or organizational unit (OU) in the specified Regions. If an account is removed from a target organization or OU, StackSets deletes stack instances from the account in the specified Regions.")
  enabled?: boolean;

  @doc("Gets and sets the property retainStacksOnAccountRemoval. If set to true, stack resources are retained when an account is removed from a target organization or OU. If set to false, stack resources are deleted. Specify only if Enabled is set to True.")
  retainStacksOnAccountRemoval?: boolean;
}

@doc("PermissionModel enum")
union PermissionModel {
  @doc("PermissionModel enum SELF_MANAGED")
  SELF_MANAGED: "SELF_MANAGED",

  @doc("PermissionModel enum SERVICE_MANAGED")
  SERVICE_MANAGED: "SERVICE_MANAGED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Active")
model ActiveModel {
  @doc("Gets and sets the property active. When true, StackSets performs non-conflicting operations concurrently and queues conflicting operations. After conflicting operations finish, StackSets starts queued operations in request order.")
  @clientName("activecsharp", "csharp")
  active?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OperationPreferences")
model OperationPreferences {
  @doc("Gets and sets the property failureToleranceCount.")
  failureToleranceCount?: int32;

  @doc("Gets and sets the property failureTolerancePercentage.")
  failureTolerancePercentage?: int32;

  @doc("Gets and sets the property maxConcurrentCount.")
  maxConcurrentCount?: int32;

  @doc("Gets and sets the property maxConcurrentPercentage.")
  maxConcurrentPercentage?: int32;

  @doc("Gets and sets the property regionConcurrencyType. The concurrency type of deploying StackSets operations in regions, could be in parallel or one region at a time")
  regionConcurrencyType?: string;

  @doc("Gets and sets the property regionOrder.")
  @extension("x-ms-identifiers", [])
  regionOrder?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Parameter")
model Parameter {
  @doc("Gets and sets the property parameterKey. The key associated with the parameter. If you don't specify a key and value for a particular parameter, AWS CloudFormation uses the default value that is specified in your template.")
  parameterKey?: string;

  @doc("Gets and sets the property parameterValue. The input value associated with the parameter.")
  parameterValue?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StackInstances")
model StackInstances {
  @doc("Gets and sets the property deploymentTargets.  The AWS OrganizationalUnitIds or Accounts for which to create stack instances in the specified Regions.")
  deploymentTargets?: DeploymentTargets;

  @doc("Gets and sets the property parameterOverrides. A list of stack set parameters whose values you want to override in the selected stack instances.")
  @extension("x-ms-identifiers", [])
  parameterOverrides?: Parameter[];

  @doc("Gets and sets the property regions. The names of one or more Regions where you want to create stack instances using the specified AWS account(s).")
  @extension("x-ms-identifiers", [])
  regions?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. A string used to identify this tag. You can specify a maximum of 127 characters for a tag key.")
  key?: string;

  @doc("Gets and sets the property value. A string containing the value for this tag. You can specify a maximum of 256 characters for a tag value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentTargets")
model DeploymentTargets {
  @doc("Gets and sets the property accountFilterType. The filter type you want to apply on organizational units and accounts.")
  accountFilterType?: DeploymentTargetsAccountFilterType;

  @doc("Gets and sets the property accounts. AWS accounts that you want to create stack instances in the specified Region(s) for.")
  @extension("x-ms-identifiers", [])
  accounts?: string[];

  @doc("Gets and sets the property accountsUrl. Returns the value of the AccountsUrl property.")
  accountsUrl?: string;

  @doc("Gets and sets the property organizationalUnitIds. The organization root ID or organizational unit (OU) IDs to which StackSets deploys.")
  @extension("x-ms-identifiers", [])
  organizationalUnitIds?: string[];
}

@doc("DeploymentTargetsAccountFilterType enum")
union DeploymentTargetsAccountFilterType {
  @doc("DeploymentTargetsAccountFilterType enum DIFFERENCE")
  DIFFERENCE: "DIFFERENCE",

  @doc("DeploymentTargetsAccountFilterType enum INTERSECTION")
  INTERSECTION: "INTERSECTION",

  @doc("DeploymentTargetsAccountFilterType enum NONE")
  NONE: "NONE",

  @doc("DeploymentTargetsAccountFilterType enum UNION")
  UNION: "UNION",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CloudFormationStackSets {
  get is ArmResourceRead<CloudFormationStackSet>;
  @doc("Create a CloudFormationStackSet. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CloudFormationStackSet>;
  update is ArmCustomPatchAsync<
    CloudFormationStackSet,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CloudFormationStackSet>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CloudFormationStackSet>;
  listByResourceGroup is ArmResourceListByParent<CloudFormationStackSet>;
  listBySubscription is ArmListBySubscription<CloudFormationStackSet>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CloudFormation::StackSet
//--------------------------------------------------------------------------------------------
