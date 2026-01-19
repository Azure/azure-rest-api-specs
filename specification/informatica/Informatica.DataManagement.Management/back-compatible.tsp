import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Informatica.DataManagement;

<<<<<<< HEAD
@@Legacy.flattenProperty(InformaticaOrganizationResource.properties,
  "autorest"
);
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(InformaticaOrganizationResource.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Legacy.flattenProperty(InformaticaServerlessRuntimeResource.properties,
  "autorest"
);
