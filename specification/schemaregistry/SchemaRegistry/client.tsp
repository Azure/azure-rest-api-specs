import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@access(Azure.SchemaRegistry.Version, Access.internal);
@@projectedName(Azure.SchemaRegistry.Version, "client", "SchemaVersion");
@@access(Azure.SchemaRegistry.SchemaGroup, Access.internal);

// csharp-specific public models
@@access(Azure.SchemaRegistry.SchemaContentTypeValues, Access.public, "csharp");
@@projectedName(Azure.SchemaRegistry.SchemaContentTypeValues, "csharp", "ContentType");

// public client models
@@access(Azure.SchemaRegistry.SchemaFormat, Access.public);
@@access(Azure.SchemaRegistry.SchemaProperties, Access.public);
@@access(Azure.SchemaRegistry.Schema, Access.public);
@@projectedName(Azure.SchemaRegistry.ServiceApiVersions, "client", "ApiVersion");
@@access(Azure.SchemaRegistry.ServiceApiVersions, Access.public);
