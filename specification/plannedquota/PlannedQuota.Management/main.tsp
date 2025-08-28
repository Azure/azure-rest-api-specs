import "@azure-tools/typespec-autorest";
import "./versions.tsp";
import "./plannedquota.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service(#{ title: "Azure Planned Quota" })
@doc("Planned Quota Provider")
@versioned(Microsoft.PlannedQuota.Versions)
namespace Microsoft.PlannedQuota;

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Using Autorest.example intentionally to attach provider operations example"
@@Autorest.example(Operations.list,
  "./examples/PlannedQuota_Operations.json",
  "List Operations"
);

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union PlannedQuotaProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
