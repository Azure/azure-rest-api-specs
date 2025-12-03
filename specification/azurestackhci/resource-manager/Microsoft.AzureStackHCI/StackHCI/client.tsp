import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

@@clientName(Microsoft.AzureStackHCI.Update, "HciUpdate", "java");

@@clientName(ErrorDetail, "ErrorDetailModel", "python");
