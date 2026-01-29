import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using ContentUnderstanding;
using TypeSpec.Http;

namespace ClientCustomizations;

@client({
  name: "ContentUnderstandingClient",
  service: ContentUnderstanding,
})
interface ContentUnderstandingClient {
  // Flatten all ContentAnalyzers operations to client level
  // LRO operations will automatically get "begin_" prefix in Python

  analyze is ContentAnalyzers.analyze;

  analyzeBinary is ContentAnalyzers.analyzeBinary;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  copyAnalyzer is ContentAnalyzers.copy;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Doesn't fit standard naming"
  createAnalyzer is ContentAnalyzers.createOrReplace;

  deleteAnalyzer is ContentAnalyzers.delete;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteResult is ContentAnalyzers.deleteResult;

  getAnalyzer is ContentAnalyzers.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDefaults is ContentAnalyzers.getDefaults;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getOperationStatus is ContentAnalyzers.getOperationStatus;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getResult is ContentAnalyzers.getResult;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getResultFile is ContentAnalyzers.getResultFile;

  grantCopyAuthorization is ContentAnalyzers.grantCopyAuthorization;

  listAnalyzers is ContentAnalyzers.list;

  updateAnalyzer is ContentAnalyzers.update;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateDefaults is ContentAnalyzers.updateDefaults;
}

// Rename type as fieldType to avoid conflict with built-in 'type' keyword.
@@clientName(ArrayField.type, "fieldType");
@@clientName(BooleanField.type, "fieldType");
@@clientName(DateField.type, "fieldType");
@@clientName(IntegerField.type, "fieldType");
@@clientName(NumberField.type, "fieldType");
@@clientName(ObjectField.type, "fieldType");
@@clientName(StringField.type, "fieldType");
@@clientName(TimeField.type, "fieldType");
@@clientName(JsonField.type, "fieldType");

// Rename 'items' to avoid conflict with built-in 'items' method.
@@clientName(ContentFieldDefinition.items, "itemDefinition");

@@clientName(AnalyzeBinaryRequest.input, "binaryInput");

// Rename 'range' to 'inputRange' for clarity that it specifies input range.
@@clientName(AnalyzeInput.range, "inputRange");
@@clientName(AnalyzeBinaryRequest.range, "inputRange");

// .NET-specific naming: use GetAnalyzers instead of ListAnalyzers
@@clientName(ContentUnderstandingClient.listAnalyzers,
  "getAnalyzers",
  "csharp"
);

// Mark polling operations as internal - client generators automatically handle
// the polling pattern for long-running operations. When users call analyze(), the
// generated SDK returns a poller that internally uses these endpoints to check status
// and retrieve results, eliminating the need for manual operation ID management.
@@access(ContentUnderstandingClient.getResult, Access.internal);
@@access(ContentUnderstandingClient.getOperationStatus, Access.internal);

// Suppress convenient method generation for updateDefaults in Java only
@@convenientAPI(ContentUnderstandingClient.updateDefaults, false, "java");

// Client-only docs clarifying that these properties accept raw binary bytes (not base64 strings) in Python SDK.
@@clientDoc(AnalyzeInput.data,
  "Raw image bytes. Provide bytes-like object; do not base64-encode. Only one of url or data should be specified.",
  DocumentationMode.replace
);

// Custom parameter order for analyzeBinary: put required 'input' before optional parameters with defaults.
// This ensures 'contentType' (which has a default) appears after the required body parameter.
// stringEncoding is required - each SDK will set the appropriate default via language-specific customization.
op analyzeBinaryCustomSignature(
  @doc("The unique identifier of the analyzer.")
  @path
  analyzerId: string,

  @doc("The binary content of the document to analyze.")
  @bodyRoot
  input: bytes,

  @doc("The string encoding format for content spans in the response. Possible values are 'codePoint', 'utf16', and 'utf8'.")
  @query
  stringEncoding: string,

  @doc("Range of the input to analyze (ex. `1-3,5,9-`). Document content uses 1-based page numbers, while audio visual content uses integer milliseconds.")
  @query
  range?: RangeExpression,

  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Conflicts with @typespec/http/content-type-string"
  @doc("Request content type.")
  @header
  contentType?: string = "application/octet-stream",

  @doc("The location where the data may be processed. Defaults to global.")
  @query
  processingLocation?: ProcessingLocation = ProcessingLocation.global,

  @doc("The API version to use for this operation.")
  @query("api-version")
  apiVersion: string,
): AnalyzeResult;

@@override(ContentUnderstandingClient.analyzeBinary, analyzeBinaryCustomSignature);

// Custom parameter order for analyze: put main input data before optional processing parameters.
// stringEncoding is required - each SDK will set the appropriate default via language-specific customization.
op analyzeCustomSignature(
  @doc("The unique identifier of the analyzer.")
  @path
  analyzerId: string,

  @doc("Inputs to analyze. Currently, only pro mode supports multiple inputs.")
  inputs?: AnalyzeInput[],

  @doc("The string encoding format for content spans in the response. Possible values are 'codePoint', 'utf16', and 'utf8'.")
  @query
  stringEncoding: string,

  @doc("Override default mapping of model names to deployments. Ex. { \"gpt-4.1\": \"myGpt41Deployment\" }.")
  modelDeployments?: Record<string>,

  @doc("The location where the data may be processed. Defaults to global.")
  @query
  processingLocation?: ProcessingLocation = ProcessingLocation.global,

  @doc("The API version to use for this operation.")
  @query("api-version")
  apiVersion: string,
): AnalyzeResult;

@@override(ContentUnderstandingClient.analyze, analyzeCustomSignature);
