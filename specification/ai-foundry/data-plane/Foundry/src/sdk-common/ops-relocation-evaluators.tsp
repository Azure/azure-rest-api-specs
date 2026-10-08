// Evaluator client-location relocations.
//
// Rubric-based (GA) evaluator operations live on the root Evaluators client
// (client.evaluators.*). Custom code-based (preview) blob-upload operations
// remain in the ".beta" sub-client (client.beta.evaluators.*).
//
// This file is imported by ops-relocation-projects.tsp, which is imported by the
// client.tsp files used to emit the Python, JS, and Java clients.
// See https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#move-all-operations-to-root-client

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects {
  // Rubric-based evaluator generation jobs are grouped under the root Evaluators client.
  @@clientLocation(
    Azure.AI.Projects.EvaluatorGenerationJobs.create,
    Evaluators
  );
  @@clientLocation(Azure.AI.Projects.EvaluatorGenerationJobs.get, Evaluators);
  @@clientLocation(Azure.AI.Projects.EvaluatorGenerationJobs.list, Evaluators);
  @@clientLocation(
    Azure.AI.Projects.EvaluatorGenerationJobs.cancel,
    Evaluators
  );
  @@clientLocation(
    Azure.AI.Projects.EvaluatorGenerationJobs.delete,
    Evaluators
  );
}

namespace Azure.AI.Projects.Beta {
  interface Evaluators {}

  // Custom code-based (preview) blob-upload operations remain in the .beta sub-client.
  @@clientLocation(Azure.AI.Projects.Evaluators.startPendingUpload, Evaluators);
  @@clientLocation(Azure.AI.Projects.Evaluators.getCredentials, Evaluators);
}
