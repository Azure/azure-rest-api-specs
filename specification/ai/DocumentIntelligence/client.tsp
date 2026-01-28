import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using DocumentIntelligence;

@TypeSpec.Versioning.useDependency(DocumentIntelligence.Versions.v2024_11_30)
@TypeSpec.Versioning.useDependency(DocumentIntelligence.Versions.v2025_09_01)
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
  getAnalyzeResultPng is DocumentModels.getAnalyzeResultPng;
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

@@clientName(AuthorizeClassifierCopyRequest,
  "AuthorizeClassifierCopyOptions",
  "java"
);
@@clientName(BuildDocumentClassifierRequest,
  "BuildDocumentClassifierOptions",
  "java"
);
@@clientName(BuildDocumentClassifierRequest.docTypes, "documentTypes", "java");
@@clientName(BuildDocumentModelRequest, "BuildDocumentModelOptions", "java");
@@clientName(BuildDocumentModelRequest, "BuildDocumentModelOptions", "java");
@@clientName(ClassifyDocumentRequest, "ClassifyDocumentOptions", "java");
@@clientName(AnalyzeDocumentRequest, "AnalyzeDocumentOptions", "java");
@@clientName(AnalyzeBatchDocumentsRequest,
  "AnalyzeBatchDocumentsOptions",
  "java"
);
@@clientName(ComposeDocumentModelRequest,
  "ComposeDocumentModelOptions",
  "java"
);
@@clientName(AuthorizeCopyRequest, "AuthorizeModelCopyOptions", "java");
@@clientName(AnalyzeOutputOption, "AnalyzeOutputFormat", "java");

@@clientName(DocumentModelDetails.createdDateTime, "createdOn", "java");
@@clientName(DocumentModelDetails.docTypes, "documentTypes", "java");
@@clientName(DocumentModelDetails.expirationDateTime, "expiresOn", "java");
@@clientName(DocumentModelDetails.modifiedDateTime, "modifiedOn", "java");
@@clientName(ComposeDocumentModelRequest.docTypes, "documentTypes", "java");
@@clientName(ModelCopyAuthorization.expirationDateTime, "expiresOn", "java");
@@clientName(AnalyzedDocument.docType, "documentType", "java");
@@clientName(DocumentClassifierDetails.createdDateTime, "createdOn", "java");
@@clientName(DocumentClassifierDetails.docTypes, "documentTypes", "java");
@@clientName(DocumentClassifierDetails.expirationDateTime, "expiresOn", "java");
@@clientName(DocumentClassifierDetails.modifiedDateTime, "modifiedOn", "java");
@@clientName(DocumentIntelligenceOperationDetails.createdDateTime,
  "createdOn",
  "java"
);
@@clientName(DocumentIntelligenceOperationDetails.lastUpdatedDateTime,
  "lastUpdatedOn",
  "java"
);
@@clientName(ClassifierCopyAuthorization.expirationDateTime,
  "expiresOn",
  "java"
);
@@clientName(AnalyzeDocumentRequest.base64Source, "bytesSource", "java");
@@clientName(ClassifyDocumentRequest.base64Source, "bytesSource", "java");
@@clientName(AnalyzeOperation.createdDateTime, "createdOn", "java");
@@clientName(AnalyzeOperation.lastUpdatedDateTime, "lastUpdatedOn", "java");
@@clientName(AnalyzeBatchOperation.createdDateTime, "createdOn", "java");
@@clientName(AnalyzeBatchOperation.lastUpdatedDateTime,
  "lastUpdatedOn",
  "java"
);

@@clientName(StringIndexType.utf16CodeUnit, "utf16_CodeUnit", "java");
@@clientName(DocumentBarcodeKind.QRCode, "QR_Code", "java");
@@clientName(DocumentBarcodeKind.MicroQRCode, "MICRO_QR_CODE", "java");

@@clientName(DocumentIntelligenceError.innererror, "innerError", "java");
@@clientName(DocumentIntelligenceInnerError.innererror, "innerError", "java");
@@clientName(DocumentField.valueArray, "valueList", "java");
@@clientName(DocumentField.valueObject, "valueMap", "java");
@@clientName(AnalyzeBatchOperation, "AnalyzeBatchOperationDetails", "java");
@@clientName(AnalyzeOperation, "AnalyzeOperationDetails", "java");
@@clientName(AnalyzeBatchOperationDetail, "AnalyzeBatchResultDetails", "java");

