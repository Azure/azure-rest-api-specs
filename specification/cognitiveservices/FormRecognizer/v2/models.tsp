import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.Core;
using TypeSpec.Versioning;

namespace FormRecognizer;

@added(APIVersion.v2_1)
enum TextStyle {
  Other: "other",
  Handwriting: "handwriting",
}

@added(APIVersion.v2_1)
enum SelectionMarkState {
  Selected: "selected",
  Unselected: "unselected",
}

@added(APIVersion.v2_1)
enum KeyValueType {
  String: "string",
  SelectionMark: "selectionMark",
}

@added(APIVersion.v2_1)
enum FieldValueSelectionMark {
  Selected: "selected",
  Unselected: "unselected",
}

@added(APIVersion.v2_1)
enum Locale {
  EnAU: "en-AU",
  EnCA: "en-CA",
  EnGB: "en-GB",
  EnIN: "en-IN",
  EnUS: "en-US",
}

enum Language {
  @added(APIVersion.v2_1)
  Af: "af",
  @added(APIVersion.v2_1)
  Ast: "ast",
  @added(APIVersion.v2_1)
  Bi: "bi",
  @added(APIVersion.v2_1)
  Br: "br",
  @added(APIVersion.v2_1)
  Ca: "ca",
  @added(APIVersion.v2_1)
  Ceb: "ceb",
  @added(APIVersion.v2_1)
  Ch: "ch",
  @added(APIVersion.v2_1)
  Co: "co",
  @added(APIVersion.v2_1)
  Crh: "crh",
  @added(APIVersion.v2_1)
  Cs: "cs",
  @added(APIVersion.v2_1)
  Csb: "csb",
  @added(APIVersion.v2_1)
  Da: "da",
  @added(APIVersion.v2_1)
  De: "de",
  En: "en",
  Es: "es",
  @added(APIVersion.v2_1)
  Et: "et",
  @added(APIVersion.v2_1)
  Eu: "eu",
  @added(APIVersion.v2_1)
  Fi: "fi",
  @added(APIVersion.v2_1)
  Fil: "fil",
  @added(APIVersion.v2_1)
  Fj: "fj",
  @added(APIVersion.v2_1)
  Fr: "fr",
  @added(APIVersion.v2_1)
  Fur: "fur",
  @added(APIVersion.v2_1)
  Fy: "fy",
  @added(APIVersion.v2_1)
  Ga: "ga",
  @added(APIVersion.v2_1)
  Gd: "gd",
  @added(APIVersion.v2_1)
  Gil: "gil",
  @added(APIVersion.v2_1)
  Gl: "gl",
  @added(APIVersion.v2_1)
  Gv: "gv",
  @added(APIVersion.v2_1)
  Hni: "hni",
  @added(APIVersion.v2_1)
  Hsb: "hsb",
  @added(APIVersion.v2_1)
  Ht: "ht",
  @added(APIVersion.v2_1)
  Hu: "hu",
  @added(APIVersion.v2_1)
  Ia: "ia",
  @added(APIVersion.v2_1)
  Id: "id",
  @added(APIVersion.v2_1)
  It: "it",
  @added(APIVersion.v2_1)
  Iu: "iu",
  @added(APIVersion.v2_1)
  Ja: "ja",
  @added(APIVersion.v2_1)
  Jv: "jv",
  @added(APIVersion.v2_1)
  Kaa: "kaa",
  @added(APIVersion.v2_1)
  Kac: "kac",
  @added(APIVersion.v2_1)
  Kea: "kea",
  @added(APIVersion.v2_1)
  Kha: "kha",
  @added(APIVersion.v2_1)
  Kl: "kl",
  @added(APIVersion.v2_1)
  Ko: "ko",
  @added(APIVersion.v2_1)
  Ku: "ku",
  @added(APIVersion.v2_1)
  Kw: "kw",
  @added(APIVersion.v2_1)
  Lb: "lb",
  @added(APIVersion.v2_1)
  Ms: "ms",
  @added(APIVersion.v2_1)
  Mww: "mww",
  @added(APIVersion.v2_1)
  Nap: "nap",
  @added(APIVersion.v2_1)
  Nl: "nl",
  @added(APIVersion.v2_1)
  No: "no",
  @added(APIVersion.v2_1)
  Oc: "oc",
  @added(APIVersion.v2_1)
  Pl: "pl",
  @added(APIVersion.v2_1)
  Pt: "pt",
  @added(APIVersion.v2_1)
  Quc: "quc",
  @added(APIVersion.v2_1)
  Rm: "rm",
  @added(APIVersion.v2_1)
  Sco: "sco",
  @added(APIVersion.v2_1)
  Sl: "sl",
  @added(APIVersion.v2_1)
  Sq: "sq",
  @added(APIVersion.v2_1)
  Sv: "sv",
  @added(APIVersion.v2_1)
  Sw: "sw",
  @added(APIVersion.v2_1)
  Tet: "tet",
  @added(APIVersion.v2_1)
  Tr: "tr",
  @added(APIVersion.v2_1)
  Tt: "tt",
  @added(APIVersion.v2_1)
  Uz: "uz",
  @added(APIVersion.v2_1)
  Vo: "vo",
  @added(APIVersion.v2_1)
  Wae: "wae",
  @added(APIVersion.v2_1)
  Yua: "yua",
  @added(APIVersion.v2_1)
  Za: "za",
  @added(APIVersion.v2_1)
  ZhHans: "zh-Hans",
  @added(APIVersion.v2_1)
  ZhHant: "zh-Hant",
  @added(APIVersion.v2_1)
  Zu: "zu",
}

