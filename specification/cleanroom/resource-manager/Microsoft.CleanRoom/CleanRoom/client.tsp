import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CleanRoom;

@@clientName(Collaborations.create::parameters.resource, "body", "!autorest");
@@clientName(Collaborations.update::parameters.properties, "body", "!autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Collaboration.properties,
  "!autorest"
);

@@clientName(ConsortiumViews.create::parameters.resource, "body", "!autorest");
@@clientName(
  ConsortiumViews.update::parameters.properties,
  "body",
  "!autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ConsortiumView.properties,
  "!autorest"
);

@@clientName(Consortiums.create::parameters.resource, "body", "!autorest");
@@clientName(Consortiums.update::parameters.properties, "body", "!autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Consortium.properties,
  "!autorest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Contract.properties,
  "!autorest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ConsortiumViewContract.properties,
  "!autorest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AddCollaboratorInput.collaborator,
  "!autorest"
);
