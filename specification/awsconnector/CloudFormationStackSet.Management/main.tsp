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

//---------------------------------------------- CloudFormationStackSets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Cloud Formation Stack Set",
    plural: "Cloud Formation Stack Sets",
  },
  keywords: ["Microsoft.AwsConnector", "Cloud", "Formation", "Stack", "Set"],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsCloudFormationStackSetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCloudFormationStackSet")
model AwsCloudFormationStackSetProperties {
  @doc("The Amazon Resource Number (ARN) of the IAM role to use to create this stack set. Specify an IAM role only if you are using customized administrator roles to control which users or groups can manage specific stack sets within the same administrator account.")
  administrationRoleARN?: string;

  @doc("Describes whether StackSets automatically deploys to AWS Organizations accounts that are added to the target organization or organizational unit (OU). Specify only if PermissionModel is SERVICE_MANAGED.")
  autoDeployment?: AutoDeployment;

  @doc("Specifies the AWS account that you are acting from. By default, SELF is specified. For self-managed permissions, specify SELF; for service-managed permissions, if you are signed in to the organization's management account, specify SELF. If you are signed in to a delegated administrator account, specify DELEGATED_ADMIN.")
  callAs?: CallAs;

  @doc("In some cases, you must explicitly acknowledge that your stack set template contains certain capabilities in order for AWS CloudFormation to create the stack set and related stack instances.")
  @extension("x-ms-identifiers", [])
  capabilities?: string[];

  @doc("A description of the stack set. You can use the description to identify the stack set's purpose or other important information.")
  description?: string;

  @doc("The name of the IAM execution role to use to create the stack set. If you do not specify an execution role, AWS CloudFormation uses the AWSCloudFormationStackSetExecutionRole role for the stack set operation.")
  executionRoleName?: string;

  @doc("Describes whether StackSets performs non-conflicting operations concurrently and queues conflicting operations.")
  managedExecution?: ActiveModel;

  @doc("The user-specified preferences for how AWS CloudFormation performs a stack set operation.")
  operationPreferences?: OperationPreferences;

  @doc("The input parameters for the stack set template.")
  @extension("x-ms-identifiers", [])
  parameters?: Parameter[];

  @doc("Describes how the IAM roles required for stack set operations are created. By default, SELF-MANAGED is specified.")
  permissionModel?: PermissionModel;

  @doc("A group of stack instances with parameters in some specific accounts and regions.")
  @extension("x-ms-identifiers", [])
  stackInstancesGroup?: StackInstances[];

  @doc("The ID of the stack set that you're creating.")
  stackSetId?: string;

  @doc("The name to associate with the stack set. The name must be unique in the Region where you create your stack set.")
  stackSetName?: string;

  @doc("The key-value pairs to associate with this stack set and the stacks created from it. AWS CloudFormation also propagates these tags to supported resources that are created in the stacks. A maximum number of 50 tags can be specified.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The structure that contains the template body, with a minimum length of 1 byte and a maximum length of 51,200 bytes.")
  templateBody?: string;

  @doc("Location of file containing the template body. The URL must point to a template (max size: 460,800 bytes) that is located in an Amazon S3 bucket.")
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
  @doc("If set to true, StackSets automatically deploys additional stack instances to AWS Organizations accounts that are added to a target organization or organizational unit (OU) in the specified Regions. If an account is removed from a target organization or OU, StackSets deletes stack instances from the account in the specified Regions.")
  enabled?: boolean;

  @doc("If set to true, stack resources are retained when an account is removed from a target organization or OU. If set to false, stack resources are deleted. Specify only if Enabled is set to True.")
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
  @doc("When true, StackSets performs non-conflicting operations concurrently and queues conflicting operations. After conflicting operations finish, StackSets starts queued operations in request order.")
  @clientName("activecsharp", "csharp")
  active?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OperationPreferences")
model OperationPreferences {
  @doc("Property failureToleranceCount")
  failureToleranceCount?: int32;

  @doc("Property failureTolerancePercentage")
  failureTolerancePercentage?: int32;

  @doc("Property maxConcurrentCount")
  maxConcurrentCount?: int32;

  @doc("Property maxConcurrentPercentage")
  maxConcurrentPercentage?: int32;

  @doc("The concurrency type of deploying StackSets operations in regions, could be in parallel or one region at a time")
  regionConcurrencyType?: OperationPreferencesRegionConcurrencyType;

  @doc("Property regionOrder")
  @extension("x-ms-identifiers", [])
  regionOrder?: string[];
}

@doc("OperationPreferencesRegionConcurrencyType enum")
union OperationPreferencesRegionConcurrencyType {
  @doc("OperationPreferencesRegionConcurrencyType enum PARALLEL")
  PARALLEL: "PARALLEL",

  @doc("OperationPreferencesRegionConcurrencyType enum SEQUENTIAL")
  SEQUENTIAL: "SEQUENTIAL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Parameter")
model Parameter {
  @doc("The key associated with the parameter. If you don't specify a key and value for a particular parameter, AWS CloudFormation uses the default value that is specified in your template.")
  parameterKey?: string;

  @doc("The input value associated with the parameter.")
  parameterValue?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StackInstances")
model StackInstances {
  @doc("The AWS OrganizationalUnitIds or Accounts for which to create stack instances in the specified Regions.")
  deploymentTargets?: DeploymentTargets;

  @doc("A list of stack set parameters whose values you want to override in the selected stack instances.")
  @extension("x-ms-identifiers", [])
  parameterOverrides?: Parameter[];

  @doc("The names of one or more Regions where you want to create stack instances using the specified AWS account(s).")
  @extension("x-ms-identifiers", [])
  regions?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("A string used to identify this tag. You can specify a maximum of 127 characters for a tag key.")
  key?: string;

  @doc("A string containing the value for this tag. You can specify a maximum of 256 characters for a tag value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentTargets")
model DeploymentTargets {
  @doc("The filter type you want to apply on organizational units and accounts.")
  accountFilterType?: DeploymentTargetsAccountFilterType;

  @doc("AWS accounts that you want to create stack instances in the specified Region(s) for.")
  @extension("x-ms-identifiers", [])
  accounts?: string[];

  @doc("Returns the value of the AccountsUrl property.")
  accountsUrl?: string;

  @doc("The organization root ID or organizational unit (OU) IDs to which StackSets deploys.")
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
  createOrReplace is ArmResourceCreateOrReplaceAsync<CloudFormationStackSet>;
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