enum Enum6 {
  Full: "full",
}

enum Enum7 {
  Summary: "summary",
}

enum ModelStatus {
  Creating: "creating",
  Ready: "ready",
  Invalid: "invalid",
}

enum TrainStatus {
  Succeeded: "succeeded",
  PartiallySucceeded: "partiallySucceeded",
  Failed: "failed",
}

union ContentType {
  ApplicationPdf: "application/pdf",
  @added(APIVersion.v2_1)
  ImageBmp: "image/bmp",
  ImageJpeg: "image/jpeg",
  ImagePng: "image/png",
  ImageTiff: "image/tiff",
}

enum OperationStatus {
  NotStarted: "notStarted",
  Running: "running",
  Succeeded: "succeeded",
  Failed: "failed",
}

enum LengthUnit {
  Pixel: "pixel",
  Inch: "inch",
}

enum FieldValueType {
  String: "string",
  Date: "date",
  Time: "time",
  PhoneNumber: "phoneNumber",
  Number: "number",
  Integer: "integer",
  Array: "array",
  Object: "object",
  @added(APIVersion.v2_1)
  SelectionMark: "selectionMark",
  @added(APIVersion.v2_1)
  CountryRegion: "countryRegion",
}

@added(APIVersion.v2_1)
enum ReadingOrder {
  Basic: "basic",
  Natural: "natural",
}

@doc("Request parameter to train a new custom model.")
model TrainRequest {
  @doc("Source path containing the training documents.")
  source: string;

  @doc("Filter to apply to the documents in the source path for training.")
  sourceFilter?: TrainSourceFilter;

  @doc("Use label file for training a model.")
  useLabelFile?: boolean;

  @added(APIVersion.v2_1)
  @doc("Optional user defined model name (max length: 1024).")
  modelName?: string;
}

@doc("Filter to apply to the documents in the source path for training.")
model TrainSourceFilter {
  @doc("""
A case-sensitive prefix string to filter documents in the source path for
training. For example, when using a Azure storage blob Uri, use the prefix to
restrict sub folders for training.
""")
  prefix?: string;

  @doc("""
A flag to indicate if sub folders within the set of prefix folders will also
need to be included when searching for content to be preprocessed.
""")
  includeSubFolders?: boolean;
}

@error
model ErrorResponse {
  error: ErrorInformation;
}

model ErrorInformation {
  code: string;
  message: string;
}

@doc("Response to the get custom model operation.")
model Model {
  // @key
  @doc("Basic custom model information.")
  modelInfo: ModelInfo;

  @doc("Keys extracted by the custom model.")
  keys?: KeysResult;

  @doc("Training result for custom model.")
  trainResult?: TrainResult;

  @added(APIVersion.v2_1)
  @doc("Training result for composed model.")
  composedTrainResults?: TrainResult[];
}

