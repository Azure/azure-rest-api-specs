import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(Azure.Ai.Project.listSecrets, Access.internal);
