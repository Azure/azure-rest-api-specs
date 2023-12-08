import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ArcScVmm;
@doc("The VirtualMachineTemplates resource definition.")
model ScVmmVirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  @doc("Name of the VirtualMachineTemplate.")
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface ScVmmVirtualMachineTemplates {
  @doc("Implements VirtualMachineTemplate GET method.")
  get is ArmResourceRead<ScVmmVirtualMachineTemplate>;
  @doc("Onboards the ScVmm VM Template as an Azure VM Template resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ScVmmVirtualMachineTemplate>;
  @doc("Updates the VirtualMachineTemplate resource.")
  update is ArmTagsPatchAsync<ScVmmVirtualMachineTemplate>;
  @doc("Deregisters the ScVmm VM Template from Azure.")
  delete is ArmResourceDeleteAsync<
    ScVmmVirtualMachineTemplate,
    {
      ...BaseParameters<ScVmmVirtualMachineTemplate>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of VirtualMachineTemplates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ScVmmVirtualMachineTemplate>;
  @doc("List of VirtualMachineTemplates in a subscription.")
  listBySubscription is ArmListBySubscription<ScVmmVirtualMachineTemplate>;
}
