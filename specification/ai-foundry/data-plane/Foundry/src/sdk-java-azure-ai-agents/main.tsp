import "../common/service.tsp";
import "../common/custom-types.tsp";
import "../common/beta-ops-relocation-agents.tsp";

import "../agents/routes.tsp";
import "../memory-stores/routes.tsp";
import "../toolboxes/routes.tsp";
import "../agents-session-files/routes.tsp";
import "../agents-optimization/routes.tsp";
// We don't need the operations for these subclients, just the models
// so we can customize visibility where necessary.
import "../openai-responses/models.tsp";
import "../openai-conversations/routes.tsp";
