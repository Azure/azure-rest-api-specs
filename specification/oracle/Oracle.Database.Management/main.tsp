import "@azure-tools/typespec-autorest";
import "./operations/exadata/exadatainfrastructureOperations.tsp";
import "./operations/exadata/dbServersOperations.tsp";
import "./operations/exadata/vmclusterOperations.tsp";
import "./operations/exadata/virtualNetworkAddressOperations.tsp";
import "./operations/exadata/systemVersionOperations.tsp";
import "./operations/oraclesubscription/oracleSubscriptionOperations.tsp";
import "./operations/exadata/dbNodesOperations.tsp";
import "./operations/exadata/giVersionOperations.tsp";
import "./operations/exadata/dbSystemShapeOperations.tsp";
import "./operations/exadata/dnsPrivateViewsOperations.tsp";
import "./operations/exadata/dnsPrivateZonesOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseBackupOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseCharacterSetOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseNationalCharacterSetOperations.tsp";
import "./operations/autonomousdatabase/autonomousDatabaseVersionOperations.tsp";

import "./versions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;
using Autorest;

@armProviderNamespace
@service({
  title: "Oracle Database Resource Manager",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@versioned(Oracle.Database.Versions)
namespace Oracle.Database;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(Operations.list,
  "./examples/operations_list.json",
  "List Operations"
);
