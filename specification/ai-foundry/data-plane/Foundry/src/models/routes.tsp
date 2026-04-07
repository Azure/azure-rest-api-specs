import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListModelVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Models")
interface Models
  extends ReadableVersionedOperations<
      ModelVersion,
      ListModelVersionsParameters,
      ListModelVersionsParameters
    > {}
