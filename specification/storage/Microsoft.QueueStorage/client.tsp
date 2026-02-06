import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@clientNamespace(Storage.Queues, "Azure.Storage.Queues");
@@clientNamespace(Storage.Queues.Queue, "Azure.Storage.Queues");
