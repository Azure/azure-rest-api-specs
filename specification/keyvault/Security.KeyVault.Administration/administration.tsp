import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

import "../Security.KeyVault.BackupRestore/main.tsp";
import "../Security.KeyVault.BackupRestore/models.tsp";
import "../Security.KeyVault.BackupRestore/routes.tsp";
import "../Security.KeyVault.RBAC/models.tsp";
import "../Security.KeyVault.RBAC/routes.tsp";
import "../Security.KeyVault.Settings/models.tsp";
import "../Security.KeyVault.Settings/routes.tsp";
