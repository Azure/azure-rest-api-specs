import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Migrate;

@@clientName(MoveCollections.create::parameters.resource, "body");
@@clientName(MoveCollections.update::parameters.properties, "body");

@@clientName(MoveResources.create::parameters.resource, "body");
