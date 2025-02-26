import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Pinecone.VectorDb, "PineconeVectorDbMgmt", "python");
@@clientName(Pinecone.VectorDb, "PineconeVectorDbMgmtClient", "java");

@@clientNamespace(Pinecone.VectorDb,
  "com.azure.resourcemanager.pineconevectordb",
  "java"
);
@@clientNamespace(LiftrBase,
  "com.azure.resourcemanager.pineconevectordb",
  "java"
);
