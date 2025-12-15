import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models-shared.tsp";

using Azure.ClientGenerator.Core.Legacy;

namespace Search;

@doc("Defines the type of a datasource.")
union SearchIndexerDataSourceType {
  string,

  @doc("Indicates an Azure SQL datasource.")
  AzureSql: "azuresql",

  @doc("Indicates a CosmosDB datasource.")
  CosmosDb: "cosmosdb",

  @doc("Indicates an Azure Blob datasource.")
  AzureBlob: "azureblob",

  @doc("Indicates an Azure Table datasource.")
  AzureTable: "azuretable",

  @doc("Indicates a MySql datasource.")
  MySql: "mysql",

  @doc("Indicates an ADLS Gen2 datasource.")
  AdlsGen2: "adlsgen2",

  @doc("Indicates a Microsoft Fabric OneLake datasource.")
  OneLake: "onelake",

  @doc("Indicates a SharePoint datasource.")
  SharePoint: "sharepoint",
}

@doc("Represents the parsing mode for indexing from an Azure blob data source.")
union BlobIndexerParsingMode {
  string,

  @doc("Set to default for normal file processing.")
  Default: "default",

  @doc("Set to text to improve indexing performance on plain text files in blob storage.")
  Text: "text",

  @doc("Set to delimitedText when blobs are plain CSV files.")
  DelimitedText: "delimitedText",

  @doc("Set to json to extract structured content from JSON files.")
  Json: "json",

  @doc("Set to jsonArray to extract individual elements of a JSON array as separate documents.")
  JsonArray: "jsonArray",

  @doc("Set to jsonLines to extract individual JSON entities, separated by a new line, as separate documents.")
  JsonLines: "jsonLines",

  @doc("Set to markdown to extract content from markdown files.")
  Markdown: "markdown",
}

@doc("Specifies the submode that will determine whether a markdown file will be parsed into exactly one search document or multiple search documents. Default is `oneToMany`.")
union MarkdownParsingSubmode {
  string,

  @doc("Indicates that each section of the markdown file (up to a specified depth) will be parsed into individual search documents. This can result in a single markdown file producing multiple search documents. This is the default sub-mode.")
  OneToMany: "oneToMany",

  @doc("Indicates that each markdown file will be parsed into a single search document.")
  OneToOne: "oneToOne",
}

@doc("Specifies the max header depth that will be considered while grouping markdown content. Default is `h6`.")
union MarkdownHeaderDepth {
  string,

  @doc("Indicates that headers up to a level of h1 will be considered while grouping markdown content.")
  h1: "h1",

  @doc("Indicates that headers up to a level of h2 will be considered while grouping markdown content.")
  h2: "h2",

  @doc("Indicates that headers up to a level of h3 will be considered while grouping markdown content.")
  h3: "h3",

  @doc("Indicates that headers up to a level of h4 will be considered while grouping markdown content.")
  h4: "h4",

  @doc("Indicates that headers up to a level of h5 will be considered while grouping markdown content.")
  h5: "h5",

  @doc("Indicates that headers up to a level of h6 will be considered while grouping markdown content. This is the default.")
  h6: "h6",
}

@doc("Specifies the data to extract from Azure blob storage and tells the indexer which data to extract from image content when \"imageAction\" is set to a value other than \"none\".  This applies to embedded image content in a .PDF or other application, or image files such as .jpg and .png, in Azure blobs.")
union BlobIndexerDataToExtract {
  string,

  @doc("Indexes just the standard blob properties and user-specified metadata.")
  StorageMetadata: "storageMetadata",

  @doc("Extracts metadata provided by the Azure blob storage subsystem and the content-type specific metadata (for example, metadata unique to just .png files are indexed).")
  AllMetadata: "allMetadata",

  @doc("Extracts all metadata and textual content from each blob.")
  ContentAndMetadata: "contentAndMetadata",
}

@doc("Determines how to process embedded images and image files in Azure blob storage.  Setting the \"imageAction\" configuration to any value other than \"none\" requires that a skillset also be attached to that indexer.")
union BlobIndexerImageAction {
  string,

  @doc("Ignores embedded images or image files in the data set.  This is the default.")
  None: "none",

  @doc("Extracts text from images (for example, the word \"STOP\" from a traffic stop sign), and embeds it into the content field.  This action requires that \"dataToExtract\" is set to \"contentAndMetadata\".  A normalized image refers to additional processing resulting in uniform image output, sized and rotated to promote consistent rendering when you include images in visual search results. This information is generated for each image when you use this option.")
  GenerateNormalizedImages: "generateNormalizedImages",

  @doc("Extracts text from images (for example, the word \"STOP\" from a traffic stop sign), and embeds it into the content field, but treats PDF files differently in that each page will be rendered as an image and normalized accordingly, instead of extracting embedded images.  Non-PDF file types will be treated the same as if \"generateNormalizedImages\" was set.")
  GenerateNormalizedImagePerPage: "generateNormalizedImagePerPage",
}

@doc("Determines algorithm for text extraction from PDF files in Azure blob storage.")
union BlobIndexerPDFTextRotationAlgorithm {
  string,

  @doc("Leverages normal text extraction.  This is the default.")
  None: "none",

  @doc("May produce better and more readable text extraction from PDF files that have rotated text within them.  Note that there may be a small performance speed impact when this parameter is used.  This parameter only applies to PDF files, and only to PDFs with embedded text.  If the rotated text appears within an embedded image in the PDF, this parameter does not apply.")
  DetectAngles: "detectAngles",
}

@doc("Specifies the environment in which the indexer should execute.")
union IndexerExecutionEnvironment {
  string,

  @doc("Indicates that the search service can determine where the indexer should execute. This is the default environment when nothing is specified and is the recommended value.")
  standard: "standard",

  @doc("Indicates that the indexer should run with the environment provisioned specifically for the search service. This should only be specified as the execution environment if the indexer needs to access resources securely over shared private link resources.")
  private: "private",
}

@doc("Details the status of an individual indexer execution.")
union IndexerExecutionStatusDetail {
  string,

  @doc("Indicates that the reset that occurred was for a call to ResetDocs.")
  ResetDocs: "resetDocs",

  @doc("Indicates to selectively resync based on option(s) from data source.")
  Resync: "resync",
}

@doc("Represents the mode the indexer is executing in.")
union IndexingMode {
  string,

  @doc("The indexer is indexing all documents in the datasource.")
  IndexingAllDocs: "indexingAllDocs",

  @doc("The indexer is indexing selective, reset documents in the datasource. The documents being indexed are defined on indexer status.")
  IndexingResetDocs: "indexingResetDocs",

  @doc("The indexer is resyncing and indexing selective option(s) from the datasource.")
  IndexingResync: "indexingResync",
}

@doc("Defines behavior of the index projections in relation to the rest of the indexer.")
union IndexProjectionMode {
  string,

  @doc("The source document will be skipped from writing into the indexer's target index.")
  SkipIndexingParentDocuments: "skipIndexingParentDocuments",

  @doc("The source document will be written into the indexer's target index. This is the default pattern.")
  IncludeIndexingParentDocuments: "includeIndexingParentDocuments",
}

@doc("Defines the data type of a field in a search index.")
union SearchFieldDataType {
  string,

  @doc("Indicates that a field contains a string.")
  String: "Edm.String",

  @doc("Indicates that a field contains a 32-bit signed integer.")
  Int32: "Edm.Int32",

  @doc("Indicates that a field contains a 64-bit signed integer.")
  Int64: "Edm.Int64",

  @doc("Indicates that a field contains an IEEE double-precision floating point number.")
  Double: "Edm.Double",

  @doc("Indicates that a field contains a Boolean value (true or false).")
  Boolean: "Edm.Boolean",

  @doc("Indicates that a field contains a date/time value, including timezone information.")
  DateTimeOffset: "Edm.DateTimeOffset",

  @doc("Indicates that a field contains a geo-location in terms of longitude and latitude.")
  GeographyPoint: "Edm.GeographyPoint",

  @doc("Indicates that a field contains one or more complex objects that in turn have sub-fields of other types.")
  Complex: "Edm.ComplexType",

  @doc("Indicates that a field contains a single-precision floating point number. This is only valid when used with Collection(Edm.Single).")
  Single: "Edm.Single",

  @doc("Indicates that a field contains a half-precision floating point number. This is only valid when used with Collection(Edm.Half).")
  Half: "Edm.Half",

  @doc("Indicates that a field contains a 16-bit signed integer. This is only valid when used with Collection(Edm.Int16).")
  Int16: "Edm.Int16",

  @doc("Indicates that a field contains a 8-bit signed integer. This is only valid when used with Collection(Edm.SByte).")
  SByte: "Edm.SByte",

  @doc("Indicates that a field contains a 8-bit unsigned integer. This is only valid when used with Collection(Edm.Byte).")
  Byte: "Edm.Byte",
}

@doc("Defines the names of all text analyzers supported by the search engine.")
union LexicalAnalyzerName {
  string,

  @doc("Microsoft analyzer for Arabic.")
  ArMicrosoft: "ar.microsoft",

  @doc("Lucene analyzer for Arabic.")
  ArLucene: "ar.lucene",

  @doc("Lucene analyzer for Armenian.")
  HyLucene: "hy.lucene",

  @doc("Microsoft analyzer for Bangla.")
  BnMicrosoft: "bn.microsoft",

  @doc("Lucene analyzer for Basque.")
  EuLucene: "eu.lucene",

  @doc("Microsoft analyzer for Bulgarian.")
  BgMicrosoft: "bg.microsoft",

  @doc("Lucene analyzer for Bulgarian.")
  BgLucene: "bg.lucene",

  @doc("Microsoft analyzer for Catalan.")
  CaMicrosoft: "ca.microsoft",

  @doc("Lucene analyzer for Catalan.")
  CaLucene: "ca.lucene",

  @doc("Microsoft analyzer for Chinese (Simplified).")
  ZhHansMicrosoft: "zh-Hans.microsoft",

  @doc("Lucene analyzer for Chinese (Simplified).")
  ZhHansLucene: "zh-Hans.lucene",

  @doc("Microsoft analyzer for Chinese (Traditional).")
  ZhHantMicrosoft: "zh-Hant.microsoft",

  @doc("Lucene analyzer for Chinese (Traditional).")
  ZhHantLucene: "zh-Hant.lucene",

  @doc("Microsoft analyzer for Croatian.")
  HrMicrosoft: "hr.microsoft",

  @doc("Microsoft analyzer for Czech.")
  CsMicrosoft: "cs.microsoft",

  @doc("Lucene analyzer for Czech.")
  CsLucene: "cs.lucene",

  @doc("Microsoft analyzer for Danish.")
  DaMicrosoft: "da.microsoft",

  @doc("Lucene analyzer for Danish.")
  DaLucene: "da.lucene",

  @doc("Microsoft analyzer for Dutch.")
  NlMicrosoft: "nl.microsoft",

  @doc("Lucene analyzer for Dutch.")
  NlLucene: "nl.lucene",

  @doc("Microsoft analyzer for English.")
  EnMicrosoft: "en.microsoft",

  @doc("Lucene analyzer for English.")
  EnLucene: "en.lucene",

  @doc("Microsoft analyzer for Estonian.")
  EtMicrosoft: "et.microsoft",

  @doc("Microsoft analyzer for Finnish.")
  FiMicrosoft: "fi.microsoft",

  @doc("Lucene analyzer for Finnish.")
  FiLucene: "fi.lucene",

  @doc("Microsoft analyzer for French.")
  FrMicrosoft: "fr.microsoft",

  @doc("Lucene analyzer for French.")
  FrLucene: "fr.lucene",

  @doc("Lucene analyzer for Galician.")
  GlLucene: "gl.lucene",

  @doc("Microsoft analyzer for German.")
  DeMicrosoft: "de.microsoft",

  @doc("Lucene analyzer for German.")
  DeLucene: "de.lucene",

  @doc("Microsoft analyzer for Greek.")
  ElMicrosoft: "el.microsoft",

  @doc("Lucene analyzer for Greek.")
  ElLucene: "el.lucene",

  @doc("Microsoft analyzer for Gujarati.")
  GuMicrosoft: "gu.microsoft",

  @doc("Microsoft analyzer for Hebrew.")
  HeMicrosoft: "he.microsoft",

  @doc("Microsoft analyzer for Hindi.")
  HiMicrosoft: "hi.microsoft",

  @doc("Lucene analyzer for Hindi.")
  HiLucene: "hi.lucene",

  @doc("Microsoft analyzer for Hungarian.")
  HuMicrosoft: "hu.microsoft",

  @doc("Lucene analyzer for Hungarian.")
  HuLucene: "hu.lucene",

  @doc("Microsoft analyzer for Icelandic.")
  IsMicrosoft: "is.microsoft",

  @doc("Microsoft analyzer for Indonesian (Bahasa).")
  IdMicrosoft: "id.microsoft",

  @doc("Lucene analyzer for Indonesian.")
  IdLucene: "id.lucene",

  @doc("Lucene analyzer for Irish.")
  GaLucene: "ga.lucene",

  @doc("Microsoft analyzer for Italian.")
  ItMicrosoft: "it.microsoft",

  @doc("Lucene analyzer for Italian.")
  ItLucene: "it.lucene",

  @doc("Microsoft analyzer for Japanese.")
  JaMicrosoft: "ja.microsoft",

  @doc("Lucene analyzer for Japanese.")
  JaLucene: "ja.lucene",

  @doc("Microsoft analyzer for Kannada.")
  KnMicrosoft: "kn.microsoft",

  @doc("Microsoft analyzer for Korean.")
  KoMicrosoft: "ko.microsoft",

  @doc("Lucene analyzer for Korean.")
  KoLucene: "ko.lucene",

  @doc("Microsoft analyzer for Latvian.")
  LvMicrosoft: "lv.microsoft",

  @doc("Lucene analyzer for Latvian.")
  LvLucene: "lv.lucene",

  @doc("Microsoft analyzer for Lithuanian.")
  LtMicrosoft: "lt.microsoft",

  @doc("Microsoft analyzer for Malayalam.")
  MlMicrosoft: "ml.microsoft",

  @doc("Microsoft analyzer for Malay (Latin).")
  MsMicrosoft: "ms.microsoft",

  @doc("Microsoft analyzer for Marathi.")
  MrMicrosoft: "mr.microsoft",

  @doc("Microsoft analyzer for Norwegian (BokmÃ¥l).")
  NbMicrosoft: "nb.microsoft",

  @doc("Lucene analyzer for Norwegian.")
  NoLucene: "no.lucene",

  @doc("Lucene analyzer for Persian.")
  FaLucene: "fa.lucene",

  @doc("Microsoft analyzer for Polish.")
  PlMicrosoft: "pl.microsoft",

  @doc("Lucene analyzer for Polish.")
  PlLucene: "pl.lucene",

  @doc("Microsoft analyzer for Portuguese (Brazil).")
  PtBrMicrosoft: "pt-BR.microsoft",

  @doc("Lucene analyzer for Portuguese (Brazil).")
  PtBrLucene: "pt-BR.lucene",

  @doc("Microsoft analyzer for Portuguese (Portugal).")
  PtPtMicrosoft: "pt-PT.microsoft",

  @doc("Lucene analyzer for Portuguese (Portugal).")
  PtPtLucene: "pt-PT.lucene",

  @doc("Microsoft analyzer for Punjabi.")
  PaMicrosoft: "pa.microsoft",

  @doc("Microsoft analyzer for Romanian.")
  RoMicrosoft: "ro.microsoft",

  @doc("Lucene analyzer for Romanian.")
  RoLucene: "ro.lucene",

  @doc("Microsoft analyzer for Russian.")
  RuMicrosoft: "ru.microsoft",

  @doc("Lucene analyzer for Russian.")
  RuLucene: "ru.lucene",

  @doc("Microsoft analyzer for Serbian (Cyrillic).")
  SrCyrillicMicrosoft: "sr-cyrillic.microsoft",

  @doc("Microsoft analyzer for Serbian (Latin).")
  SrLatinMicrosoft: "sr-latin.microsoft",

  @doc("Microsoft analyzer for Slovak.")
  SkMicrosoft: "sk.microsoft",

  @doc("Microsoft analyzer for Slovenian.")
  SlMicrosoft: "sl.microsoft",

  @doc("Microsoft analyzer for Spanish.")
  EsMicrosoft: "es.microsoft",

  @doc("Lucene analyzer for Spanish.")
  EsLucene: "es.lucene",

  @doc("Microsoft analyzer for Swedish.")
  SvMicrosoft: "sv.microsoft",

  @doc("Lucene analyzer for Swedish.")
  SvLucene: "sv.lucene",

  @doc("Microsoft analyzer for Tamil.")
  TaMicrosoft: "ta.microsoft",

  @doc("Microsoft analyzer for Telugu.")
  TeMicrosoft: "te.microsoft",

  @doc("Microsoft analyzer for Thai.")
  ThMicrosoft: "th.microsoft",

  @doc("Lucene analyzer for Thai.")
  ThLucene: "th.lucene",

  @doc("Microsoft analyzer for Turkish.")
  TrMicrosoft: "tr.microsoft",

  @doc("Lucene analyzer for Turkish.")
  TrLucene: "tr.lucene",

  @doc("Microsoft analyzer for Ukrainian.")
  UkMicrosoft: "uk.microsoft",

  @doc("Microsoft analyzer for Urdu.")
  UrMicrosoft: "ur.microsoft",

  @doc("Microsoft analyzer for Vietnamese.")
  ViMicrosoft: "vi.microsoft",

  @doc("Standard Lucene analyzer.")
  StandardLucene: "standard.lucene",

  @doc("Standard ASCII Folding Lucene analyzer. See https://learn.microsoft.com/rest/api/searchservice/Custom-analyzers-in-Azure-Search#Analyzers")
  StandardAsciiFoldingLucene: "standardasciifolding.lucene",

  @doc("Treats the entire content of a field as a single token. This is useful for data like zip codes, ids, and some product names. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/KeywordAnalyzer.html")
  Keyword: "keyword",

  @doc("Flexibly separates text into terms via a regular expression pattern. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/PatternAnalyzer.html")
  Pattern: "pattern",

  @doc("Divides text at non-letters and converts them to lower case. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/SimpleAnalyzer.html")
  Simple: "simple",

  @doc("Divides text at non-letters; Applies the lowercase and stopword token filters. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/StopAnalyzer.html")
  Stop: "stop",

  @doc("An analyzer that uses the whitespace tokenizer. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/WhitespaceAnalyzer.html")
  Whitespace: "whitespace",
}

@doc("Defines the names of all text normalizers supported by the search engine.")
union LexicalNormalizerName {
  string,

  @doc("Converts alphabetic, numeric, and symbolic Unicode characters which are not in the first 127 ASCII characters (the \"Basic Latin\" Unicode block) into their ASCII equivalents, if such equivalents exist. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/ASCIIFoldingFilter.html")
  AsciiFolding: "asciifolding",

  @doc("Removes elisions. For example, \"l'avion\" (the plane) will be converted to \"avion\" (plane). See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/util/ElisionFilter.html")
  Elision: "elision",

  @doc("Normalizes token text to lowercase. See https://lucene.apache.org/core/6_6_1/analyzers-common/org/apache/lucene/analysis/core/LowerCaseFilter.html")
  Lowercase: "lowercase",

  @doc("Standard normalizer, which consists of lowercase and asciifolding. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/reverse/ReverseStringFilter.html")
  Standard: "standard",

  @doc("Normalizes token text to uppercase. See https://lucene.apache.org/core/6_6_1/analyzers-common/org/apache/lucene/analysis/core/UpperCaseFilter.html")
  Uppercase: "uppercase",
}

@doc("The encoding format for interpreting vector field contents.")
union VectorEncodingFormat {
  string,

  @doc("Encoding format representing bits packed into a wider data type.")
  PackedBit: "packedBit",
}

@doc("The algorithm used for indexing and querying.")
union VectorSearchAlgorithmKind {
  string,

  @doc("HNSW (Hierarchical Navigable Small World), a type of approximate nearest neighbors algorithm.")
  Hnsw: "hnsw",

  @doc("Exhaustive KNN algorithm which will perform brute-force search.")
  ExhaustiveKnn: "exhaustiveKnn",
}

@doc("The vectorization method to be used during query time.")
union VectorSearchVectorizerKind {
  string,

  @doc("Generate embeddings using an Azure OpenAI resource at query time.")
  AzureOpenAI: "azureOpenAI",

  @doc("Generate embeddings using a custom web endpoint at query time.")
  CustomWebApi: "customWebApi",

  @doc("Generate embeddings for an image or text input at query time using the Azure AI Services Vision Vectorize API.")
  AIServicesVision: "aiServicesVision",

  @doc("Generate embeddings using an Azure Machine Learning endpoint deployed via the Azure AI Foundry Model Catalog at query time.")
  AML: "aml",
}

@doc("The compression method used for indexing and querying.")
union VectorSearchCompressionKind {
  string,

  @doc("Scalar Quantization, a type of compression method. In scalar quantization, the original vectors values are compressed to a narrower type by discretizing and representing each component of a vector using a reduced set of quantized values, thereby reducing the overall data size.")
  ScalarQuantization: "scalarQuantization",

  @doc("Binary Quantization, a type of compression method. In binary quantization, the original vectors values are compressed to the narrower binary type by discretizing and representing each component of a vector using binary values, thereby reducing the overall data size.")
  BinaryQuantization: "binaryQuantization",
}

@doc("The storage method for the original full-precision vectors used for rescoring and internal index operations.")
union VectorSearchCompressionRescoreStorageMethod {
  string,

  @doc("This option preserves the original full-precision vectors. Choose this option for maximum flexibility and highest quality of compressed search results. This consumes more storage but allows for rescoring and oversampling.")
  PreserveOriginals: "preserveOriginals",

  @doc("This option discards the original full-precision vectors. Choose this option for maximum storage savings. Since this option does not allow for rescoring and oversampling, it will often cause slight to moderate reductions in quality.")
  DiscardOriginals: "discardOriginals",
}

@doc("Defines the names of all tokenizers supported by the search engine.")
union LexicalTokenizerName {
  string,

  @doc("Grammar-based tokenizer that is suitable for processing most European-language documents. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/standard/ClassicTokenizer.html")
  Classic: "classic",

  @doc("Tokenizes the input from an edge into n-grams of the given size(s). See https://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/ngram/EdgeNGramTokenizer.html")
  EdgeNGram: "edgeNGram",

  @doc("Emits the entire input as a single token. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/KeywordTokenizer.html")
  Keyword: "keyword_v2",

  @doc("Divides text at non-letters. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/LetterTokenizer.html")
  Letter: "letter",

  @doc("Divides text at non-letters and converts them to lower case. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/LowerCaseTokenizer.html")
  Lowercase: "lowercase",

  @doc("Divides text using language-specific rules.")
  MicrosoftLanguageTokenizer: "microsoft_language_tokenizer",

  @doc("Divides text using language-specific rules and reduces words to their base forms.")
  MicrosoftLanguageStemmingTokenizer: "microsoft_language_stemming_tokenizer",

  @doc("Tokenizes the input into n-grams of the given size(s). See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/ngram/NGramTokenizer.html")
  NGram: "nGram",

  @doc("Tokenizer for path-like hierarchies. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/path/PathHierarchyTokenizer.html")
  PathHierarchy: "path_hierarchy_v2",

  @doc("Tokenizer that uses regex pattern matching to construct distinct tokens. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/pattern/PatternTokenizer.html")
  Pattern: "pattern",

  @doc("Standard Lucene analyzer; Composed of the standard tokenizer, lowercase filter and stop filter. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/standard/StandardTokenizer.html")
  Standard: "standard_v2",

  @doc("Tokenizes urls and emails as one token. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/standard/UAX29URLEmailTokenizer.html")
  UaxUrlEmail: "uax_url_email",

  @doc("Divides text at whitespace. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/WhitespaceTokenizer.html")
  Whitespace: "whitespace",
}

@doc("Defines the names of all token filters supported by the search engine.")
union TokenFilterName {
  string,

  @doc("A token filter that applies the Arabic normalizer to normalize the orthography. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/ar/ArabicNormalizationFilter.html")
  ArabicNormalization: "arabic_normalization",

  @doc("Strips all characters after an apostrophe (including the apostrophe itself). See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/tr/ApostropheFilter.html")
  Apostrophe: "apostrophe",

  @doc("Converts alphabetic, numeric, and symbolic Unicode characters which are not in the first 127 ASCII characters (the \"Basic Latin\" Unicode block) into their ASCII equivalents, if such equivalents exist. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/ASCIIFoldingFilter.html")
  AsciiFolding: "asciifolding",

  @doc("Forms bigrams of CJK terms that are generated from the standard tokenizer. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/cjk/CJKBigramFilter.html")
  CjkBigram: "cjk_bigram",

  @doc("Normalizes CJK width differences. Folds full-width ASCII variants into the equivalent basic Latin, and half-width Katakana variants into the equivalent Kana. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/cjk/CJKWidthFilter.html")
  CjkWidth: "cjk_width",

  @doc("Removes English possessives, and dots from acronyms. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/standard/ClassicFilter.html")
  Classic: "classic",

  @doc("Construct bigrams for frequently occurring terms while indexing. Single terms are still indexed too, with bigrams overlaid. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/commongrams/CommonGramsFilter.html")
  CommonGram: "common_grams",

  @doc("Generates n-grams of the given size(s) starting from the front or the back of an input token. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/ngram/EdgeNGramTokenFilter.html")
  EdgeNGram: "edgeNGram_v2",

  @doc("Removes elisions. For example, \"l'avion\" (the plane) will be converted to \"avion\" (plane). See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/util/ElisionFilter.html")
  Elision: "elision",

  @doc("Normalizes German characters according to the heuristics of the German2 snowball algorithm. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/de/GermanNormalizationFilter.html")
  GermanNormalization: "german_normalization",

  @doc("Normalizes text in Hindi to remove some differences in spelling variations. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/hi/HindiNormalizationFilter.html")
  HindiNormalization: "hindi_normalization",

  @doc("Normalizes the Unicode representation of text in Indian languages. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/in/IndicNormalizationFilter.html")
  IndicNormalization: "indic_normalization",

  @doc("Emits each incoming token twice, once as keyword and once as non-keyword. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/KeywordRepeatFilter.html")
  KeywordRepeat: "keyword_repeat",

  @doc("A high-performance kstem filter for English. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/en/KStemFilter.html")
  KStem: "kstem",

  @doc("Removes words that are too long or too short. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/LengthFilter.html")
  Length: "length",

  @doc("Limits the number of tokens while indexing. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/LimitTokenCountFilter.html")
  Limit: "limit",

  @doc("Normalizes token text to lower case. See https://lucene.apache.org/core/6_6_1/analyzers-common/org/apache/lucene/analysis/core/LowerCaseFilter.html")
  Lowercase: "lowercase",

  @doc("Generates n-grams of the given size(s). See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/ngram/NGramTokenFilter.html")
  NGram: "nGram_v2",

