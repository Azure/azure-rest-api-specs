import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceGraph;

@@clientName(QueryRequestOptions.$skipToken, "skipToken");
@@clientName(QueryRequestOptions.$top, "top");
@@clientName(QueryRequestOptions.$skip, "skip");

@@clientName(FacetRequestOptions.$top, "top");

@@clientName(QueryResponse.$skipToken, "skipToken");

@@clientLocation(QueryOperationGroup.generateQuery, "Query");
