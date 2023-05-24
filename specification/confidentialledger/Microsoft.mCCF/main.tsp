import "@typespec/http";
import "@typespec/versioning";

import "./acks.tsp";
import "./proposals.tsp";
import "./recovery.tsp";
import "./transactions.tsp";
import "./service_state.tsp";

@service({
  title: "Managed CCF Governance",
})
@TypeSpec.Versioning.versioned(Microsoft.ManagedCcf.Versions)
namespace Microsoft.ManagedCcf;

enum Versions {
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `0.0.1-preview`,
}

@TypeSpec.Http.route("/gov/members")
interface GovMembers
  extends Proposals.Proposals,
    Proposals.Ballots,
    Acks.Acks,
    Recovery.Recovery {}

@TypeSpec.Http.route("/gov/service")
interface GovService extends Transactions.Transactions {}

@TypeSpec.Http.route("/gov")
interface GovState extends ServiceState.ServiceState {}
