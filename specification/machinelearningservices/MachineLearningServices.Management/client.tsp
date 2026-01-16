import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;

// Java casing fixes for SAS-related types and operations
@@clientName(GetBlobReferenceSASRequestDto, "GetBlobReferenceSasRequestDto", "java");
@@clientName(GetBlobReferenceSASResponseDto, "GetBlobReferenceSasResponseDto", "java");
@@clientName(SASCredential, "SasCredential", "java");
@@clientName(SASCredentialDto, "SasCredentialDto", "java");
@@clientName(SASAuthTypeWorkspaceConnectionProperties,
  "SasAuthTypeWorkspaceConnectionProperties",
  "java"
);
@@clientName(Registries.getBlobReferenceSAS, "getBlobReferenceSas", "java");
@@clientName(NotebookAccessTokenResult.hostName, "hostname", "java");
@@clientName(UserAccountCredentials.adminUserName, "adminUsername", "java");
@@clientName(ComputeInstanceSshSettings.adminUserName, "adminUsername", "java");

// Java casing fixes for FQDN-related types
@@clientName(ExternalFQDNResponse, "ExternalFqdnResponse", "java");
@@clientName(FqdnEndpointsPropertyBag, "FqdnEndpointsPropertyBag", "java");
@@clientName(FqdnEndpoints, "FqdnEndpoints", "java");
@@clientName(FqdnEndpoint, "FqdnEndpoint", "java");
@@clientName(FqdnEndpointDetail, "FqdnEndpointDetail", "java");
