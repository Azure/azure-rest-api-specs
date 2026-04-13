import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListModelVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v1)
@tag("Models")
interface Models
  extends VersionedOperations<
      ModelVersion,
      InputParameters<ModelVersion>,
      ListModelVersionsParameters,
      ListModelVersionsParameters
    > {}
