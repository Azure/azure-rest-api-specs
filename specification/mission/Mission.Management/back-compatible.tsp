import "@azure-tools/typespec-client-generator-core";

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
