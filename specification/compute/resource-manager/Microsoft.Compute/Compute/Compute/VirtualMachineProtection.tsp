import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;
using TypeSpec.Versioning;

namespace Compute;

/**
 * Describes the protection configuration of a virtual machine.
 */
@added(Versions.v2026_09_01)
@singleton("default")
@parentResource(VirtualMachine)
model VirtualMachineProtection
  is Azure.ResourceManager.ProxyResource<VirtualMachineProtectionProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachineProtection,
    KeyName = "vmProtectionName",
    SegmentName = "vmProtections",
    NamePattern = ""
  >;
}

/**
 * Operations for managing the protection configuration of a virtual machine.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The singleton protection resource is always addressable. Protection is disabled by updating protectionType to None rather than deleting the resource."
@added(Versions.v2026_09_01)
@armResourceOperations(#{ omitTags: true })
@tag("VirtualMachineProtections")
interface VirtualMachineProtections {
  /**
   * [Preview Feature] Gets the protection configuration of a virtual machine.
   */
  @added(Versions.v2026_09_01)
  get is ComputeResourceRead<VirtualMachineProtection>;

  /**
   * [Preview Feature] Creates or updates the protection configuration of a virtual machine. Transitioning from None to AzureBackup is handled only internally by the Azure Backup service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "VirtualMachineProtection is a singleton that always exists on the virtual machine, so the service never returns 201. It returns 200 for both synchronous and asynchronous updates."
  @added(Versions.v2026_09_01)
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    VirtualMachineProtection,
    Response = ArmResourceUpdatedResponse<VirtualMachineProtection> &
      ArmCombinedLroHeaders<FinalResult = VirtualMachineProtection>
  >;

  /**
   * [Preview Feature] Lists the protection configuration of a virtual machine. The list contains the singleton 'default' protection resource.
   */
  @added(Versions.v2026_09_01)
  list is ComputeResourceListByParent<VirtualMachineProtection>;
}

@@doc(VirtualMachineProtection.name, "The singleton resource name.");
@@doc(
  VirtualMachineProtection.properties,
  "The properties of the virtual machine protection configuration."
);
@@doc(
  VirtualMachineProtections.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update the virtual machine protection configuration."
);
