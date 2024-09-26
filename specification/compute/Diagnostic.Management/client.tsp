import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(ComputeDiagnosticBases.create,
  "ComputeDiagnosticBases.create::parameters.body",
  "runDiskInspectionInput"
);
@@clientName(ComputeDiagnosticBases.register,
  "ComputeDiagnosticBases.register::parameters.body",
  "storageConfigurationInput"
);
