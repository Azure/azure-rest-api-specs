import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CleanRoom;

@@clientName(Collaborations.create::parameters.resource, "body");
@@clientName(Collaborations.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Collaboration.properties);

@@clientName(ConsortiumViews.create::parameters.resource, "body");
@@clientName(ConsortiumViews.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConsortiumView.properties);

@@clientName(Consortiums.create::parameters.resource, "body");
@@clientName(Consortiums.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Consortium.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Contract.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConsortiumViewContract.properties
);
