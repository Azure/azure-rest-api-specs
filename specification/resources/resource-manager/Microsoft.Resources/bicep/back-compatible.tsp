import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using BicepClient;

@@clientLocation(DecompileOperationGroup.bicep, "Decompile");
