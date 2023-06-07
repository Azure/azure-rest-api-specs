import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";

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

@doc("Known versions for this service.")
enum Versions {
  @doc("2023-06-01-preview")
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2023-06-01-preview`,
}
