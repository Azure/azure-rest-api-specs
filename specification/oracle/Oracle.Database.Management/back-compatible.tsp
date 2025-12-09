import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operations/autonomousdatabase/autonomousDatabaseOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseBackupOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseCharacterSetOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseNationalCharacterSetOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseVersionOperations.tsp";
import "./operations/exadata/exadatainfrastructureOperations.tsp";
import "./operations/exadata/dbServersOperations.tsp";
import "./operations/exadata/vmclusterOperations.tsp";
import "./operations/exadata/virtualNetworkAddressOperations.tsp";
import "./operations/exadata/systemVersionOperations.tsp";
import "./operations/oraclesubscription/oracleSubscriptionOperations.tsp";
import "./operations/exadata/dbNodesOperations.tsp";
import "./operations/exadata/dbSystemShapeOperations.tsp";
import "./operations/exadata/dnsPrivateViewsOperations.tsp";
import "./operations/exadata/dnsPrivateZonesOperations.tsp";
import "./operations/exadata/giVersionOperations.tsp";

using Oracle.Database;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AutonomousDatabaseBackup.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AutonomousDatabaseCharacterSet.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AutonomousDatabaseNationalCharacterSet.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AutonomousDbVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudExadataInfrastructure.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudVmCluster.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DbNode.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DbServer.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DbSystemShape.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsPrivateView.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsPrivateZone.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GiVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OracleSubscription.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SystemVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualNetworkAddress.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DbSystem.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DbVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExascaleDbNode.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExadbVmCluster.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceAnchor.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExascaleDbStorageVault.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FlexComponent.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GiMinorVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkAnchor.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
