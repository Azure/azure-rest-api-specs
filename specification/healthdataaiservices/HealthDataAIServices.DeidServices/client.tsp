import "./main.tsp";
import "./models.tsp";
import "./models_document_flow.tsp";
import "./routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// @TypeSpec.Versioning.versioned(HealthDataAIServices.DeidServices.Versions)
namespace HealthDataAIServices.DeidServices {
  // @override(HealthDataAIServices.DeidServices.listJobDocuments)
  // op listJobDocumentsCustomization(
  //   continuationToken?: None,
  //   jobName: string
  // ): Azure.Core.Page<HealthDataAIServices.DeidServices.DocumentDetails> | Azure.Core.Foundations.ErrorResponse;
}
