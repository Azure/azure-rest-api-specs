import "@azure-tools/typespec-azure-core";

using Azure.Core.Experimental;

namespace Azure.AI.ProjectsInternal {
  using Azure.AI.Projects;

  scalar numeric extends OpenAI.numeric;
}

namespace OpenAI {
  scalar integer extends TypeSpec.int64;
  scalar numeric extends TypeSpec.float64;
}

namespace Azure.AI.Projects {
  scalar integer extends OpenAI.integer;
  alias numeric = Azure.AI.ProjectsInternal.numeric;
}
