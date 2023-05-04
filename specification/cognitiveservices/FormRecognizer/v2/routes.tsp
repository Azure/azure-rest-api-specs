import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace FormRecognizer;

@summary("Train Custom Model")
@doc("""
Create and train a custom model. The request must include a source parameter
that is either an externally accessible Azure storage blob container Uri
(preferably a Shared Access Signature Uri) or valid path to a data folder in a
locally mounted drive. When local paths are specified, they must follow the
Linux/Unix path format and be an absolute path rooted to the input mount
configuration setting value e.g., if '{Mounts:Input}' configuration setting
value is '/input' then a valid source path would be '/input/contosodataset'.
All data to be trained is expected to be under the source folder or sub folders
under it. Models are trained using documents that are of the following content
type - 'application/pdf', 'image/jpeg', 'image/png', 'image/tiff' or
'image/bmp'. Other type of content is ignored.
""")
@route("/custom/models")
@post
op TrainCustomModel is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Training request parameters.")
    @body
    trainRequest: TrainRequest;
  },
  AnalyzeOperationResult
>;

@summary("Get Custom Model")
@doc("Get detailed information about a custom model.")
@route("/custom/models/{modelId}")
@get
op GetCustomModel is Azure.Core.Foundations.Operation<
  {
    @doc("Model identifier.")
    @path
    modelId: string;

    @doc("Include list of extracted keys in model information.")
    @query
    includeKeys: boolean;
  },
  Model
>;

@summary("Delete Custom Model")
@doc("""
Mark model for deletion. Model artifacts will be permanently removed within a
predetermined period.
""")
@route("/custom/models/{modelId}")
@delete
op DeleteCustomModel is Azure.Core.Foundations.Operation<
  {
    @doc("Model identifier.")
    @path
    modelId: string;
  },
  void
>;

@summary("Analyze Form")
@doc("""
Extract key-value pairs, tables, and semantic values from a given document. The
input document must be of one of the supported content types -
'application/pdf', 'image/jpeg', 'image/png', 'image/tiff' or 'image/bmp'.
Alternatively, use 'application/json' type to specify the location (Uri or
local path) of the document to be analyzed.
""")
@route("/custom/models/{modelId}/analyze")
@post
op AnalyzeWithCustomModel is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Model identifier.")
    @path
    modelId: string;

    @doc("Include text lines and element references in the result.")
    @query
    includeTextDetails: boolean;

    @added(APIVersion.v2_1)
    @doc("""
Custom page numbers for multi-page documents(PDF/TIFF), input the number of the
pages you want to get OCR result. For a range of pages, use a hyphen. Separate
each page or range with a comma.
""")
    @query
    pages: string[];

    @doc("Upload file type")
    @header
    "Content-Type": ContentType;

    @doc(".json, .pdf, .jpg, .png, .tiff or .bmp type file stream.")
    @body
    fileStream: bytes;
  },
  AnalyzeOperationResult
>;

@summary("Get Analyze Form Result")
@doc("Obtain current status and the result of the analyze form operation.")
@route("/custom/models/{modelId}/analyzeResults/{resultId}")
@get
op GetAnalyzeFormResult is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Model identifier.")
    @path
    modelId: string;

    @doc("Analyze operation result identifier.")
    @path
    resultId: string;
  },
  AnalyzeOperationResult
>;

@summary("Copy Custom Model")
@doc("""
Copy custom model stored in this resource (the source) to user specified target
Form Recognizer resource.
""")
@route("/custom/models/{modelId}/copy")
@post
op CopyCustomModel is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Model identifier.")
    @path
    modelId: string;

    @doc("Copy request parameters.")
    @body
    copyRequest: CopyRequest;
  },
  AnalyzeOperationResult
>;

@summary("Get Custom Model Copy Result")
@doc("Obtain current status and the result of a custom model copy operation.")
@route("/custom/models/{modelId}/copyResults/{resultId}")
@get
op GetCustomModelCopyResult is Azure.Core.Foundations.Operation<
  {
    @doc("Model identifier.")
    @path
    modelId: string;

    @doc("Copy operation result identifier.")
    @path
    resultId: string;
  },
  CopyOperationResult
