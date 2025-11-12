import "@azure-tools/typespec-client-generator-core";
import "./GuestSubscription.tsp";
import "./SharedLimit.tsp";

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.ComputeLimit.GuestSubscription.properties
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.ComputeLimit.SharedLimit.properties
);
