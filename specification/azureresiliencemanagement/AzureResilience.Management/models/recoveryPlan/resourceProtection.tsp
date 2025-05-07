import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../../recoveryPlans.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Definition of recovery orchestration resource protection solution setting with recovery orchestration plan.")
@discriminator("protectionSolutionType")
model ResourceBaseProtectionSolutionSetting {
  @doc("A setting that indicates the resource protected with which recovery solution.")
  protectionSolutionType: ResourceProtectionSolutionType;
}

@doc("Definition of recovery orchestration resource native protection solution setting with recovery orchestration plan.")
model ResourceNativeProtectionSolutionSetting
  extends ResourceBaseProtectionSolutionSetting {
  @doc("A setting that indicates the resource protected with which recovery solution.")
  protectionSolutionType: ResourceProtectionSolutionType.AzureNative;
}

@doc("Definition of recovery resource custom action setting with Recovery Orchestration Plan.")
model ResourceCustomProtectionAction {
  @doc("The Azure resource ID hosting the custom action automation script.")
  resourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Automation/automationAccounts/runbooks";
    }
  ]>;
}

@doc("Definition of recovery orchestration resource custom protection setting with recovery orchestration plan.")
model ResourceCustomProtectionSetting
  extends ResourceBaseProtectionSolutionSetting {
  protectionSolutionType: ResourceProtectionSolutionType.CustomRunbook;

  @doc("The Azure resource ID hosting the failover automation script.")
  failoverAction: ResourceCustomProtectionAction;

  @doc("The Azure resource ID hosting the failover commit automation script.")
  failoverCommitAction: ResourceCustomProtectionAction;

  @doc("The Azure resource ID hosting the test failover automation script.")
  testFailoverAction: ResourceCustomProtectionAction;

  @doc("The Azure resource ID hosting the test failover cleanup automation script.")
  testFailoverCleanupAction: ResourceCustomProtectionAction;

  @doc("The Azure resource ID hosting the reprotect automation script.")
  reprotectAction: ResourceCustomProtectionAction;

  @doc("Identity details associated to the resource, which will be used for performing any operations on it")
  associatedIdentity: AssociatedIdentity;
}

@doc("Definition of recovery resource failover params for site recovery solution.")
model ResourceSiteRecoveryTestFailoverParams {
  @doc("The Azure network resource is which will be used for test failover virtual machine.")
  networkResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;
}

@doc("Definition of recovery resource reprotect params for site recovery solution.")
model ResourceSiteRecoveryTestFailoverCleanupParams {
  @doc("Comments for testfailover cleanup")
  comments?: string;
}

@doc("Definition of recovery resource reprotect params for site recovery solution.")
model ResourceSiteRecoveryReprotectParams {
  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("Disk Reprotect Input Details")
  diskReprotectInputDetails?: DiskReprotectInputDetails[];
}

@doc("Disk Reprotect Input Details")
model DiskReprotectInputDetails {
  @doc("Disk Resource Id to Reprotect")
  diskResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/disks";
    }
  ]>;

  @doc("The staging StorageAccount Resource Id.")
  stagingStorageAccountResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}

@doc("Definition of recovery orchestration resource protection with azure site recovery.")
model ResourceSiteRecoveryProtectionSetting
  extends ResourceBaseProtectionSolutionSetting {
  protectionSolutionType: ResourceProtectionSolutionType.AzureSiteRecovery;

  @doc("Test failover params for azure site recovery solution.")
  testFailoverParams: ResourceSiteRecoveryTestFailoverParams;

  @doc("Test failover params for azure site recovery solution.")
  testFailoverCleanupParams: ResourceSiteRecoveryTestFailoverCleanupParams;

  @doc("Reprotect params for azure site recovery solution.")
  reprotectParams: ResourceSiteRecoveryReprotectParams;
}
