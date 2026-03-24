import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using KeyVault;

@@clientName(KeyVault, "Client", "go");
@@clientName(SettingTypeEnum, "SettingType", "go");
