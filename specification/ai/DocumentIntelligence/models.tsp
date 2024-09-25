import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.ClientGenerator.Core;

namespace DocumentIntelligence;

@doc("Method used to compute string offset and length.")
union StringIndexType {
  string,

  @doc("""
    User-perceived display character, or grapheme cluster, as defined by Unicode
    8.0.0.
    """)
  textElements: "textElements",

  @doc("Character unit represented by a single unicode code point.  Used by Python 3.")
  unicodeCodePoint: "unicodeCodePoint",

  @doc("""
    Character unit represented by a 16-bit Unicode code unit.  Used by JavaScript,
    Java, and .NET.
    """)
  utf16CodeUnit: "utf16CodeUnit",
}

@doc("Format of the content in analyzed result.")
union ContentFormat {
  string,

  @doc("Plain text representation of the document content without any formatting.")
  text: "text",

  @doc("""
    Markdown representation of the document content with section headings, tables,
    etc.
    """)
  markdown: "markdown",
}

@doc("Document analysis features to enable.")
union DocumentAnalysisFeature {
  string,

  @doc("Perform OCR at a higher resolution to handle documents with fine print.")
  "ocrHighResolution",

  @doc("Enable the detection of the text content language.")
  "languages",

  @doc("Enable the detection of barcodes in the document.")
  "barcodes",

  @doc("Enable the detection of mathematical expressions in the document.")
  "formulas",

  @doc("Enable the detection of general key value pairs (form fields) in the document.")
  "keyValuePairs",

  @doc("Enable the recognition of various font styles.")
  "styleFont",

  @doc("Enable the extraction of additional fields via the queryFields query parameter.")
  "queryFields",
}

@doc("The unit used by the width, height, and polygon properties. For images, the unit is \"pixel\". For PDF, the unit is \"inch\".")
union LengthUnit {
  string,
  @doc("Length unit for image files.") "pixel",
  @doc("Length unit for PDF files.") "inch",
}

@doc("State of the selection mark.")
union DocumentSelectionMarkState {
  string,

  @doc("""
    The selection mark is selected, often indicated by a check ✓ or cross X inside
    the selection mark.
    """)
  "selected",

  @doc("The selection mark is not selected.")
  "unselected",
}

@doc("Barcode kind.")
union DocumentBarcodeKind {
  string,

  @doc("QR code, as defined in ISO/IEC 18004:2015.")
  QRCode: "QRCode",

  @doc("PDF417, as defined in ISO 15438.")
  PDF417: "PDF417",

  @doc("GS1 12-digit Universal Product Code.")
  UPCA: "UPCA",

  @doc("GS1 6-digit Universal Product Code.")
  UPCE: "UPCE",

  @doc("Code 39 barcode, as defined in ISO/IEC 16388:2007.")
  Code39: "Code39",

  @doc("Code 128 barcode, as defined in ISO/IEC 15417:2007.")
  Code128: "Code128",

  @doc("GS1 8-digit International Article Number (European Article Number).")
  EAN8: "EAN8",

  @doc("GS1 13-digit International Article Number (European Article Number).")
  EAN13: "EAN13",

  @doc("GS1 DataBar barcode.")
  DataBar: "DataBar",

  @doc("Code 93 barcode, as defined in ANSI/AIM BC5-1995.")
  Code93: "Code93",

  @doc("Codabar barcode, as defined in ANSI/AIM BC3-1995.")
  Codabar: "Codabar",

  @doc("GS1 DataBar Expanded barcode.")
  DataBarExpanded: "DataBarExpanded",

  @doc("Interleaved 2 of 5 barcode, as defined in ANSI/AIM BC2-1995.")
  ITF: "ITF",

  @doc("Micro QR code, as defined in ISO/IEC 23941:2022.")
  MicroQRCode: "MicroQRCode",

  @doc("Aztec code, as defined in ISO/IEC 24778:2008.")
  Aztec: "Aztec",

  @doc("Data matrix code, as defined in ISO/IEC 16022:2006.")
  DataMatrix: "DataMatrix",

  @doc("MaxiCode, as defined in ISO/IEC 16023:2000.")
  MaxiCode: "MaxiCode",
}

@doc("Formula kind.")
union DocumentFormulaKind {
  string,
  @doc("A formula embedded within the content of a paragraph.") "inline",
  @doc("A formula in display mode that takes up an entire line.") "display",
}

