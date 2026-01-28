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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Indexes")
interface Indexes
  extends VersionedOperations<
      Index,
      InputParameters<Index, "index">,
      ListIndexVersionParameters,
      ListIndexVersionParameters
    > {}
