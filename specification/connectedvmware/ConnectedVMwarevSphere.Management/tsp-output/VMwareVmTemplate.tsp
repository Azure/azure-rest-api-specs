import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConnectedVMwarevSphere;
@doc("Define the virtualMachineTemplate.")
model VMwareVmTemplate is TrackedResource<VirtualMachineTemplateProperties> {
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
interface VMwareVmTemplates {
  @doc("Implements virtual machine template GET method.")
  get is ArmResourceRead<VMwareVmTemplate>;
  @doc("Create Or Update virtual machine template.")
  create is ArmResourceCreateOrUpdateAsync<VMwareVmTemplate>;
  @doc("API to update certain properties of the virtual machine template resource.")
  update is ArmTagsPatchSync<VMwareVmTemplate>;
  @doc("Implements virtual machine template DELETE method.")
  delete is ArmResourceDeleteAsync<
    VMwareVmTemplate,
    {
      ...BaseParameters<VMwareVmTemplate>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of virtualMachineTemplates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VMwareVmTemplate>;
  @doc("List of virtualMachineTemplates in a subscription.")
  list is ArmListBySubscription<VMwareVmTemplate>;
}