  @doc("Applies normalization for Persian. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/fa/PersianNormalizationFilter.html")
  PersianNormalization: "persian_normalization",

  @doc("Create tokens for phonetic matches. See https://lucene.apache.org/core/4_10_3/analyzers-phonetic/org/apache/lucene/analysis/phonetic/package-tree.html")
  Phonetic: "phonetic",

  @doc("Uses the Porter stemming algorithm to transform the token stream. See http://tartarus.org/~martin/PorterStemmer")
  PorterStem: "porter_stem",

  @doc("Reverses the token string. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/reverse/ReverseStringFilter.html")
  Reverse: "reverse",

  @doc("Normalizes use of the interchangeable Scandinavian characters. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/ScandinavianNormalizationFilter.html")
  ScandinavianNormalization: "scandinavian_normalization",

  @doc("Folds Scandinavian characters Ã¥Ã…Ã¤Ã¦Ã„Ã†-&gt;a and Ã¶Ã–Ã¸Ã˜-&gt;o. It also discriminates against use of double vowels aa, ae, ao, oe and oo, leaving just the first one. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/ScandinavianFoldingFilter.html")
  ScandinavianFoldingNormalization: "scandinavian_folding",

  @doc("Creates combinations of tokens as a single token. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/shingle/ShingleFilter.html")
  Shingle: "shingle",

  @doc("A filter that stems words using a Snowball-generated stemmer. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/snowball/SnowballFilter.html")
  Snowball: "snowball",

  @doc("Normalizes the Unicode representation of Sorani text. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/ckb/SoraniNormalizationFilter.html")
  SoraniNormalization: "sorani_normalization",

  @doc("Language specific stemming filter. See https://learn.microsoft.com/rest/api/searchservice/Custom-analyzers-in-Azure-Search#TokenFilters")
  Stemmer: "stemmer",

  @doc("Removes stop words from a token stream. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/StopFilter.html")
  Stopwords: "stopwords",

  @doc("Trims leading and trailing whitespace from tokens. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/TrimFilter.html")
  Trim: "trim",

  @doc("Truncates the terms to a specific length. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/TruncateTokenFilter.html")
  Truncate: "truncate",

  @doc("Filters out tokens with same text as the previous token. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/RemoveDuplicatesTokenFilter.html")
  Unique: "unique",

  @doc("Normalizes token text to upper case. See https://lucene.apache.org/core/6_6_1/analyzers-common/org/apache/lucene/analysis/core/UpperCaseFilter.html")
  Uppercase: "uppercase",

  @doc("Splits words into subwords and performs optional transformations on subword groups.")
  WordDelimiter: "word_delimiter",
}

@doc("Defines the names of all character filters supported by the search engine.")
union CharFilterName {
  string,

  @doc("A character filter that attempts to strip out HTML constructs. See https://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/charfilter/HTMLStripCharFilter.html")
  HtmlStrip: "html_strip",
}

@doc("Defines flags that can be combined to control how regular expressions are used in the pattern analyzer and pattern tokenizer.")
union RegexFlags {
  string,

  @doc("Enables canonical equivalence.")
  CanonEq: "CANON_EQ",

  @doc("Enables case-insensitive matching.")
  CaseInsensitive: "CASE_INSENSITIVE",

  @doc("Permits whitespace and comments in the pattern.")
  Comments: "COMMENTS",

  @doc("Enables dotall mode.")
  DotAll: "DOTALL",

  @doc("Enables literal parsing of the pattern.")
  Literal: "LITERAL",

  @doc("Enables multiline mode.")
  Multiline: "MULTILINE",

  @doc("Enables Unicode-aware case folding.")
  UnicodeCase: "UNICODE_CASE",

  @doc("Enables Unix lines mode.")
  UnixLines: "UNIX_LINES",
}

@doc("The similarity metric to use for vector comparisons. It is recommended to choose the same similarity metric as the embedding model was trained on.")
union VectorSearchAlgorithmMetric {
  string,

  @doc("Measures the angle between vectors to quantify their similarity, disregarding magnitude. The smaller the angle, the closer the similarity.")
  Cosine: "cosine",

  @doc("Computes the straight-line distance between vectors in a multi-dimensional space. The smaller the distance, the closer the similarity.")
  Euclidean: "euclidean",

  @doc("Calculates the sum of element-wise products to gauge alignment and magnitude similarity. The larger and more positive, the closer the similarity.")
  DotProduct: "dotProduct",

  @doc("Only applicable to bit-packed binary data types. Determines dissimilarity by counting differing positions in binary vectors. The fewer differences, the closer the similarity.")
  Hamming: "hamming",
}

@doc("The quantized data type of compressed vector values.")
union VectorSearchCompressionTarget {
  string,

  @doc("8-bit signed integer.")
  Int8: "int8",
}

@doc("The Azure Open AI model name that will be called.")
union AzureOpenAIModelName {
  string,

  @doc("TextEmbeddingAda002 model.")
  TextEmbeddingAda002: "text-embedding-ada-002",

  @doc("TextEmbedding3Large model.")
  TextEmbedding3Large: "text-embedding-3-large",

  @doc("TextEmbedding3Small model.")
  TextEmbedding3Small: "text-embedding-3-small",

  @doc("Gpt4o model.")
  Gpt4o: "gpt-4o",

  @doc("Gpt4oMini model.")
  Gpt4oMini: "gpt-4o-mini",

  @doc("Gpt41 model.")
  Gpt41: "gpt-4.1",

  @doc("Gpt41Mini model.")
  Gpt41Mini: "gpt-4.1-mini",

  @doc("Gpt41Nano model.")
  Gpt41Nano: "gpt-4.1-nano",

  @doc("Gpt5 model.")
  Gpt5: "gpt-5",

  @doc("Gpt5Mini model.")
  Gpt5Mini: "gpt-5-mini",

  @doc("Gpt5Nano model.")
  Gpt5Nano: "gpt-5-nano",
}

@doc("The name of the embedding model from the Azure AI Foundry Catalog that will be called.")
union AIFoundryModelCatalogName {
  string,

  @doc("OpenAI-CLIP-Image-Text-Embeddings-vit-base-patch32")
  OpenAICLIPImageTextEmbeddingsVitBasePatch32: "OpenAI-CLIP-Image-Text-Embeddings-vit-base-patch32",

  @doc("OpenAI-CLIP-Image-Text-Embeddings-ViT-Large-Patch14-336")
  OpenAICLIPImageTextEmbeddingsViTLargePatch14336: "OpenAI-CLIP-Image-Text-Embeddings-ViT-Large-Patch14-336",

  @doc("Facebook-DinoV2-Image-Embeddings-ViT-Base")
  FacebookDinoV2ImageEmbeddingsViTBase: "Facebook-DinoV2-Image-Embeddings-ViT-Base",

  @doc("Facebook-DinoV2-Image-Embeddings-ViT-Giant")
  FacebookDinoV2ImageEmbeddingsViTGiant: "Facebook-DinoV2-Image-Embeddings-ViT-Giant",

  @doc("Cohere-embed-v3-english")
  CohereEmbedV3English: "Cohere-embed-v3-english",

  @doc("Cohere-embed-v3-multilingual")
  CohereEmbedV3Multilingual: "Cohere-embed-v3-multilingual",

  @doc("Cohere embed v4 model for generating embeddings from both text and images.")
  CohereEmbedV4: "Cohere-embed-v4",
}

@doc("The language codes supported for input text by KeyPhraseExtractionSkill.")
union KeyPhraseExtractionSkillLanguage {
  string,

  @doc("Danish")
  da: "da",

  @doc("Dutch")
  nl: "nl",

  @doc("English")
  en: "en",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("German")
  de: "de",

  @doc("Italian")
  it: "it",

  @doc("Japanese")
  ja: "ja",

  @doc("Korean")
  ko: "ko",

  @doc("Norwegian (Bokmaal)")
  no: "no",

  @doc("Polish")
  pl: "pl",

  @doc("Portuguese (Portugal)")
  `pt-PT`: "pt-PT",

  @doc("Portuguese (Brazil)")
  `pt-BR`: "pt-BR",

  @doc("Russian")
  ru: "ru",

  @doc("Spanish")
  es: "es",

  @doc("Swedish")
  sv: "sv",
}

@doc("The language codes supported for input by OcrSkill.")
union OcrSkillLanguage {
  string,

  @doc("Afrikaans")
  af: "af",

  @doc("Albanian")
  sq: "sq",

  @doc("Angika (Devanagiri)")
  anp: "anp",

  @doc("Arabic")
  ar: "ar",

  @doc("Asturian")
  ast: "ast",

  @doc("Awadhi-Hindi (Devanagiri)")
  awa: "awa",

  @doc("Azerbaijani (Latin)")
  az: "az",

  @doc("Bagheli")
  bfy: "bfy",

  @doc("Basque")
  eu: "eu",

  @doc("Belarusian (Cyrillic and Latin)")
  be: "be",

  @doc("Belarusian (Cyrillic)")
  `be-cyrl`: "be-cyrl",

  @doc("Belarusian (Latin)")
  `be-latn`: "be-latn",

  @doc("Bhojpuri-Hindi (Devanagiri)")
  bho: "bho",

  @doc("Bislama")
  bi: "bi",

  @doc("Bodo (Devanagiri)")
  brx: "brx",

  @doc("Bosnian Latin")
  bs: "bs",

  @doc("Brajbha")
  bra: "bra",

  @doc("Breton")
  br: "br",

  @doc("Bulgarian")
  bg: "bg",

  @doc("Bundeli")
  bns: "bns",

  @doc("Buryat (Cyrillic)")
  bua: "bua",

  @doc("Catalan")
  ca: "ca",

  @doc("Cebuano")
  ceb: "ceb",

  @doc("Chamling")
  rab: "rab",

  @doc("Chamorro")
  ch: "ch",

  @doc("Chhattisgarhi (Devanagiri)")
  hne: "hne",

  @doc("Chinese Simplified")
  `zh-Hans`: "zh-Hans",

  @doc("Chinese Traditional")
  `zh-Hant`: "zh-Hant",

  @doc("Cornish")
  kw: "kw",

  @doc("Corsican")
  co: "co",

  @doc("Crimean Tatar (Latin)")
  crh: "crh",

  @doc("Croatian")
  hr: "hr",

  @doc("Czech")
  cs: "cs",

  @doc("Danish")
  da: "da",

  @doc("Dari")
  prs: "prs",

  @doc("Dhimal (Devanagiri)")
  dhi: "dhi",

  @doc("Dogri (Devanagiri)")
  doi: "doi",

  @doc("Dutch")
  nl: "nl",

  @doc("English")
  en: "en",

  @doc("Erzya (Cyrillic)")
  myv: "myv",

  @doc("Estonian")
  et: "et",

  @doc("Faroese")
  fo: "fo",

  @doc("Fijian")
  fj: "fj",

  @doc("Filipino")
  fil: "fil",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("Frulian")
  fur: "fur",

  @doc("Gagauz (Latin)")
  gag: "gag",

  @doc("Galician")
  gl: "gl",

  @doc("German")
  de: "de",

  @doc("Gilbertese")
  gil: "gil",

  @doc("Gondi (Devanagiri)")
  gon: "gon",

  @doc("Greek")
  el: "el",

  @doc("Greenlandic")
  kl: "kl",

  @doc("Gurung (Devanagiri)")
  gvr: "gvr",

  @doc("Haitian Creole")
  ht: "ht",

  @doc("Halbi (Devanagiri)")
  hlb: "hlb",

  @doc("Hani")
  hni: "hni",

  @doc("Haryanvi")
  bgc: "bgc",

  @doc("Hawaiian")
  haw: "haw",

  @doc("Hindi")
  hi: "hi",

  @doc("Hmong Daw (Latin)")
  mww: "mww",

  @doc("Ho (Devanagiri)")
  hoc: "hoc",

  @doc("Hungarian")
  hu: "hu",

  @doc("Icelandic")
  `is`: "is",

  @doc("Inari Sami")
  smn: "smn",

  @doc("Indonesian")
  id: "id",

  @doc("Interlingua")
  ia: "ia",

  @doc("Inuktitut (Latin)")
  iu: "iu",

  @doc("Irish")
  ga: "ga",

  @doc("Italian")
  it: "it",

  @doc("Japanese")
  ja: "ja",

  @doc("Jaunsari (Devanagiri)")
  Jns: "Jns",

  @doc("Javanese")
  jv: "jv",

  @doc("Kabuverdianu")
  kea: "kea",

  @doc("Kachin (Latin)")
  kac: "kac",

  @doc("Kangri (Devanagiri)")
  xnr: "xnr",

  @doc("Karachay-Balkar")
  krc: "krc",

  @doc("Kara-Kalpak (Cyrillic)")
  `kaa-cyrl`: "kaa-cyrl",

  @doc("Kara-Kalpak (Latin)")
  kaa: "kaa",

  @doc("Kashubian")
  csb: "csb",

  @doc("Kazakh (Cyrillic)")
  `kk-cyrl`: "kk-cyrl",

  @doc("Kazakh (Latin)")
  `kk-latn`: "kk-latn",

  @doc("Khaling")
  klr: "klr",

  @doc("Khasi")
  kha: "kha",

  @doc("K'iche'")
  quc: "quc",

  @doc("Korean")
  ko: "ko",

  @doc("Korku")
  kfq: "kfq",

  @doc("Koryak")
  kpy: "kpy",

  @doc("Kosraean")
  kos: "kos",

  @doc("Kumyk (Cyrillic)")
  kum: "kum",

  @doc("Kurdish (Arabic)")
  `ku-arab`: "ku-arab",

  @doc("Kurdish (Latin)")
  `ku-latn`: "ku-latn",

  @doc("Kurukh (Devanagiri)")
  kru: "kru",

  @doc("Kyrgyz (Cyrillic)")
  ky: "ky",

  @doc("Lakota")
  lkt: "lkt",

  @doc("Latin")
  la: "la",

  @doc("Lithuanian")
  lt: "lt",

  @doc("Lower Sorbian")
  dsb: "dsb",

  @doc("Lule Sami")
  smj: "smj",

  @doc("Luxembourgish")
  lb: "lb",

  @doc("Mahasu Pahari (Devanagiri)")
  bfz: "bfz",

  @doc("Malay (Latin)")
  ms: "ms",

  @doc("Maltese")
  mt: "mt",

  @doc("Malto (Devanagiri)")
  kmj: "kmj",

  @doc("Manx")
  gv: "gv",

  @doc("Maori")
  mi: "mi",

  @doc("Marathi")
  mr: "mr",

  @doc("Mongolian (Cyrillic)")
  mn: "mn",

  @doc("Montenegrin (Cyrillic)")
  `cnr-cyrl`: "cnr-cyrl",

  @doc("Montenegrin (Latin)")
  `cnr-latn`: "cnr-latn",

  @doc("Neapolitan")
  nap: "nap",

  @doc("Nepali")
  ne: "ne",

  @doc("Niuean")
  niu: "niu",

  @doc("Nogay")
  nog: "nog",

  @doc("Northern Sami (Latin)")
  sme: "sme",

  @doc("Norwegian")
  nb: "nb",

  @doc("Norwegian")
  no: "no",

  @doc("Occitan")
  oc: "oc",

  @doc("Ossetic")
  os: "os",

  @doc("Pashto")
  ps: "ps",

  @doc("Persian")
  fa: "fa",

  @doc("Polish")
  pl: "pl",

  @doc("Portuguese")
  pt: "pt",

  @doc("Punjabi (Arabic)")
  pa: "pa",

  @doc("Ripuarian")
  ksh: "ksh",

  @doc("Romanian")
  ro: "ro",

  @doc("Romansh")
  rm: "rm",

  @doc("Russian")
  ru: "ru",

  @doc("Sadri (Devanagiri)")
  sck: "sck",

  @doc("Samoan (Latin)")
  sm: "sm",

  @doc("Sanskrit (Devanagiri)")
  sa: "sa",

  @doc("Santali (Devanagiri)")
  sat: "sat",

  @doc("Scots")
  sco: "sco",

  @doc("Scottish Gaelic")
  gd: "gd",

  @doc("Serbian (Latin)")
  sr: "sr",

  @doc("Serbian (Cyrillic)")
  `sr-Cyrl`: "sr-Cyrl",

  @doc("Serbian (Latin)")
  `sr-Latn`: "sr-Latn",

  @doc("Sherpa (Devanagiri)")
  xsr: "xsr",

  @doc("Sirmauri (Devanagiri)")
  srx: "srx",

  @doc("Skolt Sami")
  sms: "sms",

  @doc("Slovak")
  sk: "sk",

  @doc("Slovenian")
  sl: "sl",

  @doc("Somali (Arabic)")
  so: "so",

  @doc("Southern Sami")
  sma: "sma",

  @doc("Spanish")
  es: "es",

  @doc("Swahili (Latin)")
  sw: "sw",

  @doc("Swedish")
  sv: "sv",

  @doc("Tajik (Cyrillic)")
  tg: "tg",

  @doc("Tatar (Latin)")
  tt: "tt",

  @doc("Tetum")
  tet: "tet",

  @doc("Thangmi")
  thf: "thf",

  @doc("Tongan")
  to: "to",

  @doc("Turkish")
  tr: "tr",

  @doc("Turkmen (Latin)")
  tk: "tk",

  @doc("Tuvan")
  tyv: "tyv",

  @doc("Upper Sorbian")
  hsb: "hsb",

  @doc("Urdu")
  ur: "ur",

  @doc("Uyghur (Arabic)")
  ug: "ug",

  @doc("Uzbek (Arabic)")
  `uz-arab`: "uz-arab",

  @doc("Uzbek (Cyrillic)")
  `uz-cyrl`: "uz-cyrl",

  @doc("Uzbek (Latin)")
  uz: "uz",

  @doc("Volapük")
  vo: "vo",

  @doc("Walser")
  wae: "wae",

  @doc("Welsh")
  cy: "cy",

  @doc("Western Frisian")
  fy: "fy",

  @doc("Yucatec Maya")
  yua: "yua",

  @doc("Zhuang")
  za: "za",

  @doc("Zulu")
  zu: "zu",

  @doc("Unknown (All)")
  unk: "unk",
}

@doc("Defines the sequence of characters to use between the lines of text recognized by the OCR skill. The default value is \"space\".")
union OcrLineEnding {
  string,

  @doc("Lines are separated by a single space character.")
  Space: "space",

  @doc("Lines are separated by a carriage return ('\r') character.")
  CarriageReturn: "carriageReturn",

  @doc("Lines are separated by a single line feed ('\n') character.")
  LineFeed: "lineFeed",

  @doc("Lines are separated by a carriage return and a line feed ('\r\n') character.")
  CarriageReturnLineFeed: "carriageReturnLineFeed",
}

@doc("The language codes supported for input by ImageAnalysisSkill.")
union ImageAnalysisSkillLanguage {
  string,

  @doc("Arabic")
  ar: "ar",

  @doc("Azerbaijani")
  az: "az",

  @doc("Bulgarian")
  bg: "bg",

  @doc("Bosnian Latin")
  bs: "bs",

  @doc("Catalan")
  ca: "ca",

  @doc("Czech")
  cs: "cs",

  @doc("Welsh")
  cy: "cy",

  @doc("Danish")
  da: "da",

  @doc("German")
  de: "de",

  @doc("Greek")
  el: "el",

  @doc("English")
  en: "en",

  @doc("Spanish")
  es: "es",

  @doc("Estonian")
  et: "et",

  @doc("Basque")
  eu: "eu",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("Irish")
  ga: "ga",

  @doc("Galician")
  gl: "gl",

  @doc("Hebrew")
  he: "he",

  @doc("Hindi")
  hi: "hi",

  @doc("Croatian")
  hr: "hr",

  @doc("Hungarian")
  hu: "hu",

  @doc("Indonesian")
  id: "id",

  @doc("Italian")
  it: "it",

  @doc("Japanese")
  ja: "ja",

  @doc("Kazakh")
  kk: "kk",

  @doc("Korean")
  ko: "ko",

  @doc("Lithuanian")
  lt: "lt",

  @doc("Latvian")
  lv: "lv",

  @doc("Macedonian")
  mk: "mk",

  @doc("Malay Malaysia")
  ms: "ms",

  @doc("Norwegian (Bokmal)")
  nb: "nb",

  @doc("Dutch")
  nl: "nl",

  @doc("Polish")
  pl: "pl",

  @doc("Dari")
  prs: "prs",

  @doc("Portuguese-Brazil")
  `pt-BR`: "pt-BR",

  @doc("Portuguese-Portugal")
  pt: "pt",

  @doc("Portuguese-Portugal")
  `pt-PT`: "pt-PT",

  @doc("Romanian")
  ro: "ro",

  @doc("Russian")
  ru: "ru",

  @doc("Slovak")
  sk: "sk",

  @doc("Slovenian")
  sl: "sl",

  @doc("Serbian - Cyrillic RS")
  `sr-Cyrl`: "sr-Cyrl",

  @doc("Serbian - Latin RS")
  `sr-Latn`: "sr-Latn",

  @doc("Swedish")
  sv: "sv",

  @doc("Thai")
  th: "th",

  @doc("Turkish")
  tr: "tr",

  @doc("Ukrainian")
  uk: "uk",

  @doc("Vietnamese")
  vi: "vi",

  @doc("Chinese Simplified")
  zh: "zh",

  @doc("Chinese Simplified")
  `zh-Hans`: "zh-Hans",

  @doc("Chinese Traditional")
  `zh-Hant`: "zh-Hant",
}

@doc("The strings indicating what visual feature types to return.")
union VisualFeature {
  string,

  @doc("Visual features recognized as adult persons.")
  Adult: "adult",

  @doc("Visual features recognized as commercial brands.")
  Brands: "brands",

  @doc("Categories.")
  Categories: "categories",

  @doc("Description.")
  Description: "description",

  @doc("Visual features recognized as people faces.")
  Faces: "faces",

  @doc("Visual features recognized as objects.")
  Objects: "objects",

  @doc("Tags.")
  Tags: "tags",
}

@doc("A string indicating which domain-specific details to return.")
union ImageDetail {
  string,

  @doc("Details recognized as celebrities.")
  Celebrities: "celebrities",

  @doc("Details recognized as landmarks.")
  Landmarks: "landmarks",
}

@doc("A string indicating what entity categories to return.")
union EntityCategory {
  string,

  @doc("Entities describing a physical location.")
  Location: "location",

  @doc("Entities describing an organization.")
  Organization: "organization",

  @doc("Entities describing a person.")
  Person: "person",

  @doc("Entities describing a quantity.")
  Quantity: "quantity",

  @doc("Entities describing a date and time.")
  Datetime: "datetime",

  @doc("Entities describing a URL.")
  Url: "url",

  @doc("Entities describing an email address.")
  Email: "email",
}

@doc("Deprecated. The language codes supported for input text by EntityRecognitionSkill.")
union EntityRecognitionSkillLanguage {
  string,

  @doc("Arabic")
  ar: "ar",

  @doc("Czech")
  cs: "cs",

  @doc("Chinese-Simplified")
  `zh-Hans`: "zh-Hans",

  @doc("Chinese-Traditional")
  `zh-Hant`: "zh-Hant",

  @doc("Danish")
  da: "da",

  @doc("Dutch")
  nl: "nl",

  @doc("English")
  en: "en",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("German")
  de: "de",

  @doc("Greek")
  el: "el",

  @doc("Hungarian")
  hu: "hu",

  @doc("Italian")
  it: "it",

  @doc("Japanese")
  ja: "ja",

  @doc("Korean")
  ko: "ko",

  @doc("Norwegian (Bokmaal)")
  no: "no",

  @doc("Polish")
  pl: "pl",

  @doc("Portuguese (Portugal)")
  `pt-PT`: "pt-PT",

  @doc("Portuguese (Brazil)")
  `pt-BR`: "pt-BR",

  @doc("Russian")
  ru: "ru",

  @doc("Spanish")
  es: "es",

  @doc("Swedish")
  sv: "sv",

  @doc("Turkish")
  tr: "tr",
}

@doc("Deprecated. The language codes supported for input text by SentimentSkill.")
union SentimentSkillLanguage {
  string,

  @doc("Danish")
  da: "da",

  @doc("Dutch")
  nl: "nl",

  @doc("English")
  en: "en",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("German")
  de: "de",

  @doc("Greek")
  el: "el",

  @doc("Italian")
  it: "it",

  @doc("Norwegian (Bokmaal)")
  no: "no",

  @doc("Polish")
  pl: "pl",

  @doc("Portuguese (Portugal)")
  `pt-PT`: "pt-PT",

  @doc("Russian")
  ru: "ru",

  @doc("Spanish")
  es: "es",

  @doc("Swedish")
  sv: "sv",

  @doc("Turkish")
  tr: "tr",
}

@doc("A string indicating what maskingMode to use to mask the personal information detected in the input text.")
union PIIDetectionSkillMaskingMode {
  string,

  @doc("No masking occurs and the maskedText output will not be returned.")
  None: "none",

  @doc("Replaces the detected entities with the character given in the maskingCharacter parameter. The character will be repeated to the length of the detected entity so that the offsets will correctly correspond to both the input text as well as the output maskedText.")
  Replace: "replace",
}

@doc("The language codes supported for input text by SplitSkill.")
union SplitSkillLanguage {
  string,

  @doc("Amharic")
  am: "am",

  @doc("Bosnian")
  bs: "bs",

  @doc("Czech")
  cs: "cs",

  @doc("Danish")
  da: "da",

  @doc("German")
  de: "de",

  @doc("English")
  en: "en",

  @doc("Spanish")
  es: "es",

  @doc("Estonian")
  et: "et",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("Hebrew")
  he: "he",

  @doc("Hindi")
  hi: "hi",

  @doc("Croatian")
  hr: "hr",

  @doc("Hungarian")
  hu: "hu",

  @doc("Indonesian")
  id: "id",

  @doc("Icelandic")
  `is`: "is",

  @doc("Italian")
  it: "it",

  @doc("Japanese")
  ja: "ja",

  @doc("Korean")
  ko: "ko",

  @doc("Latvian")
  lv: "lv",

  @doc("Norwegian")
  nb: "nb",

  @doc("Dutch")
  nl: "nl",

  @doc("Polish")
  pl: "pl",

  @doc("Portuguese (Portugal)")
  pt: "pt",

  @doc("Portuguese (Brazil)")
  `pt-br`: "pt-br",

  @doc("Russian")
  ru: "ru",

  @doc("Slovak")
  sk: "sk",

  @doc("Slovenian")
  sl: "sl",

  @doc("Serbian")
  sr: "sr",

  @doc("Swedish")
  sv: "sv",

  @doc("Turkish")
  tr: "tr",

  @doc("Urdu")
  ur: "ur",

  @doc("Chinese (Simplified)")
  zh: "zh",
}

@doc("A value indicating which split mode to perform.")
union TextSplitMode {
  string,

  @doc("Split the text into individual pages.")
  Pages: "pages",

  @doc("Split the text into individual sentences.")
  Sentences: "sentences",
}

@doc("A value indicating which unit to use.")
union SplitSkillUnit {
  string,

