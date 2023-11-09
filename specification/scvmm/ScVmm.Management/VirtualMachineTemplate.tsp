import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
@doc("The VirtualMachineTemplates resource definition.")
model VirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  @doc("Name of the VirtualMachineTemplate.")
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachineTemplates {
  @doc("Implements VirtualMachineTemplate GET method.")
  get is ArmResourceRead<VirtualMachineTemplate>;
  @doc("Onboards the ScVmm VM Template as an Azure VM Template resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualMachineTemplate>;
  @doc("Updates the VirtualMachineTemplate resource.")
  update is ArmTagsPatchAsync<VirtualMachineTemplate>;
  @doc("Deregisters the ScVmm VM Template from Azure.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineTemplate,
    {
      ...BaseParameters<VirtualMachineTemplate>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: Force;
    }
  >;
  @doc("List of VirtualMachineTemplates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;
  @doc("List of VirtualMachineTemplates in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualMachineTemplate>;
}
