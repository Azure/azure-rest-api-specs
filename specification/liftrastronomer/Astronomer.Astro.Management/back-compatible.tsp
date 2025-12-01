import "@azure-tools/typespec-client-generator-core";

using Astronomer.Astro;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrganizationResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
