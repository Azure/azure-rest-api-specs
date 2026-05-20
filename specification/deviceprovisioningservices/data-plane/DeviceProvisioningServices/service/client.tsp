import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ProvisioningServiceClient;

@@clientLocation(IndividualEnrollmentOperationGroup.get,
  "IndividualEnrollment"
);
@@clientLocation(IndividualEnrollmentOperationGroup.createOrUpdate,
  "IndividualEnrollment"
);
@@clientLocation(IndividualEnrollmentOperationGroup.delete,
  "IndividualEnrollment"
);
@@clientLocation(IndividualEnrollmentOperationGroup.query,
  "IndividualEnrollment"
);
@@clientLocation(IndividualEnrollmentOperationGroup.getAttestationMechanism,
  "IndividualEnrollment"
);
@@clientLocation(IndividualEnrollmentOperationGroup.runBulkOperation,
  "IndividualEnrollment"
);

@@clientLocation(EnrollmentGroupOperationGroup.get, "EnrollmentGroup");
@@clientLocation(EnrollmentGroupOperationGroup.createOrUpdate,
  "EnrollmentGroup"
);
@@clientLocation(EnrollmentGroupOperationGroup.delete, "EnrollmentGroup");
@@clientLocation(EnrollmentGroupOperationGroup.query, "EnrollmentGroup");
@@clientLocation(EnrollmentGroupOperationGroup.getAttestationMechanism,
  "EnrollmentGroup"
);
@@clientLocation(EnrollmentGroupOperationGroup.runBulkOperation,
  "EnrollmentGroup"
);

@@clientLocation(DeviceRegistrationStateOperationGroup.get,
  "DeviceRegistrationState"
);
@@clientLocation(DeviceRegistrationStateOperationGroup.delete,
  "DeviceRegistrationState"
);
@@clientLocation(DeviceRegistrationStateOperationGroup.query,
  "DeviceRegistrationState"
);
