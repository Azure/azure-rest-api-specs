import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.HorizonDb, "HorizonDBMgmtClient");
@@clientName(Microsoft.HorizonDb.HorizonDbCluster, "HorizonDBCluster");
@@clientName(Microsoft.HorizonDb.HorizonDbPool, "HorizonDBPool");
@@clientName(Microsoft.HorizonDb.HorizonDbReplica, "HorizonDBReplica");
@@clientName(Microsoft.HorizonDb.HorizonDbFirewallRule, "HorizonDBFirewallRule");