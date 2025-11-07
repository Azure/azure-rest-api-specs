import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "../common/service.tsp";

import "../agents/operations.tsp";
import "../memory_stores/operations.tsp";
// We don't need the operations for these subclients, just the models
// so we can customize visibility where necessary.
import "../responses/operations.tsp";
import "../conversations/operations.tsp";

namespace Azure.AI.Projects;
