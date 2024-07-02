import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.StandbyPool;

@@access(Operations.list, Access.internal, "csharp");