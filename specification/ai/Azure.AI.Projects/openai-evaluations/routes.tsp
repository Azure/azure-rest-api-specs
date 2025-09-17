import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../.external-readonly/openai.external.typespec/evals/models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ServiceTraitsEvals = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvalsOperations = Azure.Core.ResourceOperations<ServiceTraitsEvals>;

@route("openai/evals")
@added(Versions.v2025_10_15_preview)
@removed(Versions.v1)
interface Evals {


}
