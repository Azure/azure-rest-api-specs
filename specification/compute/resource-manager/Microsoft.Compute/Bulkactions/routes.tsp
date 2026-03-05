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

@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteDeallocate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesExecuteDeallocate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteHibernate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesExecuteHibernate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteStart::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesExecuteStart::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteCreate::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesExecuteCreate::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteDelete::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesExecuteDelete::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesGetOperationStatus::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesGetOperationStatus::parameters.body,
  "The request body"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesCancelOperations::parameters.body,
  "requestBody"
);
@@doc(VirtualMachineBulkOperations.virtualMachinesCancelOperations::parameters.body,
  "The request body"
);

@armResourceOperations(#{ omitTags: true })
interface VirtualMachineBulkOperations {
  // -------------- Routes -------------
  /** VirtualMachinesExecuteDeallocate: Execute deallocate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteDeallocate is ArmProviderActionSync<
    Request = ExecuteDeallocateRequest,
    Response = ArmResponse<DeallocateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteHibernate: Execute hibernate operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteHibernate is ArmProviderActionSync<
    Request = ExecuteHibernateRequest,
    Response = ArmResponse<HibernateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteStart: Execute start operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteStart is ArmProviderActionSync<
    Request = ExecuteStartRequest,
    Response = ArmResponse<StartResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteCreate: Execute create operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteCreate is ArmProviderActionSync<
    Request = ExecuteCreateRequest,
    Response = ArmResponse<CreateResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesExecuteDelete: Execute delete operation for a batch of virtual machines, this operation is triggered as soon as Computeschedule receives it. */
  virtualMachinesExecuteDelete is ArmProviderActionSync<
    Request = ExecuteDeleteRequest,
    Response = ArmResponse<DeleteResourceOperationResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesGetOperationStatus: Polling endpoint to read status of operations performed on virtual machines */
  virtualMachinesGetOperationStatus is ArmProviderActionSync<
    Request = GetOperationStatusRequest,
    Response = ArmResponse<GetOperationStatusResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;

  /** VirtualMachinesCancelOperations: Cancel a previously submitted (start/deallocate/hibernate) request */
  virtualMachinesCancelOperations is ArmProviderActionSync<
    Request = CancelOperationsRequest,
    Response = ArmResponse<CancelOperationsResponse>,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;
}
