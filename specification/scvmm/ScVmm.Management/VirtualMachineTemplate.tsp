import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** The VirtualMachineTemplates resource definition. */
model VirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  /** Name of the VirtualMachineTemplate. */
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachineTemplates {
  /** Implements VirtualMachineTemplate GET method. */
  get is ArmResourceRead<VirtualMachineTemplate>;
  /** Onboards the ScVmm VM Template as an Azure VM Template resource. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualMachineTemplate>;
  /** Updates the VirtualMachineTemplate resource. */
  update is ArmTagsPatchAsync<VirtualMachineTemplate>;
  /** Deregisters the ScVmm VM Template from Azure. */
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineTemplate,
    {
      ...BaseParameters<VirtualMachineTemplate>;
      ...QueryForceDelete;
    }
  >;
  /** List of VirtualMachineTemplates in a resource group. */
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;
  /** List of VirtualMachineTemplates in a subscription. */
  listBySubscription is ArmListBySubscription<VirtualMachineTemplate>;
}
