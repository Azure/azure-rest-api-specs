import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using KeyVault;

#suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
@@flattenProperty(KeyVault.UpdateSettingRequest.value);