>;

@summary("Generate Copy Authorization")
@doc("Generate authorization to copy a model into the target Form Recognizer resource.")
op GenerateModelCopyAuthorization is Azure.Core.ResourceCreateWithServiceProvidedName<CopyAuthorizationResult>;

@added(APIVersion.v2_1)
@summary("Compose trained with labels models into one composed model.")
@doc("""
Compose request would include list of models ids.
It would validate what all
models either trained with labels model or composed model.
It would validate
limit of models put together.
""")
@route("/custom/models/compose")
@post
op ComposeCustomModels is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Compose models")
    @body
    composeRequest: ComposeRequest;

    @doc("Accept header")
    @header
    Accept: "application/json, text/json";
  },
  AnalyzeOperationResult
>;

@added(APIVersion.v2_1)
@summary("Analyze Business Card")
@doc("""
Extract field text and semantic values from a given business card document. The
input document must be of one of the supported content types -
'application/pdf', 'image/jpeg', 'image/png', 'image/tiff' or 'image/bmp'.
Alternatively, use 'application/json' type to specify the location (Uri) of the
document to be analyzed.
""")
@route("/prebuilt/businessCard/analyze")
@post
op AnalyzeBusinessCard is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Include text lines and element references in the result.")
    @query
    includeTextDetails: boolean;

    @doc("""
Locale of the input document. Supported locales include: en-AU, en-CA, en-GB,
en-IN, en-US(default).
""")
    @query
    locale: Locale;

    @doc("""
Custom page numbers for multi-page documents(PDF/TIFF), input the number of the
pages you want to get OCR result. For a range of pages, use a hyphen. Separate
each page or range with a comma.
""")
    @query
    pages: string[];

    @doc("Upload file type")
    @header
    "Content-Type": ContentType;

    @doc(".json, .pdf, .jpg, .png, .tiff or .bmp type file stream.")
    @body
    fileStream: bytes;
  },
  AnalyzeOperationResult
>;

@added(APIVersion.v2_1)
@summary("Get Analyze Business Card Result")
@doc("Track the progress and obtain the result of the analyze business card operation.")
@route("/prebuilt/businessCard/analyzeResults/{resultId}")
@get
op GetAnalyzeBusinessCardResult is Azure.Core.Foundations.Operation<
  {
    @doc("Analyze operation result identifier.")
    @path
    resultId: string;
  },
  AnalyzeOperationResult
>;

@added(APIVersion.v2_1)
@summary("Analyze Invoice Document")
@doc("""
Extract field text and semantic values from a given invoice document. The input
document must be of one of the supported content types - 'application/pdf',
'image/jpeg', 'image/png', 'image/tiff' or 'image/bmp'. Alternatively, use
'application/json' type to specify the location (Uri) of the document to be
analyzed.
""")
@route("/prebuilt/invoice/analyze")
@post
op AnalyzeInvoice is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Include text lines and element references in the result.")
    @query
    includeTextDetails: boolean;

    @doc("""
Locale of the input document. Supported locales include: en-AU, en-CA, en-GB,
en-IN, en-US(default).
""")
    @query
    locale: Locale;

    @doc("""
Custom page numbers for multi-page documents(PDF/TIFF), input the number of the
pages you want to get OCR result. For a range of pages, use a hyphen. Separate
each page or range with a comma.
""")
    @query
    pages: string[];

    @doc("Upload file type")
    @header
    "Content-Type": ContentType;

    @doc(".json, .pdf, .jpg, .png, .tiff or .bmp type file stream.")
    @body
    fileStream: bytes;
  },
  AnalyzeOperationResult
>;

@added(APIVersion.v2_1)
@summary("Get Analyze Invoice Result")
@doc("Track the progress and obtain the result of the analyze invoice operation.")
@route("/prebuilt/invoice/analyzeResults/{resultId}")
@get
op GetAnalyzeInvoiceResult is Azure.Core.Foundations.Operation<
  {
    @doc("Analyze operation result identifier.")
    @path
    resultId: string;
  },
  AnalyzeOperationResult
