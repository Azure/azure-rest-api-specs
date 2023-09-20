import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using DevCenter;
using Azure.ClientGenerator.Core;

namespace SDKCustomizations;

@client({
    name: "EnvironmentClient",
    service: DevCenter,
})
interface EnvironmentClientOperations extends DevCenter.EnvironmentsOperations{
    // ...DevCenter.EnvironmentsOperations;
}
