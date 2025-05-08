import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.FileShares, "FileSharesManagementClient", "java");

interface FileSharesManagementClient {

@@clientName(CheckNameAvailabilityResponse, "CheckNameAvailabilityResult", "csharp");

@@clientName(Operation, "Info", "csharp");

}