>;

@added(APIVersion.v2_1)
@summary("Analyze ID Document")
@doc("""
Extract field text and semantic values from a given ID document. The input
document must be of one of the supported content types - 'application/pdf',
'image/jpeg', 'image/png', 'image/tiff' or 'image/bmp'. Alternatively, use
'application/json' type to specify the location (Uri) of the document to be
analyzed.
""")
@route("/prebuilt/idDocument/analyze")
@post
op AnalyzeIdDocument is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Include text lines and element references in the result.")
    @query
    includeTextDetails: boolean;

    @doc("""
Custom page numbers for multi-page documents(PDF/TIFF), input the number of the
pages you want to get OCR result. For a range of pages, use a hyphen. Separate
each page or range with a comma.
""")
    @query
    pages: string[];

    @doc("Upload file type")
    @header
    "Content-Type": ContentType;

    @doc(".json, .pdf, .jpg, .png, .tiff or .bmp type file stream.")
    @body
    fileStream: bytes;
  },
  AnalyzeOperationResult
>;

@added(APIVersion.v2_1)
@summary("Get Analyze ID Document Result")
@doc("Track the progress and obtain the result of the analyze ID operation.")
@route("/prebuilt/idDocument/analyzeResults/{resultId}")
@get
op GetAnalyzeIdDocumentResult is Azure.Core.Foundations.Operation<
  {
    @doc("Analyze operation result identifier.")
    @path
    resultId: string;
  },
  AnalyzeOperationResult
>;

@summary("Analyze Receipt")
@doc("""
Extract field text and semantic values from a given receipt document. The input
document must be of one of the supported content types - 'application/pdf',
'image/jpeg', 'image/png', 'image/tiff' or 'image/bmp'. Alternatively, use
'application/json' type to specify the location (Uri) of the document to be
analyzed.
""")
@route("/prebuilt/receipt/analyze")
@post
op AnalyzeReceipt is Azure.Core.Foundations.LongRunningOperation<
  {
    @doc("Include text lines and element references in the result.")
    @query
    includeTextDetails: boolean;

    @added(APIVersion.v2_1)
    @doc("""
Locale of the input document. Supported locales include: en-AU, en-CA, en-GB,
en-IN, en-US(default).
""")
    @query
    locale: Locale;

    @added(APIVersion.v2_1)
    @doc("""
Custom page numbers for multi-page documents(PDF/TIFF), input the number of the
pages you want to get OCR result. For a range of pages, use a hyphen. Separate
each page or range with a comma.
""")
    @query
    pages: string[];

    @doc("Upload file type")
    @header
    "Content-Type": ContentType;

    @doc(".json, .pdf, .jpg, .png, .tiff or .bmp type file stream.")
    @body
    fileStream: bytes;
  },
  AnalyzeOperationResult
>;

@summary("Get Analyze Receipt Result")
@doc("Track the progress and obtain the result of the analyze receipt operation.")
@route("/prebuilt/receipt/analyzeResults/{resultId}")
@get
op GetAnalyzeReceiptResult is Azure.Core.Foundations.Operation<
  {
    @doc("Analyze operation result identifier.")
    @path
    resultId: string;
  },
  AnalyzeOperationResult
>;

