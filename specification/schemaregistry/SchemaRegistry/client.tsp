import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@access(Azure.SchemaRegistry.Version, Access.internal);
@@projectedName(Azure.SchemaRegistry.Version, "client", "SchemaVersion");
@@access(Azure.SchemaRegistry.SchemaGroup, Access.internal);

// csharp-specific public models
@@access(Azure.SchemaRegistry.SchemaContentTypeValues, Access.internal);
@@usage(Azure.SchemaRegistry.SchemaContentTypeValues, Usage.input | Usage.output);
@@projectedName(Azure.SchemaRegistry.SchemaContentTypeValues, "client", "ContentType");

// public client models
@@access(Azure.SchemaRegistry.SchemaFormat, Access.internal);
@@usage(Azure.SchemaRegistry.SchemaFormat, Usage.input | Usage.output);
@@access(Azure.SchemaRegistry.SchemaProperties, Access.internal);
@@usage(Azure.SchemaRegistry.SchemaProperties, Usage.input | Usage.output);
@@access(Azure.SchemaRegistry.Schema, Access.internal);
@@usage(Azure.SchemaRegistry.Schema, Usage.input | Usage.output);
