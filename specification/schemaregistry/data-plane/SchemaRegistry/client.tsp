import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using SchemaRegistry;

@useDependency(ServiceVersion.V2023_07_01)
namespace ClientCustomizations;

// operations
@@access(listSchemaGroups, Access.internal);
@@access(getSchemaById, Access.internal);
@@access(getSchemaByVersion, Access.internal);
@@access(listSchemaVersions, Access.internal);
@@access(getSchemaPropertiesByContent, Access.internal);
@@access(registerSchema, Access.internal);