@resource("custom/models")
@doc("Basic custom model information.")
model ModelInfo {
  @doc("Model identifier.")
  @key
  modelId: string;

  @doc("Status of the model.")
  status: ModelStatus;

  @doc("Date and time (UTC) when the model was created.")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: utcDateTime;

  @added(APIVersion.v2_1)
  @doc("Optional user defined model name (max length: 1024).")
  modelName?: string;

  @added(APIVersion.v2_1)
  @doc("Optional model attributes.")
  attributes?: Attributes;
}

@added(APIVersion.v2_1)
@doc("Optional model attributes.")
model Attributes {
  @doc("Is this model composed? (default: false).")
  isComposed?: boolean;
}

@doc("Keys extracted by the custom model.")
model KeysResult {
  @doc("Object mapping clusterIds to a list of keys.")
  clusters: Record<string[]>;
}

@doc("Custom model training result.")
model TrainResult {
  @doc("""
List of the documents used to train the model and any errors reported in each
document.
""")
  trainingDocuments: TrainingDocumentInfo[];

  @doc("""
List of fields used to train the model and the train operation error reported
by each.
""")
  fields?: FormFieldsReport[];

  @doc("Average accuracy.")
  averageModelAccuracy?: float32;

  @added(APIVersion.v2_1)
  @doc("Model identifier.")
  modelId?: string;

  @doc("Errors returned during the training operation.")
  errors?: ErrorInformation[];
}

@doc("Report for a custom model training document.")
model TrainingDocumentInfo {
  @doc("Training document name.")
  documentName: string;

  @doc("Total number of pages trained.")
  pages: int32;

  @doc("List of errors.")
  errors: ErrorInformation[];

  @doc("Status of the training operation.")
  status: TrainStatus;
}

@doc("Report for a custom model training field.")
model FormFieldsReport {
  @doc("Training field name.")
  fieldName: string;

  @doc("Estimated extraction accuracy for this field.")
  accuracy: float32;
}

@doc("Uri or local path to source data.")
model SourcePath {
  @doc("File source path.")
  source?: string;
}