  @doc("The length will be measured by character.")
  Characters: "characters",

  @doc("The length will be measured by an AzureOpenAI tokenizer from the tiktoken library.")
  AzureOpenAITokens: "azureOpenAITokens",
}

@doc("A value indicating which tokenizer to use.")
union SplitSkillEncoderModelName {
  string,

  @doc("Refers to a base model trained with a 50,000 token vocabulary, often used in general natural language processing tasks.")
  R50kBase: "r50k_base",

  @doc("A base model with a 50,000 token vocabulary, optimized for prompt-based tasks.")
  P50kBase: "p50k_base",

  @doc("Similar to p50k_base but fine-tuned for editing or rephrasing tasks with a 50,000 token vocabulary.")
  P50kEdit: "p50k_edit",

  @doc("A base model with a 100,000 token vocabulary.")
  CL100kBase: "cl100k_base",
}

@doc("The language codes supported for input text by CustomEntityLookupSkill.")
union CustomEntityLookupSkillLanguage {
  string,

  @doc("Danish")
  da: "da",

  @doc("German")
  de: "de",

  @doc("English")
  en: "en",

  @doc("Spanish")
  es: "es",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("Italian")
  it: "it",

  @doc("Korean")
  ko: "ko",

  @doc("Portuguese")
  pt: "pt",
}

@doc("The language codes supported for input text by TextTranslationSkill.")
union TextTranslationSkillLanguage {
  string,

  @doc("Afrikaans")
  af: "af",

  @doc("Arabic")
  ar: "ar",

  @doc("Bangla")
  bn: "bn",

  @doc("Bosnian (Latin)")
  bs: "bs",

  @doc("Bulgarian")
  bg: "bg",

  @doc("Cantonese (Traditional)")
  yue: "yue",

  @doc("Catalan")
  ca: "ca",

  @doc("Chinese Simplified")
  `zh-Hans`: "zh-Hans",

  @doc("Chinese Traditional")
  `zh-Hant`: "zh-Hant",

  @doc("Croatian")
  hr: "hr",

  @doc("Czech")
  cs: "cs",

  @doc("Danish")
  da: "da",

  @doc("Dutch")
  nl: "nl",

  @doc("English")
  en: "en",

  @doc("Estonian")
  et: "et",

  @doc("Fijian")
  fj: "fj",

  @doc("Filipino")
  fil: "fil",

  @doc("Finnish")
  fi: "fi",

  @doc("French")
  fr: "fr",

  @doc("German")
  de: "de",

  @doc("Greek")
  el: "el",

  @doc("Haitian Creole")
  ht: "ht",

  @doc("Hebrew")
  he: "he",

  @doc("Hindi")
  hi: "hi",

  @doc("Hmong Daw")
  mww: "mww",

  @doc("Hungarian")
  hu: "hu",

  @doc("Icelandic")
  `is`: "is",

  @doc("Indonesian")
  id: "id",

  @doc("Italian")
  it: "it",

  @doc("Japanese")
  ja: "ja",

  @doc("Kiswahili")
  sw: "sw",

  @doc("Klingon")
  tlh: "tlh",

  @doc("Klingon (Latin script)")
  `tlh-Latn`: "tlh-Latn",

  @doc("Klingon (Klingon script)")
  `tlh-Piqd`: "tlh-Piqd",

  @doc("Korean")
  ko: "ko",

  @doc("Latvian")
  lv: "lv",

  @doc("Lithuanian")
  lt: "lt",

  @doc("Malagasy")
  mg: "mg",

  @doc("Malay")
  ms: "ms",

  @doc("Maltese")
  mt: "mt",

  @doc("Norwegian")
  nb: "nb",

  @doc("Persian")
  fa: "fa",

  @doc("Polish")
  pl: "pl",

  @doc("Portuguese")
  pt: "pt",

  @doc("Portuguese (Brazil)")
  `pt-br`: "pt-br",

  @doc("Portuguese (Portugal)")
  `pt-PT`: "pt-PT",

  @doc("Queretaro Otomi")
  otq: "otq",

  @doc("Romanian")
  ro: "ro",

  @doc("Russian")
  ru: "ru",

  @doc("Samoan")
  sm: "sm",

  @doc("Serbian (Cyrillic)")
  `sr-Cyrl`: "sr-Cyrl",

  @doc("Serbian (Latin)")
  `sr-Latn`: "sr-Latn",

  @doc("Slovak")
  sk: "sk",

  @doc("Slovenian")
  sl: "sl",

  @doc("Spanish")
  es: "es",

  @doc("Swedish")
  sv: "sv",

  @doc("Tahitian")
  ty: "ty",

  @doc("Tamil")
  ta: "ta",

  @doc("Telugu")
  te: "te",

  @doc("Thai")
  th: "th",

  @doc("Tongan")
  to: "to",

  @doc("Turkish")
  tr: "tr",

  @doc("Ukrainian")
  uk: "uk",

  @doc("Urdu")
  ur: "ur",

  @doc("Vietnamese")
  vi: "vi",

  @doc("Welsh")
  cy: "cy",

  @doc("Yucatec Maya")
  yua: "yua",

  @doc("Irish")
  ga: "ga",

  @doc("Kannada")
  kn: "kn",

  @doc("Maori")
  mi: "mi",

  @doc("Malayalam")
  ml: "ml",

  @doc("Punjabi")
  pa: "pa",
}

@doc("Controls the cardinality of the output produced by the skill. Default is 'oneToMany'.")
union DocumentIntelligenceLayoutSkillOutputMode {
  string,

  @doc("Specify that the output should be parsed as 'oneToMany'.")
  OneToMany: "oneToMany",
}

@doc("Controls the cardinality of the output format. Default is 'markdown'.")
union DocumentIntelligenceLayoutSkillOutputFormat {
  string,

  @doc("Specify the format of the output as text.")
  Text: "text",

  @doc("Specify the format of the output as markdown.")
  Markdown: "markdown",
}

@doc("The depth of headers in the markdown output. Default is h6.")
union DocumentIntelligenceLayoutSkillMarkdownHeaderDepth {
  string,

  @doc("Header level 1.")
  H1: "h1",

  @doc("Header level 2.")
  H2: "h2",

  @doc("Header level 3.")
  H3: "h3",

  @doc("Header level 4.")
  H4: "h4",

  @doc("Header level 5.")
  H5: "h5",

  @doc("Header level 6.")
  H6: "h6",
}

@doc("Controls the cardinality of the content extracted from the document by the skill.")
union DocumentIntelligenceLayoutSkillExtractionOptions {
  string,

  @doc("Specify that image content should be extracted from the document.")
  Images: "images",

  @doc("Specify that location metadata should be extracted from the document.")
  LocationMetadata: "locationMetadata",
}

@doc("Controls the cardinality of the chunk unit. Default is 'characters'")
union DocumentIntelligenceLayoutSkillChunkingUnit {
  string,

  @doc("Specifies chunk by characters.")
  Characters: "characters",
}

@doc("Represents the overall indexer status.")
union IndexerStatus {
  string,

  @doc("Indicates that the indexer is in an unknown state.")
  Unknown: "unknown",

  @doc("Indicates that the indexer experienced an error that cannot be corrected without human intervention.")
  Error: "error",

  @doc("Indicates that the indexer is running normally.")
  Running: "running",
}

@doc("Represents the status of an individual indexer execution.")
union IndexerExecutionStatus {
  string,

  @doc("An indexer invocation has failed, but the failure may be transient. Indexer invocations will continue per schedule.")
  TransientFailure: "transientFailure",

  @doc("Indexer execution completed successfully.")
  Success: "success",

  @doc("Indexer execution is in progress.")
  InProgress: "inProgress",

  @doc("Indexer has been reset.")
  Reset: "reset",
}

@doc("Defines the function used to interpolate score boosting across a range of documents.")
union ScoringFunctionInterpolation {
  string,

  @doc("Boosts scores by a linearly decreasing amount. This is the default interpolation for scoring functions.")
  Linear: "linear",

  @doc("Boosts scores by a constant factor.")
  Constant: "constant",

  @doc("Boosts scores by an amount that decreases quadratically. Boosts decrease slowly for higher scores, and more quickly as the scores decrease. This interpolation option is not allowed in tag scoring functions.")
  Quadratic: "quadratic",

  @doc("Boosts scores by an amount that decreases logarithmically. Boosts decrease quickly for higher scores, and more slowly as the scores decrease. This interpolation option is not allowed in tag scoring functions.")
  Logarithmic: "logarithmic",
}

@doc("Defines the aggregation function used to combine the results of all the scoring functions in a scoring profile.")
union ScoringFunctionAggregation {
  string,

  @doc("Boost scores by the sum of all scoring function results.")
  Sum: "sum",

  @doc("Boost scores by the average of all scoring function results.")
  Average: "average",

  @doc("Boost scores by the minimum of all scoring function results.")
  Minimum: "minimum",

  @doc("Boost scores by the maximum of all scoring function results.")
  Maximum: "maximum",

  @doc("Boost scores using the first applicable scoring function in the scoring profile.")
  FirstMatching: "firstMatching",

  @doc("Boost scores by the product of all scoring function results.")
  Product: "product",
}

@doc("Represents classes of characters on which a token filter can operate.")
union TokenCharacterKind {
  string,

  @doc("Keeps letters in tokens.")
  Letter: "letter",

  @doc("Keeps digits in tokens.")
  Digit: "digit",

  @doc("Keeps whitespace in tokens.")
  Whitespace: "whitespace",

  @doc("Keeps punctuation in tokens.")
  Punctuation: "punctuation",

  @doc("Keeps symbols in tokens.")
  Symbol: "symbol",
}

@doc("Lists the languages supported by the Microsoft language tokenizer.")
union MicrosoftTokenizerLanguage {
  string,

  @doc("Selects the Microsoft tokenizer for Bangla.")
  Bangla: "bangla",

  @doc("Selects the Microsoft tokenizer for Bulgarian.")
  Bulgarian: "bulgarian",

  @doc("Selects the Microsoft tokenizer for Catalan.")
  Catalan: "catalan",

  @doc("Selects the Microsoft tokenizer for Chinese (Simplified).")
  ChineseSimplified: "chineseSimplified",

  @doc("Selects the Microsoft tokenizer for Chinese (Traditional).")
  ChineseTraditional: "chineseTraditional",

  @doc("Selects the Microsoft tokenizer for Croatian.")
  Croatian: "croatian",

  @doc("Selects the Microsoft tokenizer for Czech.")
  Czech: "czech",

  @doc("Selects the Microsoft tokenizer for Danish.")
  Danish: "danish",

  @doc("Selects the Microsoft tokenizer for Dutch.")
  Dutch: "dutch",

  @doc("Selects the Microsoft tokenizer for English.")
  English: "english",

  @doc("Selects the Microsoft tokenizer for French.")
  French: "french",

  @doc("Selects the Microsoft tokenizer for German.")
  German: "german",

  @doc("Selects the Microsoft tokenizer for Greek.")
  Greek: "greek",

  @doc("Selects the Microsoft tokenizer for Gujarati.")
  Gujarati: "gujarati",

  @doc("Selects the Microsoft tokenizer for Hindi.")
  Hindi: "hindi",

  @doc("Selects the Microsoft tokenizer for Icelandic.")
  Icelandic: "icelandic",

  @doc("Selects the Microsoft tokenizer for Indonesian.")
  Indonesian: "indonesian",

  @doc("Selects the Microsoft tokenizer for Italian.")
  Italian: "italian",

  @doc("Selects the Microsoft tokenizer for Japanese.")
  Japanese: "japanese",

  @doc("Selects the Microsoft tokenizer for Kannada.")
  Kannada: "kannada",

  @doc("Selects the Microsoft tokenizer for Korean.")
  Korean: "korean",

  @doc("Selects the Microsoft tokenizer for Malay.")
  Malay: "malay",

  @doc("Selects the Microsoft tokenizer for Malayalam.")
  Malayalam: "malayalam",

  @doc("Selects the Microsoft tokenizer for Marathi.")
  Marathi: "marathi",

  @doc("Selects the Microsoft tokenizer for Norwegian (BokmÃ¥l).")
  NorwegianBokmaal: "norwegianBokmaal",

  @doc("Selects the Microsoft tokenizer for Polish.")
  Polish: "polish",

  @doc("Selects the Microsoft tokenizer for Portuguese.")
  Portuguese: "portuguese",

  @doc("Selects the Microsoft tokenizer for Portuguese (Brazil).")
  PortugueseBrazilian: "portugueseBrazilian",

  @doc("Selects the Microsoft tokenizer for Punjabi.")
  Punjabi: "punjabi",

  @doc("Selects the Microsoft tokenizer for Romanian.")
  Romanian: "romanian",

  @doc("Selects the Microsoft tokenizer for Russian.")
  Russian: "russian",

  @doc("Selects the Microsoft tokenizer for Serbian (Cyrillic).")
  SerbianCyrillic: "serbianCyrillic",

  @doc("Selects the Microsoft tokenizer for Serbian (Latin).")
  SerbianLatin: "serbianLatin",

  @doc("Selects the Microsoft tokenizer for Slovenian.")
  Slovenian: "slovenian",

  @doc("Selects the Microsoft tokenizer for Spanish.")
  Spanish: "spanish",

  @doc("Selects the Microsoft tokenizer for Swedish.")
  Swedish: "swedish",

  @doc("Selects the Microsoft tokenizer for Tamil.")
  Tamil: "tamil",

  @doc("Selects the Microsoft tokenizer for Telugu.")
  Telugu: "telugu",

  @doc("Selects the Microsoft tokenizer for Thai.")
  Thai: "thai",

  @doc("Selects the Microsoft tokenizer for Ukrainian.")
  Ukrainian: "ukrainian",

  @doc("Selects the Microsoft tokenizer for Urdu.")
  Urdu: "urdu",

  @doc("Selects the Microsoft tokenizer for Vietnamese.")
  Vietnamese: "vietnamese",
}

@doc("Lists the languages supported by the Microsoft language stemming tokenizer.")
union MicrosoftStemmingTokenizerLanguage {
  string,

  @doc("Selects the Microsoft stemming tokenizer for Arabic.")
  Arabic: "arabic",

  @doc("Selects the Microsoft stemming tokenizer for Bangla.")
  Bangla: "bangla",

  @doc("Selects the Microsoft stemming tokenizer for Bulgarian.")
  Bulgarian: "bulgarian",

  @doc("Selects the Microsoft stemming tokenizer for Catalan.")
  Catalan: "catalan",

  @doc("Selects the Microsoft stemming tokenizer for Croatian.")
  Croatian: "croatian",

  @doc("Selects the Microsoft stemming tokenizer for Czech.")
  Czech: "czech",

  @doc("Selects the Microsoft stemming tokenizer for Danish.")
  Danish: "danish",

  @doc("Selects the Microsoft stemming tokenizer for Dutch.")
  Dutch: "dutch",

  @doc("Selects the Microsoft stemming tokenizer for English.")
  English: "english",

  @doc("Selects the Microsoft stemming tokenizer for Estonian.")
  Estonian: "estonian",

  @doc("Selects the Microsoft stemming tokenizer for Finnish.")
  Finnish: "finnish",

  @doc("Selects the Microsoft stemming tokenizer for French.")
  French: "french",

  @doc("Selects the Microsoft stemming tokenizer for German.")
  German: "german",

  @doc("Selects the Microsoft stemming tokenizer for Greek.")
  Greek: "greek",

  @doc("Selects the Microsoft stemming tokenizer for Gujarati.")
  Gujarati: "gujarati",

  @doc("Selects the Microsoft stemming tokenizer for Hebrew.")
  Hebrew: "hebrew",

  @doc("Selects the Microsoft stemming tokenizer for Hindi.")
  Hindi: "hindi",

  @doc("Selects the Microsoft stemming tokenizer for Hungarian.")
  Hungarian: "hungarian",

  @doc("Selects the Microsoft stemming tokenizer for Icelandic.")
  Icelandic: "icelandic",

  @doc("Selects the Microsoft stemming tokenizer for Indonesian.")
  Indonesian: "indonesian",

  @doc("Selects the Microsoft stemming tokenizer for Italian.")
  Italian: "italian",

  @doc("Selects the Microsoft stemming tokenizer for Kannada.")
  Kannada: "kannada",

  @doc("Selects the Microsoft stemming tokenizer for Latvian.")
  Latvian: "latvian",

  @doc("Selects the Microsoft stemming tokenizer for Lithuanian.")
  Lithuanian: "lithuanian",

  @doc("Selects the Microsoft stemming tokenizer for Malay.")
  Malay: "malay",

  @doc("Selects the Microsoft stemming tokenizer for Malayalam.")
  Malayalam: "malayalam",

  @doc("Selects the Microsoft stemming tokenizer for Marathi.")
  Marathi: "marathi",

  @doc("Selects the Microsoft stemming tokenizer for Norwegian (BokmÃ¥l).")
  NorwegianBokmaal: "norwegianBokmaal",

  @doc("Selects the Microsoft stemming tokenizer for Polish.")
  Polish: "polish",

  @doc("Selects the Microsoft stemming tokenizer for Portuguese.")
  Portuguese: "portuguese",

  @doc("Selects the Microsoft stemming tokenizer for Portuguese (Brazil).")
  PortugueseBrazilian: "portugueseBrazilian",

  @doc("Selects the Microsoft stemming tokenizer for Punjabi.")
  Punjabi: "punjabi",

  @doc("Selects the Microsoft stemming tokenizer for Romanian.")
  Romanian: "romanian",

  @doc("Selects the Microsoft stemming tokenizer for Russian.")
  Russian: "russian",

  @doc("Selects the Microsoft stemming tokenizer for Serbian (Cyrillic).")
  SerbianCyrillic: "serbianCyrillic",

  @doc("Selects the Microsoft stemming tokenizer for Serbian (Latin).")
  SerbianLatin: "serbianLatin",

  @doc("Selects the Microsoft stemming tokenizer for Slovak.")
  Slovak: "slovak",

  @doc("Selects the Microsoft stemming tokenizer for Slovenian.")
  Slovenian: "slovenian",

  @doc("Selects the Microsoft stemming tokenizer for Spanish.")
  Spanish: "spanish",

  @doc("Selects the Microsoft stemming tokenizer for Swedish.")
  Swedish: "swedish",

  @doc("Selects the Microsoft stemming tokenizer for Tamil.")
  Tamil: "tamil",

  @doc("Selects the Microsoft stemming tokenizer for Telugu.")
  Telugu: "telugu",

  @doc("Selects the Microsoft stemming tokenizer for Turkish.")
  Turkish: "turkish",

  @doc("Selects the Microsoft stemming tokenizer for Ukrainian.")
  Ukrainian: "ukrainian",

  @doc("Selects the Microsoft stemming tokenizer for Urdu.")
  Urdu: "urdu",
}

@doc("Scripts that can be ignored by CjkBigramTokenFilter.")
union CjkBigramTokenFilterScripts {
  string,

  @doc("Ignore Han script when forming bigrams of CJK terms.")
  Han: "han",

  @doc("Ignore Hiragana script when forming bigrams of CJK terms.")
  Hiragana: "hiragana",

  @doc("Ignore Katakana script when forming bigrams of CJK terms.")
  Katakana: "katakana",

  @doc("Ignore Hangul script when forming bigrams of CJK terms.")
  Hangul: "hangul",
}

@doc("Specifies which side of the input an n-gram should be generated from.")
union EdgeNGramTokenFilterSide {
  string,

  @doc("Specifies that the n-gram should be generated from the front of the input.")
  Front: "front",

  @doc("Specifies that the n-gram should be generated from the back of the input.")
  Back: "back",
}

@doc("Identifies the type of phonetic encoder to use with a PhoneticTokenFilter.")
union PhoneticEncoder {
  string,

  @doc("Encodes a token into a Metaphone value.")
  Metaphone: "metaphone",

  @doc("Encodes a token into a double metaphone value.")
  DoubleMetaphone: "doubleMetaphone",

  @doc("Encodes a token into a Soundex value.")
  Soundex: "soundex",

  @doc("Encodes a token into a Refined Soundex value.")
  RefinedSoundex: "refinedSoundex",

  @doc("Encodes a token into a Caverphone 1.0 value.")
  Caverphone1: "caverphone1",

  @doc("Encodes a token into a Caverphone 2.0 value.")
  Caverphone2: "caverphone2",

  @doc("Encodes a token into a Cologne Phonetic value.")
  Cologne: "cologne",

  @doc("Encodes a token into a NYSIIS value.")
  Nysiis: "nysiis",

  @doc("Encodes a token using the Kölner Phonetik algorithm.")
  KoelnerPhonetik: "koelnerPhonetik",

  @doc("Encodes a token using the Haase refinement of the Kölner Phonetik algorithm.")
  HaasePhonetik: "haasePhonetik",

  @doc("Encodes a token into a Beider-Morse value.")
  BeiderMorse: "beiderMorse",
}

@doc("The language to use for a Snowball token filter.")
union SnowballTokenFilterLanguage {
  string,

  @doc("Selects the Lucene Snowball stemming tokenizer for Armenian.")
  Armenian: "armenian",

  @doc("Selects the Lucene Snowball stemming tokenizer for Basque.")
  Basque: "basque",

  @doc("Selects the Lucene Snowball stemming tokenizer for Catalan.")
  Catalan: "catalan",

  @doc("Selects the Lucene Snowball stemming tokenizer for Danish.")
  Danish: "danish",

  @doc("Selects the Lucene Snowball stemming tokenizer for Dutch.")
  Dutch: "dutch",

  @doc("Selects the Lucene Snowball stemming tokenizer for English.")
  English: "english",

  @doc("Selects the Lucene Snowball stemming tokenizer for Finnish.")
  Finnish: "finnish",

  @doc("Selects the Lucene Snowball stemming tokenizer for French.")
  French: "french",

  @doc("Selects the Lucene Snowball stemming tokenizer for German.")
  German: "german",

  @doc("Selects the Lucene Snowball stemming tokenizer that uses the German variant algorithm.")
  German2: "german2",

  @doc("Selects the Lucene Snowball stemming tokenizer for Hungarian.")
  Hungarian: "hungarian",

  @doc("Selects the Lucene Snowball stemming tokenizer for Italian.")
  Italian: "italian",

  @doc("Selects the Lucene Snowball stemming tokenizer for Dutch that uses the Kraaij-Pohlmann stemming algorithm.")
  Kp: "kp",

  @doc("Selects the Lucene Snowball stemming tokenizer for English that uses the Lovins stemming algorithm.")
  Lovins: "lovins",

  @doc("Selects the Lucene Snowball stemming tokenizer for Norwegian.")
  Norwegian: "norwegian",

  @doc("Selects the Lucene Snowball stemming tokenizer for English that uses the Porter stemming algorithm.")
  Porter: "porter",

  @doc("Selects the Lucene Snowball stemming tokenizer for Portuguese.")
  Portuguese: "portuguese",

  @doc("Selects the Lucene Snowball stemming tokenizer for Romanian.")
  Romanian: "romanian",

  @doc("Selects the Lucene Snowball stemming tokenizer for Russian.")
  Russian: "russian",

  @doc("Selects the Lucene Snowball stemming tokenizer for Spanish.")
  Spanish: "spanish",

  @doc("Selects the Lucene Snowball stemming tokenizer for Swedish.")
  Swedish: "swedish",

  @doc("Selects the Lucene Snowball stemming tokenizer for Turkish.")
  Turkish: "turkish",
}

@doc("The language to use for a stemmer token filter.")
union StemmerTokenFilterLanguage {
  string,

  @doc("Selects the Lucene stemming tokenizer for Arabic.")
  Arabic: "arabic",

  @doc("Selects the Lucene stemming tokenizer for Armenian.")
  Armenian: "armenian",

  @doc("Selects the Lucene stemming tokenizer for Basque.")
  Basque: "basque",

  @doc("Selects the Lucene stemming tokenizer for Portuguese (Brazil).")
  Brazilian: "brazilian",

  @doc("Selects the Lucene stemming tokenizer for Bulgarian.")
  Bulgarian: "bulgarian",

  @doc("Selects the Lucene stemming tokenizer for Catalan.")
  Catalan: "catalan",

  @doc("Selects the Lucene stemming tokenizer for Czech.")
  Czech: "czech",

  @doc("Selects the Lucene stemming tokenizer for Danish.")
  Danish: "danish",

  @doc("Selects the Lucene stemming tokenizer for Dutch.")
  Dutch: "dutch",

  @doc("Selects the Lucene stemming tokenizer for Dutch that uses the Kraaij-Pohlmann stemming algorithm.")
  DutchKp: "dutchKp",

  @doc("Selects the Lucene stemming tokenizer for English.")
  English: "english",

  @doc("Selects the Lucene stemming tokenizer for English that does light stemming.")
  LightEnglish: "lightEnglish",

  @doc("Selects the Lucene stemming tokenizer for English that does minimal stemming.")
  MinimalEnglish: "minimalEnglish",

  @doc("Selects the Lucene stemming tokenizer for English that removes trailing possessives from words.")
  PossessiveEnglish: "possessiveEnglish",

  @doc("Selects the Lucene stemming tokenizer for English that uses the Porter2 stemming algorithm.")
  Porter2: "porter2",

  @doc("Selects the Lucene stemming tokenizer for English that uses the Lovins stemming algorithm.")
  Lovins: "lovins",

  @doc("Selects the Lucene stemming tokenizer for Finnish.")
  Finnish: "finnish",

  @doc("Selects the Lucene stemming tokenizer for Finnish that does light stemming.")
  LightFinnish: "lightFinnish",

  @doc("Selects the Lucene stemming tokenizer for French.")
  French: "french",

  @doc("Selects the Lucene stemming tokenizer for French that does light stemming.")
  LightFrench: "lightFrench",

  @doc("Selects the Lucene stemming tokenizer for French that does minimal stemming.")
  MinimalFrench: "minimalFrench",

  @doc("Selects the Lucene stemming tokenizer for Galician.")
  Galician: "galician",

  @doc("Selects the Lucene stemming tokenizer for Galician that does minimal stemming.")
  MinimalGalician: "minimalGalician",

  @doc("Selects the Lucene stemming tokenizer for German.")
  German: "german",

  @doc("Selects the Lucene stemming tokenizer that uses the German variant algorithm.")
  German2: "german2",

  @doc("Selects the Lucene stemming tokenizer for German that does light stemming.")
  LightGerman: "lightGerman",

  @doc("Selects the Lucene stemming tokenizer for German that does minimal stemming.")
  MinimalGerman: "minimalGerman",

  @doc("Selects the Lucene stemming tokenizer for Greek.")
  Greek: "greek",

  @doc("Selects the Lucene stemming tokenizer for Hindi.")
  Hindi: "hindi",

  @doc("Selects the Lucene stemming tokenizer for Hungarian.")
  Hungarian: "hungarian",

  @doc("Selects the Lucene stemming tokenizer for Hungarian that does light stemming.")
  LightHungarian: "lightHungarian",