@summary("Analyze Layout")
@doc("""
Extract text and layout information from a given document. The input document
must be of one of the supported content types - 'application/pdf',
'image/jpeg', 'image/png', 'image/tiff' or 'image/bmp'. Alternatively, use
'application/json' type to specify the location (Uri or local path) of the
document to be analyzed.
""")
@route("/layout/analyze")
@post
op AnalyzeLayout is Azure.Core.Foundations.LongRunningOperation<
  {
    @added(APIVersion.v2_1)
    @doc("""
Custom page numbers for multi-page documents(PDF/TIFF), input the number of the
pages you want to get OCR result. For a range of pages, use a hyphen. Separate
each page or range with a comma.
""")
    @query
    pages: string[];

    @added(APIVersion.v2_1)
    @doc("""
Currently, only Afrikaans (‘af’), Albanian (‘sq’), Asturian (‘ast’), Basque
(‘eu’), Bislama (‘bi’), Breton (‘br’), Catalan (‘ca’), Cebuano (‘ceb’),
Chamorro (‘ch’), Cornish (‘kw’), Corsican (‘co’), Crimean Tatar - Latin
script(‘crh’), Czech (‘cs’), Danish (‘da’), Dutch (‘nl’), English ('en'),
Estonian (‘et’), Fijian (‘fj’), Filipino (‘fil’), Finnish (‘fi’), French
(‘fr’), Friulian (‘fur’), Galician (‘gl’), German (‘de’), Gilbertese (‘gil’),
Greenlandic (‘kl’), Haitian Creole (‘ht’), Hani (‘hni’), Hmong Daw (‘mww’),
Hungarian (‘hu’), Indonesian (‘id’), Interlingua (‘ia’), Inuktitut (‘iu’),
Irish (‘ga’), Italian (‘it’), Japanese (‘ja’), Javanese (‘jv’), Kabuverdianu
(‘kea’), Kachin (‘kac’), Kara-Kalpak (‘kaa’), Kashubian (‘csb’), Khasi (‘kha’),
Korean (‘ko’), Kurdish - Latin script (‘ku’), K’iche’ (‘quc’), Luxembourgish
(‘lb’), Malay (‘ms’), Manx (‘gv’), Neapolitan (‘nap’), Norwegian (‘no’),
Occitan (‘oc’), Polish (‘pl’), Portuguese (‘pt’), Romansh (‘rm’), Scots
(‘sco’), Scottish Gaelic (‘gd’), simplified Chinese (‘zh-Hans’), Slovenian
(‘sl’), Spanish (‘es’), Swahili (‘sw’), Swedish (‘sv’), Tatar - Latin script
(‘tt’), Tetum (‘tet’), traditional Chinese (‘zh-Hant’), Turkish (‘tr’), Upper
Sorbian (‘hsb’), Uzbek (‘uz’), Volapük (‘vo’), Walser (‘wae’), Western Frisian
(‘fy’), Yucatec Maya (‘yua’), Zhuang (‘za’) and Zulu (‘zu’) are supported
(print – seventy-three languages and handwritten – English only). Layout
supports auto language identification and multi language documents, so only
provide a language code if you would like to force the documented to be
processed as that specific language.
""")
    @query
    language: Language;

    @added(APIVersion.v2_1)
    @doc("""
Reading order algorithm to sort the text lines returned. Supported reading
orders include: basic(default), natural.
""")
    @query
    readingOrder: ReadingOrder;

    @doc("Upload file type")
    @header
    "Content-Type": ContentType;

    @doc(".json, .pdf, .jpg, .png, .tiff or .bmp type file stream.")
    @body
    fileStream: bytes;
  },
  AnalyzeOperationResult
>;

@summary("Get Analyze Layout Result")
@doc("Track the progress and obtain the result of the analyze layout operation")
@route("/layout/analyzeResults/{resultId}")
@get
op GetAnalyzeLayoutResult is Azure.Core.Foundations.Operation<
  {
    @doc("Analyze operation result identifier.")
    @path
    resultId: string;
  },
  AnalyzeOperationResult
>;

@summary("List Custom Models")
@doc("Get information about all custom models")
@route("?op=full")
op ListCustomModels is Azure.Core.ResourceList<
  ModelInfo,
  {
    parameters: {
      @doc("Specify whether to return summary or full list of models.")
      @query
      "op": Enum6;
    };
  }
>;

@summary("Get Custom Models")
@doc("Get information about all custom models")
@route("/custom/models")
@get
op GetCustomModels is Azure.Core.Foundations.Operation<
  {
    @doc("Specify whether to return summary or full list of models.")
    @query
    "op": Enum7;
  },
  Models
>;
