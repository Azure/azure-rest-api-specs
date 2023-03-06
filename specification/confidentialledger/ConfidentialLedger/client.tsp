import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.ConfidentialLedger;

@@client(Azure.ConfidentialLedger, {name: "LedgerClient"})

@@summary(Azure.ConfidentialLedger.AmazingNewModel, "Some augment summary.")