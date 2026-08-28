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
  location: Azure.Core.azureLocation;
};

@@clientName(
  VirtualMachineBulkOperations.bulkDeallocate::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkDeallocate::parameters.body,
  "The virtual machines to deallocate and the execution settings for the bulk action."
);
@@clientName(
  VirtualMachineBulkOperations.bulkHibernate::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkHibernate::parameters.body,
  "The virtual machines to hibernate and the execution settings for the bulk action."
);
@@clientName(
  VirtualMachineBulkOperations.bulkStart::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkStart::parameters.body,
  "The virtual machines to start and the execution settings for the bulk action."
);
@@clientName(
  VirtualMachineBulkOperations.bulkCreate::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkCreate::parameters.body,
  "The virtual machine configuration and execution settings for the bulk create action."
);
@@clientName(
  VirtualMachineBulkOperations.bulkVdiFlexCreate::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkVdiFlexCreate::parameters.body,
  "The virtual desktop infrastructure configuration and allocation preferences for the bulk create action."
);
@@clientName(
  VirtualMachineBulkOperations.bulkDelete::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkDelete::parameters.body,
  "The virtual machines to delete and the execution settings for the bulk action."
);
@@clientName(
  VirtualMachineBulkOperations.bulkReimage::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkReimage::parameters.body,
  "The virtual machines to reimage and the execution settings for the bulk action."
);
@@clientName(
  VirtualMachineBulkOperations.bulkGetOperationsStatus::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkGetOperationsStatus::parameters.body,
  "The Bulk Action Operation Ids that identify the operations for which current status should be returned."
);
@@clientName(
  VirtualMachineBulkOperations.bulkCancel::parameters.body,
  "requestBody"
);
@@doc(
  VirtualMachineBulkOperations.bulkCancel::parameters.body,
  "The Bulk Action Operation Ids that identify the operations to cancel."
);

@armResourceOperations(#{ omitTags: true })
interface VirtualMachineBulkOperations {
  // -------------- Routes -------------
  /** Deallocates one or more virtual machines. Bulk Actions begins processing the request immediately and returns a Bulk Action Operation Id for each virtual machine. Use the returned IDs to get operation status. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkDeallocate")
  bulkDeallocate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The virtual machines to deallocate and the execution settings for the bulk action.")
    @body
    body: ExecuteDeallocateRequest,
  ): ArmResponse<DeallocateResourceOperationResponse> | ErrorResponse;
  /** Hibernates one or more virtual machines that support hibernation. Bulk Actions begins processing the request immediately and returns a Bulk Action Operation Id for each virtual machine. Use the returned IDs to get operation status. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkHibernate")
  bulkHibernate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The virtual machines to hibernate and the execution settings for the bulk action.")
    @body
    body: ExecuteHibernateRequest,
  ): ArmResponse<HibernateResourceOperationResponse> | ErrorResponse;

  /** Starts one or more virtual machines. Bulk Actions begins processing the request immediately and returns a Bulk Action Operation Id for each virtual machine. Use the returned IDs to get operation status. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkStart")
  bulkStart(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The virtual machines to start and the execution settings for the bulk action.")
    @body
    body: ExecuteStartRequest,
  ): ArmResponse<StartResourceOperationResponse> | ErrorResponse;

  /** Creates one or more virtual machines from a common configuration and optional per-virtual-machine overrides. Bulk Actions begins processing the request immediately and returns a Bulk Action Operation Id for each virtual machine. Use the returned IDs to get operation status. */
  @removed(Versions.`2026-06-06`)
  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkCreate")
  bulkCreate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The virtual machine configuration and execution settings for the bulk create action.")
    @body
    body: ExecuteCreateRequest,
  ): ArmResponse<CreateResourceOperationResponse> | ErrorResponse;

  /** Creates one or more virtual machines for a virtual desktop infrastructure workload by using flexible SKU and availability zone preferences. Bulk Actions begins processing the request immediately and returns a Bulk Action Operation Id for each virtual machine. Use the returned IDs to get operation status. */
  @removed(Versions.`2026-06-06`)
  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkVdiFlexCreate")
  bulkVdiFlexCreate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The virtual desktop infrastructure configuration and allocation preferences for the bulk create action.")
    @body
    body: ExecuteVdiCreateRequest,
  ): ArmResponse<CreateResourceOperationResponse> | ErrorResponse;

  /** Deletes one or more virtual machines. This operation is destructive. Bulk Actions begins processing the request immediately and returns a Bulk Action Operation Id for each virtual machine. Use the returned IDs to get operation status. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkDelete")
  bulkDelete(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The virtual machines to delete and the execution settings for the bulk action.")
    @body
    body: ExecuteDeleteRequest,
  ): ArmResponse<DeleteResourceOperationResponse> | ErrorResponse;

  /** Gets the current status of operations identified by their Bulk Action Operation Ids. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkGetOperationStatus")
  bulkGetOperationsStatus(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The Bulk Action Operation Ids that identify the operations for which current status should be returned.")
    @body
    body: GetOperationStatusRequest,
  ): ArmResponse<GetOperationStatusResponse> | ErrorResponse;

  /** Cancels eligible start, deallocate, or hibernate operations identified by their Bulk Action Operation Ids. Work that has already completed is not reversed. */
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkCancel")
  bulkCancel(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The Bulk Action Operation Ids that identify the operations to cancel.")
    @body
    body: CancelOperationsRequest,
  ): ArmResponse<CancelOperationsResponse> | ErrorResponse;

  /** Reimages one or more virtual machines. Reimaging is destructive and can replace operating system disk contents. Bulk Actions begins processing the request immediately and returns a Bulk Action Operation Id for each virtual machine. Use the returned IDs to get operation status. */
  @removed(Versions.`2026-06-06`)
  @added(Versions.`2026-07-06-preview`)
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("virtualMachinesBulkReimage")
  bulkReimage(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @doc("The virtual machines to reimage and the execution settings for the bulk action.")
    @body
    body: ExecuteReimageRequest,
  ): ArmResponse<ReimageResourceOperationResponse> | ErrorResponse;

  /** Lists recent errors for operations in a resource group. */
  @added(Versions.`2026-07-06-preview`)
  @get
  @autoRoute
  @list
  @action("listBulkOperationErrors")
  bulkListOperationErrors(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @query("lookbackInMinutes")
    @doc("The number of minutes before the current time to include when listing bulk action errors.")
    lookbackInMinutes?: int32,
  ): ArmResponse<ListBulkOperationErrorsResponse> | ErrorResponse;

  /** Acknowledges errors for specified operations in a resource group. */
  @added(Versions.`2026-07-06-preview`)
  @post
  @autoRoute
  @armResourceCollectionAction
  @action("acknowledgeBulkOperationErrors")
  bulkAcknowledgeOperationErrors(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension.ResourceGroup>,
    ...Extension.ResourceGroup,
    ...ProviderNamespace<Extension.ResourceGroup>,
    ...LocationParameter,

    @body
    @doc("The Bulk Action Operation Ids that identify operations for which errors should be acknowledged.")
    body: AcknowledgeBulkOperationErrorsRequest,
  ): ArmResponse<AcknowledgeBulkOperationErrorsResponse> | ErrorResponse;
}
