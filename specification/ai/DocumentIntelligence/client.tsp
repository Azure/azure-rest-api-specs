import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using DocumentIntelligence;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
//@TypeSpec.Versioning.useDependency(DocumentIntelligence.Versions.v2023_07_31)
@TypeSpec.Versioning.useDependency(
  DocumentIntelligence.Versions.v2023_10_31_preview
)
namespace ClientCustomizations;

@client({
  name: "DocumentAnalysisClient",
  service: DocumentIntelligence,
})
interface DocumentAnalysisClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  analyzeDocument is DocumentModels.analyzeDocument;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  classifyDocument is DocumentClassifiers.classifyDocument;
}

@client({
  name: "DocumentModelAdministrationClient",
  service: DocumentIntelligence,
})
interface DocumentModelAdministrationClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  buildDocumentModel is DocumentModels.buildModel;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  composeModel is DocumentModels.composeModel;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  authorizeModelCopy is DocumentModels.authorizeModelCopy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  copyModelTo is DocumentModels.copyModelTo;
  getModel is DocumentModels.getModel;
  listModels is DocumentModels.listModels;
  deleteModel is DocumentModels.deleteModel;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getResourceInfo is MiscellaneousOperations.getResourceInfo;
  getOperation is MiscellaneousOperations.getOperation;
  listOperations is MiscellaneousOperations.listOperations;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  buildClassifier is DocumentClassifiers.buildClassifier;
  getClassifier is DocumentClassifiers.getClassifier;
  listClassifiers is DocumentClassifiers.listClassifiers;
  deleteClassifier is DocumentClassifiers.deleteClassifier;
}
