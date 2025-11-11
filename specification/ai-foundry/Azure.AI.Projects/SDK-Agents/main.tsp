import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "../common/service.tsp";

import "../agents/routes.tsp";
import "../memory_stores/routes.tsp";
// We don't need the operations for these subclients, just the models
// so we can customize visibility where necessary.
import "../responses/routes.tsp";
import "../conversations/routes.tsp";

namespace Azure.AI.Projects;
