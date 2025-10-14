import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using Microsoft.Compute;

@@alternateType(ContentTypeResponseHeader.contentType, never, "java");
