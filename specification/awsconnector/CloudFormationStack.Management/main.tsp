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

//---------------------------------------------- CloudFormationStacks ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model CloudFormationStack is TrackedResource<CloudFormationStackProperties> {
  @doc("Name of CloudFormationStack")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("cloudFormationStacks")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudFormationStack")
model CloudFormationStackProperties {
  @doc("Awsproperties")
  awsProperties?: AwsCloudFormationStackProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCloudFormationStack")
model AwsCloudFormationStackProperties {
  @doc("Capabilities")
  @extension("x-ms-identifiers", [])
  capabilities?: Capabilities[];

  @doc("Changesetid")
  changeSetId?: string;

  @doc("Creationtime")
  creationTime?: string;

  @doc("Description")
  description?: string;

  @doc("Disablerollback")
  disableRollback?: boolean;

  @doc("Enableterminationprotection")
  enableTerminationProtection?: boolean;

  @doc("Lastupdatetime")
  lastUpdateTime?: string;

  @doc("Notificationarns")
  @extension("x-ms-identifiers", [])
  notificationARNs?: string[];

  @doc("Outputs")
  @extension("x-ms-identifiers", [])
  outputs?: Output[];

  @doc("Parameters")
  parameters?: Record<string>;

  @doc("Parentid")
  parentId?: string;

  @doc("Rolearn")
  roleARN?: string;

  @doc("Rootid")
  rootId?: string;

  @doc("Stackid")
  stackId?: string;

  @doc("Stackname")
  stackName?: string;

  @doc("Stackpolicybody")
  stackPolicyBody?: unknown;

  @doc("Stackpolicyurl")
  stackPolicyURL?: string;

  @doc("Stackstatus")
  stackStatus?: StackStatus;

  @doc("Stackstatusreason")
  stackStatusReason?: string;

  @doc("Tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Templatebody")
  templateBody?: unknown;

  @doc("Templateurl")
  templateURL?: string;

  @doc("Timeoutinminutes")
  timeoutInMinutes?: int32;
}

@doc("Capabilities enum")
union Capabilities {
  @doc("Capabilities enum CAPABILITY_AUTO_EXPAND")
  CAPABILITY_AUTO_EXPAND: "CAPABILITY_AUTO_EXPAND",

  @doc("Capabilities enum CAPABILITY_IAM")
  CAPABILITY_IAM: "CAPABILITY_IAM",

  @doc("Capabilities enum CAPABILITY_NAMED_IAM")
  CAPABILITY_NAMED_IAM: "CAPABILITY_NAMED_IAM",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Output")
model Output {
  @doc("Description")
  description?: string;

  @doc("Exportname")
  exportName?: string;

  @doc("Outputkey")
  outputKey?: string;

  @doc("Outputvalue")
  outputValue?: string;
}

@doc("StackStatus enum")
union StackStatus {
  @doc("StackStatus enum CREATE_COMPLETE")
  CREATE_COMPLETE: "CREATE_COMPLETE",

  @doc("StackStatus enum CREATE_FAILED")
  CREATE_FAILED: "CREATE_FAILED",

  @doc("StackStatus enum CREATE_IN_PROGRESS")
  CREATE_IN_PROGRESS: "CREATE_IN_PROGRESS",

  @doc("StackStatus enum DELETE_COMPLETE")
  DELETE_COMPLETE: "DELETE_COMPLETE",

  @doc("StackStatus enum DELETE_FAILED")
  DELETE_FAILED: "DELETE_FAILED",

  @doc("StackStatus enum DELETE_IN_PROGRESS")
  DELETE_IN_PROGRESS: "DELETE_IN_PROGRESS",

  @doc("StackStatus enum IMPORT_COMPLETE")
  IMPORT_COMPLETE: "IMPORT_COMPLETE",

  @doc("StackStatus enum IMPORT_IN_PROGRESS")
  IMPORT_IN_PROGRESS: "IMPORT_IN_PROGRESS",

  @doc("StackStatus enum IMPORT_ROLLBACK_COMPLETE")
  IMPORT_ROLLBACK_COMPLETE: "IMPORT_ROLLBACK_COMPLETE",

  @doc("StackStatus enum IMPORT_ROLLBACK_FAILED")
  IMPORT_ROLLBACK_FAILED: "IMPORT_ROLLBACK_FAILED",

  @doc("StackStatus enum IMPORT_ROLLBACK_IN_PROGRESS")
  IMPORT_ROLLBACK_IN_PROGRESS: "IMPORT_ROLLBACK_IN_PROGRESS",

  @doc("StackStatus enum REVIEW_IN_PROGRESS")
  REVIEW_IN_PROGRESS: "REVIEW_IN_PROGRESS",

  @doc("StackStatus enum ROLLBACK_COMPLETE")
  ROLLBACK_COMPLETE: "ROLLBACK_COMPLETE",

  @doc("StackStatus enum ROLLBACK_FAILED")
  ROLLBACK_FAILED: "ROLLBACK_FAILED",

  @doc("StackStatus enum ROLLBACK_IN_PROGRESS")
  ROLLBACK_IN_PROGRESS: "ROLLBACK_IN_PROGRESS",

  @doc("StackStatus enum UPDATE_COMPLETE")
  UPDATE_COMPLETE: "UPDATE_COMPLETE",

  @doc("StackStatus enum UPDATE_COMPLETE_CLEANUP_IN_PROGRESS")
  UPDATE_COMPLETE_CLEANUP_IN_PROGRESS: "UPDATE_COMPLETE_CLEANUP_IN_PROGRESS",

  @doc("StackStatus enum UPDATE_FAILED")
  UPDATE_FAILED: "UPDATE_FAILED",

  @doc("StackStatus enum UPDATE_IN_PROGRESS")
  UPDATE_IN_PROGRESS: "UPDATE_IN_PROGRESS",

  @doc("StackStatus enum UPDATE_ROLLBACK_COMPLETE")
  UPDATE_ROLLBACK_COMPLETE: "UPDATE_ROLLBACK_COMPLETE",

  @doc("StackStatus enum UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS")
  UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS: "UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS",

  @doc("StackStatus enum UPDATE_ROLLBACK_FAILED")
  UPDATE_ROLLBACK_FAILED: "UPDATE_ROLLBACK_FAILED",

  @doc("StackStatus enum UPDATE_ROLLBACK_IN_PROGRESS")
  UPDATE_ROLLBACK_IN_PROGRESS: "UPDATE_ROLLBACK_IN_PROGRESS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Key")
  key?: string;

  @doc("Value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CloudFormationStacks {
  get is ArmResourceRead<CloudFormationStack>;
  @doc("Create a CloudFormationStack. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CloudFormationStack>;
  update is ArmCustomPatchAsync<
    CloudFormationStack,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CloudFormationStack>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CloudFormationStack>;
  listByResourceGroup is ArmResourceListByParent<CloudFormationStack>;
  listBySubscription is ArmListBySubscription<CloudFormationStack>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CloudFormation::Stack
//--------------------------------------------------------------------------------------------
