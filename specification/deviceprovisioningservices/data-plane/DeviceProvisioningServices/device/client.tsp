import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ProvisioningDeviceClient;

@@clientLocation(
  RuntimeRegistration.operationStatusLookup,
  "RuntimeRegistration"
);
@@clientLocation(
  RuntimeRegistration.deviceRegistrationStatusLookup,
  "RuntimeRegistration"
);
@@clientLocation(RuntimeRegistration.registerDevice, "RuntimeRegistration");
@@clientLocation(
  RuntimeRegistration.registerDeviceAndIssueCertificate,
  "RuntimeRegistration"
);
@@clientLocation(DeviceUpdate.requestSoftwareUpdates, "DeviceUpdate");
@@clientLocation(DeviceUpdate.requestOnboardingUpdates, "DeviceUpdate");
@@clientLocation(DeviceUpdate.reportUpdateStatus, "DeviceUpdate");
