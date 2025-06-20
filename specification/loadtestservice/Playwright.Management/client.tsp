import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Playwright.Management, "PlaywrightMgmt", "python");
@@clientName(Playwright.Management, "PlaywrightManagementClient", "javascript");
