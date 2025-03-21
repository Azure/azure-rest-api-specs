import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service(#{ title: "ModSimWorkbench Control Plane API" })
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("The application type of the chamber workload.")
union EdaType {
  string,

  @doc("Workload configured to support semiconductor design")
  Semiconductor: "Semiconductor",
}

@doc("Workload properties.")
model WorkloadProperties {
  ...ProvisioningStateProperty;
  ...PowerStateProperty;
  ...RestartAtProperty;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The virtual machine size of the chamber workload. For more information about virtual machine sizes, see [Sizes for virtual machines](https://learn.microsoft.com/azure/virtual-machines/sizes).<br/>The available chamber workload VM sizes depend on region.<br/>For a list of available sizes use these APIs: [List all available virtual machine sizes in a region](https://learn.microsoft.com/rest/api/compute/virtualmachinesizes/list), [List all available virtual machine sizes for resizing](https://learn.microsoft.com/rest/api/compute/virtualmachines/listavailablesizes).*")
  vmSize: string; // TODO: Eventually deprecate. Use top-level sku.

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Application type.")
  edaType: EdaType;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Fixing this would be a breaking change."
  @visibility(Lifecycle.Read)
  @doc("The chamber workload private IP address.")
  privateIP?: string; // TODO: Should be "privateIp";

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "zones needs to be removed from workload property level"
  @removed(Versions.`2024-05-01-preview`)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The chamber workload zone.")
  zones?: Array<string>;
}

@doc("Workload tracked resource.")
@parentResource(Chamber)
model Workload is TrackedResource<WorkloadProperties> {
  @doc("The name of the workload")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @segment("workloads")
  @key("workloadName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Availability Zones are a valid envelope property"
  @added(Versions.`2024-05-01-preview`)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The availability zones.")
  zones?: Array<string>;

  // #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Sku is a valid envelope property"
  // @added(Versions.`2024-05-01-preview`)
  //@visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  // @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  // sku: Azure.ResourceManager.Foundations.Sku;
}

@armResourceOperations
interface Workloads
  extends NestedResourceOperations<Workload, WorkloadProperties>,
    Restartable<Workload> {}
