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
  /** submitDeallocate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/submitDeallocate")
  @post
  @action
  submitDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | RequestLevelError;

  /** submitHibernate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/submitHibernate")
  @post
  @action
  submitHibernate(
    ...Params,
    @body @doc("The request body") requestBody: SubmitHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | RequestLevelError;

  /** submitStart for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/submitStart")
  @post
  @action
  submitStart(
    ...Params,
    @body @doc("The request body") requestBody: SubmitStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | RequestLevelError;

  /** executeDeallocate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/executeDeallocate")
  @post
  @action
  executeDeallocate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | RequestLevelError;

  /** executeHibernate for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/executeHibernate")
  @post
  @action
  executeHibernate(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | RequestLevelError;

  /** executeStart for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/executeStart")
  @post
  @action
  executeStart(
    ...Params,
    @body @doc("The request body") requestBody: ExecuteStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | RequestLevelError;

  /** getOperationStatus for a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/getOperationStatus")
  @post
  @action
  getoperationstatus(
    ...Params,
    @body @doc("The request body") requestBody: GetOperationStatusRequest,
  ): ArmResponse<GetOperationStatusResponse> | RequestLevelError;

  /** cancelOperations on a virtual machine */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "necessary to avoid standard routing"
  @route("/subscriptions/{subscriptionId}/locations/{locationparameter}/providers/Microsoft.Compute/virtualMachines/providers/Microsoft.ComputeSchedule/cancelOperations")
  @post
  @action
  cancelops(
    ...Params,
    @body @doc("The request body") requestBody: CancelOperationsRequest,
  ): ArmResponse<CancelOperationsResponse> | RequestLevelError;
}
