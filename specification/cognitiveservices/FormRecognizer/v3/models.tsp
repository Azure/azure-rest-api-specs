import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace FormRecognizer;

enum StringIndexType {
  TextElements: "textElements",
  UnicodeCodePoint: "unicodeCodePoint",
  Utf16CodeUnit: "utf16CodeUnit",
}

enum DocumentAnalysisFeature {
  OcrHighResolution: "ocr.highResolution",
  OcrFormula: "ocr.formula",
  OcrFont: "ocr.font",
  QueryFieldsPremium: "queryFields.premium",
}

enum DocumentPageKind {
  Document: "document",
  Sheet: "sheet",
  Slide: "slide",
  Image: "image",
}

enum LengthUnit {
  Pixel: "pixel",
  Inch: "inch",
}

enum SelectionMarkState {
  Selected: "selected",
  Unselected: "unselected",
}

enum DocumentAnnotationKind {
  Check: "check",
  Cross: "cross",
}

enum DocumentBarcodeKind {
  "QRCode",
  "PDF417",
  Upca: "UPCA",
  Upce: "UPCE",
  "Code39",
  "Code128",
  "EAN8",
  "EAN13",
  "DataBar",
  "Code93",
  "Codabar",
  "DataBarExpanded",
  "ITF",
  "MicroQRCode",
  "Aztec",
  "DataMatrix",
  "MaxiCode",
}

enum DocumentFormulaKind {
  Inline: "inline",
  Display: "display",
}

enum ParagraphRole {
  PageHeader: "pageHeader",
  PageFooter: "pageFooter",
  PageNumber: "pageNumber",
  Title: "title",
  SectionHeading: "sectionHeading",
  Footnote: "footnote",
  FormulaBlock: "formulaBlock",
}

enum DocumentTableCellKind {
  Content: "content",
  RowHeader: "rowHeader",
  ColumnHeader: "columnHeader",
  StubHead: "stubHead",
  Description: "description",
}

enum FontStyle {
  Normal: "normal",
  Italic: "italic",
}

enum FontWeight {
  Normal: "normal",
  Bold: "bold",
}

enum DocumentFieldType {
  String: "string",
  Date: "date",
  Time: "time",
  PhoneNumber: "phoneNumber",
  Number: "number",
  Integer: "integer",
  SelectionMark: "selectionMark",
  CountryRegion: "countryRegion",
  Signature: "signature",
  Array: "array",
  Object: "object",
  Currency: "currency",
  Address: "address",
  Boolean: "boolean",
}

enum DocumentSignatureType {
  Signed: "signed",
  Unsigned: "unsigned",
}

enum DocumentBuildMode {
  Template: "template",
  Neural: "neural",
}

enum OperationKind {
  DocumentModelBuild: "documentModelBuild",
  DocumentModelCompose: "documentModelCompose",
  DocumentModelCopyTo: "documentModelCopyTo",
  DocumentClassifierBuild: "documentClassifierBuild",
}


enum ContentType {
  ApplicationOctetStream: "application/octet-stream",
  ApplicationPdf: "application/pdf",
  @added(APIVersion.v2023_02_28_preview)
  ApplicationVndOpenxmlformatsOfficedocumentPresentationmlPresentation: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
  @added(APIVersion.v2023_02_28_preview)
  ApplicationVndOpenxmlformatsOfficedocumentSpreadsheetmlSheet: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  @added(APIVersion.v2023_02_28_preview)
  ApplicationVndOpenxmlformatsOfficedocumentWordprocessingmlDocument: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  @added(APIVersion.v2023_02_28_preview)
  TextHtml: "text/html",
  ImageBmp: "image/bmp",
  ImageHeif: "image/heif",
  ImageJpeg: "image/jpeg",
  ImagePng: "image/png",
  ImageTiff: "image/tiff",
}

enum AnalyzeResultOperationStatus {
  NotStarted: "notStarted",
  Running: "running",
  Failed: "failed",
  Succeeded: "succeeded",
}

enum OperationStatus {
  NotStarted: "notStarted",
  Running: "running",
  Failed: "failed",
  Succeeded: "succeeded",
  Canceled: "canceled",
}

@doc("Document analysis parameters.")
model AnalyzeDocumentRequest {
  @doc("Document URL to analyze")
  urlSource?: string;

  @doc("Base64 encoding of the document to analyze")
  base64Source?: bytes;
}

