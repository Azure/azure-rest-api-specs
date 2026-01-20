import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using ContentUnderstanding;

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

  copyAnalyzer is ContentAnalyzers.copy;

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

// Mark polling operations as internal - client generators automatically handle
// the polling pattern for long-running operations. When users call analyze(), the
// generated SDK returns a poller that internally uses these endpoints to check status
// and retrieve results, eliminating the need for manual operation ID management.
@@access(ContentUnderstandingClient.getResult, Access.internal);
@@access(ContentUnderstandingClient.getOperationStatus, Access.internal);

// Client-only docs clarifying that these properties accept raw binary bytes (not base64 strings) in Python SDK.
@@clientDoc(AnalyzeInput.data,
  "Raw image bytes. Provide bytes-like object; do not base64-encode. Only one of url or data should be specified.",
  DocumentationMode.replace
);

// .NET-specific naming: use GetAnalyzers instead of ListAnalyzers
@@clientName(ContentUnderstandingClient.listAnalyzers,
  "getAnalyzers",
  "csharp"
);

@@convenientAPI(ContentAnalyzers.update, false, "csharp");
@@convenientAPI(ContentAnalyzers.updateDefaults, false, "csharp");
