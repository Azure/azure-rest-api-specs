import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Orbital;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AvailableContacts.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AvailableGroundStation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationResult.properties);

@@clientName(Spacecrafts.createOrUpdate::parameters.resource, "parameters");
@@clientName(Spacecrafts.updateTags::parameters.properties, "parameters");
@@clientName(Spacecrafts.listAvailableContacts::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Spacecraft.properties);

@@clientName(Contacts.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Contact.properties);

@@clientName(ContactProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(ContactProfiles.updateTags::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ContactProfile.properties);
