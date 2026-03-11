import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ResourceGraph;

@@clientName(resources::parameters.body, "query");