@doc("Error response object.")
@error
model ErrorResponse {
  @doc("Error info.")
  error: Error;
}

@doc("Error info.")
model Error {
  @doc("Error code.")
  code: string;

  @doc("Error message.")
  message: string;

  @doc("Target of the error.")
  target?: string;

  @doc("List of detailed errors.")
  details?: Error[];

  @doc("Detailed error.")
  innererror?: InnerError;
}

@doc("Detailed error.")
model InnerError {
  @doc("Error code.")
  code: string;

  @doc("Error message.")
  message?: string;

  @doc("Detailed error.")
  innererror?: InnerError;
}

@doc("Status and result of the analyze operation.")
model AnalyzeResultOperation {
  @doc("Operation status.")
  status: AnalyzeResultOperationStatus;

  @doc("Date and time (UTC) when the analyze operation was submitted.")
  createdDateTime: zonedDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: zonedDateTime;

  @doc("Encountered error during document analysis.")
  error?: Error;

  @doc("Document analysis result.")
  analyzeResult?: AnalyzeResult;
}

@doc("Document analysis result.")
model AnalyzeResult {
  @doc("API version used to produce this result.")
  apiVersion: string;

  @doc("Document model ID used to produce this result.")
  modelId: string;

  @doc("Method used to compute string offset and length.")
  stringIndexType: StringIndexType;

  @doc("""
Concatenate string representation of all textual and visual elements in reading
order.
""")
  content: string;

  @doc("Analyzed pages.")
  pages: DocumentPage[];

  @doc("Extracted paragraphs.")
  paragraphs?: DocumentParagraph[];

  @doc("Extracted tables.")
  tables?: DocumentTable[];

  @doc("Extracted key-value pairs.")
  keyValuePairs?: DocumentKeyValuePair[];

  @doc("Extracted font styles.")
  styles?: DocumentStyle[];

  @doc("Detected languages.")
  languages?: DocumentLanguage[];

  @doc("Extracted documents.")
  documents?: Document[];
}

@doc("Content and layout elements extracted from a page from the input.")
model DocumentPage {
  @doc("Kind of document page.")
  kind: DocumentPageKind;

  @doc("1-based page number in the input document.")
  pageNumber: int32;

  @doc("""
The general orientation of the content in clockwise direction, measured in
degrees between (-180, 180].
""")
  angle?: float32;

  @doc("The width of the image/PDF in pixels/inches, respectively.")
  width?: float32;

  @doc("The height of the image/PDF in pixels/inches, respectively.")
  height?: float32;

  @doc("""
The unit used by the width, height, and polygon properties. For images, the
unit is \"pixel\". For PDF, the unit is \"inch\".
""")
  unit?: LengthUnit;

  @doc("Location of the page in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Extracted words from the page.")
  words?: DocumentWord[];

  @doc("Extracted selection marks from the page.")
  selectionMarks?: DocumentSelectionMark[];

  @doc("""
Extracted lines from the page, potentially containing both textual and visual
elements.
""")
  lines?: DocumentLine[];

  @doc("Extracted annotations from the page.")
  annotations?: DocumentAnnotation[];

  @doc("Extracted barcodes from the page.")
  barcodes?: DocumentBarcode[];

  @doc("Extracted formulas from the page.")
  formulas?: DocumentFormula[];

  @doc("Extracted images from the page.")
  images?: DocumentImage[];
}

@doc("""
Contiguous region of the concatenated content property, specified as an offset
and length.
""")
model DocumentSpan {
  @doc("Zero-based index of the content represented by the span.")
  offset: int32;

  @doc("Number of characters in the content represented by the span.")
  length: int32;
}

@doc("""
A word object consisting of a contiguous sequence of characters.  For non-space
delimited languages, such as Chinese, Japanese, and Korean, each character is
represented as its own word.
""")
model DocumentWord {
  @doc("Text content of the word.")
  content: string;

  @doc("Bounding polygon of the word.")
  polygon?: float32[];

  @doc("Location of the word in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the word.")
  confidence: float32;
}

@doc("""
A selection mark object representing check boxes, radio buttons, and other
elements indicating a selection.
""")
model DocumentSelectionMark {
  @doc("State of the selection mark.")
  state: SelectionMarkState;

  @doc("Bounding polygon of the selection mark.")
  polygon?: float32[];

  @doc("Location of the selection mark in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the selection mark.")
  confidence: float32;
}

