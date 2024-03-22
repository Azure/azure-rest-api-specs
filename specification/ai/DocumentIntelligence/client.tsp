import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using DocumentIntelligence;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(
  DocumentIntelligence.Versions.v2024_02_29_preview
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
  getClassifier is DocumentClassifiers.getClassifier;
  listClassifiers is DocumentClassifiers.listClassifiers;
  deleteClassifier is DocumentClassifiers.deleteClassifier;
}

@@clientName(AnalyzeDocumentRequest, "csharp", "AnalyzeDocumentContent");
@@clientName(AuthorizeCopyRequest, "csharp", "AuthorizeCopyContent");
@@clientName(BuildDocumentClassifierRequest, "csharp", "BuildDocumentClassifierContent");
@@clientName(BuildDocumentModelRequest, "csharp", "BuildDocumentModelContent");
@@clientName(ClassifyDocumentRequest, "csharp", "ClassifyDocumentContent");
@@clientName(ComposeDocumentModelRequest, "csharp", "ComposeDocumentModelContent");
@@clientName(DocumentBarcodeKind.EAN13, "csharp", "Ean13");
@@clientName(DocumentBarcodeKind.EAN8, "csharp", "Ean8");
@@clientName(DocumentBarcodeKind.ITF, "csharp", "Itf");
@@clientName(DocumentBarcodeKind.MicroQRCode, "csharp", "MicroQrCode");
@@clientName(DocumentBarcodeKind.PDF417, "csharp", "Pdf417");
@@clientName(DocumentBarcodeKind.QRCode, "csharp", "QrCode");
@@clientName(DocumentBarcodeKind.UPCA, "csharp", "Upca");
@@clientName(DocumentBarcodeKind.UPCE, "csharp", "Upce");
@@clientName(DocumentClassifierDetails.createdDateTime, "csharp", "CreatedOn");
@@clientName(DocumentClassifierDetails.expirationDateTime, "csharp", "ExpiresOn");
@@clientName(DocumentField.valueArray, "csharp", "ValueList");
@@clientName(DocumentField.valueInteger, "csharp", "ValueLong");
@@clientName(DocumentField.valueNumber, "csharp", "ValueDouble");
@@clientName(DocumentField.valueObject, "csharp", "ValueDictionary");
@@clientName(DocumentFieldType.array, "csharp", "List");
@@clientName(DocumentFieldType.integer, "csharp", "Long");
@@clientName(DocumentFieldType.number, "csharp", "Double");
@@clientName(DocumentFieldType.object, "csharp", "Dictionary");
@@clientName(DocumentModelDetails.createdDateTime, "csharp", "CreatedOn");
@@clientName(DocumentModelDetails.expirationDateTime, "csharp", "ExpiresOn");
@@clientName(FontStyle, "csharp", "DocumentFontStyle");
@@clientName(FontWeight, "csharp", "DocumentFontWeight");
@@clientName(OperationDetails.createdDateTime, "csharp", "CreatedOn");
@@clientName(OperationDetails.lastUpdatedDateTime, "csharp", "LastUpdatedOn");
@@clientName(QuotaDetails.quotaResetDateTime, "csharp", "QuotaResetsOn");

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
@@usage(DocumentList, Usage.output, "csharp");
@@usage(DocumentListItem, Usage.output, "csharp");
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
@@usage(ComponentDocumentModelDetails, Usage.input, "csharp");
@@usage(CopyAuthorization, Usage.input | Usage.output, "csharp");

@@clientName(AnalyzeDocumentRequest.base64Source, "bytesSource", "python");
@@clientName(ClassifyDocumentRequest.base64Source, "bytesSource", "python");
