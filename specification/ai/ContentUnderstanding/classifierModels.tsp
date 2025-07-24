import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

@added(Versions.v2025_05_01_preview)
@doc("Classifier that classifies content into categories with optional splitting.")
@resource("classifiers")
model ContentClassifier {
  @doc("The unique identifier of the classifier.")
  @key
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9._-]{1,64}$")
  classifierId: string;

  @doc("A description of the classifier.")
  description?: string;

  @doc("Tags associated with the classifier.")
  tags?: Record<string>;

  @doc("The status of the classifier.")
  @visibility(Lifecycle.Read)
  status: ResourceStatus;

  @doc("The date and time when the classifier was created.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The date and time when the classifier was last modified.")
  @visibility(Lifecycle.Read)
  lastModifiedAt: utcDateTime;

  @doc("Warnings encountered while creating the classifier.")
  @visibility(Lifecycle.Read)
  warnings?: Azure.Core.Foundations.Error[];

  // TODO: Do we want to provide an overall instruction?

  @doc("The categories to classify against.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  categories: Record<ClassifierCategory>;

  @doc("Mode used to split input into content objects.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  splitMode?: ClassifierSplitMode = ClassifierSplitMode.noSplit;

  @added(Versions.v2025_05_01_preview)
  @doc("The location where the data may be processed.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  processingLocation?: ProcessingLocation = ProcessingLocation.geography;
}

@added(Versions.v2025_05_01_preview)
@doc("A classifier category.")
model ClassifierCategory {
  @doc("The description of the category.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description?: string;

  @doc("Optional analyzer used to process the content.")
  analyzerId?: string;
}

@added(Versions.v2025_05_01_preview)
@doc("Mode used to split input into content objects.")
union ClassifierSplitMode {
  string,

  @doc("Treat the entire input as a single content object.")
  noSplit: "noSplit",

  @doc("Split each page of the input into a separate content object.")
  perPage: "perPage",

  @doc("Split the input into content objects based on the input and category definitions.")
  auto: "auto",
}

@added(Versions.v2025_05_01_preview)
@doc("Classify operation parameters.")
model ClassifyParameters {
  // @doc("Range of the input to classify (ex. `1-3;5;9-`).  Document content uses 1-based page numbers, while audio visual content uses integer milliseconds.")
  // @query
  // range?: RangeExpression;

  @added(Versions.v2025_05_01_preview)
  @doc("The encoding format for content spans in the response.")
  @query
  stringEncoding?: StringEncoding = StringEncoding.codePoint;

  @added(Versions.v2025_05_01_preview)
  @doc("The location where the data may be processed.")
  @query
  processingLocation?: ProcessingLocation;
}

@added(Versions.v2025_05_01_preview)
@doc("Classify operation request.")
model ClassifyRequest {
  ...ClassifyParameters;

  @doc("The URL of the document to classify.")
  url?: url;
}

@added(Versions.v2025_05_01_preview)
@doc("Classify operation request directly from binary content.")
model ClassifyBinaryRequest {
  ...ClassifyParameters;

  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Conflicts with @typespec/http/content-type-string"
  @doc("Request content type.")
  @header
  contentType: string = "application/octet-stream";

  @doc("The binary content of the document to classify.")
  @bodyRoot
  input: bytes;
}

// @added(Versions.v2025_05_01_preview)
// @doc("...")
// model AdHocClassifyRequest {
//   ...ClassifyRequest;

//   @doc("The content categories to classify against.")
//   categories?: Record<ClassifierCategory>;

//   @doc("Mode used to split input into content objects.")
//   splitMode?: ClassifierSplitMode = ClassifierSplitMode.noSplit;
// }

@added(Versions.v2025_05_01_preview)
@doc("Classify operation result.")
model ClassifyResult {
  @doc("The unique identifier of the classifier.")
  @pattern("^[a-zA-Z0-9._-]{1,64}$")
  classifierId?: string;

  @doc("The version of the API used to classify the document.")
  apiVersion?: string;

  @doc("The date and time when the result was created.")
  createdAt?: utcDateTime;

  @doc("Warnings encountered while classifying the document.")
  warnings?: Azure.Core.Foundations.Error[];

  @added(Versions.v2025_05_01_preview)
  @doc("The string encoding used for content spans.")
  stringEncoding?: StringEncoding = StringEncoding.codePoint;

  @doc("The classified content.")
  contents: MediaContent[];
}
