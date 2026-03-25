import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientNamespace(Storage.DataLake, "Azure.Storage.Files.DataLake", "!python");
