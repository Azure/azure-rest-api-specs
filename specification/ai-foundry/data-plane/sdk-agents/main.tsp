import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Foundry/src/common/service.tsp";

import "../Foundry/src/agents/routes.tsp";
import "../Foundry/src/memory_stores/routes.tsp";
// We don't need the operations for these subclients, just the models
// so we can customize visibility where necessary.
import "../Foundry/src/responses/models.tsp";
import "../Foundry/src/conversations/models.tsp";
