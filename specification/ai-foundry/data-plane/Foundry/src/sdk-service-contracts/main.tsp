import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../agents/routes.tsp";
import "../common/models.tsp";
import "../common/service.tsp";
import "../memory_stores/routes.tsp";
import "../openai-conversations/routes.tsp";
import "../openai-responses/routes.tsp";

import "./client.tsp";