  @doc("Selects the Lucene stemming tokenizer for Indonesian.")
  Indonesian: "indonesian",

  @doc("Selects the Lucene stemming tokenizer for Irish.")
  Irish: "irish",

  @doc("Selects the Lucene stemming tokenizer for Italian.")
  Italian: "italian",

  @doc("Selects the Lucene stemming tokenizer for Italian that does light stemming.")
  LightItalian: "lightItalian",

  @doc("Selects the Lucene stemming tokenizer for Sorani.")
  Sorani: "sorani",

  @doc("Selects the Lucene stemming tokenizer for Latvian.")
  Latvian: "latvian",

  @doc("Selects the Lucene stemming tokenizer for Norwegian (BokmÃ¥l).")
  Norwegian: "norwegian",

  @doc("Selects the Lucene stemming tokenizer for Norwegian (BokmÃ¥l) that does light stemming.")
  LightNorwegian: "lightNorwegian",

  @doc("Selects the Lucene stemming tokenizer for Norwegian (BokmÃ¥l) that does minimal stemming.")
  MinimalNorwegian: "minimalNorwegian",

  @doc("Selects the Lucene stemming tokenizer for Norwegian (Nynorsk) that does light stemming.")
  LightNynorsk: "lightNynorsk",

  @doc("Selects the Lucene stemming tokenizer for Norwegian (Nynorsk) that does minimal stemming.")
  MinimalNynorsk: "minimalNynorsk",

  @doc("Selects the Lucene stemming tokenizer for Portuguese.")
  Portuguese: "portuguese",

  @doc("Selects the Lucene stemming tokenizer for Portuguese that does light stemming.")
  LightPortuguese: "lightPortuguese",

  @doc("Selects the Lucene stemming tokenizer for Portuguese that does minimal stemming.")
  MinimalPortuguese: "minimalPortuguese",

  @doc("Selects the Lucene stemming tokenizer for Portuguese that uses the RSLP stemming algorithm.")
  PortugueseRslp: "portugueseRslp",

  @doc("Selects the Lucene stemming tokenizer for Romanian.")
  Romanian: "romanian",

  @doc("Selects the Lucene stemming tokenizer for Russian.")
  Russian: "russian",

  @doc("Selects the Lucene stemming tokenizer for Russian that does light stemming.")
  LightRussian: "lightRussian",

  @doc("Selects the Lucene stemming tokenizer for Spanish.")
  Spanish: "spanish",

  @doc("Selects the Lucene stemming tokenizer for Spanish that does light stemming.")
  LightSpanish: "lightSpanish",

  @doc("Selects the Lucene stemming tokenizer for Swedish.")
  Swedish: "swedish",

  @doc("Selects the Lucene stemming tokenizer for Swedish that does light stemming.")
  LightSwedish: "lightSwedish",

  @doc("Selects the Lucene stemming tokenizer for Turkish.")
  Turkish: "turkish",
}

@doc("Identifies a predefined list of language-specific stopwords.")
union StopwordsList {
  string,

  @doc("Selects the stopword list for Arabic.")
  Arabic: "arabic",

  @doc("Selects the stopword list for Armenian.")
  Armenian: "armenian",

  @doc("Selects the stopword list for Basque.")
  Basque: "basque",

  @doc("Selects the stopword list for Portuguese (Brazil).")
  Brazilian: "brazilian",

  @doc("Selects the stopword list for Bulgarian.")
  Bulgarian: "bulgarian",

  @doc("Selects the stopword list for Catalan.")
  Catalan: "catalan",

  @doc("Selects the stopword list for Czech.")
  Czech: "czech",

  @doc("Selects the stopword list for Danish.")
  Danish: "danish",

  @doc("Selects the stopword list for Dutch.")
  Dutch: "dutch",

  @doc("Selects the stopword list for English.")
  English: "english",

  @doc("Selects the stopword list for Finnish.")
  Finnish: "finnish",

  @doc("Selects the stopword list for French.")
  French: "french",

  @doc("Selects the stopword list for Galician.")
  Galician: "galician",

  @doc("Selects the stopword list for German.")
  German: "german",

  @doc("Selects the stopword list for Greek.")
  Greek: "greek",

  @doc("Selects the stopword list for Hindi.")
  Hindi: "hindi",

  @doc("Selects the stopword list for Hungarian.")
  Hungarian: "hungarian",

  @doc("Selects the stopword list for Indonesian.")
  Indonesian: "indonesian",

  @doc("Selects the stopword list for Irish.")
  Irish: "irish",

  @doc("Selects the stopword list for Italian.")
  Italian: "italian",

  @doc("Selects the stopword list for Latvian.")
  Latvian: "latvian",

  @doc("Selects the stopword list for Norwegian.")
  Norwegian: "norwegian",

  @doc("Selects the stopword list for Persian.")
  Persian: "persian",

  @doc("Selects the stopword list for Portuguese.")
  Portuguese: "portuguese",

  @doc("Selects the stopword list for Romanian.")
  Romanian: "romanian",

  @doc("Selects the stopword list for Russian.")
  Russian: "russian",

  @doc("Selects the stopword list for Sorani.")
  Sorani: "sorani",

  @doc("Selects the stopword list for Spanish.")
  Spanish: "spanish",

  @doc("Selects the stopword list for Swedish.")
  Swedish: "swedish",

  @doc("Selects the stopword list for Thai.")
  Thai: "thai",

  @doc("Selects the stopword list for Turkish.")
  Turkish: "turkish",
}

@doc("Options with various types of permission data to index.")
union IndexerPermissionOption {
  string,

  @doc("Indexer to ingest ACL userIds from data source to index.")
  UserIds: "userIds",

  @doc("Indexer to ingest ACL groupIds from data source to index.")
  GroupIds: "groupIds",

  @doc("Indexer to ingest Azure RBAC scope from data source to index.")
  RbacScope: "rbacScope",
}

@doc("A value indicating whether the field should be used as a permission filter.")
union PermissionFilter {
  string,

  @doc("Field represents user IDs that should be used to filter document access on queries.")
  UserIds: "userIds",

  @doc("Field represents group IDs that should be used to filter document access on queries.")
  GroupIds: "groupIds",

  @doc("Field represents an RBAC scope that should be used to filter document access on queries.")
  RbacScope: "rbacScope",
}

@doc("A value indicating whether permission filtering is enabled for the index.")
union SearchIndexPermissionFilterOption {
  string,

  @doc("enabled.")
  Enabled: "enabled",

  @doc("disabled.")
  Disabled: "disabled",
}

@doc("Specifies how 'extraParameters' should be handled by Azure AI Foundry. Defaults to 'error'.")
union ChatCompletionExtraParametersBehavior {
  string,

  @doc("Passes any extra parameters directly to the model.")
  PassThrough: "pass-through",

  @doc("Drops all extra parameters.")
  Drop: "drop",

  @doc("Raises an error if any extra parameter is present.")
  Error: "error",
}

@doc("Specifies how the LLM should format the response.")
union ChatCompletionResponseFormatType {
  string,

  @doc("Plain text response format.")
  Text: "text",

  @doc("Arbitrary JSON object response format.")
  JsonObject: "jsonObject",

  @doc("JSON schema-adhering response format.")
  JsonSchema: "jsonSchema",
}

@doc("Represents score to use for sort order of documents.")
union RankingOrder {
  string,

  @doc("Sets sort order as BoostedRerankerScore")
  BoostedRerankerScore: "BoostedRerankerScore",

  @doc("Sets sort order as ReRankerScore")
  RerankerScore: "RerankerScore",
}

@doc("Options with various types of permission data to index.")
union IndexerResyncOption {
  string,

  @doc("Indexer to re-ingest pre-selected permissions data from data source to index.")
  Permissions: "permissions",
}

@doc("Request body for resync indexer operation.")
model IndexerResyncBody {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Re-sync options that have been pre-defined from data source.")
  options?: IndexerResyncOption[] | null;
}

