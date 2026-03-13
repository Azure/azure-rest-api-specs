import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
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

@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkDeallocate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkDeallocate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkHibernate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkHibernate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkStart::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkStart::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkCreate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkCreate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesVdiFlexCreate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesVdiFlexCreate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkDelete::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkDelete::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkReimage::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkReimage::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkGetOperationStatus::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkGetOperationStatus::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkCancelOperations::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesBulkCancelOperations::parameters.body,
  "The request body"
);

@armResourceOperations(#{ omitTags: true })
interface VirtualMachineBulkOperations {
  // -------------- Routes -------------
  /** VirtualMachinesBulkDeallocate: Execute deallocate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesBulkDeallocate is ArmProviderActionSync<
    Request = ExecuteDeallocateRequest,
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesBulkHibernate: Execute hibernate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesBulkHibernate is ArmProviderActionSync<
    Request = ExecuteHibernateRequest,
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesBulkStart: Execute start operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesBulkStart is ArmProviderActionSync<
    Request = ExecuteStartRequest,
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesBulkCreate: Execute create operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesBulkCreate is ArmProviderActionSync<
    Request = ExecuteCreateRequest,
    Response = ArmResponse<CreateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesVdiFlexCreate: Bulk create  operation for a batch of virtual machines, this operation supports flex properties to give options on Sku and zone selection. */
  virtualMachinesVdiFlexCreate is ArmProviderActionSync<
    Request = ExecuteVdiCreateRequest,
    Response = ArmResponse<CreateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesBulkDelete: Execute delete operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesBulkDelete is ArmProviderActionSync<
    Request = ExecuteDeleteRequest,
    Response = ArmResponse<DeleteResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesBulkGetOperationStatus: Polling endpoint to read status of operations performed on virtual machines */
  virtualMachinesBulkGetOperationStatus is ArmProviderActionSync<
    Request = GetOperationStatusRequest,
    Response = ArmResponse<GetOperationStatusResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesBulkCancelOperations: Cancel a previously submitted (start/deallocate/hibernate) request */
  virtualMachinesBulkCancelOperations is ArmProviderActionSync<
    Request = CancelOperationsRequest,
    Response = ArmResponse<CancelOperationsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesBulkReimage: Execute reimage operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesBulkReimage is ArmProviderActionSync<
    Request = ExecuteReimageRequest,
    Response = ArmResponse<ReimageResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;
}
