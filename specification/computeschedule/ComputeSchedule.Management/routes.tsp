import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
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
  /** virtualMachinesSubmitDeallocateAction: submitDeallocate action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesSubmitDeallocateAction")
  @post
  @action
  virtualMachinesSubmitDeallocateAction(
    ...Params,
    @body @doc("The request body") requestBody: SubmitDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | RequestLevelError;

  /** virtualMachinesSubmitHibernateAction: submitHibernate action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesSubmitHibernateAction")
  @post
  @action
  virtualMachinesSubmitHibernateAction(
    ...Params,
    @body @doc("The request body") requestBody: SubmitHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | RequestLevelError;

  /** virtualMachinesSubmitStartAction: submitStart action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesSubmitStartAction")
  @post
  @action
  virtualMachinesSubmitStartAction(
    ...Params,
    @body @doc("The request body") requestBody: SubmitStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | RequestLevelError;

  /** virtualMachinesExecuteDeallocateAction: executeDeallocate action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesExecuteDeallocateAction")
  @post
  @action
  virtualMachinesExecuteDeallocateAction(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | RequestLevelError;

  /** virtualMachinesExecuteHibernateAction: executeHibernate action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesExecuteHibernateAction")
  @post
  @action
  virtualMachinesExecuteHibernateAction(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | RequestLevelError;

  /** virtualMachinesExecuteStartAction: executeHibernate action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesExecuteStartAction")
  @post
  @action
  virtualMachinesExecuteStartAction(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | RequestLevelError;

  /** virtualMachinesGetOperationStatusAction: getOperationStatus action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesGetOperationStatusAction")
  @post
  @action
  virtualMachinesGetOperationStatusAction(
    ...Params,
    @body @doc("The request body") requestBody: GetOperationStatusRequest,
  ): ArmResponse<GetOperationStatusResponse> | RequestLevelError;

  /** virtualMachinesCancelOperationsAction: cancelOperations action for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.ComputeSchedule/virtualMachinesCancelOperationsAction")
  @post
  @action
  virtualMachinesCancelOperationsAction(
    ...Params,
    @body @doc("The request body") requestBody: CancelOperationsRequest,
  ): ArmResponse<CancelOperationsResponse> | RequestLevelError;
}
