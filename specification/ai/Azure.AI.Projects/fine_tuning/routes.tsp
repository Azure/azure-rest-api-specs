import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias FineTuningServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias FineTuningOperations = Azure.Core.ResourceOperations<FineTuningServiceTraits>;

@route("fine_tuning")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface FineTuningJobs {
  @doc("Get info about a fine-tuning job.")
  get is FineTuningOperations.ResourceRead<FineTuningJob>;
}
