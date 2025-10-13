import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.CodeSigning, "TrustedSigningMgmt", "python");
@@clientName(Microsoft.CodeSigning, "TrustedSigningManagementClient", "java");
