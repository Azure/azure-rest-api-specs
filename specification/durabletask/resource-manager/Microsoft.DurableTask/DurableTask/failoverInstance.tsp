import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DurableTask;

@doc("A failover instance belonging to the scheduler")
@added(Versions.v2026_07_01_Preview)
@parentResource(Scheduler)
@singleton
model FailoverInstance
  is Azure.ResourceManager.ProxyResource<FailoverInstanceProperties> {
  ...ResourceNameParameter<
    FailoverInstance,
    "failoverInstanceName",
    "failoverInstances"
  >;
}

@doc("The failover instance settings for the resource")
@added(Versions.v2026_07_01_Preview)
model FailoverInstanceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The replication role of the parent scheduler")
  replicationRole?: ReplicationRole;

  @visibility(Lifecycle.Read)
  @added(Versions.v2026_07_01_Preview)
  @doc("The current state of the failover operation")
  failoverState?: FailoverState;

  @doc("The resource ID of the partner scheduler in the failover configuration")
  partnerSchedulerResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DurableTask/schedulers";
    }
  ]>;

  @visibility(Lifecycle.Read)
  @doc("The location of the partner scheduler in the failover configuration")
  partnerSchedulerLocation?: string;
}

@doc("The replication role of the scheduler")
@added(Versions.v2026_07_01_Preview)
union ReplicationRole {
  string,

  @doc("The parent scheduler is the primary in the failover configuration")
  Primary: "Primary",

  @doc("The parent scheduler is the secondary in the failover configuration")
  Secondary: "Secondary",
}

@doc("The current state of the failover operation")
@added(Versions.v2026_07_01_Preview)
union FailoverState {
  string,

  @doc("No failover operation is active")
  None: "None",

  @doc("The failover operation is in progress")
  InProgress: "InProgress",

  @doc("The failover operation completed successfully")
  Succeeded: "Succeeded",

  @doc("The failover operation failed")
  Failed: "Failed",
}

@added(Versions.v2026_07_01_Preview)
@armResourceOperations(FailoverInstance)
interface FailoverInstances {
  @doc("Get a Failover Instance")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<FailoverInstance>;
  @doc("Create or Update a Failover Instance")
  @errorsDoc("Validation error: required parameters are missing")
  createOrReplace is ArmResourceCreateOrReplaceAsync<FailoverInstance>;
  @doc("Delete a Failover Instance")
  delete is ArmResourceDeleteWithoutOkAsync<FailoverInstance>;
  @doc("List Failover Instances")
  listByScheduler is ArmResourceListByParent<FailoverInstance>;
  @doc("Trigger a graceful failover for the parent scheduler")
  failover is ArmResourceActionAsync<FailoverInstance, void, FailoverInstance>;
  @doc("Trigger a forced failover with potential data loss for the parent scheduler")
  forceFailoverAllowDataLoss is ArmResourceActionAsync<
    FailoverInstance,
    void,
    FailoverInstance
  >;
}
