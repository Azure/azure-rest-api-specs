import "@typespec/json-schema";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.JsonSchema;

@armProviderNamespace
@jsonSchema
namespace Microsoft.Chaos;