@doc("""
A content line object consisting of an adjacent sequence of content elements,
such as words and selection marks.
""")
model DocumentLine {
  @doc("Concatenated content of the contained elements in reading order.")
  content: string;

  @doc("Bounding polygon of the line.")
  polygon?: float32[];

  @doc("Location of the line in the reading order concatenated content.")
  spans: DocumentSpan[];
}

@doc("""
An annotation object that represents a visual annotation in the document, such
as checks ✓ and crosses X.
""")
model DocumentAnnotation {
  @doc("Annotation kind.")
  kind: DocumentAnnotationKind;

  @doc("Bounding polygon of the annotation.")
  polygon: float32[];

  @doc("Confidence of correctly extracting the annotation.")
  confidence: float32;
}

@doc("A barcode object.")
model DocumentBarcode {
  @doc("Barcode kind.")
  kind: DocumentBarcodeKind;

  @doc("Barcode value")
  value: string;

  @doc("Bounding polygon of the barcode.")
  polygon?: float32[];

  @doc("Location of the barcode in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the barcode.")
  confidence: float32;
}

@doc("A formula object.")
model DocumentFormula {
  @doc("Formula kind.")
  kind: DocumentFormulaKind;

  @doc("LaTex expression describing the formula.")
  value: string;

  @doc("Bounding polygon of the formula.")
  polygon?: float32[];

  @doc("Location of the formula in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the formula.")
  confidence: float32;
}

