import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using DocumentIntelligence;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(
  DocumentIntelligence.Versions.v2024_07_31_preview
)
namespace ClientCustomizations;

@client({
  name: "DocumentIntelligenceClient",
  service: DocumentIntelligence,
})
interface DocumentIntelligenceClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  analyzeDocument is DocumentModels.analyzeDocument;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  analyzeBatchDocuments is DocumentModels.analyzeBatchDocuments;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getAnalyzeResultPdf is DocumentModels.getAnalyzeResultPdf;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getAnalyzeResultFigure is DocumentModels.getAnalyzeResultFigure;

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
  getResourceInfo is MiscellaneousOperations.getResourceInfo;
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
@@clientName(AuthorizeClassifierCopyRequest,
  "AuthorizeClassifierCopyContent",
  "csharp"
);
@@clientName(AuthorizeCopyRequest, "AuthorizeCopyContent", "csharp");
@@clientName(BuildDocumentClassifierRequest,
  "BuildDocumentClassifierContent",
  "csharp"
);
@@clientName(BuildDocumentModelRequest, "BuildDocumentModelContent", "csharp");
@@clientName(ClassifyDocumentRequest, "ClassifyDocumentContent", "csharp");
@@clientName(ComposeDocumentModelRequest,
  "ComposeDocumentModelContent",
  "csharp"
);
@@clientName(DocumentBarcodeKind.EAN13, "Ean13", "csharp");
@@clientName(DocumentBarcodeKind.EAN8, "Ean8", "csharp");
@@clientName(DocumentBarcodeKind.ITF, "Itf", "csharp");
@@clientName(DocumentBarcodeKind.MicroQRCode, "MicroQrCode", "csharp");
@@clientName(DocumentBarcodeKind.PDF417, "Pdf417", "csharp");
@@clientName(DocumentBarcodeKind.QRCode, "QrCode", "csharp");
@@clientName(DocumentBarcodeKind.UPCA, "Upca", "csharp");
@@clientName(DocumentBarcodeKind.UPCE, "Upce", "csharp");
@@clientName(DocumentClassifierDetails.createdDateTime, "CreatedOn", "csharp");
@@clientName(DocumentClassifierDetails.expirationDateTime,
  "ExpiresOn",
  "csharp"
);
@@clientName(DocumentField.valueArray, "ValueList", "csharp");
@@clientName(DocumentField.valueInteger, "ValueLong", "csharp");
@@clientName(DocumentField.valueNumber, "ValueDouble", "csharp");
@@clientName(DocumentField.valueObject, "ValueDictionary", "csharp");
@@clientName(DocumentFieldType.array, "List", "csharp");
@@clientName(DocumentFieldType.integer, "Long", "csharp");
@@clientName(DocumentFieldType.number, "Double", "csharp");
@@clientName(DocumentFieldType.object, "Dictionary", "csharp");
@@clientName(DocumentModelDetails.createdDateTime, "CreatedOn", "csharp");
@@clientName(DocumentModelDetails.expirationDateTime, "ExpiresOn", "csharp");
@@clientName(FontStyle, "DocumentFontStyle", "csharp");
@@clientName(FontWeight, "DocumentFontWeight", "csharp");
@@clientName(OperationDetails.createdDateTime, "CreatedOn", "csharp");
@@clientName(OperationDetails.lastUpdatedDateTime, "LastUpdatedOn", "csharp");

@@usage(DocumentAnalysisFeature, Usage.output, "csharp");
@@usage(LengthUnit, Usage.output, "csharp");
@@usage(DocumentSelectionMarkState, Usage.output, "csharp");
@@usage(DocumentBarcodeKind, Usage.output, "csharp");
@@usage(DocumentFormulaKind, Usage.output, "csharp");
@@usage(ParagraphRole, Usage.output, "csharp");
@@usage(DocumentTableCellKind, Usage.output, "csharp");
@@usage(FontStyle, Usage.output, "csharp");
@@usage(FontWeight, Usage.output, "csharp");
@@usage(DocumentFieldType, Usage.output, "csharp");
@@usage(DocumentSignatureType, Usage.output, "csharp");
@@usage(AnalyzeResult, Usage.output, "csharp");
@@usage(DocumentPage, Usage.output, "csharp");
@@usage(DocumentSpan, Usage.output, "csharp");
@@usage(DocumentWord, Usage.output, "csharp");
@@usage(DocumentSelectionMark, Usage.output, "csharp");
@@usage(DocumentLine, Usage.output, "csharp");
@@usage(DocumentBarcode, Usage.output, "csharp");
@@usage(DocumentFormula, Usage.output, "csharp");
@@usage(DocumentParagraph, Usage.output, "csharp");
@@usage(BoundingRegion, Usage.output, "csharp");
@@usage(DocumentTable, Usage.output, "csharp");
@@usage(DocumentTableCell, Usage.output, "csharp");
@@usage(DocumentFigure, Usage.output, "csharp");
@@usage(DocumentSection, Usage.output, "csharp");
@@usage(DocumentCaption, Usage.output, "csharp");
@@usage(DocumentFootnote, Usage.output, "csharp");
@@usage(DocumentKeyValuePair, Usage.output, "csharp");
@@usage(DocumentKeyValueElement, Usage.output, "csharp");
@@usage(DocumentStyle, Usage.output, "csharp");
@@usage(DocumentLanguage, Usage.output, "csharp");
@@usage(Document, Usage.output, "csharp");
@@usage(DocumentField, Usage.output, "csharp");
@@usage(CurrencyValue, Usage.output, "csharp");
@@usage(AddressValue, Usage.output, "csharp");
@@usage(BuildDocumentModelRequest, Usage.input, "csharp");
@@usage(ComposeDocumentModelRequest, Usage.input, "csharp");
@@usage(CopyAuthorization, Usage.input | Usage.output, "csharp");

@@clientName(AnalyzeDocumentRequest.base64Source, "bytesSource", "python");
@@clientName(ClassifyDocumentRequest.base64Source, "bytesSource", "python");
