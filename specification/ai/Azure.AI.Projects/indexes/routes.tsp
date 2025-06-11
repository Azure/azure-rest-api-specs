import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListIndexVersionParameters = {};

@doc("Document me")
model IndexInputParameters is InputParameters<Index, "pendingUploadRequest">;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_05_01)
interface Indexes
  extends VersionedOperations<
      Index,
      IndexInputParameters,
      ListIndexVersionParameters,
      ListIndexVersionParameters
    > {}
