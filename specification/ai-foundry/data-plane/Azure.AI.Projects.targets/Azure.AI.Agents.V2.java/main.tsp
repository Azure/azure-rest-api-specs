import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Azure.AI.Projects/service.tsp";

import "../Azure.AI.Projects/agents/operations.tsp";
import "../Azure.AI.Projects/memory_stores/operations.tsp";
// We don't need the operations for these subclients, just the models
// so we can customize visibility where necessary.
import "../Azure.AI.Projects/responses/models.tsp";
import "../Azure.AI.Projects/conversations/models.tsp";
