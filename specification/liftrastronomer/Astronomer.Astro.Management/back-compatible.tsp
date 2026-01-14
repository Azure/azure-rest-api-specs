import "@azure-tools/typespec-client-generator-core";

using Astronomer.Astro;

<<<<<<< HEAD
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrganizationResource.properties,
  "autorest"
);
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrganizationResource.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
