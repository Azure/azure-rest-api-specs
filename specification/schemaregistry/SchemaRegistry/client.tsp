import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;
using Azure.SchemaRegistry;

@@access(Version, Access.internal);
@@projectedName(Version, "client", "SchemaVersion");
@@access(SchemaGroup, Access.internal);

// csharp modifications
@@access(ContentTypeEnum, Access.internal);
@@usage(ContentTypeEnum, Usage.input | Usage.output);
@@projectedName(ContentTypeEnum, "csharp", "ContentType");

// operations
@@access(SchemaOperations.listSchemaGroups, Access.internal);
@@access(SchemaOperations.getSchemaById, Access.internal);
@@access(SchemaOperations.getSchemaByVersion, Access.internal);
@@access(SchemaOperations.listSchemaVersions, Access.internal);
@@access(SchemaOperations.getSchemaIdByContent, Access.internal);
@@access(SchemaOperations.registerSchema, Access.internal);

// models
@@access(SchemaFormat, Access.internal);
@@usage(SchemaFormat, Usage.input | Usage.output);
@@access(SchemaProperties, Access.internal);
@@usage(SchemaProperties, Usage.input | Usage.output);
@@access(Schema, Access.internal);
@@usage(Schema, Usage.input | Usage.output);
