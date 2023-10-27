import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@access(Azure.SchemaRegistry.Version, Access.internal);
@@projectedName(Azure.SchemaRegistry.Version, "client", "SchemaVersion");
@@access(Azure.SchemaRegistry.SchemaGroup, Access.internal);

// csharp-specific public models
@@access(Azure.SchemaRegistry.SchemaContentTypeValues, Access.public, "csharp");
@@usage(Azure.SchemaRegistry.SchemaContentTypeValues, Usage.input | Usage.output);
@@projectedName(Azure.SchemaRegistry.SchemaContentTypeValues, "csharp", "ContentType");

// public client models
@@access(Azure.SchemaRegistry.SchemaFormat, Access.public);
@@usage(Azure.SchemaRegistry.SchemaFormat, Usage.input | Usage.output);
@@access(Azure.SchemaRegistry.SchemaProperties, Access.public);
@@usage(Azure.SchemaRegistry.SchemaProperties, Usage.input | Usage.output);
@@access(Azure.SchemaRegistry.Schema, Access.public);
@@usage(Azure.SchemaRegistry.Schema, Usage.input | Usage.output);
@@projectedName(Azure.SchemaRegistry.ServiceApiVersions, "client", "ApiVersion");
@@access(Azure.SchemaRegistry.ServiceApiVersions, Access.public);
@@usage(Azure.SchemaRegistry.ServiceApiVersions, Usage.input | Usage.output);
