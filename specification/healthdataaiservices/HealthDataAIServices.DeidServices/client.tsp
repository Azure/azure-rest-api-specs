import "./main.tsp";
import "./models.tsp";
import "./models_document_flow.tsp";
import "./routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// @TypeSpec.Versioning.versioned(HealthDataAIServices.DeidServices.Versions)
namespace HealthDataAIServices.DeidServices {
  @@clientName(listJobDocuments, "listJobDocumentsInternal", "csharp,python");
  @@clientName(listJobs, "listJobsInternal", "csharp,python");
  @@clientName(HealthDataAIServices.DeidServices, "DeidentificationClient");
  @@access(listJobDocuments, Access.internal, "csharp,python");
  @@access(listJobs, Access.internal, "csharp,python");
  @@clientName(DeidentifyTextRequest.body, "content", "csharp");
}
