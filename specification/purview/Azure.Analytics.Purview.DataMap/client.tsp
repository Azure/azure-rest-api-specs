import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace PurviewDataMap;

@@client(Entity,
  {
    name: "EntityClient",
  }
);

@@client(Discovery,
  {
    name: "DiscoveryClient",
  }
);

@@client(Relationship,
  {
    name: "RelationshipClient",
  }
);

@@client(Glossary,
  {
    name: "GlossaryClient",
  }
);

@@client(Type,
  {
    name: "TypeClient",
  }
);

@@client(Lineage,
  {
    name: "LineageClient",
  }
);