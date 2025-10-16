import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using ContentUnderstanding;

// Rename type as field_type to avoid conflict with Python built-in class 'type'.
@@clientName(ArrayField.type, "field_type", "python");
@@clientName(BooleanField.type, "field_type", "python");
@@clientName(DateField.type, "field_type", "python");
@@clientName(IntegerField.type, "field_type", "python");
@@clientName(NumberField.type, "field_type", "python");
@@clientName(ObjectField.type, "field_type", "python");
@@clientName(StringField.type, "field_type", "python");
@@clientName(TimeField.type, "field_type", "python");

// Rename 'items' to avoid conflict with Python built-in function 'items' for dictionaries.
@@clientName(ContentFieldDefinition.items, "item_definition", "python");

@@clientName(AnalyzeBinaryRequest.input, "binary_input", "python");
@@clientName(ClassifyBinaryRequest.input, "binary_input", "python");

// Client-only docs clarifying that these properties accept raw binary bytes (not base64 strings) in Python SDK.
@@clientDoc(AnalyzeInput.data,
  "Raw image bytes. Provide bytes-like object; do not base64-encode. Only one of url or data should be specified.",
  DocumentationMode.replace
);
@@clientDoc(FaceSource.data,
  "Raw image bytes. Provide bytes-like object; do not base64-encode. Only one of url or data should be specified.",
  DocumentationMode.replace
);
