import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using Microsoft.Mission;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApprovalResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunityEndpointResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunityResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnclaveConnectionResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnclaveEndpointResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnclaveResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TransitHubResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
