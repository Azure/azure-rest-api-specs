import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "./recoveryGroup.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Specifies the type of recovery orchestration plan.")
union RecoveryPlanType {
  @doc("A recovery orchestration plan for regional resiliency.")
  Regional: "Regional",

  @doc("A recovery orchestration plan for zonal resiliency.")
  Zonal: "Zonal",

  string,
}

@doc("Details of the recovery orchestration plan operation execution.")
model RecoveryPlanOperationStatus {
  @doc("The most recent execution time of the recovery orchestration plan in UTC.")
  lastExecutedAt: utcDateTime;

  @doc("The status of the most recent execution of the recovery orchestration plan.")
  operationStatus: string;

  @doc("Error details for the most recent execution of the recovery orchestration plan.")
  errorDetails?: CommonTypes.ErrorDetail;
}

@doc("Details of the recovery orchestration plan failover operation execution.")
model RecoveryPlanFailoverOperationStatus is RecoveryPlanOperationStatus {
  @doc("The actual recovery time of the most recent recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  recoveryTimeActual?: duration;
}

@doc("Properties of the recovery orchestration plan.")
model RecoveryPlanProperties {
  @doc("The provisioning state of the recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The type of the recovery orchestration plan, which can be set during creation but cannot be changed afterward.")
  @visibility(Lifecycle.Create)
  planType: RecoveryPlanType;

  @doc("The current state of the recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  planState?: RecoveryPlanState;

  @doc("A description of the recovery orchestration plan.")
  @minLength(5)
  @maxLength(50)
  planDescription: string;

  @doc("Settings for the recovery orchestration groups associated with the recovery orchestration plan.")
  recoveryGroupsSetting: RecoveryGroupsSetting;

  @doc("The status of the most recent failover operation executed.")
  @visibility(Lifecycle.Read)
  latestFailoverStatus?: RecoveryPlanFailoverOperationStatus;

  @doc("The status of the most recent validation performed.")
  @visibility(Lifecycle.Read)
  latestValidationStatus?: RecoveryPlanOperationStatus;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
@tenantResource
@doc("Represents a recovery orchestration plan resource in the Azure Resilience Management provider namespace.")
model RecoveryPlan is ProxyResource<RecoveryPlanProperties> {
  @doc("The name of the recovery orchestration plan.")
  @pattern("^[a-zA-Z0-9-]{5,24}$")
  @key("recoveryPlanName")
  @segment("recoveryPlans")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  ...ManagedServiceIdentityProperty;
}
