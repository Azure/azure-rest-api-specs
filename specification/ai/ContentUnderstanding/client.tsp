import "@azure-tools/typespec-client-generator-core";
import "./main.tsp"

using Azure.ClientGenerator.Core;
using ContentUnderstanding;
@@clientName(ArrayField.type, "field_type", "python"); # FieldType
@@clientName(BooleanField.type, "field_type", "python"); # FieldType
@@clientName(DateField.type, "field_type", "python"); # FieldType
@@clientName(IntegerField.type, "field_type", "python"); # FieldType
@@clientName(NumberField.type, "field_type", "python"); # FieldType
@@clientName(ObjectField.type, "field_type", "python"); # FieldType
@@clientName(StringField.type, "field_type", "python"); # FieldType
@@clientName(TimeField.type, "field_type", "python"); # FieldType

@@clientName(FieldDefinition.items, "item_definition", "python");

@@clientName(AnalyzeBinaryRequest.input, "binary_input", "python");
@@clientName(ClassifyBinaryRequest.input, "binary_input", "python");

@@clientName(ClassifierCategory, "ClassifierCategoryDefinition", "python");
@@clientName(FieldType, "ContentFieldType", "python");

# Client-only docs clarifying that these properties accept raw binary bytes (not base64 strings) in Python SDK.
@@clientDoc(DetectFacesParameters.data, "Raw image bytes. Provide bytes-like object; do not base64-encode. Only one of url or data should be specified.", "python");
@@clientDoc(FaceSource.data, "Raw image bytes. Provide bytes-like object; do not base64-encode. Only one of url or data should be specified.", "python");



