import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using SearchClient;

@TypeSpec.Versioning.useDependency(SearchClient.Versions.v2024_07_01)
namespace Azure.Search.Documents.Indexes{
    
}

@@access(VectorSearchAlgorithmKind, Access.public, "python");