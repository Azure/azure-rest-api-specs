import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute;

interface Operations extends Azure.ResourceManager.Operations {}

alias LocationParameter = {
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  locationparameter: Azure.Core.azureLocation;
};

alias DefaultVirtualMachines = {
  /** Static virtual machine segment for bulk VM operations. */
  @path
  @segment("virtualMachines")
  virtualMachines: "bulkVmOperations";
};

@@clientName(VirtualMachineBulkOperations.bulkDeallocate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkDeallocate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkHibernate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkHibernate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkStart::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkStart::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkCreate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkCreate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkVdiFlexCreate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkVdiFlexCreate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkDelete::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkDelete::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkReimage::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkReimage::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkGetOperationsStatus::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkGetOperationsStatus::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.bulkCancel::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.bulkCancel::parameters.body,
  "The request body"
);

@armResourceOperations(#{ omitTags: true })
interface VirtualMachineBulkOperations {
  // -------------- Routes -------------
  /** BulkDeallocate: Execute deallocate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("deallocate")
  bulkDeallocate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: ExecuteDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;
  /** BulkHibernate: Execute hibernate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("hibernate")
  bulkHibernate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: ExecuteHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** BulkStart: Execute start operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("start")
  bulkStart(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: ExecuteStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** BulkCreate: Execute create operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("create")
  bulkCreate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: ExecuteCreateRequest,
  ): ArmResponse<CreateResourceOperationResponse> | ErrorResponse;

  /** BulkVdiFlexCreate: Bulk create  operation for a batch of virtual machines, this operation supports flex properties to give options on Sku and zone selection. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("vdiFlexCreate")
  bulkVdiFlexCreate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: ExecuteVdiCreateRequest,
  ): ArmResponse<CreateResourceOperationResponse> | ErrorResponse;

  /** BulkDelete: Execute delete operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("delete")
  bulkDelete(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: ExecuteDeleteRequest,
  ): ArmResponse<DeleteResourceOperationResponse> | ErrorResponse;

  /** BulkGetOperationsStatus: Polling endpoint to read status of operations performed on virtual machines */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("getOperationsStatus")
  bulkGetOperationsStatus(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: GetOperationStatusRequest,
  ): ArmResponse<GetOperationStatusResponse> | ErrorResponse;

  /** BulkCancelOperations: Cancel a previously submitted (start/deallocate/hibernate) request */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("cancel")
  bulkCancel(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: CancelOperationsRequest,
  ): ArmResponse<CancelOperationsResponse> | ErrorResponse;

  /** BulkReimage: Execute reimage operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("reimage")
  bulkReimage(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,

    @doc("The request body")
    @body
    body: ExecuteReimageRequest,
  ): ArmResponse<ReimageResourceOperationResponse> | ErrorResponse;
  /** BulkVmOperations_Get: Gets the singleton bulk VM operations proxy resource status. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Singleton proxy read endpoint; not an ARM tracked resource read."
  @get
  @autoRoute
  bulkVmOperations(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.Subscription>,
    ...Extension.Subscription,
    ...ProviderNamespace<Extension.Subscription>,
    ...LocationParameter,
    ...DefaultVirtualMachines,
  ): ArmResponse<BulkVmOperationsReadResponse> | ErrorResponse;
}
