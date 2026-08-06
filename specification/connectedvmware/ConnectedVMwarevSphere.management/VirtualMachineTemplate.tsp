import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the virtualMachineTemplate.")
model VirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  @doc("Name of the virtual machine template resource.")
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VirtualMachineTemplates {
  @doc("Implements virtual machine template GET method.")
  get is ArmResourceRead<VirtualMachineTemplate>;
  @doc("Create Or Update virtual machine template.")
  create is ArmResourceCreateOrUpdateAsync<VirtualMachineTemplate>;
  @doc("API to update certain properties of the virtual machine template resource.")
  update is ArmTagsPatchSync<VirtualMachineTemplate>;
  @doc("Implements virtual machine template DELETE method.")
  delete is ArmResourceDeleteAsync<
    VirtualMachineTemplate,
    {
      ...BaseParameters<VirtualMachineTemplate>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of virtualMachineTemplates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;
  @doc("List of virtualMachineTemplates in a subscription.")
  list is ArmListBySubscription<VirtualMachineTemplate>;
}
