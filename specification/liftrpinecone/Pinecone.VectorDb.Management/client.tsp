import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Pinecone.VectorDb, "PineconeVectorDbMgmt", "python");
@@clientName(Pinecone.VectorDb, "PineconeVectorDbMgmtClient", "java");
