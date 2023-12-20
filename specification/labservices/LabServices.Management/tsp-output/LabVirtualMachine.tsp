import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LabServices;
@doc("A lab virtual machine resource.")
@parentResource(Lab)
model LabVirtualMachine is ProxyResource<VirtualMachineProperties> {
  @doc("The ID of the virtual machine that uniquely identifies it within the containing lab. Used in resource URIs.")
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("virtualMachineName")
  @segment("virtualMachines")
  name: string;
}

@armResourceOperations
interface LabVirtualMachines {
  @doc("Returns the properties for a lab virtual machine.")
  get is ArmResourceRead<LabVirtualMachine>;
  @doc("Returns a list of all virtual machines for a lab.")
  listByLab is ArmResourceListByParent<
    LabVirtualMachine,
    {
      ...BaseParameters<LabVirtualMachine>;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Action to start a lab virtual machine.")
  start is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Action to stop a lab virtual machine.")
  stop is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Re-image a lab virtual machine. The virtual machine will be deleted and recreated using the latest published snapshot of the reference environment of the lab.")
  reimage is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Action to redeploy a lab virtual machine to a different compute node. For troubleshooting connectivity.")
  redeploy is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Resets a lab virtual machine password.")
  resetPassword is ArmResourceActionAsync<
    LabVirtualMachine,
    ResetPasswordBody,
    void
  >;
}
