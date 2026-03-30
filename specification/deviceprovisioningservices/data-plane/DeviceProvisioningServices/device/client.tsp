import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ProvisioningDeviceClient;

@@clientLocation(RuntimeRegistrationOperationGroup.operationStatusLookup,
  "RuntimeRegistration"
);
@@clientLocation(RuntimeRegistrationOperationGroup.deviceRegistrationStatusLookup,
  "RuntimeRegistration"
);
@@clientLocation(RuntimeRegistrationOperationGroup.registerDevice,
  "RuntimeRegistration"
);
@@clientLocation(RuntimeRegistrationOperationGroup.registerDeviceAndIssueCertificate,
  "RuntimeRegistration"
);
