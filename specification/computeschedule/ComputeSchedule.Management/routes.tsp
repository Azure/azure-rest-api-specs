import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ComputeSchedule;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Each resource interface must have an @armResourceOperations decorator."
interface ScheduledActions {
  // -------------- Routes -------------
  /** virtualMachinesSubmitDeallocate: submitDeallocate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitDeallocate")
  @post
  virtualMachinesSubmitDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesSubmitHibernate: submitHibernate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitHibernate")
  @post
  virtualMachinesSubmitHibernate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesSubmitStart: submitStart for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesSubmitStart")
  @post
  virtualMachinesSubmitStart(
    ...Params,
    @body @doc("The request body") requestBody: SubmitStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteDeallocate: executeDeallocate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteDeallocate")
  @post
  virtualMachinesExecuteDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteHibernate: executeHibernate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteHibernate")
  @post
  virtualMachinesExecuteHibernate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesExecuteStart: executeStart for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesExecuteStart")
  @post
  virtualMachinesExecuteStart(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** virtualMachinesGetOperationStatus: getOperationStatus for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesGetOperationStatus")
  @post
  virtualMachinesGetOperationStatus(
    ...Params,
    @body @doc("The request body") requestBody: GetOperationStatusRequest,
  ): ArmResponse<GetOperationStatusResponse> | ErrorResponse;

  /** virtualMachinesCancelOperations: cancelOperations for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ComputeSchedule/locations/{locationparameter}/virtualMachinesCancelOperations")
  @post
  virtualMachinesCancelOperations(
    ...Params,
    @body @doc("The request body") requestBody: CancelOperationsRequest,
  ): ArmResponse<CancelOperationsResponse> | ErrorResponse;
}
