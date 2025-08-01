import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Cdn;

@@clientName(CertificateSourceParameters,
  "CertificateSourceParametersBase",
  "go"
);
@@clientName(CdnEndpoint, "LinkedEndpoint", "go");

@@clientName(ValidateProbeInput.probeURL, "probeUrl", "java");
