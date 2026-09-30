import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Portal;

@@clientLocation(
  ListTenantConfigurationViolationsOperations.list,
  "ListTenantConfigurationViolations"
);
