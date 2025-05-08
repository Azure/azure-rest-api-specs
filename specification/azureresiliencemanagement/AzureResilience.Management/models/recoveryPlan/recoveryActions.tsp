import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../../recoveryPlans.tsp";
import "./recoveryResource.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Defines the set of operations that can be executed on a Recovery Orchestration Plan. These operations are applicable only to resources that meet the qualification criteria.")
union RecoveryOperationNames {
  @doc("Initiates a failover process to recover eligible resources to the target location.")
  Failover: "Failover",

  @doc("Commits the failover for resources that require an explicit commit after recovery.")
  FailoverCommit: "FailoverCommit",

  @doc("Performs re-protection or configuration changes for resources that have failed over, as required.")
  Reprotect: "Reprotect",

  @doc("Initiates a test failover process for qualified resources and those that support test failover.")
  TestFailover: "TestFailover",

  @doc("Cleans up resources and configurations created during a test failover, as required.")
  TestFailoverCleanup: "TestFailoverCleanup",

  string,
}

@doc("ValidateForOperation post action request to check if operation can be performed.")
model ValidateForOperationRequest {
  @doc("Operation Name to validate.")
  operationName: RecoveryOperationNames;
}

@doc("Protection details of resource.")
union NotQualifiedReasons {
  @doc("Resource is excluded from the Recovery Orchestration Plan.")
  InclusionStateExcluded: "InclusionStateExcluded",

  @doc("Resource Type does not support this operation.")
  ResourceTypeDoesNotSupportOperation: "ResourceTypeDoesNotSupportOperation",

  @doc("Resource current protection state does bot support this operation.")
  ResourceProtectionStateDoesNotSupportOperation: "ResourceProtectionStateDoesNotSupportOperation",

  @doc("Resource current active location does not match the input.")
  ResourceActiveLocationNotAsPerInput: "ResourceActiveLocationNotAsPerInput",

  string,
}

@doc("A state type that indicates qualification of a resource for an operation.")
union QualificationState {
  @doc("A state that indicates the qualification state is unknown.")
  Unknown: "Unknown",

  @doc("A state that indicates the resource is qualified for the operation.")
  Qualified: "Qualified",

  @doc("A state that indicates the resource is not qualified for the operation.")
  NotQualified: "NotQualified",

  @doc("A state that indicates the resource is excluded from the recovery plan itself.")
  Excluded: "Excluded",

  string,
}

@doc("Details of qualification for an operation.")
model OperationQualificationDetails {
  @doc("Resource qualification state for the operation.")
  qualificationState: QualificationState;

  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("Reasons for resource not qualified for the operation.")
  notQualifiedReasons?: string[];
}

@doc("Details of resource and its qualification for an operation")
model RecoveryResourceQualification {
  @doc("Recovery orchestration resource.")
  recoveryResource: RecoveryResource;

  @doc("Details of qualification for the operation.")
  operationQualificationDetails: OperationQualificationDetails;
}

@doc("ValidateForRecoveryOperation post action response.")
model ValidateForRecoveryOperationBaseResponse {
  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("Qualification details of resources for the operation.")
  recoveryResourceQualifications: RecoveryResourceQualification[];
}

@doc("Recovery Orchestration Plan post action response.")
model RecoveryPlanActionBaseResponse {
  @doc("JobId of the job triggered for Recovery Orchestration Plan.")
  jobId: string;
}

@doc("TestFailoverCleanup post action request.")
model TestFailoverCleanupRequest {
  @doc("Comments for test failover cleanup.")
  @maxLength(1024)
  comments?: string;
}