@doc("An image object detected in the page.")
model DocumentImage {
  @doc("Bounding polygon of the image.")
  polygon?: float32[];

  @doc("Location of the image in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("1-based page number of the page that contains the image.")
  pageNumber: int32;

  @doc("Confidence of correctly identifying the image.")
  confidence: float32;
}

@doc("""
A paragraph object consisting with contiguous lines generally with common
alignment and spacing.
""")
model DocumentParagraph {
  @doc("Semantic role of the paragraph.")
  role?: ParagraphRole;

  @doc("Concatenated content of the paragraph in reading order.")
  content: string;

  @doc("Bounding regions covering the paragraph.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the paragraph in the reading order concatenated content.")
  spans: DocumentSpan[];
}

@doc("Bounding polygon on a specific page of the input.")
model BoundingRegion {
  @doc("1-based page number of page containing the bounding region.")
  pageNumber: int32;

  @doc("Bounding polygon on the page, or the entire page if not specified.")
  polygon: float32[];
}

@doc("A table object consisting table cells arranged in a rectangular layout.")
model DocumentTable {
  @doc("Number of rows in the table.")
  rowCount: int32;

  @doc("Number of columns in the table.")
  columnCount: int32;

  @doc("Cells contained within the table.")
  cells: DocumentTableCell[];

  @doc("Bounding regions covering the table.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the table in the reading order concatenated content.")
  spans: DocumentSpan[];
}

@doc("An object representing the location and content of a table cell.")
model DocumentTableCell {
  @doc("Table cell kind.")
  kind?: DocumentTableCellKind;

  @doc("Row index of the cell.")
  rowIndex: int32;

  @doc("Column index of the cell.")
  columnIndex: int32;

  @doc("Number of rows spanned by this cell.")
  rowSpan?: int32;

  @doc("Number of columns spanned by this cell.")
  columnSpan?: int32;

  @doc("Concatenated content of the table cell in reading order.")
  content: string;

  @doc("Bounding regions covering the table cell.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the table cell in the reading order concatenated content.")
  spans: DocumentSpan[];
}

@doc("""
An object representing a form field with distinct field label (key) and field
value (may be empty).
""")
model DocumentKeyValuePair {
  @doc("Field label of the key-value pair.")
  key: DocumentKeyValueElement;

  @doc("Field value of the key-value pair.")
  value?: DocumentKeyValueElement;

  @doc("Common name of the key-value pair.")
  commonName?: string;

  @doc("Confidence of correctly extracting the key-value pair.")
  confidence: float32;
}

@doc("An object representing the field key or value in a key-value pair.")
model DocumentKeyValueElement {
  @doc("Concatenated content of the key-value element in reading order.")
  content: string;

  @doc("Bounding regions covering the key-value element.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the key-value element in the reading order concatenated content.")
  spans: DocumentSpan[];
}

@doc("An object representing observed text styles.")
model DocumentStyle {
  @doc("Is content handwritten?")
  isHandwritten?: boolean;

  @doc("""
Visually most similar font from among the set of supported font families, with
fallback fonts following CSS convention (ex. 'Arial, sans-serif').
""")
  similarFontFamily?: string;

  @doc("Font style.")
  fontStyle?: FontStyle;

  @doc("Font weight.")
  fontWeight?: FontWeight;

  @doc("Foreground color in #rrggbb hexadecimal format.")
  color?: string;

  @doc("Background color in #rrggbb hexadecimal format..")
  backgroundColor?: string;

  @doc("Location of the text elements in the concatenated content the style applies to.")
  spans: DocumentSpan[];

  @doc("Confidence of correctly identifying the style.")
  confidence: float32;
}

@doc("An object representing the detected language for a given text span.")
model DocumentLanguage {
  @doc("""
Detected language.  Value may an ISO 639-1 language code (ex. \"en\", \"fr\")
or BCP 47 language tag (ex. \"zh-Hans\").
""")
  locale: string;

  @doc("""
Location of the text elements in the concatenated content the language applies
to.
""")
  spans: DocumentSpan[];

  @doc("Confidence of correctly identifying the language.")
  confidence: float32;
}

@doc("An object describing the location and semantic content of a document.")
model Document {
  @doc("Document type.")
  docType: string;

  @doc("Bounding regions covering the document.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the document in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Dictionary of named field values.")
  fields?: Record<DocumentField>;

  @doc("Confidence of correctly extracting the document.")
  confidence: float32;
}

@doc("An object representing the content and location of a field value.")
model DocumentField {
  @doc("Data type of the field value.")
  type: DocumentFieldType;

  @doc("String value.")
  valueString?: string;

  @doc("Date value in YYYY-MM-DD format (ISO 8601).")
  valueDate?: plainDate;

  @doc("Time value in hh:mm:ss format (ISO 8601).")
  valueTime?: plainTime;

  @doc("Phone number value in E.164 format (ex. +19876543210).")
  valuePhoneNumber?: string;

  @doc("Floating point value.")
  valueNumber?: float32;

  @doc("Integer value.")
  valueInteger?: int32;

  @doc("Selection mark value.")
  valueSelectionMark?: SelectionMarkState;

  @doc("Presence of signature.")
  valueSignature?: DocumentSignatureType;

  @doc("3-letter country code value (ISO 3166-1 alpha-3).")
  valueCountryRegion?: string;

  @doc("Array of field values.")
  valueArray?: DocumentField[];

  @doc("Dictionary of named field values.")
  valueObject?: Record<DocumentField>;

  @doc("Currency value.")
  valueCurrency?: CurrencyValue;

  @doc("Address value.")
  valueAddress?: AddressValue;

  @doc("Boolean value.")
  valueBoolean?: boolean;

  @doc("Field content.")
  content?: string;

  @doc("Bounding regions covering the field.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the field in the reading order concatenated content.")
  spans?: DocumentSpan[];

  @doc("Confidence of correctly extracting the field.")
  confidence?: float32;
}

@doc("Currency field value.")
model CurrencyValue {
  @doc("Currency amount.")
  amount: float32;

  @doc("Currency symbol label, if any.")
  currencySymbol?: string;

  @doc("Resolved currency code (ISO 4217), if any.")
  currencyCode?: string;
}

@doc("Address field value.")
model AddressValue {
  @doc("House or building number.")
  houseNumber?: string;

  @doc("Post office box number.")
  poBox?: string;

  @doc("Street name.")
  road?: string;

  @doc("Name of city, town, village, etc.")
  city?: string;

  @doc("First-level administrative division.")
  state?: string;

  @doc("Postal code used for mail sorting.")
  postalCode?: string;

  @doc("Country/region.")
  countryRegion?: string;

  @doc("Street-level address, excluding city, state, countryRegion, and postalCode.")
  streetAddress?: string;

  @doc("Apartment or office number")
  unit?: string;

  @doc("""
Districts or boroughs within a city, such as Brooklyn in New York City or City
of Westminster in London.
""")
  cityDistrict?: string;

  @doc("Second-level administrative division used in certain locales.")
  stateDistrict?: string;

  @doc("Unofficial neighborhood name, like Chinatown.")
  suburb?: string;

  @doc("Build name, such as World Trade Center.")
  house?: string;

  @doc("Floor number, such as 3F.")
  level?: string;
}

@doc("Request body to build a new custom document model.")
model BuildDocumentModelRequest {
  @doc("Unique document model name.")
  modelId: string;

  @doc("Document model description.")
  description?: string;

  @doc("Custom document model build mode.")
  buildMode: DocumentBuildMode;

  @doc("Azure Blob Storage location containing the training data.")
  azureBlobSource?: AzureBlobContentSource;

  @doc("Azure Blob Storage file list specifying the training data.")
  azureBlobFileListSource?: AzureBlobFileListSource;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;
}

@doc("Azure Blob Storage content.")
model AzureBlobContentSource {
  @doc("Azure Blob Storage container URL.")
  containerUrl: string;

  @doc("Blob name prefix.")
  prefix?: string;
}

@doc("File list in Azure Blob Storage.")
model AzureBlobFileListSource {
  @doc("Azure Blob Storage container URL.")
  containerUrl: string;

  @doc("""
Path to a JSONL file within the container specifying a subset of documents for
training.
""")
  fileList: string;
}

@doc("Request body to create a composed document model from component document models.")
model ComposeDocumentModelRequest {
  @doc("Unique document model name.")
  modelId: string;

  @doc("Document model description.")
  description?: string;

  @doc("List of component document models to compose.")
  componentModels: ComponentDocumentModelDetails[];

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;
}

@doc("A component of a composed document model.")
model ComponentDocumentModelDetails {
  @doc("Unique document model name.")
  modelId: string;
}

@doc("Request body to authorize document model copy.")
model AuthorizeCopyRequest {
  @doc("Unique document model name.")
  modelId: string;

  @doc("Document model description.")
  description?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;
}

@doc("""
Authorization to copy a document model to the specified target resource and
modelId.
""")
@resource("documentModels:authorizeCopy")
model CopyAuthorization {
  @doc("ID of the target Azure resource where the document model should be copied to.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  targetResourceId: string;

  @doc("""
Location of the target Azure resource where the document model should be copied
to.
""")
  targetResourceRegion: string;

  @doc("Identifier of the target document model.")
  targetModelId: string;

  @doc("URL of the copied document model in the target account.")
  targetModelLocation: string;

  @doc("Token used to authorize the request.")
  accessToken: string;

  @doc("Date/time when the access token expires.")
  expirationDateTime: zonedDateTime;
}

@doc("List Operations response object.")
model GetOperationsResponse is Azure.Core.Page<OperationSummary>;

@doc("Operation info.")
@resource("operations")
model OperationSummary {
  @doc("Operation ID")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  operationId: string;

  @doc("Operation status.")
  status: OperationStatus;

  @doc("Operation progress (0-100).")
  percentCompleted?: int32;

  @doc("Date and time (UTC) when the operation was created.")
  createdDateTime: zonedDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: zonedDateTime;

  @doc("Type of operation.")
  kind: OperationKind;

  @doc("URL of the resource targeted by this operation.")
  resourceLocation: string;

  @doc("API version used to create this operation.")
  apiVersion?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;
}

@doc("Get Operation response object.")
@discriminator("kind")
@resource("operations/{operationId}")
model OperationDetails {
  @doc("Operation ID")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  operationId: string;

  @doc("Operation status.")
  status: OperationStatus;

  @doc("Operation progress (0-100).")
  percentCompleted?: int32;

  @doc("Date and time (UTC) when the operation was created.")
  createdDateTime: zonedDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: zonedDateTime;

  @doc("URL of the resource targeted by this operation.")
  resourceLocation: string;

  @doc("API version used to create this operation.")
  apiVersion?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;

  @doc("Encountered error.")
  error?: Error;
}

@doc("List document models response object.")
model GetDocumentModelsResponse is Azure.Core.Page<DocumentModelSummary>;

@doc("Document model summary.")
@resource("documentModels")
model DocumentModelSummary {
  @doc("Unique document model name.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  modelId: string;

  @doc("Document model description.")
  description?: string;

  @doc("Date and time (UTC) when the document model was created.")
  createdDateTime: zonedDateTime;

  @doc("Date and time (UTC) when the document model will expire.")
  expirationDateTime?: zonedDateTime;

  @doc("API version used to create this document model.")
  apiVersion?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;
}

@doc("Document model info.")
@resource("documentModels/{modelId}")
model DocumentModelDetails {
  @doc("Unique document model name.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  modelId: string;

  @doc("Document model description.")
  description?: string;

  @doc("Date and time (UTC) when the document model was created.")
  createdDateTime: zonedDateTime;

  @doc("Date and time (UTC) when the document model will expire.")
  expirationDateTime?: zonedDateTime;

  @doc("API version used to create this document model.")
  apiVersion?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;

  @doc("Supported document types.")
  docTypes?: Record<DocumentTypeDetails>;
}

@doc("Document type info.")
model DocumentTypeDetails {
  @doc("Document model description.")
  description?: string;

  @doc("Custom document model build mode.")
  buildMode?: DocumentBuildMode;

  @doc("Description of the document semantic schema using a JSON Schema style syntax.")
  fieldSchema: Record<DocumentFieldSchema>;

  @doc("Estimated confidence for each field.")
  fieldConfidence?: Record<float32>;
}

@doc("Description of the field semantic schema using a JSON Schema style syntax.")
model DocumentFieldSchema {
  @doc("Semantic data type of the field value.")
  type: DocumentFieldType;

  @doc("Field description.")
  description?: string;

  @doc("Example field content.")
  example?: string;

  @doc("Field type schema of each array element.")
  items?: DocumentFieldSchema;

  @doc("Named sub-fields of the object field.")
  properties?: Record<DocumentFieldSchema>;
}

@doc("Request body to build a new custom document classifier.")
model BuildDocumentClassifierRequest {
  @doc("Unique document classifier name.")
  classifierId: string;

  @doc("Document classifier description.")
  description?: string;

  @doc("List of document types to classify against.")
  docTypes: Record<ClassifierDocumentTypeDetails>;
}

@doc("Training data source.")
model ClassifierDocumentTypeDetails {
  @doc("Azure Blob Storage location containing the training data.")
  azureBlobSource?: AzureBlobContentSource;

  @doc("Azure Blob Storage file list specifying the training data.")
  azureBlobFileListSource?: AzureBlobFileListSource;
}

@doc("List document classifiers response object.")
model GetDocumentClassifiersResponse
  is Azure.Core.Page<DocumentClassifierDetails>;

@doc("Document classifier info.")
@resource("documentClassifiers")
model DocumentClassifierDetails {
  @doc("Unique document classifier name.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  classifierId: string;

  @doc("Document classifier description.")
  description?: string;

  @doc("Date and time (UTC) when the document classifier was created.")
  createdDateTime: zonedDateTime;

  @doc("Date and time (UTC) when the document classifier will expire.")
  expirationDateTime?: zonedDateTime;

  @doc("API version used to create this document classifier.")
  apiVersion: string;

  @doc("List of document types to classify against.")
  docTypes: Record<ClassifierDocumentTypeDetails>;
}

@doc("Document classification parameters.")
model ClassifyDocumentRequest {
  @doc("Document URL to classify")
  urlSource?: string;

  @doc("Base64 encoding of the document to classify")
  base64Source?: bytes;
}

@doc("General information regarding the current resource.")
model ResourceDetails {
  @doc("Details regarding custom document models.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  customDocumentModels: CustomDocumentModelsDetails;

  @doc("Quota used, limit, and next reset date/time.")
  customNeuralDocumentModelBuilds: QuotaDetails;
}

@doc("Details regarding custom document models.")
model CustomDocumentModelsDetails {
  @doc("Number of custom document models in the current resource.")
  count: int32;

  @doc("Maximum number of custom document models supported in the current resource.")
  limit: int32;
}

@doc("Quota used, limit, and next reset date/time.")
model QuotaDetails {
  @doc("Amount of the resource quota used.")
  used: int32;

  @doc("Resource quota limit.")
  quota: int32;

  @doc("Date/time when the resource quota usage will be reset.")
  quotaResetDateTime: zonedDateTime;
}

@doc("Get Operation response object.")
model DocumentModelBuildOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  result?: DocumentModelDetails;

  @doc("Type of operation.")
  kind: "documentModelBuild";
}

@doc("Get Operation response object.")
model DocumentModelComposeOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  result?: DocumentModelDetails;

  @doc("Type of operation.")
  kind: "documentModelCompose";
}

@doc("Get Operation response object.")
model DocumentModelCopyToOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  result?: DocumentModelDetails;

  @doc("Type of operation.")
  kind: "documentModelCopyTo";
}

@doc("Get Operation response object.")
model DocumentClassifierBuildOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  result?: DocumentClassifierDetails;

  @doc("Type of operation.")
  kind: "documentClassifierBuild";
}
