import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CleanRoom;

@@clientName(Collaborations.create::parameters.resource, "body");
@@clientName(Collaborations.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Collaboration.properties);

@@clientName(Consortiums.create::parameters.resource, "body");
@@clientName(Consortiums.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Consortium.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Contract.properties);