@doc("Represents a datasource definition, which can be used to configure an indexer.")
model SearchIndexerDataSource {
  @doc("The name of the datasource.")
  name: string;

  @doc("The description of the datasource.")
  description?: string;

  @doc("The type of the datasource.")
  type: SearchIndexerDataSourceType;

  @doc("A specific type of the data source, in case the resource is capable of different modalities. For example, 'MongoDb' for certain 'cosmosDb' accounts.")
  @visibility(Lifecycle.Read)
  subType?: string;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Pre-existing API contract"
  @doc("Credentials for the datasource.")
  @flattenProperty
  credentials: DataSourceCredentials;

  @doc("The data container for the datasource.")
  container: SearchIndexerDataContainer;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("An explicit managed identity to use for this datasource. If not specified and the connection string is a managed identity, the system-assigned managed identity is used. If not specified, the value remains unchanged. If \"none\" is specified, the value of this property is cleared.")
  identity?: SearchIndexerDataIdentity | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Ingestion options with various types of permission data.")
  indexerPermissionOptions?: IndexerPermissionOption[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The data change detection policy for the datasource.")
  dataChangeDetectionPolicy?: DataChangeDetectionPolicy | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The data deletion detection policy for the datasource.")
  dataDeletionDetectionPolicy?: DataDeletionDetectionPolicy | null;

  @doc("The ETag of the data source.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A description of an encryption key that you create in Azure Key Vault. This key is used to provide an additional level of encryption-at-rest for your datasource definition when you want full assurance that no one, not even Microsoft, can decrypt your data source definition. Once you have encrypted your data source definition, it will always remain encrypted. The search service will ignore attempts to set this property to null. You can change this property as needed if you want to rotate your encryption key; Your datasource definition will be unaffected. Encryption with customer-managed keys is not available for free search services, and is only available for paid services created on or after January 1, 2019.")
  encryptionKey?: SearchResourceEncryptionKey | null;
}

@doc("Represents credentials that can be used to connect to a datasource.")
model DataSourceCredentials {
  @doc("The connection string for the datasource. Set to `<unchanged>` (with brackets) if you don't want the connection string updated. Set to `<redacted>` if you want to remove the connection string value from the datasource.")
  connectionString?: string;
}

@doc("Represents information about the entity (such as Azure SQL table or CosmosDB collection) that will be indexed.")
model SearchIndexerDataContainer {
  @doc("The name of the table or view (for Azure SQL data source) or collection (for CosmosDB data source) that will be indexed.")
  name: string;

  @doc("A query that is applied to this data container. The syntax and meaning of this parameter is datasource-specific. Not supported by Azure SQL datasources.")
  query?: string;
}

@doc("Base type for data change detection policies.")
@discriminator("@odata.type")
model DataChangeDetectionPolicy {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;
}

@doc("Base type for data deletion detection policies.")
@discriminator("@odata.type")
model DataDeletionDetectionPolicy {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;
}

@doc("A customer-managed encryption key in Azure Key Vault. Keys that you create and manage can be used to encrypt or decrypt data-at-rest, such as indexes and synonym maps.")
model SearchResourceEncryptionKey {
  @doc("The name of your Azure Key Vault key to be used to encrypt your data at rest.")
  keyVaultKeyName: string;

  @doc("The version of your Azure Key Vault key to be used to encrypt your data at rest.")
  keyVaultKeyVersion?: string;

  @doc("The URI of your Azure Key Vault, also referred to as DNS name, that contains the key to be used to encrypt your data at rest. An example URI might be `https://my-keyvault-name.vault.azure.net`.")
  keyVaultUri: string;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Pre-existing API contract"
  @doc("Optional Azure Active Directory credentials used for accessing your Azure Key Vault. Not required if using managed identity instead.")
  @flattenProperty
  accessCredentials?: AzureActiveDirectoryApplicationCredentials;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("An explicit managed identity to use for this encryption key. If not specified and the access credentials property is null, the system-assigned managed identity is used. On update to the resource, if the explicit identity is unspecified, it remains unchanged. If \"none\" is specified, the value of this property is cleared.")
  identity?: SearchIndexerDataIdentity | null;
}

@doc("Credentials of a registered application created for your search service, used for authenticated access to the encryption keys stored in Azure Key Vault.")
model AzureActiveDirectoryApplicationCredentials {
  @doc("An AAD Application ID that was granted the required access permissions to the Azure Key Vault that is to be used when encrypting your data at rest. The Application ID should not be confused with the Object ID for your AAD Application.")
  applicationId: string;

  @doc("The authentication key of the specified AAD application.")
  applicationSecret?: string;
}

@doc("Response from a List Datasources request. If successful, it includes the full definitions of all datasources.")
model ListDataSourcesResult {
  @doc("The datasources in the Search service.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: SearchIndexerDataSource[];
}

@doc("The type of the keysOrIds.")
model DocumentKeysOrIds {
  @doc("document keys to be reset")
  documentKeys?: string[];

  @doc("datasource document identifiers to be reset")
  datasourceDocumentIds?: string[];
}

@doc("Represents an indexer.")
model SearchIndexer {
  @doc("The name of the indexer.")
  name: string;

  @doc("The description of the indexer.")
  description?: string;

  @doc("The name of the datasource from which this indexer reads data.")
  dataSourceName: string;

  @doc("The name of the skillset executing with this indexer.")
  skillsetName?: string;

  @doc("The name of the index to which this indexer writes data.")
  targetIndexName: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The schedule for this indexer.")
  schedule?: IndexingSchedule | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Parameters for indexer execution.")
  parameters?: IndexingParameters | null;

  @doc("Defines mappings between fields in the data source and corresponding target fields in the index.")
  fieldMappings?: FieldMapping[];

  @doc("Output field mappings are applied after enrichment and immediately before indexing.")
  outputFieldMappings?: FieldMapping[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating whether the indexer is disabled. Default is false.")
  disabled?: boolean | null = false;

  @doc("The ETag of the indexer.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A description of an encryption key that you create in Azure Key Vault. This key is used to provide an additional level of encryption-at-rest for your indexer definition (as well as indexer execution status) when you want full assurance that no one, not even Microsoft, can decrypt them. Once you have encrypted your indexer definition, it will always remain encrypted. The search service will ignore attempts to set this property to null. You can change this property as needed if you want to rotate your encryption key; Your indexer definition (and indexer execution status) will be unaffected. Encryption with customer-managed keys is not available for free search services, and is only available for paid services created on or after January 1, 2019.")
  encryptionKey?: SearchResourceEncryptionKey | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Adds caching to an enrichment pipeline to allow for incremental modification steps without having to rebuild the index every time.")
  cache?: SearchIndexerCache | null;
}

@doc("Represents a schedule for indexer execution.")
model IndexingSchedule {
  @doc("The interval of time between indexer executions.")
  interval: duration;

  @doc("The time when an indexer should start running.")
  startTime?: utcDateTime;
}

@doc("Represents parameters for indexer execution.")
model IndexingParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The number of items that are read from the data source and indexed as a single batch in order to improve performance. The default depends on the data source type.")
  batchSize?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum number of items that can fail indexing for indexer execution to still be considered successful. -1 means no limit. Default is 0.")
  maxFailedItems?: int32 | null = 0;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum number of items in a single batch that can fail indexing for the batch to still be considered successful. -1 means no limit. Default is 0.")
  maxFailedItemsPerBatch?: int32 | null = 0;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("A dictionary of indexer-specific configuration properties. Each name is the name of a specific property. Each value must be of a primitive type.")
  configuration?: IndexingParametersConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("A dictionary of indexer-specific configuration properties. Each name is the name of a specific property. Each value must be of a primitive type.")
model IndexingParametersConfiguration {
  ...Record<unknown>;

  @doc("Represents the parsing mode for indexing from an Azure blob data source.")
  parsingMode?: BlobIndexerParsingMode = BlobIndexerParsingMode.Default;

  @doc("Comma-delimited list of filename extensions to ignore when processing from Azure blob storage.  For example, you could exclude \".png, .mp4\" to skip over those files during indexing.")
  excludedFileNameExtensions?: string = "";

  @doc("Comma-delimited list of filename extensions to select when processing from Azure blob storage.  For example, you could focus indexing on specific application files \".docx, .pptx, .msg\" to specifically include those file types.")
  indexedFileNameExtensions?: string = "";

  @doc("For Azure blobs, set to false if you want to continue indexing when an unsupported content type is encountered, and you don't know all the content types (file extensions) in advance.")
  failOnUnsupportedContentType?: boolean = false;

  @doc("For Azure blobs, set to false if you want to continue indexing if a document fails indexing.")
  failOnUnprocessableDocument?: boolean = false;

  @doc("For Azure blobs, set this property to true to still index storage metadata for blob content that is too large to process. Oversized blobs are treated as errors by default. For limits on blob size, see https://learn.microsoft.com/azure/search/search-limits-quotas-capacity.")
  indexStorageMetadataOnlyForOversizedDocuments?: boolean = false;

  @doc("For CSV blobs, specifies a comma-delimited list of column headers, useful for mapping source fields to destination fields in an index.")
  delimitedTextHeaders?: string;

  @doc("For CSV blobs, specifies the end-of-line single-character delimiter for CSV files where each line starts a new document (for example, \"|\").")
  delimitedTextDelimiter?: string;

  @doc("For CSV blobs, indicates that the first (non-blank) line of each blob contains headers.")
  firstLineContainsHeaders?: boolean = true;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Specifies the submode that will determine whether a markdown file will be parsed into exactly one search document or multiple search documents. Default is `oneToMany`.")
  markdownParsingSubmode?: MarkdownParsingSubmode | null = MarkdownParsingSubmode.OneToMany;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Specifies the max header depth that will be considered while grouping markdown content. Default is `h6`.")
  markdownHeaderDepth?: MarkdownHeaderDepth | null = MarkdownHeaderDepth.h6;

  @doc("For JSON arrays, given a structured or semi-structured document, you can specify a path to the array using this property.")
  documentRoot?: string;

  @doc("Specifies the data to extract from Azure blob storage and tells the indexer which data to extract from image content when \"imageAction\" is set to a value other than \"none\".  This applies to embedded image content in a .PDF or other application, or image files such as .jpg and .png, in Azure blobs.")
  dataToExtract?: BlobIndexerDataToExtract = BlobIndexerDataToExtract.ContentAndMetadata;

  @doc("Determines how to process embedded images and image files in Azure blob storage.  Setting the \"imageAction\" configuration to any value other than \"none\" requires that a skillset also be attached to that indexer.")
  imageAction?: BlobIndexerImageAction = BlobIndexerImageAction.None;

  @doc("If true, will create a path //document//file_data that is an object representing the original file data downloaded from your blob data source. This allows you to pass the original file data to a custom skill for processing within the enrichment pipeline, or to the Document Extraction skill.")
  allowSkillsetToReadFileData?: boolean = false;

  @doc("Determines algorithm for text extraction from PDF files in Azure blob storage.")
  pdfTextRotationAlgorithm?: BlobIndexerPDFTextRotationAlgorithm = BlobIndexerPDFTextRotationAlgorithm.None;

  @doc("Specifies the environment in which the indexer should execute.")
  executionEnvironment?: IndexerExecutionEnvironment = IndexerExecutionEnvironment.standard;

  @doc("Increases the timeout beyond the 5-minute default for Azure SQL database data sources, specified in the format \"hh:mm:ss\".")
  queryTimeout?: string = "00:05:00";
}

@doc("Defines a mapping between a field in a data source and a target field in an index.")
model FieldMapping {
  @doc("The name of the field in the data source.")
  sourceFieldName: string;

  @doc("The name of the target field in the index. Same as the source field name by default.")
  targetFieldName?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A function to apply to each source field value before indexing.")
  mappingFunction?: FieldMappingFunction | null;
}

@doc("Represents a function that transforms a value from a data source before indexing.")
model FieldMappingFunction {
  @doc("The name of the field mapping function.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("A dictionary of parameter name/value pairs to pass to the function. Each value must be of a primitive type.")
  parameters?: Record<unknown> | null;
}

@doc("The type of the cache.")
model SearchIndexerCache {
  @doc("A guid for the SearchIndexerCache.")
  id?: string;

  @doc("The connection string to the storage account where the cache data will be persisted.")
  storageConnectionString?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Specifies whether incremental reprocessing is enabled.")
  enableReprocessing?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for connections to the enrichment cache.  If the connection string indicates an identity (ResourceId) and it's not specified, the system-assigned managed identity is used. On updates to the indexer, if the identity is unspecified, the value remains unchanged. If set to \"none\", the value of this property is cleared.")
  identity?: SearchIndexerDataIdentity | null;
}

@doc("Response from a List Indexers request. If successful, it includes the full definitions of all indexers.")
model ListIndexersResult {
  @doc("The indexers in the Search service.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: SearchIndexer[];
}

@doc("Represents the current status and execution history of an indexer.")
model SearchIndexerStatus {
  @doc("The name of the indexer.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Overall indexer status.")
  @visibility(Lifecycle.Read)
  status: IndexerStatus;

  @doc("Snapshot of the indexer's cumulative runtime consumption for the service over the current UTC period.")
  @visibility(Lifecycle.Read)
  runtime: IndexerRuntime;

  @doc("The result of the most recent or an in-progress indexer execution.")
  @visibility(Lifecycle.Read)
  lastResult?: IndexerExecutionResult;

  @doc("History of the recent indexer executions, sorted in reverse chronological order.")
  @visibility(Lifecycle.Read)
  executionHistory: IndexerExecutionResult[];

  @doc("The execution limits for the indexer.")
  @visibility(Lifecycle.Read)
  limits: SearchIndexerLimits;

  @doc("All of the state that defines and dictates the indexer's current execution.")
  @visibility(Lifecycle.Read)
  currentState?: IndexerCurrentState;
}

@doc("Represents the result of an individual indexer execution.")
model IndexerExecutionResult {
  @doc("The outcome of this indexer execution.")
  @visibility(Lifecycle.Read)
  status: IndexerExecutionStatus;

  @doc("The outcome of this indexer execution.")
  @visibility(Lifecycle.Read)
  statusDetail?: IndexerExecutionStatusDetail;

  @doc("The mode the indexer is running in.")
  @visibility(Lifecycle.Read)
  mode?: IndexingMode;

  @doc("The error message indicating the top-level error, if any.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  @doc("The start time of this indexer execution.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The end time of this indexer execution, if the execution has already completed.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime | null;

  @doc("The item-level indexing errors.")
  @visibility(Lifecycle.Read)
  errors: SearchIndexerError[];

  @doc("The item-level indexing warnings.")
  @visibility(Lifecycle.Read)
  warnings: SearchIndexerWarning[];

  @doc("The number of items that were processed during this indexer execution. This includes both successfully processed items and items where indexing was attempted but failed.")
  @visibility(Lifecycle.Read)
  itemsProcessed: int32;

  @doc("The number of items that failed to be indexed during this indexer execution.")
  @visibility(Lifecycle.Read)
  itemsFailed: int32;

  @doc("Change tracking state with which an indexer execution started.")
  @visibility(Lifecycle.Read)
  initialTrackingState?: string;

  @doc("Change tracking state with which an indexer execution finished.")
  @visibility(Lifecycle.Read)
  finalTrackingState?: string;
}

@doc("Represents all of the state that defines and dictates the indexer's current execution.")
model IndexerCurrentState {
  @doc("The mode the indexer is running in.")
  @visibility(Lifecycle.Read)
  mode?: IndexingMode;

  @doc("Change tracking state used when indexing starts on all documents in the datasource.")
  @visibility(Lifecycle.Read)
  allDocsInitialTrackingState?: string;

  @doc("Change tracking state value when indexing finishes on all documents in the datasource.")
  @visibility(Lifecycle.Read)
  allDocsFinalTrackingState?: string;

  @doc("Change tracking state used when indexing starts on select, reset documents in the datasource.")
  @visibility(Lifecycle.Read)
  resetDocsInitialTrackingState?: string;

  @doc("Change tracking state value when indexing finishes on select, reset documents in the datasource.")
  @visibility(Lifecycle.Read)
  resetDocsFinalTrackingState?: string;

  @doc("Change tracking state used when indexing starts on selective options from the datasource.")
  @visibility(Lifecycle.Read)
  resyncInitialTrackingState?: string;

  @doc("Change tracking state value when indexing finishes on selective options from the datasource.")
  @visibility(Lifecycle.Read)
  resyncFinalTrackingState?: string;

  @doc("The list of document keys that have been reset. The document key is the document's unique identifier for the data in the search index. The indexer will prioritize selectively re-ingesting these keys.")
  @visibility(Lifecycle.Read)
  resetDocumentKeys?: string[];

  @doc("The list of datasource document ids that have been reset. The datasource document id is the unique identifier for the data in the datasource. The indexer will prioritize selectively re-ingesting these ids.")
  @visibility(Lifecycle.Read)
  resetDatasourceDocumentIds?: string[];
}

@doc("Represents an item- or document-level indexing error.")
@error
model SearchIndexerError {
  @doc("The key of the item for which indexing failed.")
  @visibility(Lifecycle.Read)
  key?: string;

  @doc("The message describing the error that occurred while processing the item.")
  @visibility(Lifecycle.Read)
  errorMessage: string;

  @doc("The status code indicating why the indexing operation failed. Possible values include: 400 for a malformed input document, 404 for document not found, 409 for a version conflict, 422 when the index is temporarily unavailable, or 503 for when the service is too busy.")
  @visibility(Lifecycle.Read)
  statusCode: int32;

  @doc("The name of the source at which the error originated. For example, this could refer to a particular skill in the attached skillset. This may not be always available.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Additional, verbose details about the error to assist in debugging the indexer. This may not be always available.")
  @visibility(Lifecycle.Read)
  details?: string;

  @doc("A link to a troubleshooting guide for these classes of errors. This may not be always available.")
  @visibility(Lifecycle.Read)
  documentationLink?: string;
}

@doc("Represents an item-level warning.")
model SearchIndexerWarning {
  @doc("The key of the item which generated a warning.")
  @visibility(Lifecycle.Read)
  key?: string;

  @doc("The message describing the warning that occurred while processing the item.")
  @visibility(Lifecycle.Read)
  message: string;

  @doc("The name of the source at which the warning originated. For example, this could refer to a particular skill in the attached skillset. This may not be always available.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Additional, verbose details about the warning to assist in debugging the indexer. This may not be always available.")
  @visibility(Lifecycle.Read)
  details?: string;

  @doc("A link to a troubleshooting guide for these classes of warnings. This may not be always available.")
  @visibility(Lifecycle.Read)
  documentationLink?: string;
}

@doc("Represents the limits that can be applied to an indexer.")
model SearchIndexerLimits {
  @doc("The maximum duration that the indexer is permitted to run for one execution.")
  @visibility(Lifecycle.Read)
  maxRunTime?: duration;

  @doc("The maximum size of a document, in bytes, which will be considered valid for indexing.")
  @visibility(Lifecycle.Read)
  maxDocumentExtractionSize?: int64;

  @doc("The maximum number of characters that will be extracted from a document picked up for indexing.")
  @visibility(Lifecycle.Read)
  maxDocumentContentCharactersToExtract?: int64;
}

@doc("Represents the indexer's cumulative runtime consumption in the service.")
model IndexerRuntime {
  @doc("Cumulative runtime of the indexer from the beginningTime to endingTime, in seconds.")
  usedSeconds: int64;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Cumulative runtime remaining for all indexers in the service from the beginningTime to endingTime, in seconds.")
  remainingSeconds?: int64 | null;

  @doc("Beginning UTC time of the 24-hour period considered for indexer runtime usage (inclusive).")
  beginningTime: utcDateTime;

  @doc("End UTC time of the 24-hour period considered for indexer runtime usage (inclusive).")
  endingTime: utcDateTime;
}

@doc("A list of skills.")
model SearchIndexerSkillset {
  @doc("The name of the skillset.")
  name: string;

  @doc("The description of the skillset.")
  description?: string;

  @doc("A list of skills in the skillset.")
  skills: SearchIndexerSkill[];

  @doc("Details about the Azure AI service to be used when running skills.")
  cognitiveServices?: CognitiveServicesAccount;

  @doc("Definition of additional projections to Azure blob, table, or files, of enriched data.")
  knowledgeStore?: SearchIndexerKnowledgeStore;

  @doc("Definition of additional projections to secondary search index(es).")
  indexProjections?: SearchIndexerIndexProjection;

  @doc("The ETag of the skillset.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A description of an encryption key that you create in Azure Key Vault. This key is used to provide an additional level of encryption-at-rest for your skillset definition when you want full assurance that no one, not even Microsoft, can decrypt your skillset definition. Once you have encrypted your skillset definition, it will always remain encrypted. The search service will ignore attempts to set this property to null. You can change this property as needed if you want to rotate your encryption key; Your skillset definition will be unaffected. Encryption with customer-managed keys is not available for free search services, and is only available for paid services created on or after January 1, 2019.")
  encryptionKey?: SearchResourceEncryptionKey | null;
}

@doc("Base type for skills.")
@discriminator("@odata.type")
model SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;

  @doc("The name of the skill which uniquely identifies it within the skillset. A skill with no name defined will be given a default name of its 1-based index in the skills array, prefixed with the character '#'.")
  name?: string;

  @doc("The description of the skill which describes the inputs, outputs, and usage of the skill.")
  description?: string;

  @doc("Represents the level at which operations take place, such as the document root or document content (for example, /document or /document/content). The default is /document.")
  context?: string;

  @doc("Inputs of the skills could be a column in the source data set, or the output of an upstream skill.")
  inputs: InputFieldMappingEntry[];

  @doc("The output of a skill is either a field in a search index, or a value that can be consumed as an input by another skill.")
  outputs: OutputFieldMappingEntry[];
}

@doc("Input field mapping for a skill.")
model InputFieldMappingEntry {
  @doc("The name of the input.")
  name: string;

  @doc("The source of the input.")
  source?: string;

  @doc("The source context used for selecting recursive inputs.")
  sourceContext?: string;

  @doc("The recursive inputs used when creating a complex type.")
  inputs?: InputFieldMappingEntry[];
}

@doc("Output field mapping for a skill.")
model OutputFieldMappingEntry {
  @doc("The name of the output defined by the skill.")
  name: string;

  @doc("The target name of the output. It is optional and default to name.")
  targetName?: string;
}

@doc("Base type for describing any Azure AI service resource attached to a skillset.")
@discriminator("@odata.type")
model CognitiveServicesAccount {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;

  @doc("Description of the Azure AI service resource attached to a skillset.")
  description?: string;
}

@doc("Definition of additional projections to azure blob, table, or files, of enriched data.")
model SearchIndexerKnowledgeStore {
  @doc("The connection string to the storage account projections will be stored in.")
  storageConnectionString: string;

  @doc("A list of additional projections to perform during indexing.")
  projections: SearchIndexerKnowledgeStoreProjection[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for connections to Azure Storage when writing knowledge store projections. If the connection string indicates an identity (ResourceId) and it's not specified, the system-assigned managed identity is used. On updates to the indexer, if the identity is unspecified, the value remains unchanged. If set to \"none\", the value of this property is cleared.")
  identity?: SearchIndexerDataIdentity | null;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("A dictionary of knowledge store-specific configuration properties. Each name is the name of a specific property. Each value must be of a primitive type.")
  parameters?: SearchIndexerKnowledgeStoreParameters;
}

@doc("Container object for various projection selectors.")
model SearchIndexerKnowledgeStoreProjection {
  @doc("Projections to Azure Table storage.")
  tables?: SearchIndexerKnowledgeStoreTableProjectionSelector[];

  @doc("Projections to Azure Blob storage.")
  objects?: SearchIndexerKnowledgeStoreObjectProjectionSelector[];

  @doc("Projections to Azure File storage.")
  files?: SearchIndexerKnowledgeStoreFileProjectionSelector[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Description for what data to store in Azure Tables.")
model SearchIndexerKnowledgeStoreTableProjectionSelector
  extends SearchIndexerKnowledgeStoreProjectionSelector {
  @doc("Name of generated key to store projection under.")
  generatedKeyName: string;

  @doc("Name of the Azure table to store projected data in.")
  tableName: string;
}

@doc("Abstract class to share properties between concrete selectors.")
model SearchIndexerKnowledgeStoreProjectionSelector {
  @doc("Name of reference key to different projection.")
  referenceKeyName?: string;

  @doc("Name of generated key to store projection under.")
  generatedKeyName?: string;

  @doc("Source data to project.")
  source?: string;

  @doc("Source context for complex projections.")
  sourceContext?: string;

  @doc("Nested inputs for complex projections.")
  inputs?: InputFieldMappingEntry[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Projection definition for what data to store in Azure Blob.")
model SearchIndexerKnowledgeStoreObjectProjectionSelector
  extends SearchIndexerKnowledgeStoreBlobProjectionSelector {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Abstract class to share properties between concrete selectors.")
model SearchIndexerKnowledgeStoreBlobProjectionSelector
  extends SearchIndexerKnowledgeStoreProjectionSelector {
  @doc("Blob container to store projections in.")
  storageContainer: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Projection definition for what data to store in Azure Files.")
model SearchIndexerKnowledgeStoreFileProjectionSelector
  extends SearchIndexerKnowledgeStoreBlobProjectionSelector {}

@doc("Definition of additional projections to secondary search indexes.")
model SearchIndexerIndexProjection {
  @doc("A list of projections to be performed to secondary search indexes.")
  selectors: SearchIndexerIndexProjectionSelector[];

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("A dictionary of index projection-specific configuration properties. Each name is the name of a specific property. Each value must be of a primitive type.")
  parameters?: SearchIndexerIndexProjectionsParameters;
}

@doc("Description for what data to store in the designated search index.")
model SearchIndexerIndexProjectionSelector {
  @doc("Name of the search index to project to. Must have a key field with the 'keyword' analyzer set.")
  targetIndexName: string;

  @doc("Name of the field in the search index to map the parent document's key value to. Must be a string field that is filterable and not the key field.")
  parentKeyFieldName: string;

  @doc("Source context for the projections. Represents the cardinality at which the document will be split into multiple sub documents.")
  sourceContext: string;

  @doc("Mappings for the projection, or which source should be mapped to which field in the target index.")
  mappings: InputFieldMappingEntry[];
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("A dictionary of index projection-specific configuration properties. Each name is the name of a specific property. Each value must be of a primitive type.")
model SearchIndexerIndexProjectionsParameters {
  ...Record<unknown>;

  @doc("Defines behavior of the index projections in relation to the rest of the indexer.")
  projectionMode?: IndexProjectionMode;
}

@doc("Response from a list skillset request. If successful, it includes the full definitions of all skillsets.")
model ListSkillsetsResult {
  @doc("The skillsets defined in the Search service.")
  @visibility(Lifecycle.Read)
  @pageItems
  value: SearchIndexerSkillset[];
}

#suppress "@azure-tools/typespec-client-generator-core/property-name-conflict"
@doc("The type of the skill names.")
model SkillNames {
  @doc("the names of skills to be reset.")
  skillNames?: string[];
}

@doc("Represents a synonym map definition.")
model SynonymMap {
  @doc("The name of the synonym map.")
  name: string;

  @doc("The format of the synonym map. Only the 'solr' format is currently supported.")
  format: "solr";

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("A series of synonym rules in the specified synonym map format. The rules must be separated by newlines.")
  @encode(ArrayEncoding.newlineDelimited)
  synonyms: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A description of an encryption key that you create in Azure Key Vault. This key is used to provide an additional level of encryption-at-rest for your data when you want full assurance that no one, not even Microsoft, can decrypt your data. Once you have encrypted your data, it will always remain encrypted. The search service will ignore attempts to set this property to null. You can change this property as needed if you want to rotate your encryption key; Your data will be unaffected. Encryption with customer-managed keys is not available for free search services, and is only available for paid services created on or after January 1, 2019.")
  encryptionKey?: SearchResourceEncryptionKey | null;

  @doc("The ETag of the synonym map.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;
}

@doc("Response from a List SynonymMaps request. If successful, it includes the full definitions of all synonym maps.")
model ListSynonymMapsResult {
  @doc("The synonym maps in the Search service.")
  @visibility(Lifecycle.Read)
  @pageItems
  value: SynonymMap[];
}

@doc("Represents a search index definition, which describes the fields and search behavior of an index.")
model SearchIndex {
  @doc("The name of the index.")
  name: string;

  @doc("The description of the index.")
  description?: string;

  @doc("The fields of the index.")
  fields: SearchField[];

  @doc("The scoring profiles for the index.")
  scoringProfiles?: ScoringProfile[];

  @doc("The name of the scoring profile to use if none is specified in the query. If this property is not set and no scoring profile is specified in the query, then default scoring (tf-idf) will be used.")
  defaultScoringProfile?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Options to control Cross-Origin Resource Sharing (CORS) for the index.")
  corsOptions?: CorsOptions | null;

  @doc("The suggesters for the index.")
  suggesters?: SearchSuggester[];

  @doc("The analyzers for the index.")
  analyzers?: LexicalAnalyzer[];

  @doc("The tokenizers for the index.")
  tokenizers?: LexicalTokenizer[];

  @doc("The token filters for the index.")
  tokenFilters?: TokenFilter[];

  @doc("The character filters for the index.")
  charFilters?: CharFilter[];

  @doc("The normalizers for the index.")
  normalizers?: LexicalNormalizer[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A description of an encryption key that you create in Azure Key Vault. This key is used to provide an additional level of encryption-at-rest for your data when you want full assurance that no one, not even Microsoft, can decrypt your data. Once you have encrypted your data, it will always remain encrypted. The search service will ignore attempts to set this property to null. You can change this property as needed if you want to rotate your encryption key; Your data will be unaffected. Encryption with customer-managed keys is not available for free search services, and is only available for paid services created on or after January 1, 2019.")
  encryptionKey?: SearchResourceEncryptionKey | null;

  @doc("The type of similarity algorithm to be used when scoring and ranking the documents matching a search query. The similarity algorithm can only be defined at index creation time and cannot be modified on existing indexes. If null, the ClassicSimilarity algorithm is used.")
  similarity?: SimilarityAlgorithm;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Defines parameters for a search index that influence semantic capabilities.")
  semantic?: SemanticSearch | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Contains configuration options related to vector search.")
  vectorSearch?: VectorSearch | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating whether permission filtering is enabled for the index.")
  permissionFilterOption?: SearchIndexPermissionFilterOption | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating whether Purview is enabled for the index.")
  purviewEnabled?: boolean | null;

  @doc("The ETag of the index.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;
}

@doc("Represents a field in an index definition, which describes the name, data type, and search behavior of a field.")
model SearchField {
  @doc("The name of the field, which must be unique within the fields collection of the index or parent field.")
  name: string;

  @doc("The data type of the field.")
  type: SearchFieldDataType;

  @doc("A value indicating whether the field uniquely identifies documents in the index. Exactly one top-level field in each index must be chosen as the key field and it must be of type Edm.String. Key fields can be used to look up documents directly and update or delete specific documents. Default is false for simple fields and null for complex fields.")
  key?: boolean;

  @doc("A value indicating whether the field can be returned in a search result. You can disable this option if you want to use a field (for example, margin) as a filter, sorting, or scoring mechanism but do not want the field to be visible to the end user. This property must be true for key fields, and it must be null for complex fields. This property can be changed on existing fields. Enabling this property does not cause any increase in index storage requirements. Default is true for simple fields, false for vector fields, and null for complex fields.")
  retrievable?: boolean;

  @doc("An immutable value indicating whether the field will be persisted separately on disk to be returned in a search result. You can disable this option if you don't plan to return the field contents in a search response to save on storage overhead. This can only be set during index creation and only for vector fields. This property cannot be changed for existing fields or set as false for new fields. If this property is set as false, the property 'retrievable' must also be set to false. This property must be true or unset for key fields, for new fields, and for non-vector fields, and it must be null for complex fields. Disabling this property will reduce index storage requirements. The default is true for vector fields.")
  stored?: boolean;

  @doc("A value indicating whether the field is full-text searchable. This means it will undergo analysis such as word-breaking during indexing. If you set a searchable field to a value like \"sunny day\", internally it will be split into the individual tokens \"sunny\" and \"day\". This enables full-text searches for these terms. Fields of type Edm.String or Collection(Edm.String) are searchable by default. This property must be false for simple fields of other non-string data types, and it must be null for complex fields. Note: searchable fields consume extra space in your index to accommodate additional tokenized versions of the field value for full-text searches. If you want to save space in your index and you don't need a field to be included in searches, set searchable to false.")
  searchable?: boolean;

  @doc("A value indicating whether to enable the field to be referenced in $filter queries. filterable differs from searchable in how strings are handled. Fields of type Edm.String or Collection(Edm.String) that are filterable do not undergo word-breaking, so comparisons are for exact matches only. For example, if you set such a field f to \"sunny day\", $filter=f eq 'sunny' will find no matches, but $filter=f eq 'sunny day' will. This property must be null for complex fields. Default is true for simple fields and null for complex fields.")
  filterable?: boolean;

  @doc("A value indicating whether to enable the field to be referenced in $orderby expressions. By default, the search engine sorts results by score, but in many experiences users will want to sort by fields in the documents. A simple field can be sortable only if it is single-valued (it has a single value in the scope of the parent document). Simple collection fields cannot be sortable, since they are multi-valued. Simple sub-fields of complex collections are also multi-valued, and therefore cannot be sortable. This is true whether it's an immediate parent field, or an ancestor field, that's the complex collection. Complex fields cannot be sortable and the sortable property must be null for such fields. The default for sortable is true for single-valued simple fields, false for multi-valued simple fields, and null for complex fields.")
  sortable?: boolean;

  @doc("A value indicating whether to enable the field to be referenced in facet queries. Typically used in a presentation of search results that includes hit count by category (for example, search for digital cameras and see hits by brand, by megapixels, by price, and so on). This property must be null for complex fields. Fields of type Edm.GeographyPoint or Collection(Edm.GeographyPoint) cannot be facetable. Default is true for all other simple fields.")
  facetable?: boolean;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating whether the field should be used as a permission filter.")
  permissionFilter?: PermissionFilter | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating whether the field contains sensitivity label information.")
  sensitivityLabel?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The name of the analyzer to use for the field. This option can be used only with searchable fields and it can't be set together with either searchAnalyzer or indexAnalyzer. Once the analyzer is chosen, it cannot be changed for the field. Must be null for complex fields.")
  analyzer?: LexicalAnalyzerName | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The name of the analyzer used at search time for the field. This option can be used only with searchable fields. It must be set together with indexAnalyzer and it cannot be set together with the analyzer option. This property cannot be set to the name of a language analyzer; use the analyzer property instead if you need a language analyzer. This analyzer can be updated on an existing field. Must be null for complex fields.")
  searchAnalyzer?: LexicalAnalyzerName | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The name of the analyzer used at indexing time for the field. This option can be used only with searchable fields. It must be set together with searchAnalyzer and it cannot be set together with the analyzer option.  This property cannot be set to the name of a language analyzer; use the analyzer property instead if you need a language analyzer. Once the analyzer is chosen, it cannot be changed for the field. Must be null for complex fields.")
  indexAnalyzer?: LexicalAnalyzerName | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The name of the normalizer to use for the field. This option can be used only with fields with filterable, sortable, or facetable enabled. Once the normalizer is chosen, it cannot be changed for the field. Must be null for complex fields.")
  normalizer?: LexicalNormalizerName | null;

  @doc("The dimensionality of the vector field.")
  @maxValue(4096)
  @minValue(2)
  dimensions?: int32;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The name of the vector search profile that specifies the algorithm and vectorizer to use when searching the vector field.")
  vectorSearchProfile?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The encoding format to interpret the field contents.")
  vectorEncoding?: VectorEncodingFormat | null;

  @doc("A list of the names of synonym maps to associate with this field. This option can be used only with searchable fields. Currently only one synonym map per field is supported. Assigning a synonym map to a field ensures that query terms targeting that field are expanded at query-time using the rules in the synonym map. This attribute can be changed on existing fields. Must be null or an empty collection for complex fields.")
  synonymMaps?: string[];

  @doc("A list of sub-fields if this is a field of type Edm.ComplexType or Collection(Edm.ComplexType). Must be null or empty for simple fields.")
  fields?: SearchField[];
}

@doc("Defines parameters for a search index that influence scoring in search queries.")
model ScoringProfile {
  @doc("The name of the scoring profile.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Parameters that boost scoring based on text matches in certain index fields.")
  text?: TextWeights | null;

  @doc("The collection of functions that influence the scoring of documents.")
  functions?: ScoringFunction[];

  @doc("A value indicating how the results of individual scoring functions should be combined. Defaults to \"Sum\". Ignored if there are no scoring functions.")
  functionAggregation?: ScoringFunctionAggregation;
}

@doc("Defines weights on index fields for which matches should boost scoring in search queries.")
model TextWeights {
  @doc("The dictionary of per-field weights to boost document scoring. The keys are field names and the values are the weights for each field.")
  weights: Record<float64>;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
@doc("Base type for functions that can modify document scores during ranking.")
@discriminator("type")
model ScoringFunction {
  @doc("The name of the field used as input to the scoring function.")
  fieldName: string;

  @doc("A multiplier for the raw score. Must be a positive number not equal to 1.0.")
  boost: float64;

  @doc("A value indicating how boosting will be interpolated across document scores; defaults to \"Linear\".")
  interpolation?: ScoringFunctionInterpolation;

  @doc("Type of ScoringFunction.")
  type: string;
}

@doc("Defines options to control Cross-Origin Resource Sharing (CORS) for an index.")
model CorsOptions {
  @doc("The list of origins from which JavaScript code will be granted access to your index. Can contain a list of hosts of the form {protocol}://{fully-qualified-domain-name}[:{port#}], or a single '*' to allow all origins (not recommended).")
  allowedOrigins: string[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The duration for which browsers should cache CORS preflight responses. Defaults to 5 minutes.")
  maxAgeInSeconds?: int64 | null;
}

@doc("Defines how the Suggest API should apply to a group of fields in the index.")
model SearchSuggester {
  @doc("The name of the suggester.")
  name: string;

  @doc("A value indicating the capabilities of the suggester.")
  searchMode: "analyzingInfixMatching";

  @doc("The list of field names to which the suggester applies. Each field must be searchable.")
  sourceFields: string[];
}

@doc("Base type for analyzers.")
@discriminator("@odata.type")
model LexicalAnalyzer {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;

  @doc("The name of the analyzer. It must only contain letters, digits, spaces, dashes or underscores, can only start and end with alphanumeric characters, and is limited to 128 characters.")
  name: string;
}

@doc("Base type for tokenizers.")
@discriminator("@odata.type")
model LexicalTokenizer {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;

  @doc("The name of the tokenizer. It must only contain letters, digits, spaces, dashes or underscores, can only start and end with alphanumeric characters, and is limited to 128 characters.")
  name: string;
}

@doc("Base type for token filters.")
@discriminator("@odata.type")
model TokenFilter {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;

  @doc("The name of the token filter. It must only contain letters, digits, spaces, dashes or underscores, can only start and end with alphanumeric characters, and is limited to 128 characters.")
  name: string;
}

@doc("Base type for character filters.")
@discriminator("@odata.type")
model CharFilter {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;

  @doc("The name of the char filter. It must only contain letters, digits, spaces, dashes or underscores, can only start and end with alphanumeric characters, and is limited to 128 characters.")
  name: string;
}

@doc("Base type for normalizers.")
@discriminator("@odata.type")
model LexicalNormalizer {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;

  @doc("The name of the char filter. It must only contain letters, digits, spaces, dashes or underscores, can only start and end with alphanumeric characters, and is limited to 128 characters.")
  name: string;
}

@doc("Base type for similarity algorithms. Similarity algorithms are used to calculate scores that tie queries to documents. The higher the score, the more relevant the document is to that specific query. Those scores are used to rank the search results.")
@discriminator("@odata.type")
model SimilarityAlgorithm {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: string;
}

@doc("Defines parameters for a search index that influence semantic capabilities.")
model SemanticSearch {
  @doc("Allows you to set the name of a default semantic configuration in your index, making it optional to pass it on as a query parameter every time.")
  defaultConfiguration?: string;

  @doc("The semantic configurations for the index.")
  configurations?: SemanticConfiguration[];
}

@doc("Defines a specific configuration to be used in the context of semantic capabilities.")
model SemanticConfiguration {
  @doc("The name of the semantic configuration.")
  name: string;

  @doc("Describes the title, content, and keyword fields to be used for semantic ranking, captions, highlights, and answers. At least one of the three sub properties (titleField, prioritizedKeywordsFields and prioritizedContentFields) need to be set.")
  prioritizedFields: SemanticPrioritizedFields;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Specifies the score type to be used for the sort order of the search results.")
  rankingOrder?: RankingOrder | null;

  @doc("Determines which semantic or query rewrite models to use during model flighting/upgrades.")
  flightingOptIn?: boolean = false;
}

@doc("Describes the title, content, and keywords fields to be used for semantic ranking, captions, highlights, and answers.")
model SemanticPrioritizedFields {
  @doc("Defines the title field to be used for semantic ranking, captions, highlights, and answers. If you don't have a title field in your index, leave this blank.")
  titleField?: SemanticField;

  @doc("Defines the content fields to be used for semantic ranking, captions, highlights, and answers. For the best result, the selected fields should contain text in natural language form. The order of the fields in the array represents their priority. Fields with lower priority may get truncated if the content is long.")
  prioritizedContentFields?: SemanticField[];

  @doc("Defines the keyword fields to be used for semantic ranking, captions, highlights, and answers. For the best result, the selected fields should contain a list of keywords. The order of the fields in the array represents their priority. Fields with lower priority may get truncated if the content is long.")
  prioritizedKeywordsFields?: SemanticField[];
}

@doc("A field that is used as part of the semantic configuration.")
model SemanticField {
  @doc("File name")
  fieldName: string;
}

@doc("Contains configuration options related to vector search.")
model VectorSearch {
  @doc("Defines combinations of configurations to use with vector search.")
  profiles?: VectorSearchProfile[];

  @doc("Contains configuration options specific to the algorithm used during indexing or querying.")
  algorithms?: VectorSearchAlgorithmConfiguration[];

  @doc("Contains configuration options on how to vectorize text vector queries.")
  vectorizers?: VectorSearchVectorizer[];

  @doc("Contains configuration options specific to the compression method used during indexing or querying.")
  compressions?: VectorSearchCompression[];
}

@doc("Defines a combination of configurations to use with vector search.")
model VectorSearchProfile {
  @doc("The name to associate with this particular vector search profile.")
  name: string;

  @doc("The name of the vector search algorithm configuration that specifies the algorithm and optional parameters.")
  algorithm: string;

  @doc("The name of the vectorization being configured for use with vector search.")
  vectorizer?: string;

  @doc("The name of the compression method configuration that specifies the compression method and optional parameters.")
  compression?: string;
}

@doc("Contains configuration options specific to the algorithm used during indexing or querying.")
@discriminator("kind")
model VectorSearchAlgorithmConfiguration {
  @doc("The name to associate with this particular configuration.")
  name: string;

  @doc("Type of VectorSearchAlgorithmConfiguration.")
  kind: VectorSearchAlgorithmKind;
}

@doc("Specifies the vectorization method to be used during query time.")
@discriminator("kind")
model VectorSearchVectorizer {
  @doc("The name to associate with this particular vectorization method.")
  name: string;

  @doc("Type of VectorSearchVectorizer.")
  kind: VectorSearchVectorizerKind;
}

@doc("Contains configuration options specific to the compression method used during indexing or querying.")
@discriminator("kind")
model VectorSearchCompression {
  @doc("The name to associate with this particular configuration.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Contains the options for rescoring.")
  rescoringOptions?: RescoringOptions | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The number of dimensions to truncate the vectors to. Truncating the vectors reduces the size of the vectors and the amount of data that needs to be transferred during search. This can save storage cost and improve search performance at the expense of recall. It should be only used for embeddings trained with Matryoshka Representation Learning (MRL) such as OpenAI text-embedding-3-large (small). The default value is null, which means no truncation.")
  truncationDimension?: int32 | null;

  @doc("Type of VectorSearchCompression.")
  kind: VectorSearchCompressionKind;
}

@doc("Contains the options for rescoring.")
model RescoringOptions {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("If set to true, after the initial search on the compressed vectors, the similarity scores are recalculated using the full-precision vectors. This will improve recall at the expense of latency.")
  enableRescoring?: boolean | null = true;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Default oversampling factor. Oversampling retrieves a greater set of potential documents to offset the resolution loss due to quantization. This increases the set of results that will be rescored on full-precision vectors. Minimum value is 1, meaning no oversampling (1x). This parameter can only be set when 'enableRescoring' is true. Higher values improve recall at the expense of latency.")
  defaultOversampling?: float64 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Controls the storage method for original vectors. This setting is immutable.")
  rescoreStorageMethod?: VectorSearchCompressionRescoreStorageMethod | null = VectorSearchCompressionRescoreStorageMethod.PreserveOriginals;
}

@doc("Response from a List Indexes request. If successful, it includes the full definitions of all indexes.")
model ListIndexesResult {
  @doc("The indexes in the Search service.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: SearchIndex[];
}

@doc("Statistics for a given index. Statistics are collected periodically and are not guaranteed to always be up-to-date.")
model GetIndexStatisticsResult {
  @doc("The number of documents in the index.")
  @visibility(Lifecycle.Read)
  documentCount: int64;

  @doc("The amount of storage in bytes consumed by the index.")
  @visibility(Lifecycle.Read)
  storageSize: int64;

  @doc("The amount of memory in bytes consumed by vectors in the index.")
  @visibility(Lifecycle.Read)
  vectorIndexSize: int64;
}

@doc("Specifies some text and analysis components used to break that text into tokens.")
model AnalyzeRequest {
  @doc("The text to break into tokens.")
  text: string;

  @doc("The name of the analyzer to use to break the given text. If this parameter is not specified, you must specify a tokenizer instead. The tokenizer and analyzer parameters are mutually exclusive.")
  analyzer?: LexicalAnalyzerName;

  @doc("The name of the tokenizer to use to break the given text. If this parameter is not specified, you must specify an analyzer instead. The tokenizer and analyzer parameters are mutually exclusive.")
  tokenizer?: LexicalTokenizerName;

  @doc("The name of the normalizer to use to normalize the given text.")
  normalizer?: LexicalNormalizerName;

  @doc("An optional list of token filters to use when breaking the given text. This parameter can only be set when using the tokenizer parameter.")
  tokenFilters?: TokenFilterName[];

  @doc("An optional list of character filters to use when breaking the given text. This parameter can only be set when using the tokenizer parameter.")
  charFilters?: CharFilterName[];
}

@doc("The result of testing an analyzer on text.")
model AnalyzeResult {
  @doc("The list of tokens returned by the analyzer specified in the request.")
  tokens: AnalyzedTokenInfo[];
}

@doc("Information about a token returned by an analyzer.")
model AnalyzedTokenInfo {
  @doc("The token returned by the analyzer.")
  @visibility(Lifecycle.Read)
  token: string;

  @doc("The index of the first character of the token in the input text.")
  @visibility(Lifecycle.Read)
  startOffset: int32;

  @doc("The index of the last character of the token in the input text.")
  @visibility(Lifecycle.Read)
  endOffset: int32;

  @doc("The position of the token in the input text relative to other tokens. The first token in the input text has position 0, the next has position 1, and so on. Depending on the analyzer used, some tokens might have the same position, for example if they are synonyms of each other.")
  @visibility(Lifecycle.Read)
  position: int32;
}

@doc("Represents an index alias, which describes a mapping from the alias name to an index. The alias name can be used in place of the index name for supported operations.")
model SearchAlias {
  @doc("The name of the alias.")
  name: string;

  @doc("The name of the index this alias maps to. Only one index name may be specified.")
  indexes: string[];

  @doc("The ETag of the alias.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;
}

@doc("Response from a List Aliases request. If successful, it includes the associated index mappings for all aliases.")
model ListAliasesResult {
  @doc("The aliases in the Search service.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: SearchAlias[];
}

// Knowledge Base models
@doc("Represents a knowledge base definition.")
model KnowledgeBase {
  @doc("The name of the knowledge base.")
  name: string;

  @doc("Knowledge sources referenced by this knowledge base.")
  knowledgeSources: KnowledgeSourceReference[];

  @doc("Contains configuration options on how to connect to AI models.")
  models?: KnowledgeBaseModel[];

  @doc("The retrieval reasoning effort configuration.")
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;

  @doc("The output mode for the knowledge base.")
  outputMode?: KnowledgeRetrievalOutputMode;

  @doc("The ETag of the knowledge base.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A description of an encryption key that you create in Azure Key Vault.")
  encryptionKey?: SearchResourceEncryptionKey | null;

  @doc("The description of the knowledge base.")
  description?: string;

  @doc("Instructions considered by the knowledge base when developing query plan.")
  retrievalInstructions?: string;

  @doc("Instructions considered by the knowledge base when generating answers.")
  answerInstructions?: string;
}

@doc("Result from listing knowledge bases.")
model ListKnowledgeBasesResult {
  @doc("The knowledge bases in the service.")
  @pageItems
  value: KnowledgeBase[];
}

@discriminator("kind")
@doc("Specifies the connection parameters for the model to use for query planning.")
model KnowledgeBaseModel {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The AI model to be used for query planning.")
  kind: KnowledgeBaseModelKind;
}

@doc("The AI model to be used for query planning.")
union KnowledgeBaseModelKind {
  string,

  @doc("Use Azure Open AI models for query planning.")
  AzureOpenAI: "azureOpenAI",
}

@doc("Specifies the Azure OpenAI resource used to do query planning.")
model KnowledgeBaseAzureOpenAIModel extends KnowledgeBaseModel {
  kind: KnowledgeBaseModelKind.AzureOpenAI;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("Azure OpenAI parameters.")
  azureOpenAIParameters: AzureOpenAIVectorizerParameters;
}

// Knowledge Source models
@doc("Reference to a knowledge source.")
model KnowledgeSourceReference {
  @doc("The name of the knowledge source.")
  name: string;
}

@doc("Specifies the parameters for connecting to the Azure OpenAI resource.")
model AzureOpenAiParameters {
  @doc("The resource URI of the Azure OpenAI resource.")
  resourceUri?: url;

  @doc("ID of the Azure OpenAI model deployment on the designated resource.")
  deploymentId?: string;

  @doc("API key of the designated Azure OpenAI resource.")
  apiKey?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for outbound connections.")
  authIdentity?: SearchIndexerDataIdentity | null;

  @doc("The name of the embedding model that is deployed at the provided deploymentId path.")
  modelName?: AzureOpenAIModelName;
}

// Knowledge Source models
@discriminator("kind")
@doc("Represents a knowledge source definition.")
model KnowledgeSource {
  @doc("The name of the knowledge source.")
  name: string;

  @doc("Optional user-defined description.")
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The type of the knowledge source.")
  kind: KnowledgeSourceKind;

  @doc("The ETag of the knowledge source.")
  @encodedName("application/json", "@odata.etag")
  eTag?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A description of an encryption key that you create in Azure Key Vault. This key is used to provide an additional level of encryption-at-rest for your knowledge source definition when you want full assurance that no one, not even Microsoft, can decrypt them. Once you have encrypted your knowledge source definition, it will always remain encrypted. The search service will ignore attempts to set this property to null. You can change this property as needed if you want to rotate your encryption key; Your knowledge source definition will be unaffected. Encryption with customer-managed keys is not available for free search services, and is only available for paid services created on or after January 1, 2019.")
  encryptionKey?: SearchResourceEncryptionKey | null;
}

@doc("The kind of the knowledge source.")
union KnowledgeSourceKind {
  string,

  @doc("A knowledge source that reads data from a Search Index.")
  SearchIndex: "searchIndex",

  @doc("A knowledge source that read and ingest data from Azure Blob Storage to a Search Index.")
  AzureBlob: "azureBlob",

  @doc("A knowledge source that reads data from indexed SharePoint.")
  IndexedSharePoint: "indexedSharePoint",

  @doc("A knowledge source that reads data from indexed OneLake.")
  IndexedOneLake: "indexedOneLake",

  @doc("A knowledge source that reads data from the web.")
  Web: "web",

  @doc("A knowledge source that reads data from remote SharePoint.")
  RemoteSharePoint: "remoteSharePoint",
}

@doc("Knowledge Source targeting a search index.")
model SearchIndexKnowledgeSource extends KnowledgeSource {
  kind: KnowledgeSourceKind.SearchIndex;

  @doc("The parameters for the knowledge source.")
  searchIndexParameters: SearchIndexKnowledgeSourceParameters;
}

@doc("Parameters for search index knowledge source.")
model SearchIndexKnowledgeSourceParameters {
  @doc("The name of the Search index.")
  searchIndexName: string;

  @doc("Used to request additional fields for referenced source data.")
  sourceDataFields?: SearchIndexFieldReference[];

  @doc("Used to restrict which fields to search on the search index.")
  searchFields?: SearchIndexFieldReference[];

  @doc("Used to specify a different semantic configuration on the target search index other than the default one.")
  semanticConfigurationName?: string;
}

@doc("Field reference for a search index.")
model SearchIndexFieldReference {
  @doc("The name of the field.")
  name: string;
}

@doc("Configuration for Azure Blob Storage knowledge source.")
model AzureBlobKnowledgeSource extends KnowledgeSource {
  kind: KnowledgeSourceKind.AzureBlob;

  @doc("The type of the knowledge source.")
  azureBlobParameters: AzureBlobKnowledgeSourceParameters;
}

@doc("Parameters for Azure Blob Storage knowledge source.")
model AzureBlobKnowledgeSourceParameters {
  @doc("Key-based connection string or the ResourceId format if using a managed identity.")
  connectionString: string;

  @doc("The name of the blob storage container.")
  containerName: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional folder path within the container.")
  folderPath?: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("Set to true if connecting to an ADLS Gen2 storage account. Default is false.")
  isADLSGen2?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Consolidates all general ingestion settings.")
  ingestionParameters?: KnowledgeSourceIngestionParameters | null;

  @doc("Resources created by the knowledge source.")
  @visibility(Lifecycle.Read)
  createdResources?: CreatedResources;
}

@doc("Configuration for SharePoint knowledge source.")
model IndexedSharePointKnowledgeSource extends KnowledgeSource {
  kind: KnowledgeSourceKind.IndexedSharePoint;

  @doc("The parameters for the knowledge source.")
  indexedSharePointParameters: IndexedSharePointKnowledgeSourceParameters;
}

@doc("Parameters for SharePoint knowledge source.")
model IndexedSharePointKnowledgeSourceParameters {
  @doc("SharePoint connection string with format: SharePointOnlineEndpoint=[SharePoint site url];ApplicationId=[Azure AD App ID];ApplicationSecret=[Azure AD App client secret];TenantId=[SharePoint site tenant id]")
  connectionString: string;

  @doc("Specifies which SharePoint libraries to access.")
  containerName: IndexedSharePointContainerName;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional query to filter SharePoint content.")
  query?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Consolidates all general ingestion settings.")
  ingestionParameters?: KnowledgeSourceIngestionParameters | null;

  @doc("Resources created by the knowledge source.")
  @visibility(Lifecycle.Read)
  createdResources?: CreatedResources;
}

@doc("Configuration for OneLake knowledge source.")
model IndexedOneLakeKnowledgeSource extends KnowledgeSource {
  kind: KnowledgeSourceKind.IndexedOneLake;

  @doc("The parameters for the knowledge source.")
  indexedOneLakeParameters: IndexedOneLakeKnowledgeSourceParameters;
}

@doc("Parameters for OneLake knowledge source.")
model IndexedOneLakeKnowledgeSourceParameters {
  @doc("OneLake workspace ID.")
  fabricWorkspaceId: string;

  @doc("Specifies which OneLake lakehouse to access.")
  lakehouseId: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional OneLakehouse folder or shortcut to filter OneLake content.")
  targetPath?: string | null;

  @doc("Consolidates all general ingestion settings.")
  ingestionParameters?: KnowledgeSourceIngestionParameters;

  @doc("Resources created by the knowledge source.")
  @visibility(Lifecycle.Read)
  createdResources?: CreatedResources;
}

@doc("Knowledge Source targeting web results.")
model WebKnowledgeSource extends KnowledgeSource {
  kind: KnowledgeSourceKind.Web;

  @doc("The parameters for the web knowledge source.")
  webParameters?: WebKnowledgeSourceParameters;
}

@doc("Parameters for web knowledge source.")
model WebKnowledgeSourceParameters {
  @doc("Domain allow/block configuration for web results.")
  domains?: WebKnowledgeSourceDomains;
}

@doc("Domain allow/block configuration for web knowledge source.")
model WebKnowledgeSourceDomains {
  @doc("Domains that are allowed for web results.")
  allowedDomains?: WebKnowledgeSourceDomain[];

  @doc("Domains that are blocked from web results.")
  blockedDomains?: WebKnowledgeSourceDomain[];
}

@doc("Configuration for web knowledge source domain.")
model WebKnowledgeSourceDomain {
  @doc("The address of the domain.")
  address: string;

  @doc("Whether or not to include subpages from this domain.")
  includeSubpages?: boolean;
}

@doc("Configuration for remote SharePoint knowledge source.")
model RemoteSharePointKnowledgeSource extends KnowledgeSource {
  kind: KnowledgeSourceKind.RemoteSharePoint;

  @doc("The parameters for the remote SharePoint knowledge source.")
  remoteSharePointParameters?: RemoteSharePointKnowledgeSourceParameters;
}

@doc("Parameters for remote SharePoint knowledge source.")
model RemoteSharePointKnowledgeSourceParameters {
  @doc("Keyword Query Language (KQL) expression with queryable SharePoint properties and attributes to scope the retrieval before the query runs.")
  filterExpression?: string;

  @doc("A list of metadata fields to be returned for each item in the response. Only retrievable metadata properties can be included in this list. By default, no metadata is returned.")
  resourceMetadata?: string[];

  @doc("Container ID for SharePoint Embedded connection. When this is null, it will use SharePoint Online.")
  containerTypeId?: string;
}

@doc("Result from listing knowledge sources.")
model ListKnowledgeSourcesResult {
  @doc("The knowledge sources in the service.")
  @pageItems
  value: KnowledgeSource[];
}

@doc("Resources created by the knowledge source. Keys represent resource types (e.g., 'datasource', 'indexer', 'skillset', 'index') and values represent resource names.")
model CreatedResources {
  ...Record<string>;
}

@doc("Response from a get service statistics request. If successful, it includes service level counters and limits.")
model SearchServiceStatistics {
  @doc("Service level resource counters.")
  counters: SearchServiceCounters;

  @doc("Service level general limits.")
  limits: SearchServiceLimits;

  @doc("Service level indexer runtime consumption.")
  indexersRuntime: ServiceIndexersRuntime;
}

@doc("Represents service-level resource counters and quotas.")
model SearchServiceCounters {
  @doc("Total number of aliases.")
  aliasesCount: ResourceCounter;

  @doc("Total number of documents across all indexes in the service.")
  documentCount: ResourceCounter;

  @doc("Total number of indexes.")
  indexesCount: ResourceCounter;

  @doc("Total number of indexers.")
  indexersCount: ResourceCounter;

  @doc("Total number of data sources.")
  dataSourcesCount: ResourceCounter;

  @doc("Total size of used storage in bytes.")
  storageSize: ResourceCounter;

  @doc("Total number of synonym maps.")
  synonymMaps: ResourceCounter;

  @doc("Total number of skillsets.")
  skillsetCount: ResourceCounter;

  @doc("Total memory consumption of all vector indexes within the service, in bytes.")
  vectorIndexSize: ResourceCounter;
}

@doc("Represents a resource's usage and quota.")
model ResourceCounter {
  @doc("The resource usage amount.")
  usage: int64;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The resource amount quota.")
  quota?: int64 | null;
}

@doc("Represents various service level limits.")
model SearchServiceLimits {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum allowed fields per index.")
  maxFieldsPerIndex?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum depth which you can nest sub-fields in an index, including the top-level complex field. For example, a/b/c has a nesting depth of 3.")
  maxFieldNestingDepthPerIndex?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum number of fields of type Collection(Edm.ComplexType) allowed in an index.")
  maxComplexCollectionFieldsPerIndex?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum number of objects in complex collections allowed per document.")
  maxComplexObjectsInCollectionsPerDocument?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum amount of storage in bytes allowed per index.")
  maxStoragePerIndex?: int64 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum cumulative indexer runtime in seconds allowed for the service.")
  maxCumulativeIndexerRuntimeSeconds?: int64 | null;
}

@doc("Represents service-level indexer runtime counters.")
model ServiceIndexersRuntime {
  @doc("Cumulative runtime of all indexers in the service from the beginningTime to endingTime, in seconds.")
  usedSeconds: int64;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Cumulative runtime remaining for all indexers in the service from the beginningTime to endingTime, in seconds.")
  remainingSeconds?: int64 | null;

  @doc("Beginning UTC time of the 24-hour period considered for indexer runtime usage (inclusive).")
  beginningTime: utcDateTime;

  @doc("End UTC time of the 24-hour period considered for indexer runtime usage (inclusive).")
  endingTime: utcDateTime;
}

@doc("Allows you to take control over the process of converting text into indexable/searchable tokens. It's a user-defined configuration consisting of a single predefined tokenizer and one or more filters. The tokenizer is responsible for breaking text into tokens, and the filters for modifying tokens emitted by the tokenizer.")
model CustomAnalyzer extends LexicalAnalyzer {
  @doc("The name of the tokenizer to use to divide continuous text into a sequence of tokens, such as breaking a sentence into words.")
  tokenizer: LexicalTokenizerName;

  @doc("A list of token filters used to filter out or modify the tokens generated by a tokenizer. For example, you can specify a lowercase filter that converts all characters to lowercase. The filters are run in the order in which they are listed.")
  tokenFilters?: TokenFilterName[];

  @doc("A list of character filters used to prepare input text before it is processed by the tokenizer. For instance, they can replace certain characters or symbols. The filters are run in the order in which they are listed.")
  charFilters?: CharFilterName[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of analyzer.")
  `@odata.type`: "#Microsoft.Azure.Search.CustomAnalyzer";
}

@doc("Flexibly separates text into terms via a regular expression pattern. This analyzer is implemented using Apache Lucene.")
model PatternAnalyzer extends LexicalAnalyzer {
  @doc("A value indicating whether terms should be lower-cased. Default is true.")
  lowercase?: boolean = true;

  @doc("A regular expression pattern to match token separators. Default is an expression that matches one or more non-word characters.")
  pattern?: string = "\\W+";

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("Regular expression flags.")
  @encode(ArrayEncoding.pipeDelimited)
  flags?: RegexFlags;

  @doc("A list of stopwords.")
  stopwords?: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of analyzer.")
  `@odata.type`: "#Microsoft.Azure.Search.PatternAnalyzer";
}

@doc("Standard Apache Lucene analyzer; Composed of the standard tokenizer, lowercase filter and stop filter.")
model LuceneStandardAnalyzer extends LexicalAnalyzer {
  @doc("The maximum token length. Default is 255. Tokens longer than the maximum length are split. The maximum token length that can be used is 300 characters.")
  @maxValue(300)
  maxTokenLength?: int32 = 255;

  @doc("A list of stopwords.")
  stopwords?: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of analyzer.")
  `@odata.type`: "#Microsoft.Azure.Search.StandardAnalyzer";
}

@doc("Divides text at non-letters; Applies the lowercase and stopword token filters. This analyzer is implemented using Apache Lucene.")
model StopAnalyzer extends LexicalAnalyzer {
  @doc("A list of stopwords.")
  stopwords?: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of analyzer.")
  `@odata.type`: "#Microsoft.Azure.Search.StopAnalyzer";
}

@doc("Allows you to configure normalization for filterable, sortable, and facetable fields, which by default operate with strict matching. This is a user-defined configuration consisting of at least one or more filters, which modify the token that is stored.")
model CustomNormalizer extends LexicalNormalizer {
  @doc("A list of token filters used to filter out or modify the input token. For example, you can specify a lowercase filter that converts all characters to lowercase. The filters are run in the order in which they are listed.")
  tokenFilters?: TokenFilterName[];

  @doc("A list of character filters used to prepare input text before it is processed. For instance, they can replace certain characters or symbols. The filters are run in the order in which they are listed.")
  charFilters?: CharFilterName[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of normalizer.")
  `@odata.type`: "#Microsoft.Azure.Search.CustomNormalizer";
}

@doc("Grammar-based tokenizer that is suitable for processing most European-language documents. This tokenizer is implemented using Apache Lucene.")
model ClassicTokenizer extends LexicalTokenizer {
  @doc("The maximum token length. Default is 255. Tokens longer than the maximum length are split. The maximum token length that can be used is 300 characters.")
  @maxValue(300)
  maxTokenLength?: int32 = 255;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.ClassicTokenizer";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Tokenizes the input from an edge into n-grams of the given size(s). This tokenizer is implemented using Apache Lucene.")
model EdgeNGramTokenizer extends LexicalTokenizer {
  @doc("The minimum n-gram length. Default is 1. Maximum is 300. Must be less than the value of maxGram.")
  @maxValue(300)
  minGram?: int32 = 1;

  @doc("The maximum n-gram length. Default is 2. Maximum is 300.")
  @maxValue(300)
  maxGram?: int32 = 2;

  @doc("Character classes to keep in the tokens.")
  tokenChars?: TokenCharacterKind[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.EdgeNGramTokenizer";
}

#deprecated "Use KeywordTokenizerV2 instead."
@doc("Emits the entire input as a single token. This tokenizer is implemented using Apache Lucene.")
model KeywordTokenizer extends LexicalTokenizer {
  @doc("The read buffer size in bytes. Default is 256.")
  bufferSize?: int32 = 256;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.KeywordTokenizer";
}

@doc("Emits the entire input as a single token. This tokenizer is implemented using Apache Lucene.")
model KeywordTokenizerV2 extends LexicalTokenizer {
  @doc("The maximum token length. Default is 256. Tokens longer than the maximum length are split. The maximum token length that can be used is 300 characters.")
  @maxValue(300)
  maxTokenLength?: int32 = 256;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.KeywordTokenizerV2";
}

@doc("Divides text using language-specific rules.")
model MicrosoftLanguageTokenizer extends LexicalTokenizer {
  @doc("The maximum token length. Tokens longer than the maximum length are split. Maximum token length that can be used is 300 characters. Tokens longer than 300 characters are first split into tokens of length 300 and then each of those tokens is split based on the max token length set. Default is 255.")
  @maxValue(300)
  maxTokenLength?: int32 = 255;

  @doc("A value indicating how the tokenizer is used. Set to true if used as the search tokenizer, set to false if used as the indexing tokenizer. Default is false.")
  isSearchTokenizer?: boolean = false;

  @doc("The language to use. The default is English.")
  language?: MicrosoftTokenizerLanguage;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.MicrosoftLanguageTokenizer";
}

@doc("Divides text using language-specific rules and reduces words to their base forms.")
model MicrosoftLanguageStemmingTokenizer extends LexicalTokenizer {
  @doc("The maximum token length. Tokens longer than the maximum length are split. Maximum token length that can be used is 300 characters. Tokens longer than 300 characters are first split into tokens of length 300 and then each of those tokens is split based on the max token length set. Default is 255.")
  @maxValue(300)
  maxTokenLength?: int32 = 255;

  @doc("A value indicating how the tokenizer is used. Set to true if used as the search tokenizer, set to false if used as the indexing tokenizer. Default is false.")
  isSearchTokenizer?: boolean = false;

  @doc("The language to use. The default is English.")
  language?: MicrosoftStemmingTokenizerLanguage;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.MicrosoftLanguageStemmingTokenizer";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Tokenizes the input into n-grams of the given size(s). This tokenizer is implemented using Apache Lucene.")
model NGramTokenizer extends LexicalTokenizer {
  @doc("The minimum n-gram length. Default is 1. Maximum is 300. Must be less than the value of maxGram.")
  @maxValue(300)
  minGram?: int32 = 1;

  @doc("The maximum n-gram length. Default is 2. Maximum is 300.")
  @maxValue(300)
  maxGram?: int32 = 2;

  @doc("Character classes to keep in the tokens.")
  tokenChars?: TokenCharacterKind[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.NGramTokenizer";
}

@doc("Tokenizer for path-like hierarchies. This tokenizer is implemented using Apache Lucene.")
model PathHierarchyTokenizerV2 extends LexicalTokenizer {
  @doc("The delimiter character to use. Default is \"/\".")
  @maxLength(1)
  delimiter?: string = "/";

  @doc("A value that, if set, replaces the delimiter character. Default is \"/\".")
  @maxLength(1)
  replacement?: string = "/";

  @doc("The maximum token length. Default and maximum is 300.")
  @maxValue(300)
  maxTokenLength?: int32 = 300;

  @doc("A value indicating whether to generate tokens in reverse order. Default is false.")
  reverse?: boolean = false;

  @doc("The number of initial tokens to skip. Default is 0.")
  skip?: int32 = 0;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.PathHierarchyTokenizerV2";
}

@doc("Tokenizer that uses regex pattern matching to construct distinct tokens. This tokenizer is implemented using Apache Lucene.")
model PatternTokenizer extends LexicalTokenizer {
  @doc("A regular expression pattern to match token separators. Default is an expression that matches one or more non-word characters.")
  pattern?: string = "\\W+";

  @doc("Regular expression flags.")
  flags?: RegexFlags;

  @doc("The zero-based ordinal of the matching group in the regular expression pattern to extract into tokens. Use -1 if you want to use the entire pattern to split the input into tokens, irrespective of matching groups. Default is -1.")
  group?: int32 = -1;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.PatternTokenizer";
}

#deprecated "LuceneStandardTokenizer is deprecated. Use LuceneStandardTokenizerV2 instead."
@doc("Breaks text following the Unicode Text Segmentation rules. This tokenizer is implemented using Apache Lucene.")
model LuceneStandardTokenizer extends LexicalTokenizer {
  @doc("The maximum token length. Default is 255. Tokens longer than the maximum length are split.")
  maxTokenLength?: int32 = 255;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.StandardTokenizer";
}

@doc("Breaks text following the Unicode Text Segmentation rules. This tokenizer is implemented using Apache Lucene.")
model LuceneStandardTokenizerV2 extends LexicalTokenizer {
  @doc("The maximum token length. Default is 255. Tokens longer than the maximum length are split. The maximum token length that can be used is 300 characters.")
  @maxValue(300)
  maxTokenLength?: int32 = 255;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.StandardTokenizerV2";
}

@doc("Tokenizes urls and emails as one token. This tokenizer is implemented using Apache Lucene.")
model UaxUrlEmailTokenizer extends LexicalTokenizer {
  @doc("The maximum token length. Default is 255. Tokens longer than the maximum length are split. The maximum token length that can be used is 300 characters.")
  @maxValue(300)
  maxTokenLength?: int32 = 255;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of tokenizer.")
  `@odata.type`: "#Microsoft.Azure.Search.UaxUrlEmailTokenizer";
}

@doc("Converts alphabetic, numeric, and symbolic Unicode characters which are not in the first 127 ASCII characters (the \"Basic Latin\" Unicode block) into their ASCII equivalents, if such equivalents exist. This token filter is implemented using Apache Lucene.")
model AsciiFoldingTokenFilter extends TokenFilter {
  @doc("A value indicating whether the original token will be kept. Default is false.")
  preserveOriginal?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.AsciiFoldingTokenFilter";
}

@doc("Forms bigrams of CJK terms that are generated from the standard tokenizer. This token filter is implemented using Apache Lucene.")
model CjkBigramTokenFilter extends TokenFilter {
  @doc("The scripts to ignore.")
  ignoreScripts?: CjkBigramTokenFilterScripts[];

  @doc("A value indicating whether to output both unigrams and bigrams (if true), or just bigrams (if false). Default is false.")
  outputUnigrams?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.CjkBigramTokenFilter";
}

@doc("Construct bigrams for frequently occurring terms while indexing. Single terms are still indexed too, with bigrams overlaid. This token filter is implemented using Apache Lucene.")
model CommonGramTokenFilter extends TokenFilter {
  @doc("The set of common words.")
  commonWords: string[];

  @doc("A value indicating whether common words matching will be case insensitive. Default is false.")
  ignoreCase?: boolean = false;

  @doc("A value that indicates whether the token filter is in query mode. When in query mode, the token filter generates bigrams and then removes common words and single terms followed by a common word. Default is false.")
  queryMode?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.CommonGramTokenFilter";
}

@doc("Decomposes compound words found in many Germanic languages. This token filter is implemented using Apache Lucene.")
model DictionaryDecompounderTokenFilter extends TokenFilter {
  @doc("The list of words to match against.")
  wordList: string[];

  @doc("The minimum word size. Only words longer than this get processed. Default is 5. Maximum is 300.")
  @maxValue(300)
  minWordSize?: int32 = 5;

  @doc("The minimum subword size. Only subwords longer than this are outputted. Default is 2. Maximum is 300.")
  @maxValue(300)
  minSubwordSize?: int32 = 2;

  @doc("The maximum subword size. Only subwords shorter than this are outputted. Default is 15. Maximum is 300.")
  @maxValue(300)
  maxSubwordSize?: int32 = 15;

  @doc("A value indicating whether to add only the longest matching subword to the output. Default is false.")
  onlyLongestMatch?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.DictionaryDecompounderTokenFilter";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
#deprecated "EdgeNGramTokenFilter is deprecated. Use EdgeNGramTokenFilterV2 instead."
@doc("Generates n-grams of the given size(s) starting from the front or the back of an input token. This token filter is implemented using Apache Lucene.")
model EdgeNGramTokenFilter extends TokenFilter {
  @doc("The minimum n-gram length. Default is 1. Must be less than the value of maxGram.")
  minGram?: int32 = 1;

  @doc("The maximum n-gram length. Default is 2.")
  maxGram?: int32 = 2;

  @doc("Specifies which side of the input the n-gram should be generated from. Default is \"front\".")
  side?: EdgeNGramTokenFilterSide = EdgeNGramTokenFilterSide.Front;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.EdgeNGramTokenFilter";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Generates n-grams of the given size(s) starting from the front or the back of an input token. This token filter is implemented using Apache Lucene.")
model EdgeNGramTokenFilterV2 extends TokenFilter {
  @doc("The minimum n-gram length. Default is 1. Maximum is 300. Must be less than the value of maxGram.")
  @maxValue(300)
  minGram?: int32 = 1;

  @doc("The maximum n-gram length. Default is 2. Maximum is 300.")
  @maxValue(300)
  maxGram?: int32 = 2;

  @doc("Specifies which side of the input the n-gram should be generated from. Default is \"front\".")
  side?: EdgeNGramTokenFilterSide = EdgeNGramTokenFilterSide.Front;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.EdgeNGramTokenFilterV2";
}

@doc("Removes elisions. For example, \"l'avion\" (the plane) will be converted to \"avion\" (plane). This token filter is implemented using Apache Lucene.")
model ElisionTokenFilter extends TokenFilter {
  @doc("The set of articles to remove.")
  articles?: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.ElisionTokenFilter";
}

@doc("A token filter that only keeps tokens with text contained in a specified list of words. This token filter is implemented using Apache Lucene.")
model KeepTokenFilter extends TokenFilter {
  @doc("The list of words to keep.")
  keepWords: string[];

  @doc("A value indicating whether to lower case all words first. Default is false.")
  keepWordsCase?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.KeepTokenFilter";
}

@doc("Marks terms as keywords. This token filter is implemented using Apache Lucene.")
model KeywordMarkerTokenFilter extends TokenFilter {
  @doc("A list of words to mark as keywords.")
  keywords: string[];

  @doc("A value indicating whether to ignore case. If true, all words are converted to lower case first. Default is false.")
  ignoreCase?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.KeywordMarkerTokenFilter";
}

@doc("Removes words that are too long or too short. This token filter is implemented using Apache Lucene.")
model LengthTokenFilter extends TokenFilter {
  @doc("The minimum length in characters. Default is 0. Maximum is 300. Must be less than the value of max.")
  @maxValue(300)
  min?: int32 = 0;

  @doc("The maximum length in characters. Default and maximum is 300.")
  @maxValue(300)
  max?: int32 = 300;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.LengthTokenFilter";
}

@doc("Limits the number of tokens while indexing. This token filter is implemented using Apache Lucene.")
model LimitTokenFilter extends TokenFilter {
  @doc("The maximum number of tokens to produce. Default is 1.")
  maxTokenCount?: int32 = 1;

  @doc("A value indicating whether all tokens from the input must be consumed even if maxTokenCount is reached. Default is false.")
  consumeAllTokens?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.LimitTokenFilter";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
#deprecated "NGramTokenFilter is deprecated. Use NGramTokenFilterV2 instead."
@doc("Generates n-grams of the given size(s). This token filter is implemented using Apache Lucene.")
model NGramTokenFilter extends TokenFilter {
  @doc("The minimum n-gram length. Default is 1. Must be less than the value of maxGram.")
  minGram?: int32 = 1;

  @doc("The maximum n-gram length. Default is 2.")
  maxGram?: int32 = 2;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.NGramTokenFilter";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Generates n-grams of the given size(s). This token filter is implemented using Apache Lucene.")
model NGramTokenFilterV2 extends TokenFilter {
  @doc("The minimum n-gram length. Default is 1. Maximum is 300. Must be less than the value of maxGram.")
  @maxValue(300)
  minGram?: int32 = 1;

  @doc("The maximum n-gram length. Default is 2. Maximum is 300.")
  @maxValue(300)
  maxGram?: int32 = 2;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.NGramTokenFilterV2";
}

@doc("Uses Java regexes to emit multiple tokens - one for each capture group in one or more patterns. This token filter is implemented using Apache Lucene.")
model PatternCaptureTokenFilter extends TokenFilter {
  @doc("A list of patterns to match against each token.")
  patterns: string[];

  @doc("A value indicating whether to return the original token even if one of the patterns matches. Default is true.")
  preserveOriginal?: boolean = true;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.PatternCaptureTokenFilter";
}

@doc("A character filter that replaces characters in the input string. It uses a regular expression to identify character sequences to preserve and a replacement pattern to identify characters to replace. For example, given the input text \"aa bb aa bb\", pattern \"(aa)\\s+(bb)\", and replacement \"$1#$2\", the result would be \"aa#bb aa#bb\". This token filter is implemented using Apache Lucene.")
model PatternReplaceTokenFilter extends TokenFilter {
  @doc("A regular expression pattern.")
  pattern: string;

  @doc("The replacement text.")
  replacement: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.PatternReplaceTokenFilter";
}

@doc("Create tokens for phonetic matches. This token filter is implemented using Apache Lucene.")
model PhoneticTokenFilter extends TokenFilter {
  @doc("The phonetic encoder to use. Default is \"metaphone\".")
  encoder?: PhoneticEncoder = PhoneticEncoder.Metaphone;

  @doc("A value indicating whether encoded tokens should replace original tokens. If false, encoded tokens are added as synonyms. Default is true.")
  replace?: boolean = true;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.PhoneticTokenFilter";
}

@doc("Creates combinations of tokens as a single token. This token filter is implemented using Apache Lucene.")
model ShingleTokenFilter extends TokenFilter {
  @doc("The maximum shingle size. Default and minimum value is 2.")
  @minValue(2)
  maxShingleSize?: int32 = 2;

  @doc("The minimum shingle size. Default and minimum value is 2. Must be less than the value of maxShingleSize.")
  @minValue(2)
  minShingleSize?: int32 = 2;

  @doc("A value indicating whether the output stream will contain the input tokens (unigrams) as well as shingles. Default is true.")
  outputUnigrams?: boolean = true;

  @doc("A value indicating whether to output unigrams for those times when no shingles are available. This property takes precedence when outputUnigrams is set to false. Default is false.")
  outputUnigramsIfNoShingles?: boolean = false;

  @doc("The string to use when joining adjacent tokens to form a shingle. Default is a single space (\" \").")
  tokenSeparator?: string = " ";

  @doc("The string to insert for each position at which there is no token. Default is an underscore (\"_\").")
  filterToken?: string = "_";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.ShingleTokenFilter";
}

@doc("A filter that stems words using a Snowball-generated stemmer. This token filter is implemented using Apache Lucene.")
model SnowballTokenFilter extends TokenFilter {
  @doc("The language to use.")
  language: SnowballTokenFilterLanguage;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.SnowballTokenFilter";
}

@doc("Language specific stemming filter. This token filter is implemented using Apache Lucene. See https://learn.microsoft.com/rest/api/searchservice/Custom-analyzers-in-Azure-Search#TokenFilters")
model StemmerTokenFilter extends TokenFilter {
  @doc("The language to use.")
  language: StemmerTokenFilterLanguage;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.StemmerTokenFilter";
}

@doc("Provides the ability to override other stemming filters with custom dictionary-based stemming. Any dictionary-stemmed terms will be marked as keywords so that they will not be stemmed with stemmers down the chain. Must be placed before any stemming filters. This token filter is implemented using Apache Lucene. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/miscellaneous/StemmerOverrideFilter.html")
model StemmerOverrideTokenFilter extends TokenFilter {
  @doc("A list of stemming rules in the following format: \"word => stem\", for example: \"ran => run\".")
  rules: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.StemmerOverrideTokenFilter";
}

@doc("Removes stop words from a token stream. This token filter is implemented using Apache Lucene. See http://lucene.apache.org/core/4_10_3/analyzers-common/org/apache/lucene/analysis/core/StopFilter.html")
model StopwordsTokenFilter extends TokenFilter {
  @doc("The list of stopwords. This property and the stopwords list property cannot both be set.")
  stopwords?: string[];

  @doc("A predefined list of stopwords to use. This property and the stopwords property cannot both be set. Default is English.")
  stopwordsList?: StopwordsList = StopwordsList.English;

  @doc("A value indicating whether to ignore case. If true, all words are converted to lower case first. Default is false.")
  ignoreCase?: boolean = false;

  @doc("A value indicating whether to ignore the last search term if it's a stop word. Default is true.")
  removeTrailing?: boolean = true;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.StopwordsTokenFilter";
}

@doc("Matches single or multi-word synonyms in a token stream. This token filter is implemented using Apache Lucene.")
model SynonymTokenFilter extends TokenFilter {
  @doc("A list of synonyms in following one of two formats: 1. incredible, unbelievable, fabulous => amazing - all terms on the left side of => symbol will be replaced with all terms on its right side; 2. incredible, unbelievable, fabulous, amazing - comma separated list of equivalent words. Set the expand option to change how this list is interpreted.")
  synonyms: string[];

  @doc("A value indicating whether to case-fold input for matching. Default is false.")
  ignoreCase?: boolean = false;

  @doc("A value indicating whether all words in the list of synonyms (if => notation is not used) will map to one another. If true, all words in the list of synonyms (if => notation is not used) will map to one another. The following list: incredible, unbelievable, fabulous, amazing is equivalent to: incredible, unbelievable, fabulous, amazing => incredible, unbelievable, fabulous, amazing. If false, the following list: incredible, unbelievable, fabulous, amazing will be equivalent to: incredible, unbelievable, fabulous, amazing => incredible. Default is true.")
  expand?: boolean = true;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.SynonymTokenFilter";
}

@doc("Truncates the terms to a specific length. This token filter is implemented using Apache Lucene.")
model TruncateTokenFilter extends TokenFilter {
  @doc("The length at which terms will be truncated. Default and maximum is 300.")
  @maxValue(300)
  length?: int32 = 300;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.TruncateTokenFilter";
}

@doc("Filters out tokens with same text as the previous token. This token filter is implemented using Apache Lucene.")
model UniqueTokenFilter extends TokenFilter {
  @doc("A value indicating whether to remove duplicates only at the same position. Default is false.")
  onlyOnSamePosition?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.UniqueTokenFilter";
}

@doc("Splits words into subwords and performs optional transformations on subword groups. This token filter is implemented using Apache Lucene.")
model WordDelimiterTokenFilter extends TokenFilter {
  @doc("A value indicating whether to generate part words. If set, causes parts of words to be generated; for example \"AzureSearch\" becomes \"Azure\" \"Search\". Default is true.")
  generateWordParts?: boolean = true;

  @doc("A value indicating whether to generate number subwords. Default is true.")
  generateNumberParts?: boolean = true;

  @doc("A value indicating whether maximum runs of word parts will be catenated. For example, if this is set to true, \"Azure-Search\" becomes \"AzureSearch\". Default is false.")
  catenateWords?: boolean = false;

  @doc("A value indicating whether maximum runs of number parts will be catenated. For example, if this is set to true, \"1-2\" becomes \"12\". Default is false.")
  catenateNumbers?: boolean = false;

  @doc("A value indicating whether all subword parts will be catenated. For example, if this is set to true, \"Azure-Search-1\" becomes \"AzureSearch1\". Default is false.")
  catenateAll?: boolean = false;

  @doc("A value indicating whether to split words on caseChange. For example, if this is set to true, \"AzureSearch\" becomes \"Azure\" \"Search\". Default is true.")
  splitOnCaseChange?: boolean = true;

  @doc("A value indicating whether original words will be preserved and added to the subword list. Default is false.")
  preserveOriginal?: boolean = false;

  @doc("A value indicating whether to split on numbers. For example, if this is set to true, \"Azure1Search\" becomes \"Azure\" \"1\" \"Search\". Default is true.")
  splitOnNumerics?: boolean = true;

  @doc("A value indicating whether to remove trailing \"'s\" for each subword. Default is true.")
  stemEnglishPossessive?: boolean = true;

  @doc("A list of tokens to protect from being delimited.")
  protectedWords?: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of token filter.")
  `@odata.type`: "#Microsoft.Azure.Search.WordDelimiterTokenFilter";
}

@doc("A character filter that applies mappings defined with the mappings option. Matching is greedy (longest pattern matching at a given point wins). Replacement is allowed to be the empty string. This character filter is implemented using Apache Lucene.")
model MappingCharFilter extends CharFilter {
  @doc("A list of mappings of the following format: \"a=>b\" (all occurrences of the character \"a\" will be replaced with character \"b\").")
  mappings: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of char filter.")
  `@odata.type`: "#Microsoft.Azure.Search.MappingCharFilter";
}

@doc("A character filter that replaces characters in the input string. It uses a regular expression to identify character sequences to preserve and a replacement pattern to identify characters to replace. For example, given the input text \"aa bb aa bb\", pattern \"(aa)\\s+(bb)\", and replacement \"$1#$2\", the result would be \"aa#bb aa#bb\". This character filter is implemented using Apache Lucene.")
model PatternReplaceCharFilter extends CharFilter {
  @doc("A regular expression pattern.")
  pattern: string;

  @doc("The replacement text.")
  replacement: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of char filter.")
  `@odata.type`: "#Microsoft.Azure.Search.PatternReplaceCharFilter";
}

@doc("Legacy similarity algorithm which uses the Lucene TFIDFSimilarity implementation of TF-IDF. This variation of TF-IDF introduces static document length normalization as well as coordinating factors that penalize documents that only partially match the searched queries.")
model ClassicSimilarityAlgorithm extends SimilarityAlgorithm {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: "#Microsoft.Azure.Search.ClassicSimilarity";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Ranking function based on the Okapi BM25 similarity algorithm. BM25 is a TF-IDF-like algorithm that includes length normalization (controlled by the 'b' parameter) as well as term frequency saturation (controlled by the 'k1' parameter).")
model BM25SimilarityAlgorithm extends SimilarityAlgorithm {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("This property controls the scaling function between the term frequency of each matching terms and the final relevance score of a document-query pair. By default, a value of 1.2 is used. A value of 0.0 means the score does not scale with an increase in term frequency.")
  k1?: float64 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("This property controls how the length of a document affects the relevance score. By default, a value of 0.75 is used. A value of 0.0 means no length normalization is applied, while a value of 1.0 means the score is fully normalized by the length of the document.")
  b?: float64 | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: "#Microsoft.Azure.Search.BM25Similarity";
}

@doc("Contains configuration options specific to the HNSW approximate nearest neighbors algorithm used during indexing and querying. The HNSW algorithm offers a tunable trade-off between search speed and accuracy.")
model HnswAlgorithmConfiguration extends VectorSearchAlgorithmConfiguration {
  @doc("Contains the parameters specific to HNSW algorithm.")
  hnswParameters?: HnswParameters;

  @doc("The name of the kind of algorithm being configured for use with vector search.")
  kind: "hnsw";
}

@doc("Contains the parameters specific to the HNSW algorithm.")
model HnswParameters {
  @doc("The number of bi-directional links created for every new element during construction. Increasing this parameter value may improve recall and reduce retrieval times for datasets with high intrinsic dimensionality at the expense of increased memory consumption and longer indexing time.")
  @maxValue(10)
  @minValue(4)
  m?: int32 = 4;

  @doc("The size of the dynamic list containing the nearest neighbors, which is used during index time. Increasing this parameter may improve index quality, at the expense of increased indexing time. At a certain point, increasing this parameter leads to diminishing returns.")
  @maxValue(1000)
  @minValue(100)
  efConstruction?: int32 = 400;

  @doc("The size of the dynamic list containing the nearest neighbors, which is used during search time. Increasing this parameter may improve search results, at the expense of slower search. At a certain point, increasing this parameter leads to diminishing returns.")
  @maxValue(1000)
  @minValue(100)
  efSearch?: int32 = 500;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The similarity metric to use for vector comparisons.")
  metric?: VectorSearchAlgorithmMetric | null;
}

@doc("Contains configuration options specific to the exhaustive KNN algorithm used during querying, which will perform brute-force search across the entire vector index.")
model ExhaustiveKnnAlgorithmConfiguration
  extends VectorSearchAlgorithmConfiguration {
  @doc("Contains the parameters specific to exhaustive KNN algorithm.")
  exhaustiveKnnParameters?: ExhaustiveKnnParameters;

  @doc("The name of the kind of algorithm being configured for use with vector search.")
  kind: "exhaustiveKnn";
}

@doc("Contains the parameters specific to exhaustive KNN algorithm.")
model ExhaustiveKnnParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The similarity metric to use for vector comparisons.")
  metric?: VectorSearchAlgorithmMetric | null;
}

@doc("Contains configuration options specific to the scalar quantization compression method used during indexing and querying.")
model ScalarQuantizationCompression extends VectorSearchCompression {
  @doc("Contains the parameters specific to Scalar Quantization.")
  scalarQuantizationParameters?: ScalarQuantizationParameters;

  @doc("The name of the kind of compression method being configured for use with vector search.")
  kind: "scalarQuantization";
}

@doc("Contains the parameters specific to Scalar Quantization.")
model ScalarQuantizationParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The quantized data type of compressed vector values.")
  quantizedDataType?: VectorSearchCompressionTarget | null;
}

@doc("Contains configuration options specific to the binary quantization compression method used during indexing and querying.")
model BinaryQuantizationCompression extends VectorSearchCompression {
  @doc("The name of the kind of compression method being configured for use with vector search.")
  kind: "binaryQuantization";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Specifies the Azure OpenAI resource used to vectorize a query string.")
model AzureOpenAIVectorizer extends VectorSearchVectorizer {
  @doc("Contains the parameters specific to Azure OpenAI embedding vectorization.")
  azureOpenAIParameters?: AzureOpenAIVectorizerParameters;

  @doc("The name of the kind of vectorization method being configured for use with vector search.")
  kind: "azureOpenAI";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Specifies the parameters for connecting to the Azure OpenAI resource.")
model AzureOpenAIVectorizerParameters {
  @doc("The resource URI of the Azure OpenAI resource.")
  resourceUri?: url;

  @doc("ID of the Azure OpenAI model deployment on the designated resource.")
  deploymentId?: string;

  @doc("API key of the designated Azure OpenAI resource.")
  apiKey?: string;

  @doc("The user-assigned managed identity used for outbound connections.")
  authIdentity?: SearchIndexerDataIdentity;

  @doc("The name of the embedding model that is deployed at the provided deploymentId path.")
  modelName?: AzureOpenAIModelName;
}

@doc("Abstract base type for data identities.")
@discriminator("@odata.type")
model SearchIndexerDataIdentity {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of identity.")
  `@odata.type`: string;
}

@doc("Specifies a user-defined vectorizer for generating the vector embedding of a query string. Integration of an external vectorizer is achieved using the custom Web API interface of a skillset.")
model WebApiVectorizer extends VectorSearchVectorizer {
  @doc("Specifies the properties of the user-defined vectorizer.")
  customWebApiParameters?: WebApiVectorizerParameters;

  @doc("The name of the kind of vectorization method being configured for use with vector search.")
  kind: "customWebApi";
}

@doc("Specifies the properties for connecting to a user-defined vectorizer.")
model WebApiVectorizerParameters {
  @doc("The URI of the Web API providing the vectorizer.")
  uri?: url;

  @doc("The headers required to make the HTTP request.")
  httpHeaders?: Record<string>;

  @doc("The method for the HTTP request.")
  httpMethod?: string;

  @doc("The desired timeout for the request. Default is 30 seconds.")
  timeout?: duration;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Applies to custom endpoints that connect to external code in an Azure function or some other application that provides the transformations. This value should be the application ID created for the function or app when it was registered with Azure Active Directory. When specified, the vectorization connects to the function or app using a managed ID (either system or user-assigned) of the search service and the access token of the function or app, using this value as the resource id for creating the scope of the access token.")
  authResourceId?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for outbound connections. If an authResourceId is provided and it's not specified, the system-assigned managed identity is used. On updates to the indexer, if the identity is unspecified, the value remains unchanged. If set to \"none\", the value of this property is cleared.")
  authIdentity?: SearchIndexerDataIdentity | null;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Clears the identity property of a datasource.")
model AIServicesVisionVectorizer extends VectorSearchVectorizer {
  @doc("Contains the parameters specific to AI Services Vision embedding vectorization.")
  aiServicesVisionParameters?: AIServicesVisionParameters;

  @doc("The name of the kind of vectorization method being configured for use with vector search.")
  kind: "aiServicesVision";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Specifies the AI Services Vision parameters for vectorizing a query image or text.")
model AIServicesVisionParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the AI Services Vision service. It will default to the latest available when not specified.")
  modelVersion: string | null;

  @doc("The resource URI of the AI Services resource.")
  resourceUri: url;

  @doc("API key of the designated AI Services resource.")
  apiKey?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for outbound connections. If an authResourceId is provided and it's not specified, the system-assigned managed identity is used. On updates to the index, if the identity is unspecified, the value remains unchanged. If set to \"none\", the value of this property is cleared.")
  authIdentity?: SearchIndexerDataIdentity | null;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Specifies an Azure Machine Learning endpoint deployed via the Azure AI Foundry Model Catalog for generating the vector embedding of a query string.")
model AMLVectorizer extends VectorSearchVectorizer {
  @doc("Specifies the properties of the AML vectorizer.")
  amlParameters?: AMLParameters;

  @doc("The name of the kind of vectorization method being configured for use with vector search.")
  kind: "aml";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Specifies the properties for connecting to an AML vectorizer.")
model AMLParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Required for no authentication or key authentication) The scoring URI of the AML service to which the JSON payload will be sent. Only the https URI scheme is allowed.")
  uri: url | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Required for key authentication) The key for the AML service.")
  key?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Required for token authentication). The Azure Resource Manager resource ID of the AML service. It should be in the format subscriptions/{guid}/resourceGroups/{resource-group-name}/Microsoft.MachineLearningServices/workspaces/{workspace-name}/services/{service_name}.")
  resourceId?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Optional) When specified, indicates the timeout for the http client making the API call.")
  timeout?: duration | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Optional for token authentication). The region the AML service is deployed in.")
  region?: string | null;

  @doc("The name of the embedding model from the Azure AI Foundry Catalog that is deployed at the provided endpoint.")
  modelName?: AIFoundryModelCatalogName;
}

@doc("Clears the identity property of a datasource.")
model SearchIndexerDataNoneIdentity extends SearchIndexerDataIdentity {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("The discriminator for derived types.")
  `@odata.type`: "#Microsoft.Azure.Search.DataNoneIdentity";
}

@doc("Specifies the identity for a datasource to use.")
model SearchIndexerDataUserAssignedIdentity extends SearchIndexerDataIdentity {
  @doc("The fully qualified Azure resource Id of a user assigned managed identity typically in the form \"/subscriptions/12345678-1234-1234-1234-1234567890ab/resourceGroups/rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId\" that should have been assigned to the search service.")
  userAssignedIdentity: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of identity.")
  `@odata.type`: "#Microsoft.Azure.Search.DataUserAssignedIdentity";
}

@doc("Defines a data change detection policy that captures changes based on the value of a high water mark column.")
model HighWaterMarkChangeDetectionPolicy extends DataChangeDetectionPolicy {
  @doc("The name of the high water mark column.")
  highWaterMarkColumnName: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of data change detection policy.")
  `@odata.type`: "#Microsoft.Azure.Search.HighWaterMarkChangeDetectionPolicy";
}

@doc("Defines a data change detection policy that captures changes using the Integrated Change Tracking feature of Azure SQL Database.")
model SqlIntegratedChangeTrackingPolicy extends DataChangeDetectionPolicy {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of data change detection policy.")
  `@odata.type`: "#Microsoft.Azure.Search.SqlIntegratedChangeTrackingPolicy";
}

@doc("Defines a data deletion detection policy that implements a soft-deletion strategy. It determines whether an item should be deleted based on the value of a designated 'soft delete' column.")
model SoftDeleteColumnDeletionDetectionPolicy
  extends DataDeletionDetectionPolicy {
  @doc("The name of the column to use for soft-deletion detection.")
  softDeleteColumnName?: string;

  @doc("The marker value that identifies an item as deleted.")
  softDeleteMarkerValue?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of data deletion detection policy.")
  `@odata.type`: "#Microsoft.Azure.Search.SoftDeleteColumnDeletionDetectionPolicy";
}

@doc("Defines a data deletion detection policy utilizing Azure Blob Storage's native soft delete feature for deletion detection.")
model NativeBlobSoftDeleteDeletionDetectionPolicy
  extends DataDeletionDetectionPolicy {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of data deletion detection policy.")
  `@odata.type`: "#Microsoft.Azure.Search.NativeBlobSoftDeleteDeletionDetectionPolicy";
}

@doc("Defines a function that boosts scores based on distance from a geographic location.")
model DistanceScoringFunction extends ScoringFunction {
  @doc("Parameter values for the distance scoring function.")
  distance: DistanceScoringParameters;

  @doc("Indicates the type of function to use. Valid values include magnitude, freshness, distance, and tag. The function type must be lower case.")
  type: "distance";
}

@doc("Provides parameter values to a distance scoring function.")
model DistanceScoringParameters {
  @doc("The name of the parameter passed in search queries to specify the reference location.")
  referencePointParameter: string;

  @doc("The distance in kilometers from the reference location where the boosting range ends.")
  boostingDistance: float64;
}

@doc("Defines a function that boosts scores based on the value of a date-time field.")
model FreshnessScoringFunction extends ScoringFunction {
  @doc("Parameter values for the freshness scoring function.")
  freshness: FreshnessScoringParameters;

  @doc("Indicates the type of function to use. Valid values include magnitude, freshness, distance, and tag. The function type must be lower case.")
  type: "freshness";
}

@doc("Provides parameter values to a freshness scoring function.")
model FreshnessScoringParameters {
  @doc("The expiration period after which boosting will stop for a particular document.")
  boostingDuration: duration;
}

@doc("Defines a function that boosts scores based on the magnitude of a numeric field.")
model MagnitudeScoringFunction extends ScoringFunction {
  @doc("Parameter values for the magnitude scoring function.")
  magnitude: MagnitudeScoringParameters;

  @doc("Indicates the type of function to use. Valid values include magnitude, freshness, distance, and tag. The function type must be lower case.")
  type: "magnitude";
}

@doc("Provides parameter values to a magnitude scoring function.")
model MagnitudeScoringParameters {
  @doc("The field value at which boosting starts.")
  boostingRangeStart: float64;

  @doc("The field value at which boosting ends.")
  boostingRangeEnd: float64;

  @doc("A value indicating whether to apply a constant boost for field values beyond the range end value; default is false.")
  constantBoostBeyondRange?: boolean;
}

@doc("Defines a function that boosts scores of documents with string values matching a given list of tags.")
model TagScoringFunction extends ScoringFunction {
  @doc("Parameter values for the tag scoring function.")
  tag: TagScoringParameters;

  @doc("Indicates the type of function to use. Valid values include magnitude, freshness, distance, and tag. The function type must be lower case.")
  type: "tag";
}

@doc("Provides parameter values to a tag scoring function.")
model TagScoringParameters {
  @doc("The name of the parameter passed in search queries to specify the list of tags to compare against the target field.")
  tagsParameter: string;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("A dictionary of knowledge store-specific configuration properties. Each name is the name of a specific property. Each value must be of a primitive type.")
model SearchIndexerKnowledgeStoreParameters {
  ...Record<unknown>;

  @doc("Whether or not projections should synthesize a generated key name if one isn't already present.")
  synthesizeGeneratedKeyName?: boolean = false;
}

@doc("An empty object that represents the default Azure AI service resource for a skillset.")
model DefaultCognitiveServicesAccount extends CognitiveServicesAccount {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of Azure AI service resource attached to a skillset.")
  `@odata.type`: "#Microsoft.Azure.Search.DefaultCognitiveServices";
}

@doc("The multi-region account key of an Azure AI service resource that's attached to a skillset.")
model CognitiveServicesAccountKey extends CognitiveServicesAccount {
  @doc("The key used to provision the Azure AI service resource attached to a skillset.")
  key: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of Azure AI service resource attached to a skillset.")
  `@odata.type`: "#Microsoft.Azure.Search.CognitiveServicesByKey";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("The account key of an Azure AI service resource that's attached to a skillset, to be used with the resource's subdomain.")
model AIServicesAccountKey extends CognitiveServicesAccount {
  @doc("The key used to provision the Azure AI service resource attached to a skillset.")
  key: string;

  @doc("The subdomain url for the corresponding AI Service.")
  subdomainUrl: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of Azure AI service resource attached to a skillset.")
  `@odata.type`: "#Microsoft.Azure.Search.AIServicesByKey";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("The multi-region account of an Azure AI service resource that's attached to a skillset.")
model AIServicesAccountIdentity extends CognitiveServicesAccount {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for connections to AI Service. If not specified, the system-assigned managed identity is used. On updates to the skillset, if the identity is unspecified, the value remains unchanged. If set to \"none\", the value of this property is cleared.")
  identity?: SearchIndexerDataIdentity | null;

  @doc("The subdomain url for the corresponding AI Service.")
  subdomainUrl: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of Azure AI service resource attached to a skillset.")
  `@odata.type`: "#Microsoft.Azure.Search.AIServicesByIdentity";
}

@doc("An object that contains information about the matches that were found, and related metadata.")
model CustomEntity {
  @doc("The top-level entity descriptor. Matches in the skill output will be grouped by this name, and it should represent the \"normalized\" form of the text being found.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("This field can be used as a passthrough for custom metadata about the matched text(s). The value of this field will appear with every match of its entity in the skill output.")
  description?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("This field can be used as a passthrough for custom metadata about the matched text(s). The value of this field will appear with every match of its entity in the skill output.")
  type?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("This field can be used as a passthrough for custom metadata about the matched text(s). The value of this field will appear with every match of its entity in the skill output.")
  subtype?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("This field can be used as a passthrough for custom metadata about the matched text(s). The value of this field will appear with every match of its entity in the skill output.")
  id?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Defaults to false. Boolean value denoting whether comparisons with the entity name should be sensitive to character casing. Sample case insensitive matches of \"Microsoft\" could be: microsoft, microSoft, MICROSOFT.")
  caseSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Defaults to false. Boolean value denoting whether comparisons with the entity name should be sensitive to accent.")
  accentSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Defaults to 0. Maximum value of 5. Denotes the acceptable number of divergent characters that would still constitute a match with the entity name. The smallest possible fuzziness for any given match is returned. For instance, if the edit distance is set to 3, \"Windows10\" would still match \"Windows\", \"Windows10\" and \"Windows 7\". When case sensitivity is set to false, case differences do NOT count towards fuzziness tolerance, but otherwise do.")
  fuzzyEditDistance?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Changes the default case sensitivity value for this entity. It be used to change the default value of all aliases caseSensitive values.")
  defaultCaseSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Changes the default accent sensitivity value for this entity. It be used to change the default value of all aliases accentSensitive values.")
  defaultAccentSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Changes the default fuzzy edit distance value for this entity. It can be used to change the default value of all aliases fuzzyEditDistance values.")
  defaultFuzzyEditDistance?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("An array of complex objects that can be used to specify alternative spellings or synonyms to the root entity name.")
  aliases?: CustomEntityAlias[] | null;
}

@doc("A complex object that can be used to specify alternative spellings or synonyms to the root entity name.")
model CustomEntityAlias {
  @doc("The text of the alias.")
  text: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Determine if the alias is case sensitive.")
  caseSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Determine if the alias is accent sensitive.")
  accentSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Determine the fuzzy edit distance of the alias.")
  fuzzyEditDistance?: int32 | null;
}

@doc("A skill that enables scenarios that require a Boolean operation to determine the data to assign to an output.")
model ConditionalSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Util.ConditionalSkill";
}

@doc("A skill that uses text analytics for key phrase extraction.")
model KeyPhraseExtractionSkill extends SearchIndexerSkill {
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: KeyPhraseExtractionSkillLanguage;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A number indicating how many key phrases to return. If absent, all identified key phrases will be returned.")
  maxKeyPhraseCount?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the Text Analytics service. It will default to the latest available when not specified. We recommend you do not specify this value unless absolutely necessary.")
  modelVersion?: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.KeyPhraseExtractionSkill";
}

@doc("A skill that extracts text from image files.")
model OcrSkill extends SearchIndexerSkill {
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: OcrSkillLanguage;

  @doc("A value indicating to turn orientation detection on or not. Default is false.")
  detectOrientation?: boolean = false;

  @doc("Defines the sequence of characters to use between the lines of text recognized by the OCR skill. The default value is \"space\".")
  lineEnding?: OcrLineEnding;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Vision.OcrSkill";
}

@doc("A skill that analyzes image files. It extracts a rich set of visual features based on the image content.")
model ImageAnalysisSkill extends SearchIndexerSkill {
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: ImageAnalysisSkillLanguage;

  @doc("A list of visual features.")
  visualFeatures?: VisualFeature[];

  @doc("A string indicating which domain-specific details to return.")
  details?: ImageDetail[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Vision.ImageAnalysisSkill";
}

@doc("A skill that detects the language of input text and reports a single language code for every document submitted on the request. The language code is paired with a score indicating the confidence of the analysis.")
model LanguageDetectionSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A country code to use as a hint to the language detection model if it cannot disambiguate the language.")
  defaultCountryHint?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the Text Analytics service. It will default to the latest available when not specified. We recommend you do not specify this value unless absolutely necessary.")
  modelVersion?: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.LanguageDetectionSkill";
}

@doc("A skill for reshaping the outputs. It creates a complex type to support composite fields (also known as multipart fields).")
model ShaperSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Util.ShaperSkill";
}

@doc("A skill for merging two or more strings into a single unified string, with an optional user-defined delimiter separating each component part.")
model MergeSkill extends SearchIndexerSkill {
  @doc("The tag indicates the start of the merged text. By default, the tag is an empty space.")
  insertPreTag?: string = " ";

  @doc("The tag indicates the end of the merged text. By default, the tag is an empty space.")
  insertPostTag?: string = " ";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.MergeSkill";
}

@doc("This skill is deprecated. Use the V3.EntityRecognitionSkill instead.")
model EntityRecognitionSkill extends SearchIndexerSkill {
  @doc("A list of entity categories that should be extracted.")
  categories?: EntityCategory[];

  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: EntityRecognitionSkillLanguage;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Determines whether or not to include entities which are well known but don't conform to a pre-defined type. If this configuration is not set (default), set to null or set to false, entities which don't conform to one of the pre-defined types will not be surfaced.")
  includeTypelessEntities?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value between 0 and 1 that be used to only include entities whose confidence score is greater than the value specified. If not set (default), or if explicitly set to null, all entities will be included.")
  minimumPrecision?: float64 | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.EntityRecognitionSkill";
}

@doc("This skill is deprecated. Use the V3.SentimentSkill instead.")
model SentimentSkill extends SearchIndexerSkill {
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: SentimentSkillLanguage;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.SentimentSkill";
}

@doc("Using the Text Analytics API, evaluates unstructured text and for each record, provides sentiment labels (such as \"negative\", \"neutral\" and \"positive\") based on the highest confidence score found by the service at a sentence and document-level.")
model SentimentSkillV3 extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: string | null;

  @doc("If set to true, the skill output will include information from Text Analytics for opinion mining, namely targets (nouns or verbs) and their associated assessment (adjective) in the text. Default is false.")
  includeOpinionMining?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the Text Analytics service. It will default to the latest available when not specified. We recommend you do not specify this value unless absolutely necessary.")
  modelVersion?: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.V3.SentimentSkill";
}

@doc("Using the Text Analytics API, extracts linked entities from text.")
model EntityLinkingSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: string | null;

  @doc("A value between 0 and 1 that be used to only include entities whose confidence score is greater than the value specified. If not set (default), or if explicitly set to null, all entities will be included.")
  @minValue(0)
  @maxValue(1)
  minimumPrecision?: float64;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the Text Analytics service. It will default to the latest available when not specified. We recommend you do not specify this value unless absolutely necessary.")
  modelVersion?: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.V3.EntityLinkingSkill";
}

@doc("Using the Text Analytics API, extracts entities of different types from text.")
model EntityRecognitionSkillV3 extends SearchIndexerSkill {
  @doc("A list of entity categories that should be extracted.")
  categories?: string[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: string | null;

  @doc("A value between 0 and 1 that be used to only include entities whose confidence score is greater than the value specified. If not set (default), or if explicitly set to null, all entities will be included.")
  @minValue(0)
  @maxValue(1)
  minimumPrecision?: float64;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the Text Analytics API. It will default to the latest available when not specified. We recommend you do not specify this value unless absolutely necessary.")
  modelVersion?: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.V3.EntityRecognitionSkill";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Using the Text Analytics API, extracts personal information from an input text and gives you the option of masking it.")
model PIIDetectionSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: string | null;

  @doc("A value between 0 and 1 that be used to only include entities whose confidence score is greater than the value specified. If not set (default), or if explicitly set to null, all entities will be included.")
  @minValue(0)
  @maxValue(1)
  minimumPrecision?: float64;

  @doc("A parameter that provides various ways to mask the personal information detected in the input text. Default is 'none'.")
  maskingMode?: PIIDetectionSkillMaskingMode;

  @doc("The character used to mask the text if the maskingMode parameter is set to replace. Default is '*'.")
  @maxLength(1)
  maskingCharacter?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the Text Analytics service. It will default to the latest available when not specified. We recommend you do not specify this value unless absolutely necessary.")
  modelVersion?: string | null;

  @doc("A list of PII entity categories that should be extracted and masked.")
  piiCategories?: string[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("If specified, will set the PII domain to include only a subset of the entity categories. Possible values include: 'phi', 'none'. Default is 'none'.")
  domain?: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.PIIDetectionSkill";
}

@doc("A skill to split a string into chunks of text.")
model SplitSkill extends SearchIndexerSkill {
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: SplitSkillLanguage;

  @doc("A value indicating which split mode to perform.")
  textSplitMode?: TextSplitMode;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The desired maximum page length. Default is 10000.")
  maximumPageLength?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Only applicable when textSplitMode is set to 'pages'. If specified, n+1th chunk will start with this number of characters/tokens from the end of the nth chunk.")
  pageOverlapLength?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Only applicable when textSplitMode is set to 'pages'. If specified, the SplitSkill will discontinue splitting after processing the first 'maximumPagesToTake' pages, in order to improve performance when only a few initial pages are needed from each document.")
  maximumPagesToTake?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Only applies if textSplitMode is set to pages. There are two possible values. The choice of the values will decide the length (maximumPageLength and pageOverlapLength) measurement. The default is 'characters', which means the length will be measured by character.")
  unit?: SplitSkillUnit | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("Only applies if the unit is set to azureOpenAITokens. If specified, the splitSkill will use these parameters when performing the tokenization. The parameters are a valid 'encoderModelName' and an optional 'allowedSpecialTokens' property.")
  azureOpenAITokenizerParameters?: AzureOpenAITokenizerParameters | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.SplitSkill";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Azure OpenAI Tokenizer parameters.")
model AzureOpenAITokenizerParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Only applies if the unit is set to azureOpenAITokens. Options include 'R50k_base', 'P50k_base', 'P50k_edit' and 'CL100k_base'. The default value is 'CL100k_base'.")
  encoderModelName?: SplitSkillEncoderModelName | null;

  @doc("(Optional) Only applies if the unit is set to azureOpenAITokens. This parameter defines a collection of special tokens that are permitted within the tokenization process.")
  allowedSpecialTokens?: string[];
}

@doc("A skill looks for text from a custom, user-defined list of words and phrases.")
model CustomEntityLookupSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A value indicating which language code to use. Default is `en`.")
  defaultLanguageCode?: CustomEntityLookupSkillLanguage | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Path to a JSON or CSV file containing all the target text to match against. This entity definition is read at the beginning of an indexer run. Any updates to this file during an indexer run will not take effect until subsequent runs. This config must be accessible over HTTPS.")
  entitiesDefinitionUri?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The inline CustomEntity definition.")
  inlineEntitiesDefinition?: CustomEntity[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A global flag for CaseSensitive. If CaseSensitive is not set in CustomEntity, this value will be the default value.")
  globalDefaultCaseSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A global flag for AccentSensitive. If AccentSensitive is not set in CustomEntity, this value will be the default value.")
  globalDefaultAccentSensitive?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A global flag for FuzzyEditDistance. If FuzzyEditDistance is not set in CustomEntity, this value will be the default value.")
  globalDefaultFuzzyEditDistance?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.CustomEntityLookupSkill";
}

@doc("A skill to translate text from one language to another.")
model TextTranslationSkill extends SearchIndexerSkill {
  @doc("The language code to translate documents into for documents that don't specify the to language explicitly.")
  defaultToLanguageCode: TextTranslationSkillLanguage;

  @doc("The language code to translate documents from for documents that don't specify the from language explicitly.")
  defaultFromLanguageCode?: TextTranslationSkillLanguage;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The language code to translate documents from when neither the fromLanguageCode input nor the defaultFromLanguageCode parameter are provided, and the automatic language detection is unsuccessful. Default is `en`.")
  suggestedFrom?: TextTranslationSkillLanguage | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.TranslationSkill";
}

@doc("A skill that extracts content from a file within the enrichment pipeline.")
model DocumentExtractionSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The parsingMode for the skill. Will be set to 'default' if not defined.")
  parsingMode?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The type of data to be extracted for the skill. Will be set to 'contentAndMetadata' if not defined.")
  dataToExtract?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("A dictionary of configurations for the skill.")
  configuration?: Record<unknown> | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Util.DocumentExtractionSkill";
}

@doc("A skill that extracts content and layout information, via Azure AI Services, from files within the enrichment pipeline.")
model DocumentIntelligenceLayoutSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Controls the output format. Default is 'markdown'.")
  outputFormat?: DocumentIntelligenceLayoutSkillOutputFormat | null = DocumentIntelligenceLayoutSkillOutputFormat.Markdown;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Controls the cardinality of the output produced by the skill. Default is 'oneToMany'.")
  outputMode?: DocumentIntelligenceLayoutSkillOutputMode | null = DocumentIntelligenceLayoutSkillOutputMode.OneToMany;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The depth of headers in the markdown output. Default is h6.")
  markdownHeaderDepth?: DocumentIntelligenceLayoutSkillMarkdownHeaderDepth | null = DocumentIntelligenceLayoutSkillMarkdownHeaderDepth.H6;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Controls the cardinality of the content extracted from the document by the skill.")
  extractionOptions?: DocumentIntelligenceLayoutSkillExtractionOptions[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Controls the cardinality for chunking the content.")
  chunkingProperties?: DocumentIntelligenceLayoutSkillChunkingProperties | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Util.DocumentIntelligenceLayoutSkill";
}

@doc("A skill that can call a Web API endpoint, allowing you to extend a skillset by having it call your custom code.")
model WebApiSkill extends SearchIndexerSkill {
  @doc("The url for the Web API.")
  uri: string;

  @doc("The headers required to make the http request.")
  httpHeaders?: WebApiHttpHeaders;

  @doc("The method for the http request.")
  httpMethod?: string;

  @doc("The desired timeout for the request. Default is 30 seconds.")
  timeout?: duration;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The desired batch size which indicates number of documents.")
  batchSize?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("If set, the number of parallel calls that can be made to the Web API.")
  degreeOfParallelism?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Applies to custom skills that connect to external code in an Azure function or some other application that provides the transformations. This value should be the application ID created for the function or app when it was registered with Azure Active Directory. When specified, the custom skill connects to the function or app using a managed ID (either system or user-assigned) of the search service and the access token of the function or app, using this value as the resource id for creating the scope of the access token.")
  authResourceId?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for outbound connections. If an authResourceId is provided and it's not specified, the system-assigned managed identity is used. On updates to the indexer, if the identity is unspecified, the value remains unchanged. If set to \"none\", the value of this property is cleared.")
  authIdentity?: SearchIndexerDataIdentity | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Custom.WebApiSkill";
}

@doc("The AML skill allows you to extend AI enrichment with a custom Azure Machine Learning (AML) model. Once an AML model is trained and deployed, an AML skill integrates it into AI enrichment.")
model AzureMachineLearningSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Required for no authentication or key authentication) The scoring URI of the AML service to which the JSON payload will be sent. Only the https URI scheme is allowed.")
  uri?: url | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Required for key authentication) The key for the AML service.")
  key?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Required for token authentication). The Azure Resource Manager resource ID of the AML service. It should be in the format subscriptions/{guid}/resourceGroups/{resource-group-name}/Microsoft.MachineLearningServices/workspaces/{workspace-name}/services/{service_name}.")
  resourceId?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Optional) When specified, indicates the timeout for the http client making the API call.")
  timeout?: duration | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Optional for token authentication). The region the AML service is deployed in.")
  region?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("(Optional) When specified, indicates the number of calls the indexer will make in parallel to the endpoint you have provided. You can decrease this value if your endpoint is failing under too high of a request load, or raise it if your endpoint is able to accept more requests and you would like an increase in the performance of the indexer. If not set, a default value of 5 is used. The degreeOfParallelism can be set to a maximum of 10 and a minimum of 1.")
  degreeOfParallelism?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Custom.AmlSkill";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
@doc("Allows you to generate a vector embedding for a given text input using the Azure OpenAI resource.")
model AzureOpenAIEmbeddingSkill extends SearchIndexerSkill {
  ...AzureOpenAIVectorizerParameters;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The number of dimensions the resulting output embeddings should have. Only supported in text-embedding-3 and later models.")
  dimensions?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Text.AzureOpenAIEmbeddingSkill";
}

@doc("Allows you to generate a vector embedding for a given image or text input using the Azure AI Services Vision Vectorize API.")
model VisionVectorizeSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The version of the model to use when calling the AI Services Vision service. It will default to the latest available when not specified.")
  modelVersion: string | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Vision.VectorizeSkill";
}

@doc("A skill that leverages Azure AI Content Understanding to process and extract structured insights from documents, enabling enriched, searchable content for enhanced document indexing and retrieval.")
model ContentUnderstandingSkill extends SearchIndexerSkill {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Controls the cardinality of the content extracted from the document by the skill.")
  extractionOptions?: ContentUnderstandingSkillExtractionOptions[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Controls the cardinality for chunking the content.")
  chunkingProperties?: ContentUnderstandingSkillChunkingProperties | null;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Util.ContentUnderstandingSkill";
}

@doc("Controls the cardinality of the content extracted from the document by the skill.")
union ContentUnderstandingSkillExtractionOptions {
  string,

  @doc("Specify that image content should be extracted from the document.")
  Images: "images",

  @doc("Specify that location metadata should be extracted from the document.")
  LocationMetadata: "locationMetadata",
}

@doc("Controls the cardinality for chunking the content.")
model ContentUnderstandingSkillChunkingProperties {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The unit of the chunk.")
  unit?: ContentUnderstandingSkillChunkingUnit | null = ContentUnderstandingSkillChunkingUnit.Characters;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum chunk length in characters. Default is 500.")
  maximumLength?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The length of overlap provided between two text chunks. Default is 0.")
  overlapLength?: int32 | null;
}

@doc("Controls the cardinality of the chunk unit. Default is 'characters'")
union ContentUnderstandingSkillChunkingUnit {
  string,

  @doc("Specifies chunk by characters.")
  Characters: "characters",
}

@doc("Object defining the custom schema the model will use to structure its output.")
model ChatCompletionSchema {
  @doc("Type of schema representation. Usually 'object'. Default is 'object'.")
  type?: string = "object";

  @doc("A JSON-formatted string that defines the output schema's properties and constraints for the model.")
  properties?: string;

  @doc("An array of the property names that are required to be part of the model's response. All properties must be included for structured outputs.")
  required?: string[];

  @doc("Controls whether it is allowable for an object to contain additional keys / values that were not defined in the JSON Schema. Default is false.")
  additionalProperties?: boolean = false;
}

@doc("Determines how the language model's response should be serialized. Defaults to 'text'.")
model ChatCompletionResponseFormat {
  @doc("Specifies how the LLM should format the response.")
  type?: ChatCompletionResponseFormatType = ChatCompletionResponseFormatType.Text;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("An open dictionary for extended properties. Required if 'type' == 'json_schema'")
  jsonSchemaProperties?: ChatCompletionSchemaProperties | null;
}

@doc("Properties for JSON schema response format.")
model ChatCompletionSchemaProperties {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Name of the json schema the model will adhere to.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Description of the json schema the model will adhere to.")
  description?: string | null;

  @doc("Whether or not the model's response should use structured outputs. Default is true.")
  strict?: boolean = true;

  @doc("The schema definition.")
  schema?: ChatCompletionSchema;
}

@doc("Common language model parameters for Chat Completions. If omitted, default values are used.")
model ChatCompletionCommonModelParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The name of the model to use (e.g., 'gpt-4o', etc.). Default is null if not specified.")
  @encodedName("application/json", "model")
  modelName?: string | null = null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A float in the range [-2,2] that reduces or increases likelihood of repeated tokens. Default is 0.")
  frequencyPenalty?: float64 | null = 0;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("A float in the range [-2,2] that penalizes new tokens based on their existing presence. Default is 0.")
  presencePenalty?: float64 | null = 0;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Maximum number of tokens to generate.")
  maxTokens?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Sampling temperature. Default is 0.7.")
  temperature?: float64 | null = 0.7;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Random seed for controlling deterministic outputs. If omitted, randomization is used.")
  seed?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("List of stop sequences that will cut off text generation. Default is none.")
  stop?: string[] | null;
}

@doc("A skill that calls a language model via Azure AI Foundry's Chat Completions endpoint.")
model ChatCompletionSkill extends SearchIndexerSkill {
  @doc("The url for the Web API.")
  uri: string;

  @doc("The headers required to make the http request.")
  httpHeaders?: WebApiHttpHeaders;

  @doc("The method for the http request.")
  httpMethod?: string;

  @doc("The desired timeout for the request. Default is 30 seconds.")
  timeout?: duration;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The desired batch size which indicates number of documents.")
  batchSize?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("If set, the number of parallel calls that can be made to the Web API.")
  degreeOfParallelism?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Applies to custom skills that connect to external code in an Azure function or some other application that provides the transformations. This value should be the application ID created for the function or app when it was registered with Azure Active Directory. When specified, the custom skill connects to the function or app using a managed ID (either system or user-assigned) of the search service and the access token of the function or app, using this value as the resource id for creating the scope of the access token.")
  authResourceId?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The user-assigned managed identity used for outbound connections. If an authResourceId is provided and it's not specified, the system-assigned managed identity is used. On updates to the indexer, if the identity is unspecified, the value remains unchanged. If set to \"none\", the value of this property is cleared.")
  authIdentity?: SearchIndexerDataIdentity | null;

  @doc("API key for authenticating to the model. Both apiKey and authIdentity cannot be specified at the same time.")
  apiKey?: string;

  @doc("Common language model parameters that customers can tweak. If omitted, reasonable defaults will be applied.")
  commonModelParameters?: ChatCompletionCommonModelParameters;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("Open-type dictionary for model-specific parameters that should be appended to the chat completions call. Follows Azure AI Foundry's extensibility pattern.")
  extraParameters?: Record<unknown> | null;

  @doc("How extra parameters are handled by Azure AI Foundry. Default is 'error'.")
  extraParametersBehavior?: ChatCompletionExtraParametersBehavior = ChatCompletionExtraParametersBehavior.Error;

  @doc("Determines how the LLM should format its response. Defaults to 'text' response type.")
  responseFormat?: ChatCompletionResponseFormat;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("A URI fragment specifying the type of skill.")
  `@odata.type`: "#Microsoft.Skills.Custom.ChatCompletionSkill";
}

@doc("Statistics for a given index. Statistics are collected periodically and are not guaranteed to always be up-to-date.")
model IndexStatisticsSummary {
  @doc("The name of the index.")
  name: string;

  @doc("The number of documents in the index.")
  @visibility(Lifecycle.Read)
  documentCount: int64;

  @doc("The amount of storage in bytes consumed by the index.")
  @visibility(Lifecycle.Read)
  storageSize: int64;

  @doc("The amount of memory in bytes consumed by vectors in the index.")
  @visibility(Lifecycle.Read)
  vectorIndexSize: int64;
}

@doc("Response from a request to retrieve stats summary of all indexes. If successful, it includes the stats of each index in the service.")
model ListIndexStatsSummary {
  @doc("The Statistics summary of all indexes in the Search service.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: IndexStatisticsSummary[];
}

@doc("Controls the cardinality for chunking the content.")
model DocumentIntelligenceLayoutSkillChunkingProperties {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The unit of the chunk.")
  unit?: DocumentIntelligenceLayoutSkillChunkingUnit | null = DocumentIntelligenceLayoutSkillChunkingUnit.Characters;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The maximum chunk length in characters. Default is 500.")
  maximumLength?: int32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The length of overlap provided between two text chunks. Default is 0.")
  overlapLength?: int32 | null;
}

@doc("A dictionary of http request headers.")
model WebApiHttpHeaders {
  ...Record<string>;
}
