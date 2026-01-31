import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common/service.tsp";
import "../common/custom_types.tsp";

import "../agents/routes.tsp";
import "../memory_stores/routes.tsp";
// We don't need the operations for these subclients, just the models
// so we can customize visibility where necessary.
import "../openai-responses/models.tsp";
import "../openai-conversations/models.tsp";
