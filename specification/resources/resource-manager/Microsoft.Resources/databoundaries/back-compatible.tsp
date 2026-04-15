import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

@@clientLocation(DataBoundaryDefinitions.getTenant, DataBoundaries);
@@clientLocation(DataBoundaryDefinitions.put, DataBoundaries);
@@clientName(DataBoundaryDefinitions.put::parameters.resource,
  "dataBoundaryDefinition"
);