@doc("Semantic role of the paragraph.")
union ParagraphRole {
  string,
  @doc("Text near the top edge of the page.") "pageHeader",
  @doc("Text near the bottom edge of the page.") "pageFooter",
  @doc("Page number.") "pageNumber",
  @doc("Top-level title describing the entire document.") "title",
  @doc("Sub heading describing a section of the document.") "sectionHeading",
  @doc("A note usually placed after the main content on a page.") "footnote",
  @doc("A block of formulas, often with shared alignment.") "formulaBlock",
}

@doc("Table cell kind.")
union DocumentTableCellKind {
  string,

  @doc("Contains the main content/data.")
  content: "content",

  @doc("Describes the content of the row.")
  rowHeader: "rowHeader",

  @doc("Describes the content of the column.")
  columnHeader: "columnHeader",

  @doc("Describes the row headers, usually located at the top left corner of a table.")
  stubHead: "stubHead",

  @doc("Describes the content in (parts of) the table.")
  description: "description",
}

@doc("Font style.")
union FontStyle {
  string,
  @doc("Characters are represented normally.") "normal",
  @doc("Characters are visually slanted to the right.") "italic",
}

@doc("Font weight.")
union FontWeight {
  string,
  @doc("Characters are represented normally.") "normal",
  @doc("Characters are represented with thicker strokes.") "bold",
}

@doc("Semantic data type of the field value.")
union DocumentFieldType {
  string,

  @doc("Plain text.")
  string: "string",

  @doc("Date, normalized to ISO 8601 (YYYY-MM-DD) format.")
  date: "date",

  @doc("Time, normalized to ISO 8601 (hh:mm:ss) format.")
  time: "time",

  @doc("Phone number, normalized to E.164 (+{CountryCode}{SubscriberNumber}) format.")
  phoneNumber: "phoneNumber",

  @doc("Floating point number, normalized to double precision floating point.")
  number: "number",

  @doc("Integer number, normalized to 64-bit signed integer.")
  integer: "integer",

  @doc("Is field selected?")
  selectionMark: "selectionMark",

  @doc("Country/region, normalized to ISO 3166-1 alpha-3 format (ex. USA).")
  countryRegion: "countryRegion",

  @doc("Is signature present?")
  signature: "signature",

  @doc("List of subfields of the same type.")
  array: "array",

  @doc("Named list of subfields of potentially different types.")
  object: "object",

  @doc("Currency amount with optional currency symbol and unit.")
  currency: "currency",

  @doc("Parsed address.")
  address: "address",

  @doc("Boolean value, normalized to true or false.")
  boolean: "boolean",

  @doc("Array of selected string values.")
  selectionGroup: "selectionGroup",
}

@doc("Presence of signature.")
union DocumentSignatureType {
  string,
  @doc("A signature is detected.") "signed",
  @doc("No signatures are detected.") "unsigned",
}

@doc("Custom document model build mode.")
union DocumentBuildMode {
  string,

  @doc("Target documents with similar visual templates.")
  "template",

  @doc("Support documents with diverse visual templates.")
  "neural",

  @added(Versions.v2024_07_31_preview)
  @doc("Enable documents of all types using generative AI techniques.")
  "generative",
}

@doc("Type of operation.")
union OperationKind {
  string,

  @doc("Build a new custom document model.")
  documentModelBuild: "documentModelBuild",

  @doc("Compose a new custom document model from existing models.")
  documentModelCompose: "documentModelCompose",

  @doc("""
    Copy an existing document model to potentially a different resource, region, or
    subscription.
    """)
  documentModelCopyTo: "documentModelCopyTo",

  @added(Versions.v2024_07_31_preview)
  @doc("""
    Copy an existing document classifier to potentially a different resource, region, or
    subscription.
    """)
  documentClassifierCopyTo: "documentClassifierCopyTo",

  @doc("Build a new custom classifier model.")
  documentClassifierBuild: "documentClassifierBuild",
}

@doc("Document splitting mode.")
union SplitMode {
  string,

  @doc("Automatically split file into documents.")
  auto: "auto",

  @doc("Treat the entire file as a single document.")
  none: "none",

  @doc("Treat each page in the file as a separate document.")
  perPage: "perPage",
}

@lroStatus
@doc("Operation status.")
union OperationStatus {
  string,

  @doc("The operation has not started yet.")
  notStarted: "notStarted",

  @doc("The operation is in progress.")
  running: "running",

  @doc("The operation has failed.")
  @lroFailed
  failed: "failed",