@doc("Status and result of the queued analyze operation.")
model AnalyzeOperationResult {
  @doc("Operation status.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  status: OperationStatus;

  @doc("Date and time (UTC) when the analyze operation was submitted.")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: utcDateTime;

  @doc("Results of the analyze operation.")
  analyzeResult?: AnalyzeResult;
}

@doc("Analyze operation result.")
model AnalyzeResult {
  @doc("Version of schema used for this result.")
  version: string;

  @doc("Text extracted from the input.")
  readResults: ReadResult[];

  @doc("Page-level information extracted from the input.")
  pageResults?: PageResult[];

  @doc("Document-level information extracted from the input.")
  documentResults?: DocumentResult[];

  @doc("List of errors reported during the analyze operation.")
  errors?: ErrorInformation[];
}

@doc("Text extracted from a page in the input document.")
model ReadResult {
  @doc("The 1-based page number in the input document.")
  page: int32;

  @doc("""
The general orientation of the text in clockwise direction, measured in degrees
between (-180, 180].
""")
  angle: float32;

  @doc("The width of the image/PDF in pixels/inches, respectively.")
  width: float32;

  @doc("The height of the image/PDF in pixels/inches, respectively.")
  height: float32;

  @doc("""
The unit used by the width, height and boundingBox properties. For images, the
unit is \"pixel\". For PDF, the unit is \"inch\".
""")
  unit: LengthUnit;

  @doc("""
When includeTextDetails is set to true, a list of recognized text lines. The
maximum number of lines returned is 300 per page. The lines are sorted top to
bottom, left to right, although in certain cases proximity is treated with
higher priority. As the sorting order depends on the detected text, it may
change across images and OCR version updates. Thus, business logic should be
built upon the actual line location instead of order.
""")
  lines?: TextLine[];

  @added(APIVersion.v2_1)
  @doc("List of selection marks extracted from the page.")
  selectionMarks?: SelectionMark[];

  @removed(APIVersion.v2_1)
  @doc("The detected language on the page overall.")
  language?: Language;
}

@doc("An object representing an extracted text line.")
model TextLine {
  @doc("The text content of the line.")
  text: string;

  @doc("Bounding box of an extracted line.")
  boundingBox: float32[];

  @doc("List of words in the text line.")
  words: TextWord[];

  @added(APIVersion.v2_1)
  @doc("Text appearance properties.")
  appearance?: Appearance;

  @removed(APIVersion.v2_1)
  @doc("The detected language of this line, if different from the overall page language.")
  language?: Language;
}

@doc("An object representing a word.")
model TextWord {
  @doc("The text content of the word.")
  text: string;

  @doc("Bounding box of an extracted word.")
  boundingBox: float32[];

  @doc("Confidence value.")
  confidence?: float32;
}

@added(APIVersion.v2_1)
@doc("An object representing the appearance of the text line.")
model Appearance {
  @doc("An object representing the style of the text line.")
  style: Style;
}

@added(APIVersion.v2_1)
@doc("An object representing the style of the text line.")
model Style {
  @doc("The text line style name, including handwriting and other.")
  name: TextStyle;

  @doc("The confidence of text line style.")
  confidence: float32;
}

@added(APIVersion.v2_1)
@doc("Information about the extracted selection mark.")
model SelectionMark {
  @doc("Bounding box of the selection mark.")
  boundingBox: float32[];

  @doc("Confidence value.")
  confidence: float32;

  @doc("State of the selection mark.")
  state: SelectionMarkState;
}

@doc("Extracted information from a single page.")
model PageResult {
  @doc("Page number.")
  page: int32;

  @doc("Cluster identifier.")
  clusterId?: int32;

  @doc("List of key-value pairs extracted from the page.")
  keyValuePairs?: KeyValuePair[];

  @doc("List of data tables extracted from the page.")
  tables?: DataTable[];
}

@doc("Information about the extracted key-value pair.")
model KeyValuePair {
  @doc("A user defined label for the key/value pair entry.")
  label?: string;

  @doc("Information about the extracted key in a key-value pair.")
  key: KeyValueElement;

  @doc("Information about the extracted value in a key-value pair.")
  value: KeyValueElement;

  @doc("Confidence value.")
  confidence: float32;
}

@doc("Information about the extracted key or value in a key-value pair.")
model KeyValueElement {
  @added(APIVersion.v2_1)
  @doc("Semantic data type of the key value element.")
  type?: KeyValueType;

  @doc("The text content of the key or value.")
  text: string;

  @doc("Bounding box of the key or value.")
  boundingBox?: float32[];

  @doc("""
When includeTextDetails is set to true, a list of references to the text
elements constituting this key or value.
""")
  elements?: string[];
}

@doc("Information about the extracted table contained in a page.")
model DataTable {
  @doc("Number of rows.")
  rows: int32;

  @doc("Number of columns.")
  columns: int32;

  @doc("List of cells contained in the table.")
  cells: DataTableCell[];

  // FIXME: check this
  @added(APIVersion.v2_1)
  @doc("Bounding box of the table.")
  boundingBox: float32[];
}

@doc("Information about the extracted cell in a table.")
model DataTableCell {
  @doc("Row index of the cell.")
  rowIndex: int32;

  @doc("Column index of the cell.")
  columnIndex: int32;

  @doc("Number of rows spanned by this cell.")
  rowSpan?: int32;

  @doc("Number of columns spanned by this cell.")
  columnSpan?: int32;

  @doc("Text content of the cell.")
  text: string;

  @doc("Bounding box of the cell.")
  boundingBox: float32[];

  @doc("Confidence value.")
  confidence: float32;

  @doc("""
When includeTextDetails is set to true, a list of references to the text
elements constituting this table cell.
""")
  elements?: string[];

  @doc("Is the current cell a header cell?")
  isHeader?: boolean;

  @doc("Is the current cell a footer cell?")
  isFooter?: boolean;
}

@doc("A set of extracted fields corresponding to the input document.")
model DocumentResult {
  @doc("Document type.")
  docType: string;

  @added(APIVersion.v2_1)
  @doc("Model identifier.")
  modelId?: string;

  @doc("First and last page number where the document is found.")
  pageRange: int32[];

  @added(APIVersion.v2_1)
  @doc("Predicted document type confidence.")
  docTypeConfidence?: float32;

  @doc("Dictionary of named field values.")
  fields: Record<FieldValue>;
}

@doc("Recognized field value.")
model FieldValue {
  @doc("Type of field value.")
  type: FieldValueType;

  @doc("String value.")
  valueString?: string;

  @doc("Date value.")
  valueDate?: plainDate;

  @doc("Time value.")
  valueTime?: plainTime;

  @doc("Phone number value.")
  valuePhoneNumber?: string;

  @doc("Floating point value.")
  valueNumber?: float32;

  @doc("Integer value.")
  valueInteger?: int32;

  @doc("Array of field values.")
  valueArray?: FieldValue[];

  @doc("Dictionary of named field values.")
  valueObject?: Record<FieldValue>;

  @added(APIVersion.v2_1)
  @doc("Selection mark value.")
  valueSelectionMark?: FieldValueSelectionMark;

  @added(APIVersion.v2_1)
  @doc("3-letter country code (ISO 3166-1 alpha-3).")
  valueCountryRegion?: string;

  @doc("Text content of the extracted field.")
  text?: string;

  @doc("Bounding box of the field value, if appropriate.")
  boundingBox?: float32[];

  @doc("Confidence score.")
  confidence?: float32;

  @doc("""
When includeTextDetails is set to true, a list of references to the text
elements constituting this field.
""")
  elements?: string[];

  @doc("The 1-based page number in the input document.")
  page?: int32;
}

@doc("""
Request parameter to copy an existing custom model from the source resource to
a target resource referenced by the resource ID.
""")
model CopyRequest {
  @doc("""
Azure Resource Id of the target Form Recognizer resource where the model is
copied to.
""")
  targetResourceId: string;

  @doc("""
Location of the target Azure resource. A valid Azure region name supported by
Cognitive Services.
""")
  targetResourceRegion: string;

  @doc("Entity that encodes claims to authorize the copy request.")
  copyAuthorization: CopyAuthorizationResult;
}

@doc("Request parameter that contains authorization claims for copy operation.")
@resource("custom/models/copyAuthorization")
model CopyAuthorizationResult {
  @doc("Model identifier.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  modelId: string;

  @doc("Token claim used to authorize the request.")
  accessToken: string;

  @doc("""
The time when the access token expires. The date is represented as the number
of seconds from 1970-01-01T0:0:0Z UTC until the expiration time.
""")
  expirationDateTimeTicks: int32;
}

@doc("Status and result of the queued copy operation.")
model CopyOperationResult {
  @doc("Operation status.")
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  status: OperationStatus;

  @doc("Date and time (UTC) when the copy operation was submitted.")
  createdDateTime: utcDateTime;

  @doc("Date and time (UTC) when the status was last updated.")
  lastUpdatedDateTime: utcDateTime;

  @doc("Results of the copy operation.")
  copyResult?: CopyResult;
}

@doc("Custom model copy result.")
model CopyResult {
  @doc("Identifier of the target model.")
  modelId: string;

  @doc("Errors returned during the copy operation.")
  errors?: ErrorInformation[];
}

@added(APIVersion.v2_1)
@doc("Request contract for compose operation.")
model ComposeRequest {
  @doc("List of model ids to compose.")
  modelIds: string[];

  @doc("Optional user defined model name (max length: 1024).")
  modelName?: string;
}

@doc("Response to the list custom models operation.")
@pagedResult
model Models {
  @doc("Summary of all trained custom models.")
  summary?: ModelsSummary;

  @doc("Collection of trained custom models.")
  @items
  modelList?: ModelInfo[];

  @doc("Link to the next page of custom models.")
  @nextLink
  nextLink?: string;
}

@doc("Summary of all trained custom models.")
model ModelsSummary {
  @doc("Current count of trained custom models.")
  count: int32;

  @doc("Max number of models that can be trained for this account.")
  limit: int32;

  @doc("Date and time (UTC) when the summary was last updated.")
  lastUpdatedDateTime: utcDateTime;
}
