import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListIndexVersionParameters = {
  @doc("Continuation token for pagination.")
  @query
  continuationToken?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_05_01)
interface Indexes
  extends ServicePatterns.VersionedOperations<
      Index,
      "PendingUploadRequest",
      ListIndexVersionParameters,
      ListIndexVersionParameters
    > {}
