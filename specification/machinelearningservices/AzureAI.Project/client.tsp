import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Inernal method, to be used by custom hand-written code in the SDKs, to get the secrets for a given connection. 
@@access(Azure.Ai.Project.listSecrets, Access.internal);
