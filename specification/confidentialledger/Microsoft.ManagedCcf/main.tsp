import "@typespec/http";
import "@typespec/versioning";

import "./acks.tsp";
import "./proposals.tsp";
import "./recovery.tsp";
import "./service_state.tsp";
import "./transactions.tsp";

#suppress "@azure-tools/typespec-azure-core/auth-required" "!!FIXME!!"
@service(#{ title: "Managed CCF Governance" })
@TypeSpec.Versioning.versioned(Microsoft.ManagedCcf.Versions)
namespace Microsoft.ManagedCcf;

enum Versions {
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2023-06-01-preview`,
}
