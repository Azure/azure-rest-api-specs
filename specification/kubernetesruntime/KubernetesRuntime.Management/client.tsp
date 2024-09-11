import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.KubernetesRuntime;

@@access(Operations.list, Access.internal, "csharp");