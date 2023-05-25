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

enum Versions {
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `0.0.1-preview`,
}