@@clientName(AnalyzeBatchDocumentsRequest,
  "AnalyzeBatchDocumentsOptions",
  "csharp"
);
@@clientName(AnalyzeBatchDocumentsRequest.azureBlobSource,
  "BlobSource",
  "csharp"
);
@@clientName(AnalyzeBatchDocumentsRequest.azureBlobFileListSource,
  "BlobFileListSource",
  "csharp"
);
@@clientName(AnalyzeBatchDocumentsRequest.resultContainerUrl,
  "ResultContainerUri",
  "csharp"
);
@@clientName(AnalyzeBatchOperation, "AnalyzeBatchOperationDetails", "csharp");
@@clientName(AnalyzeBatchOperation.createdDateTime, "CreatedOn", "csharp");
@@clientName(AnalyzeBatchOperation.lastUpdatedDateTime,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(AnalyzeBatchOperationDetail,
  "AnalyzeBatchResultDetails",
  "csharp"
);
@@clientName(AnalyzeBatchOperationDetail.resultUrl, "ResultUri", "csharp");
@@clientName(AnalyzeBatchOperationDetail.sourceUrl, "SourceUri", "csharp");
@@clientName(AnalyzedDocument.docType, "DocumentType", "csharp");
@@clientName(AnalyzeDocumentRequest, "AnalyzeDocumentOptions", "csharp");
@@clientName(AnalyzeDocumentRequest.base64Source, "BytesSource", "csharp");
@@clientName(AnalyzeDocumentRequest.urlSource, "UriSource", "csharp");
@@clientName(AuthorizeClassifierCopyRequest,
  "AuthorizeClassifierCopyOptions",
  "csharp"
);
@@clientName(AuthorizeCopyRequest, "AuthorizeModelCopyOptions", "csharp");
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
  "BuildClassifierOptions",
  "csharp"
);
@@clientName(BuildDocumentClassifierRequest.docTypes,
  "DocumentTypes",
  "csharp"
);
@@clientName(BuildDocumentModelRequest, "BuildDocumentModelOptions", "csharp");
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
@@clientName(ClassifyDocumentRequest, "ClassifyDocumentOptions", "csharp");
@@clientName(ClassifyDocumentRequest.base64Source, "BytesSource", "csharp");
@@clientName(ClassifyDocumentRequest.urlSource, "UriSource", "csharp");
@@clientName(ComposeDocumentModelRequest, "ComposeModelOptions", "csharp");
@@clientName(ComposeDocumentModelRequest.docTypes, "DocumentTypes", "csharp");
@@clientName(ContentSourceKind.azureBlob, "Blob", "csharp");
@@clientName(ContentSourceKind.azureBlobFileList, "BlobFileList", "csharp");
@@clientName(ContentSourceKind.base64, "Bytes", "csharp");
@@clientName(ContentSourceKind.url, "Uri", "csharp");
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
@@clientName(DocumentField.type, "FieldType", "csharp");
@@clientName(DocumentField.valueArray, "ValueList", "csharp");
@@clientName(DocumentField.valueInteger, "ValueInt64", "csharp");
@@clientName(DocumentField.valueNumber, "ValueDouble", "csharp");
@@clientName(DocumentFieldSchema.type, "FieldType", "csharp");
@@clientName(DocumentFieldType.array, "List", "csharp");
@@clientName(DocumentFieldType.integer, "Int64", "csharp");
@@clientName(DocumentFieldType.number, "Double", "csharp");
@@clientName(DocumentFieldType.object, "Dictionary", "csharp");
@@clientName(DocumentIntelligenceError.innererror, "InnerError", "csharp");
@@clientName(DocumentIntelligenceInnerError.innererror, "InnerError", "csharp");
@@clientName(DocumentIntelligenceOperationDetails.createdDateTime,
  "CreatedOn",
  "csharp"
);
@@clientName(DocumentIntelligenceOperationDetails.lastUpdatedDateTime,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(DocumentModelDetails.azureBlobSource, "BlobSource", "csharp");
@@clientName(DocumentModelDetails.azureBlobFileListSource,
  "BlobFileListSource",
  "csharp"
);
@@clientName(DocumentModelDetails.createdDateTime, "CreatedOn", "csharp");
@@clientName(DocumentModelDetails.docTypes, "DocumentTypes", "csharp");
@@clientName(DocumentModelDetails.expirationDateTime, "ExpiresOn", "csharp");
@@clientName(DocumentModelDetails.modifiedDateTime, "ModifiedOn", "csharp");
@@clientName(ModelCopyAuthorization.expirationDateTime, "ExpiresOn", "csharp");

@@clientName(AnalyzeDocumentRequest.base64Source, "bytesSource", "python");
@@clientName(ClassifyDocumentRequest.base64Source, "bytesSource", "python");
@@clientName(DocumentFieldSchema.items, "itemsSchema", "python");
@@clientName(AnalyzeFromStreamRequestParams.input, "body", "python");
