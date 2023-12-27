import "@typespec/http";
import "@typespec/versioning";

import "./acks.tsp";
import "./proposals.tsp";
import "./recovery.tsp";
import "./service_state.tsp";
import "./transactions.tsp";

@service({
  title: "Managed CCF Governance",
})
@TypeSpec.Versioning.versioned(Microsoft.ManagedCcf.Versions)
namespace Microsoft.ManagedCcf;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2023-06-01-preview`,
}
