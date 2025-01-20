import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(KeyVault, "Client", "go");

using KeyVault;

@@clientName(SettingTypeEnum, "SettingType", "go");