  @doc("The operation has succeeded.")
  @lroSucceeded
  succeeded: "succeeded",

  @doc("The operation has completed.")
  @lroSucceeded
  completed: "completed",

  @doc("The operation has been canceled.")
  @lroCanceled
  canceled: "canceled",
}

@doc("Type of content source.")
union ContentSourceKind {
  string,

  @doc("Content at a specific URL.")
  "url",

  @doc("Content represented via Base64 encoding.")
  "base64",

  @doc("Files in a path within an Azure Blob Storage container.")
  "azureBlob",

  @doc("A file list specifying individual files in an Azure Blob Storage container.")
  "azureBlobFileList",
}

@added(Versions.v2024_07_31_preview)
@doc("Additional output to generate during analysis.")
union AnalyzeOutputOption {
  string,

  @doc("Generate searchable PDF output.")
  "pdf",

  @doc("Generate cropped images of detected figures.")
  "figures",
}

@doc("Document analysis parameters.")
model AnalyzeDocumentRequest {
  @doc("Document URL to analyze.  Either urlSource or base64Source must be specified.")
  urlSource?: url;

  @doc("""
    Base64 encoding of the document to analyze.  Either urlSource or base64Source
    must be specified.
    """)
  base64Source?: bytes;
}

@added(Versions.v2024_07_31_preview)
@doc("Batch document analysis parameters.")
model AnalyzeBatchDocumentsRequest {
  @doc("""
    Azure Blob Storage location containing the batch documents.  Either
    azureBlobSource or azureBlobFileListSource must be specified.
    """)
  azureBlobSource?: AzureBlobContentSource;

  @doc("""
    Azure Blob Storage file list specifying the batch documents.  Either
    azureBlobSource or azureBlobFileListSource must be specified.
    """)
  azureBlobFileListSource?: AzureBlobFileListContentSource;

  @doc("Azure Blob Storage container URL where analyze result files will be stored.")
  resultContainerUrl: url;

  @doc("Blob name prefix of result files.")
  resultPrefix?: string;

  @doc("Overwrite existing analyze result files?")
  overwriteExisting?: boolean = false;
}

@doc("Error response object.")
@error
model ErrorResponse {
  @doc("Error info.")
  error: Error;
}

@doc("The error object.")
@clientName("DocumentIntelligenceError", "csharp")
model Error {
  @doc("One of a server-defined set of error codes.")
  code: string;

  @doc("A human-readable representation of the error.")
  message: string;

  @doc("The target of the error.")
  target?: string;

  @doc("An array of details about specific errors that led to this reported error.")
  details?: Error[];

  @doc("An object containing more specific information than the current object about the error.")
  innererror?: InnerError;
}

@doc("An object containing more specific information about the error.")
model InnerError {
  @doc("One of a server-defined set of error codes.")
  code?: string;

  @doc("A human-readable representation of the error.")
  message?: string;

  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "https://github.com/Azure/typespec-azure/issues/417"
  @doc("Inner error.")
  @clientName("InnerErrorObject", "csharp")
  innererror?: InnerError;
}

@doc("The error object.")
@clientName("DocumentIntelligenceWarning", "csharp")
model Warning {
  @doc("One of a server-defined set of warning codes.")
  code: string;

  @doc("A human-readable representation of the warning.")
  message: string;

  @doc("The target of the error.")
  target?: string;
}

@doc("Status and result of the analyze operation.")
model AnalyzeResultOperation {
  @doc("Operation status.  notStarted, running, succeeded, or failed")
  status: OperationStatus;

  @doc("Date and time (UTC) when the analyze operation was submitted.")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: utcDateTime;

  @doc("Encountered error during document analysis.")
  error?: Error;

  @lroResult
  @doc("Document analysis result.")
  analyzeResult?: AnalyzeResult;
}

@added(Versions.v2024_07_31_preview)
@doc("Status and result of the analyze batch operation.")
model AnalyzeBatchResultOperation {
  @doc("Operation status.  notStarted, running, completed, or failed")
  status: OperationStatus;

  @doc("Date and time (UTC) when the operation was submitted.")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: utcDateTime;

  @doc("Operation progress (0-100).")
  @minValue(0)
  @maxValue(100)
  percentCompleted?: int32;

  @doc("Encountered error during batch document analysis.")
  error?: Error;

  @lroResult
  @doc("Batch document analysis result.")
  result?: AnalyzeBatchResult;
}

