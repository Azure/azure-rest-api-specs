import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using ElasticAzure;

@@clientName(ElasticAzure, "ElasticAzureManagementClient");
@@clientName(ElasticAzure.Organizations, "Organizations");
@@clientName(ElasticAzure.Operations, "Operations");