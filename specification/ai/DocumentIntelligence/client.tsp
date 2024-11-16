import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using DocumentIntelligence;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(DocumentIntelligence.Versions.v2024_11_30)
namespace ClientCustomizations;

@client({
  name: "DocumentIntelligenceClient",
  service: DocumentIntelligence,
})
interface DocumentIntelligenceClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  analyzeDocument is DocumentModels.analyzeDocument;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getAnalyzeResultPdf is DocumentModels.getAnalyzeResultPdf;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getAnalyzeResultFigure is DocumentModels.getAnalyzeResultFigure;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteAnalyzeResult is DocumentModels.deleteAnalyzeResult;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  analyzeBatchDocuments is DocumentModels.analyzeBatchDocuments;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listAnalyzeBatchResults is DocumentModels.listAnalyzeBatchResults;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteAnalyzeBatchResult is DocumentModels.deleteAnalyzeBatchResult;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getAnalyzeBatchResult is DocumentModels.getAnalyzeBatchResult;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  classifyDocument is DocumentClassifiers.classifyDocument;
}

@client({
  name: "DocumentIntelligenceAdministrationClient",
  service: DocumentIntelligence,
})
interface DocumentIntelligenceAdministrationClient {
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
  getResourceDetails is MiscellaneousOperations.getResourceDetails;
  getOperation is MiscellaneousOperations.getOperation;
  listOperations is MiscellaneousOperations.listOperations;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  buildClassifier is DocumentClassifiers.buildClassifier;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  authorizeClassifierCopy is DocumentClassifiers.authorizeClassifierCopy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  copyClassifierTo is DocumentClassifiers.copyClassifierTo;
  getClassifier is DocumentClassifiers.getClassifier;
  listClassifiers is DocumentClassifiers.listClassifiers;
  deleteClassifier is DocumentClassifiers.deleteClassifier;
}

@@clientName(AnalyzeBatchDocumentsRequest,
  "AnalyzeBatchDocumentsContent",
  "csharp"
);
@@clientName(AnalyzeDocumentRequest, "AnalyzeDocumentContent", "csharp");
@@clientName(AnalyzeDocumentRequest.urlSource, "UriSource", "csharp");
@@clientName(AuthorizeClassifierCopyRequest,
  "AuthorizeClassifierCopyContent",
  "csharp"
);
@@clientName(AuthorizeCopyRequest, "AuthorizeCopyContent", "csharp");
@@clientName(AzureBlobContentSource, "BlobContentSource", "csharp");
@@clientName(AzureBlobContentSource.containerUrl, "ContainerUri", "csharp");
@@clientName(AzureBlobFileListContentSource,
  "BlobFileListContentSource",
  "csharp"
);
@@clientName(AzureBlobFileListContentSource.containerUrl,
  "ContainerUri",
  "csharp"
);
@@clientName(BuildDocumentClassifierRequest,
  "BuildDocumentClassifierContent",
  "csharp"
);
@@clientName(BuildDocumentClassifierRequest.docTypes,
  "DocumentTypes",
  "csharp"
);
@@clientName(BuildDocumentModelRequest, "BuildDocumentModelContent", "csharp");
@@clientName(BuildDocumentModelRequest.azureBlobSource, "BlobSource", "csharp");
@@clientName(BuildDocumentModelRequest.azureBlobFileListSource,
  "BlobFileListSource",
  "csharp"
);
@@clientName(ClassifierCopyAuthorization.expirationDateTime,
  "ExpiresOn",
  "csharp"
);
@@clientName(ClassifierDocumentTypeDetails.azureBlobSource,
  "BlobSource",
  "csharp"
);
@@clientName(ClassifierDocumentTypeDetails.azureBlobFileListSource,
  "BlobFileListSource",
  "csharp"
);
@@clientName(ClassifyDocumentRequest, "ClassifyDocumentContent", "csharp");
@@clientName(ClassifyDocumentRequest.urlSource, "UriSource", "csharp");
@@clientName(ComposeDocumentModelRequest,
  "ComposeDocumentModelContent",
  "csharp"
);
@@clientName(ComposeDocumentModelRequest.docTypes, "DocumentTypes", "csharp");
@@clientName(ContentSourceKind.azureBlob, "Blob", "csharp");
@@clientName(ContentSourceKind.azureBlobFileList, "BlobFileList", "csharp");
@@clientName(ContentSourceKind.url, "Uri", "csharp");
@@clientName(ModelCopyAuthorization.expirationDateTime, "ExpiresOn", "csharp");
@@clientName(AnalyzedDocument.docType, "DocumentType", "csharp");
@@clientName(DocumentAnalysisFeature.styleFont, "FontStyling", "csharp");
@@clientName(DocumentBarcodeKind.EAN13, "Ean13", "csharp");
@@clientName(DocumentBarcodeKind.EAN8, "Ean8", "csharp");
@@clientName(DocumentBarcodeKind.ITF, "Itf", "csharp");
@@clientName(DocumentBarcodeKind.MicroQRCode, "MicroQrCode", "csharp");
@@clientName(DocumentBarcodeKind.PDF417, "Pdf417", "csharp");
@@clientName(DocumentBarcodeKind.QRCode, "QrCode", "csharp");
@@clientName(DocumentBarcodeKind.UPCA, "Upca", "csharp");
@@clientName(DocumentBarcodeKind.UPCE, "Upce", "csharp");
@@clientName(DocumentClassifierDetails.createdDateTime, "CreatedOn", "csharp");
@@clientName(DocumentClassifierDetails.docTypes, "DocumentTypes", "csharp");
@@clientName(DocumentClassifierDetails.expirationDateTime,
  "ExpiresOn",
  "csharp"
);
@@clientName(DocumentClassifierDetails.modifiedDateTime,
  "ModifiedOn",
  "csharp"
);
@@clientName(DocumentField.valueArray, "ValueList", "csharp");
@@clientName(DocumentField.valueInteger, "ValueLong", "csharp");
@@clientName(DocumentField.valueNumber, "ValueDouble", "csharp");
@@clientName(DocumentField.valueObject, "ValueDictionary", "csharp");
@@clientName(DocumentFieldSchema.type, "FieldType", "csharp");
@@clientName(DocumentFieldType.array, "List", "csharp");
@@clientName(DocumentFieldType.integer, "Long", "csharp");
@@clientName(DocumentFieldType.number, "Double", "csharp");
@@clientName(DocumentFieldType.object, "Dictionary", "csharp");
@@clientName(DocumentModelDetails.azureBlobSource, "BlobSource", "csharp");
@@clientName(DocumentModelDetails.azureBlobFileListSource,
  "BlobFileListSource",
  "csharp"
);
@@clientName(DocumentModelDetails.createdDateTime, "CreatedOn", "csharp");
@@clientName(DocumentModelDetails.docTypes, "DocumentTypes", "csharp");
@@clientName(DocumentModelDetails.expirationDateTime, "ExpiresOn", "csharp");
@@clientName(DocumentModelDetails.modifiedDateTime, "ModifiedOn", "csharp");
// https://github.com/Azure/typespec-azure/issues/417
@@clientName(DocumentIntelligenceInnerError.innererror,
  "InnerErrorObject",
  "csharp"
);
@@clientName(DocumentIntelligenceOperationDetails.createdDateTime,
  "CreatedOn",
  "csharp"
);
@@clientName(DocumentIntelligenceOperationDetails.lastUpdatedDateTime,
  "LastUpdatedOn",
  "csharp"
);

@@clientName(AnalyzeDocumentRequest.base64Source, "bytesSource", "python");
@@clientName(ClassifyDocumentRequest.base64Source, "bytesSource", "python");
