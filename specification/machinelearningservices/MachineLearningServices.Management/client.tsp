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
