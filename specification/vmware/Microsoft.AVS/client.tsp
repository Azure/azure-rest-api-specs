import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;

@@flattenProperty(Azure.ResourceManager.TrackedResource.properties, "java");
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties, "java");
