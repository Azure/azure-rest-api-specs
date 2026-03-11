import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ResourceGraph;

@@clientName(FacetRequestOptions.$top, "top");

@@clientName(QueryRequestOptions.$skipToken, "skipToken");
@@clientName(QueryRequestOptions.$top, "top");
@@clientName(QueryRequestOptions.$skip, "skip");

@@clientName(QueryResponse.$skipToken, "skipToken");

@@clientName(resources::parameters.body, "query");