@added(Versions.v2024_07_31_preview)
@doc("Batch document analysis result.")
model AnalyzeBatchResult {
  @doc("Number of documents that completed with status succeeded.")
  succeededCount: int32;

  @doc("Number of documents that completed with status failed.")
  failedCount: int32;

  @doc("Number of documents that completed with status skipped.")
  skippedCount: int32;

  @doc("Operation detail for each document in the batch.")
  details: AnalyzeBatchOperationDetail[];
}

@added(Versions.v2024_07_31_preview)
@doc("Operation detail for a document in a batch analysis.")
model AnalyzeBatchOperationDetail {
  @doc("Analyze status.  succeeded, failed, or skipped")
  status: OperationStatus;

  @doc("URL of the source document.")
  sourceUrl: url;

  @doc("URL of the analyze result JSON.")
  resultUrl?: url;

  @doc("Encountered error.")
  error?: Error;
}

@doc("Document analysis result.")
model AnalyzeResult {
  @doc("API version used to produce this result.")
  apiVersion: string;

  @doc("Document model ID used to produce this result.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  modelId: string;

  @doc("Method used to compute string offset and length.")
  stringIndexType: StringIndexType;

  @doc("Format of the analyze result top-level content.")
  contentFormat?: ContentFormat;

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

  @doc("Extracted figures.")
  figures?: DocumentFigure[];

  @doc("Extracted sections.")
  sections?: DocumentSection[];

  @doc("Extracted key-value pairs.")
  keyValuePairs?: DocumentKeyValuePair[];

  @doc("Extracted font styles.")
  styles?: DocumentStyle[];

  @doc("Detected languages.")
  languages?: DocumentLanguage[];

  @doc("Extracted documents.")
  documents?: Document[];

  @doc("List of warnings encountered.")
  warnings?: Warning[];
}

@doc("Content and layout elements extracted from a page from the input.")
model DocumentPage {
  @doc("1-based page number in the input document.")
  @minValue(1)
  pageNumber: int32;

  @doc("""
    The general orientation of the content in clockwise direction, measured in
    degrees between (-180, 180].
    """)
  @minValueExclusive(-180)
  @maxValue(180)
  angle?: float32;

  @doc("The width of the image/PDF in pixels/inches, respectively.")
  @minValue(0)
  width?: float32;

  @doc("The height of the image/PDF in pixels/inches, respectively.")
  @minValue(0)
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

  @doc("Extracted barcodes from the page.")
  barcodes?: DocumentBarcode[];

  @doc("Extracted formulas from the page.")
  formulas?: DocumentFormula[];
}

@doc("""
  Contiguous region of the concatenated content property, specified as an offset
  and length.
  """)
model DocumentSpan {
  @doc("Zero-based index of the content represented by the span.")
  @minValue(0)
  offset: int32;

  @doc("Number of characters in the content represented by the span.")
  @minValue(0)
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

  // FIXME: No way to specify constraints on array elements without creating new scalar types.
  @doc("""
    Bounding polygon of the word, with coordinates specified relative to the
    top-left of the page. The numbers represent the x, y values of the polygon
    vertices, clockwise from the left (-180 degrees inclusive) relative to the
    element orientation.
    """)
  polygon?: float32[];

  @doc("Location of the word in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the word.")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("""
  A selection mark object representing check boxes, radio buttons, and other
  elements indicating a selection.
  """)
model DocumentSelectionMark {
  @doc("State of the selection mark.")
  state: DocumentSelectionMarkState;

  @doc("""
    Bounding polygon of the selection mark, with coordinates specified relative
    to the top-left of the page. The numbers represent the x, y values of the
    polygon vertices, clockwise from the left (-180 degrees inclusive) relative
    to the element orientation.
    """)
  polygon?: float32[];

  @doc("Location of the selection mark in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the selection mark.")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("""
  A content line object consisting of an adjacent sequence of content elements,
  such as words and selection marks.
  """)
model DocumentLine {
  @doc("Concatenated content of the contained elements in reading order.")
  content: string;

  @doc("""
    Bounding polygon of the line, with coordinates specified relative to the
    top-left of the page. The numbers represent the x, y values of the polygon
    vertices, clockwise from the left (-180 degrees inclusive) relative to the
    element orientation.
    """)
  polygon?: float32[];

  @doc("Location of the line in the reading order concatenated content.")
  spans: DocumentSpan[];
}

@doc("A barcode object.")
model DocumentBarcode {
  @doc("Barcode kind.")
  kind: DocumentBarcodeKind;

  @doc("Barcode value.")
  value: string;

  @doc("""
    Bounding polygon of the barcode, with coordinates specified relative to the
    top-left of the page. The numbers represent the x, y values of the polygon
    vertices, clockwise from the left (-180 degrees inclusive) relative to the
    element orientation.
    """)
  polygon?: float32[];

  @doc("Location of the barcode in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the barcode.")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("A formula object.")
model DocumentFormula {
  @doc("Formula kind.")
  kind: DocumentFormulaKind;

  @doc("LaTex expression describing the formula.")
  value: string;

  @doc("""
    Bounding polygon of the formula, with coordinates specified relative to the
    top-left of the page. The numbers represent the x, y values of the polygon
    vertices, clockwise from the left (-180 degrees inclusive) relative to the
    element orientation.
    """)
  polygon?: float32[];

  @doc("Location of the formula in the reading order concatenated content.")
  span: DocumentSpan;

  @doc("Confidence of correctly extracting the formula.")
  @minValue(0)
  @maxValue(1)
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
  @minValue(1)
  pageNumber: int32;

  @doc("""
    Bounding polygon on the page, or the entire page if not specified.
    Coordinates specified relative to the top-left of the page. The numbers
    represent the x, y values of the polygon vertices, clockwise from the left
    (-180 degrees inclusive) relative to the element orientation.
    """)
  polygon: float32[];
}

@doc("A table object consisting table cells arranged in a rectangular layout.")
model DocumentTable {
  @doc("Number of rows in the table.")
  @minValue(1)
  rowCount: int32;

  @doc("Number of columns in the table.")
  @minValue(1)
  columnCount: int32;

  @doc("Cells contained within the table.")
  cells: DocumentTableCell[];

  @doc("Bounding regions covering the table.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the table in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Caption associated with the table.")
  caption?: DocumentCaption;

  @doc("List of footnotes associated with the table.")
  footnotes?: DocumentFootnote[];
}

@doc("An object representing the location and content of a table cell.")
model DocumentTableCell {
  @doc("Table cell kind.")
  kind?: DocumentTableCellKind = DocumentTableCellKind.content;

  @doc("Row index of the cell.")
  rowIndex: int32;

  @doc("Column index of the cell.")
  columnIndex: int32;

  @doc("Number of rows spanned by this cell.")
  @minValue(1)
  // default
  rowSpan?: int32 = 1;

  @doc("Number of columns spanned by this cell.")
  @minValue(1)
  columnSpan?: int32 = 1;

  @doc("Concatenated content of the table cell in reading order.")
  content: string;

  @doc("Bounding regions covering the table cell.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the table cell in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Child elements of the table cell.")
  elements?: DocumentElement[];
}

@doc("An object representing a figure in the document.")
model DocumentFigure {
  @doc("Bounding regions covering the figure.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the figure in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Child elements of the figure, excluding any caption or footnotes.")
  elements?: DocumentElement[];

  @doc("Caption associated with the figure.")
  caption?: DocumentCaption;

  @doc("List of footnotes associated with the figure.")
  footnotes?: DocumentFootnote[];

  @added(Versions.v2024_07_31_preview)
  @doc("Figure ID.")
  id?: string;
}

@doc("An object representing a section in the document.")
model DocumentSection {
  @doc("Location of the section in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Child elements of the section.")
  elements?: DocumentElement[];
}

@doc("A caption object describing a table or figure.")
model DocumentCaption {
  @doc("Content of the caption.")
  content: string;

  @doc("Bounding regions covering the caption.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the caption in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Child elements of the caption.")
  elements?: DocumentElement[];
}

@doc("A footnote object describing a table or figure.")
model DocumentFootnote {
  @doc("Content of the footnote.")
  content: string;

  @doc("Bounding regions covering the footnote.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the footnote in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Child elements of the footnote.")
  elements?: DocumentElement[];
}

@doc("""
  An JSON pointer referencing an element of the document, such as paragraph,
  table, section, etc.
  """)
scalar DocumentElement extends string;

@doc("""
  An object representing a form field with distinct field label (key) and field
  value (may be empty).
  """)
model DocumentKeyValuePair {
  @doc("Field label of the key-value pair.")
  key: DocumentKeyValueElement;

  @doc("Field value of the key-value pair.")
  value?: DocumentKeyValueElement;

  @doc("Confidence of correctly extracting the key-value pair.")
  @minValue(0)
  @maxValue(1)
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
  @pattern("^#[0-9a-f]{6}$")
  color?: string;

  @doc("Background color in #rrggbb hexadecimal format..")
  @pattern("^#[0-9a-f]{6}$")
  backgroundColor?: string;

  @doc("Location of the text elements in the concatenated content the style applies to.")
  spans: DocumentSpan[];

  @doc("Confidence of correctly identifying the style.")
  @minValue(0)
  @maxValue(1)
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
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("An object describing the location and semantic content of a document.")
@clientName("AnalyzedDocument", "csharp")
model Document {
  @doc("Document type.")
  @minLength(2)
  @maxLength(64)
  docType: string;

  @doc("Bounding regions covering the document.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the document in the reading order concatenated content.")
  spans: DocumentSpan[];

  @doc("Dictionary of named field values.")
  fields?: Record<DocumentField>;

  @doc("Confidence of correctly extracting the document.")
  @minValue(0)
  @maxValue(1)
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
  valueNumber?: float64;

  @doc("Integer value.")
  valueInteger?: int64;

  @doc("Selection mark value.")
  valueSelectionMark?: DocumentSelectionMarkState;

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

  @doc("Selection group value.")
  valueSelectionGroup?: string[];

  @doc("Field content.")
  content?: string;

  @doc("Bounding regions covering the field.")
  boundingRegions?: BoundingRegion[];

  @doc("Location of the field in the reading order concatenated content.")
  spans?: DocumentSpan[];

  @doc("Confidence of correctly extracting the field.")
  @minValue(0)
  @maxValue(1)
  confidence?: float32;
}

@doc("Currency field value.")
model CurrencyValue {
  @doc("Currency amount.")
  amount: float64;

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
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  modelId: string;

  @doc("Document model description.")
  @maxLength(4096)
  description?: string;

  @doc("Custom document model build mode.")
  buildMode: DocumentBuildMode;

  @doc("""
    Azure Blob Storage location containing the training data.  Either
    azureBlobSource or azureBlobFileListSource must be specified.
    """)
  azureBlobSource?: AzureBlobContentSource;

  @doc("""
    Azure Blob Storage file list specifying the training data.  Either
    azureBlobSource or azureBlobFileListSource must be specified.
    """)
  azureBlobFileListSource?: AzureBlobFileListContentSource;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;

  @added(Versions.v2024_07_31_preview)
  @doc("Max number of V100-equivalent GPU hours to use for model training.  Default=0.5.")
  maxTrainingHours?: float32 = 0.5;

  @added(Versions.v2024_07_31_preview)
  @doc("Allow overwriting an existing model with the same name.")
  allowOverwrite?: boolean = false;
}

@doc("Azure Blob Storage content.")
model AzureBlobContentSource {
  @doc("Azure Blob Storage container URL.")
  containerUrl: url;

  @doc("Blob name prefix.")
  prefix?: string;
}

@doc("File list in Azure Blob Storage.")
model AzureBlobFileListContentSource {
  @doc("Azure Blob Storage container URL.")
  containerUrl: url;

  @doc("Path to a JSONL file within the container specifying a subset of documents.")
  fileList: string;
}

@doc("Request body to create a composed document model from component document models.")
model ComposeDocumentModelRequest {
  @doc("Unique document model name.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  modelId: string;

  @doc("Document model description.")
  @maxLength(4096)
  description?: string;

  @doc("Custom classifier to split and classify the input file.")
  classifierId: string;

  @doc("File splitting behavior.")
  split?: SplitMode = SplitMode.none;

  @doc("Dictionary mapping supported docTypes to the corresponding document models.")
  docTypes: Record<DocumentTypeDetails>;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;
}

@doc("Request body to authorize document model copy.")
model AuthorizeCopyRequest {
  @doc("Unique document model name.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  modelId: string;

  @doc("Document model description.")
  @maxLength(4096)
  description?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;
}

@doc("""
  Authorization to copy a document model to the specified target resource and
  modelId.
  """)
model CopyAuthorization {
  @doc("ID of the target Azure resource where the document model should be copied to.")
  targetResourceId: string;

  @doc("""
    Location of the target Azure resource where the document model should be copied
    to.
    """)
  targetResourceRegion: string;

  @doc("Identifier of the target document model.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  targetModelId: string;

  @doc("URL of the copied document model in the target account.")
  targetModelLocation: url;

  @doc("Token used to authorize the request.")
  accessToken: string;

  @doc("Date/time when the access token expires.")
  expirationDateTime: utcDateTime;
}

@added(Versions.v2024_07_31_preview)
@doc("Request body to authorize document classifier copy.")
model AuthorizeClassifierCopyRequest {
  @doc("Unique document classifier name.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  classifierId: string;

  @doc("Document classifier description.")
  @maxLength(4096)
  description?: string;

  @doc("List of key-value tag attributes associated with the document classifier.")
  tags?: Record<string>;
}

@added(Versions.v2024_07_31_preview)
@doc("""
  Authorization to copy a document classifier to the specified target resource and
  classifierId.
  """)
model ClassifierCopyAuthorization {
  @doc("ID of the target Azure resource where the document classifier should be copied to.")
  targetResourceId: string;

  @doc("""
    Location of the target Azure resource where the document classifier should be copied
    to.
    """)
  targetResourceRegion: string;

  @doc("Identifier of the target document classifier.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  targetClassifierId: string;

  @doc("URL of the copied document classifier in the target account.")
  targetClassifierLocation: url;

  @doc("Token used to authorize the request.")
  accessToken: string;

  @doc("Date/time when the access token expires.")
  expirationDateTime: utcDateTime;
}

@doc("Operation info.")
@resource("operations")
@discriminator("kind")
model OperationDetails {
  @doc("Operation ID")
  @key
  @visibility("read", "create")
  operationId: string;

  @doc("Operation status.  notStarted, running, completed, or failed")
  status: OperationStatus;

  @doc("Operation progress (0-100).")
  @minValue(0)
  @maxValue(100)
  percentCompleted?: int32;

  @doc("Date and time (UTC) when the operation was created.")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: utcDateTime;

  @doc("Type of operation.")
  kind: OperationKind;

  @doc("URL of the resource targeted by this operation.")
  resourceLocation: url;

  @doc("API version used to create this operation.")
  apiVersion?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;

  @doc("Encountered error.")
  error?: Error;
}

@resource("documentModels")
@doc("Document model info.")
model DocumentModelDetails {
  @key
  @visibility("read", "create")
  @doc("Unique document model name.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  modelId: string;

  @doc("Document model description.")
  @maxLength(4096)
  description?: string;

  @doc("Date and time (UTC) when the document model was created.")
  @visibility("read")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the document model will expire.")
  @visibility("read")
  expirationDateTime?: utcDateTime;

  @doc("API version used to create this document model.")
  @visibility("read")
  apiVersion?: string;

  @doc("List of key-value tag attributes associated with the document model.")
  tags?: Record<string>;

  @doc("Custom document model build mode.")
  @visibility("read")
  buildMode?: DocumentBuildMode;

  @doc("""
    Azure Blob Storage location containing the training data.  Either
    azureBlobSource or azureBlobFileListSource must be specified.
    """)
  @visibility("read")
  azureBlobSource?: AzureBlobContentSource;

  @doc("""
    Azure Blob Storage file list specifying the training data.  Either
    azureBlobSource or azureBlobFileListSource must be specified.
    """)
  @visibility("read")
  azureBlobFileListSource?: AzureBlobFileListContentSource;

  @doc("For composed models, the custom classifier to split and classify the input file.")
  classifierId?: string;

  @doc("For composed models, the file splitting behavior.")
  split?: SplitMode = SplitMode.none;

  @doc("Supported document types.")
  @visibility("read")
  docTypes?: Record<DocumentTypeDetails>;

  @doc("List of warnings encountered while building the model.")
  @visibility("read")
  warnings?: Warning[];

  @added(Versions.v2024_07_31_preview)
  @doc("Number of V100-equivalent GPU hours consumed for model training.")
  @visibility("read")
  trainingHours?: float32;
}

@doc("Document type info.")
model DocumentTypeDetails {
  @doc("Document model description.")
  @maxLength(4096)
  description?: string;

  @doc("Custom document model build mode.")
  buildMode?: DocumentBuildMode;

  @doc("Description of the document semantic schema using a JSON Schema style syntax.")
  fieldSchema?: Record<DocumentFieldSchema>;

  @doc("Estimated confidence for each field.")
  fieldConfidence?: Record<float32>;

  @doc("Document model to use for analyzing documents with specified type.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  @maxLength(64)
  modelId?: string;

  @doc("Only perform analysis if docType confidence is above threshold.")
  confidenceThreshold?: float32;

  @doc("List of optional analysis features.")
  features?: DocumentAnalysisFeature[];

  @doc("List of additional fields to extract.  Ex. \"NumberOfGuests,StoreNumber\"")
  queryFields?: string[];

  @doc("Maximum number of documents of specified type to analyze.  Default=all.")
  maxDocumentsToAnalyze?: int32;
}

@doc("Description of the field semantic schema using a JSON Schema style syntax.")
model DocumentFieldSchema {
  @doc("Semantic data type of the field value.")
  type: DocumentFieldType;

  @doc("Field description.")
  @maxLength(4096)
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
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  classifierId: string;

  @doc("Document classifier description.")
  @maxLength(4096)
  description?: string;

  @doc("Base classifierId on top of which to train the classifier.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  baseClassifierId?: string;

  @doc("List of document types to classify against.")
  docTypes: Record<ClassifierDocumentTypeDetails>;

  @added(Versions.v2024_07_31_preview)
  @doc("Allow overwriting an existing classifier with the same name.")
  allowOverwrite?: boolean = false;
}

@doc("Classifier document type info.")
model ClassifierDocumentTypeDetails {
  @doc("Type of training data source.")
  sourceKind?: ContentSourceKind;

  @doc("""
    Azure Blob Storage location containing the training data for a classifier
    document type.  Either azureBlobSource or azureBlobFileListSource must be
    specified.
    """)
  azureBlobSource?: AzureBlobContentSource;

  @doc("""
    Azure Blob Storage file list specifying the training data for a classifier
    document type.  Either azureBlobSource or azureBlobFileListSource must be
    specified.
    """)
  azureBlobFileListSource?: AzureBlobFileListContentSource;
}

@doc("Document classifier info.")
@resource("documentClassifiers")
model DocumentClassifierDetails {
  @key
  @visibility("read", "create")
  @doc("Unique document classifier name.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  @maxLength(64)
  classifierId: string;

  @doc("Document classifier description.")
  @maxLength(4096)
  description?: string;

  @doc("Date and time (UTC) when the document classifier was created.")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the document classifier will expire.")
  expirationDateTime?: utcDateTime;

  @doc("API version used to create this document classifier.")
  apiVersion: string;

  @doc("Base classifierId on top of which the classifier was trained.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._~-]{1,63}$")
  baseClassifierId?: string;

  @doc("List of document types to classify against.")
  docTypes: Record<ClassifierDocumentTypeDetails>;

  @doc("List of warnings encountered while building the classifier.")
  warnings?: Warning[];
}

@doc("Document classification parameters.")
model ClassifyDocumentRequest {
  @doc("Document URL to classify.  Either urlSource or base64Source must be specified.")
  urlSource?: url;

  @doc("""
    Base64 encoding of the document to classify.  Either urlSource or base64Source
    must be specified.
    """)
  base64Source?: bytes;
}

@doc("General information regarding the current resource.")
model ResourceDetails {
  @doc("Details regarding custom document models.")
  customDocumentModels: CustomDocumentModelsDetails;
}

@doc("Details regarding custom document models.")
model CustomDocumentModelsDetails {
  @doc("Number of custom document models in the current resource.")
  count: int32;

  @doc("Maximum number of custom document models supported in the current resource.")
  limit: int32;
}

@doc("Get Operation response object.")
model DocumentModelBuildOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  @lroResult
  result?: DocumentModelDetails;

  @doc("Type of operation.")
  kind: OperationKind.documentModelBuild;
}

@doc("Get Operation response object.")
model DocumentModelComposeOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  @lroResult
  result?: DocumentModelDetails;

  @doc("Type of operation.")
  kind: OperationKind.documentModelCompose;
}

@doc("Get Operation response object.")
model DocumentModelCopyToOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  @lroResult
  result?: DocumentModelDetails;

  @doc("Type of operation.")
  kind: OperationKind.documentModelCopyTo;
}

@added(Versions.v2024_07_31_preview)
@doc("Get Operation response object.")
model DocumentClassifierCopyToOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  @lroResult
  result?: DocumentClassifierDetails;

  @doc("Type of operation.")
  kind: OperationKind.documentClassifierCopyTo;
}

@doc("Get Operation response object.")
model DocumentClassifierBuildOperationDetails extends OperationDetails {
  @doc("Operation result upon success.")
  @lroResult
  result?: DocumentClassifierDetails;

  @doc("Type of operation.")
  kind: OperationKind.documentClassifierBuild;
}
