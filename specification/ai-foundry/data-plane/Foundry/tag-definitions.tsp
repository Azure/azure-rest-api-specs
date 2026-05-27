using OpenAPI;

@tagMetadata(#[
  #{ name: "Responses", description: "Responses from the API" },
  #{ name: "Agents" },
  #{ name: "Conversations", parent: "Responses" },
  #{ name: "Platform APIs" },
  #{ name: "Datasets", parent: "Platform APIs" },
  #{ name: "Indexes", parent: "Platform APIs" },
  #{ name: "Connections", parent: "Platform APIs" },
  #{ name: "Memory stores", parent: "Platform APIs" },
  #{ name: "Scheduler", parent: "Platform APIs" },
  #{ name: "Fine-tuning", parent: "Platform APIs" },
  #{ name: "Evaluations" },
  #{ name: "Evalsuite", parent: "Evaluations" }
])
namespace Azure.AI.Projects;
