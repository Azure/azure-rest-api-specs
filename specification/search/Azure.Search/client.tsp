import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using SearchClient;

@TypeSpec.Versioning.useDependency(SearchClient.Versions.v2024_07_01)
namespace Customizations;

// @client({
//     name: "SearchIndexClient",
//     service: SearchClient,
// })
// interface Client1 {
//     DataSourcesOperationsCreateOrUpdate is SearchClient.DataSourcesOperations.createOrUpdate;
// }

// @client({
//     name: "SearchServiceClient",
//     service: SearchClient,
// })
// interface Client2 {
//     DataSourcesOperationsDelete is SearchClient.DataSourcesOperations.delete;
// }

@@access(VectorSearchAlgorithmKind, Access.public);
@@usage(VectorSearchAlgorithmKind, Usage.input);
@@access(VectorSearchVectorizerKind, Access.public);
@@usage(VectorSearchVectorizerKind, Usage.input);
