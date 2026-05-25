import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Compute;

@@clientName(
  VirtualMachineBulkOperations.bulkDeallocate,
  "BulkDeallocateOperation"
);
@@clientName(
  VirtualMachineBulkOperations.bulkHibernate,
  "BulkHibernateOperation"
);
@@clientName(VirtualMachineBulkOperations.bulkStart, "BulkStartOperation");
@@clientName(
  VirtualMachineBulkOperations.bulkGetOperationsStatus,
  "BulkGetOperationsStatus"
);
@@clientName(VirtualMachineBulkOperations.bulkCancel, "BulkCancelOperations");
@@clientName(VirtualMachineBulkOperations.bulkCreate, "BulkCreateOperation");
@@clientName(VirtualMachineBulkOperations.bulkDelete, "BulkDeleteOperation");
@@clientName(VirtualMachineBulkOperations.bulkReimage, "BulkReimageOperation");
@@clientName(
  VirtualMachineBulkOperations.bulkVdiFlexCreate,
  "BulkVdiFlexCreateOperation"
);

@@clientName(CancelOperationsResponse, "CancelOperationsResult", "csharp");
@@clientName(DeadlineType, "ScheduledActionDeadlineType", "csharp");
@@clientName(
  DeallocateResourceOperationResponse,
  "DeallocateResourceOperationResult",
  "csharp"
);
@@clientName(
  DeallocateResourceOperationResponse.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  ExecutionParameters,
  "ScheduledActionExecutionParameterDetail",
  "csharp"
);
@@clientName(GetOperationStatusResponse, "GetOperationStatusResult", "csharp");
@@clientName(
  HibernateResourceOperationResponse,
  "HibernateResourceOperationResult",
  "csharp"
);
@@clientName(HibernateResourceOperationResponse.type, "ResourceType", "csharp");
@@clientName(OperationState, "ScheduledActionOperationState", "csharp");

@@clientName(ResourceOperation, "ResourceOperationResult", "csharp");
@@clientName(Resources, "UserRequestResources", "csharp");
@@clientName(RetryPolicy, "UserRequestRetryPolicy", "csharp");
@@clientName(
  StartResourceOperationResponse,
  "StartResourceOperationResult",
  "csharp"
);
@@clientName(StartResourceOperationResponse.type, "ResourceType", "csharp");
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");
@@clientName(
  OperationErrorDetails.timeStamp,
  "errorDetailsTimestamp",
  "csharp,javascript,java,python"
);

@@clientName(
  DeleteResourceOperationResponse,
  "DeleteResourceOperationResult",
  "csharp"
);
@@clientName(
  CreateResourceOperationResponse,
  "CreateResourceOperationResult",
  "csharp"
);
@@clientName(ExecuteHibernateRequest, "ExecuteHibernateContent");
@@clientName(ExecuteCreateRequest, "ExecuteCreateContent");
@@clientName(ExecuteDeallocateRequest, "ExecuteDeallocateContent");
@@clientName(ExecuteDeleteRequest, "ExecuteDeleteContent");
@@clientName(ExecuteStartRequest, "ExecuteStartContent");
@@clientName(GetOperationStatusRequest, "GetOperationStatusContent");
@@clientName(CancelOperationsRequest, "CancelOperationsContent");
@@clientName(ManagedDiskParameters, "ManagedDiskParametersContent");
@@clientName(DiskEncryptionSetParameters, "DiskEncryptionSetParametersContent");

@@clientName(
  UserInitiatedRedeploy.automaticallyApprove,
  "UserInitiatedRedeployAutomaticallyApprove"
);
@@clientName(
  UserInitiatedReboot.automaticallyApprove,
  "UserInitiatedRebootAutomaticallyApprove"
);
@@clientName(
  AllInstancesDown.automaticallyApprove,
  "AllInstancesDownAutomaticallyApprove"
);
@@clientName(
  ExecuteVdiCreateRequest,
  "BulkActionsExecuteVdiCreateRequestContent",
  "csharp"
);
@@clientName(
  ExecuteReimageRequest,
  "BulkActionsExecuteReimageRequestContent",
  "csharp"
);
@@clientName(
  ReimageResourceOperationResponse,
  "BulkActionsReimageResourceOperationResponseResult",
  "csharp"
);
@@clientName(
  VirtualMachineReimageParameters,
  "BulkActionsVirtualMachineReimageParametersContent",
  "csharp"
);
@@clientName(
  OSProfileProvisioningData,
  "BulkActionsOsProfileProvisioningContent",
  "csharp"
);
// =====================================================================
// Fix: Go SDK Validation incorrectly detects networkApiVersion as an API version
// parameter because its name contains "apiversion". This causes
// the Go emitter to crash with "unexpected constant client side default
// 2026-04-15-preview for field NetworkAPIVersion". Override the heuristic.
// =====================================================================
@@apiVersion(NetworkProfile.networkApiVersion, false, "go");

// =====================================================================
// Fix: Python emits the `\W` in `(Regex match [\W_])` directly into the
// generated docstring, producing a SyntaxWarning on Python 3.12+
// ("invalid escape sequence '\W'"). Escape `\W` to `\\W` in the Python
// client doc only so the generated docstring contains a valid escape.
// See https://github.com/Azure/azure-sdk-for-python/issues/47011
// =====================================================================
@@clientDoc(OSProfile.adminPassword,
  "Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)",
  DocumentationMode.replace,
  "python"
);
@@clientDoc(OSProfileProvisioningData.adminPassword,
  "Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)",
  DocumentationMode.replace,
  "python"
);
