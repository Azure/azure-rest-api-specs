// Prototype combined entrypoint: composes both Discovery data-plane services
// (Workspace + Bookshelf) into a single TypeSpec compilation so the C# emitter
// can produce ONE Azure.AI.Discovery package via standard tsp-client.
// Both services now share the single Microsoft.Discovery.Common library.
import "../Discovery.Workspace/main.tsp";
import "../Discovery.Bookshelf/main.tsp";
