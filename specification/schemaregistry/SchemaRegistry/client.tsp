import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@access(Azure.SchemaRegistry.Version, Access.internal);
@@projectedName(Azure.SchemaRegistry.Version, "client", "SchemaVersion");
@@access(Azure.SchemaRegistry.SchemaGroup, Access.internal);

// csharp modifications
@@access(Azure.SchemaRegistry.ContentTypeEnum, Access.internal);
@@usage(Azure.SchemaRegistry.ContentTypeEnum, Usage.input | Usage.output);
@@projectedName(Azure.SchemaRegistry.ContentTypeEnum, "csharp", "ContentType");

// operations
@@access(Azure.SchemaRegistry.SchemaOperations.listSchemaGroups, Access.internal);
@@access(Azure.SchemaRegistry.SchemaOperations.getSchemaById, Access.internal);
@@access(Azure.SchemaRegistry.SchemaOperations.listSchemaVersions, Access.internal);
@@access(Azure.SchemaRegistry.SchemaOperations.getSchemaIdByContent, Access.internal);
@@access(Azure.SchemaRegistry.SchemaOperations.registerSchema, Access.internal);

// models
@@access(Azure.SchemaRegistry.SchemaFormat, Access.internal);
@@usage(Azure.SchemaRegistry.SchemaFormat, Usage.input | Usage.output);
@@access(Azure.SchemaRegistry.SchemaProperties, Access.internal);
@@usage(Azure.SchemaRegistry.SchemaProperties, Usage.input | Usage.output);
@@access(Azure.SchemaRegistry.Schema, Access.internal);
@@usage(Azure.SchemaRegistry.Schema, Usage.input | Usage.output);
