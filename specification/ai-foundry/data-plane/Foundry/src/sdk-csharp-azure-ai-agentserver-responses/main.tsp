// Azure AI Responses Server SDK — TypeSpec view
//
// This view selectively imports the OpenAI responses routes and models from the
// upstream Azure REST API spec and applies local customizations (client.tsp) to
// generate C# model classes in our SDK namespace.

// Common models and service infrastructure.
import "../common/custom-types.tsp";
import "../common/servicepatterns.tsp";
import "../common/error.range.tsp";
import "../common/models.tsp";
import "../toolboxes/models.tsp";

// Common service definition (namespace Azure.AI.Projects, Versions enum)
import "../common/service.tsp";

// OpenAI responses routes + models (routes reference the model types, making them visible to the emitter)
import "../openai/responses/routes.tsp";

// Local customizations (namespace mapping, sequence_number)
import "./client.tsp";
