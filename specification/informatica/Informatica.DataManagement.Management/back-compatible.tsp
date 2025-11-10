import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Informatica.DataManagement;

@@Legacy.flattenProperty(InformaticaOrganizationResource.properties,
  "autorest"
);
@@Legacy.flattenProperty(InformaticaServerlessRuntimeResource.properties,
  "autorest"
);
