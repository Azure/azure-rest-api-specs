import "@azure-tools/typespec-client-generator-core";
import "../main.tsp";

using Azure.ClientGenerator.Core;
using Storage.Blob;
using TypeSpec.Http;

namespace DatalakeGoCustomizations;

// Root client
@client(
  {
    name: "ServiceClient",
    service: Storage.Blob,
  },
  "go"
)
interface ServiceClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  listContainersSegment is Service.listContainers;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  getUserDelegationKey is Service.getUserDelegationKey;
}
@client(
  {
    name: "BlobClient",
    service: Storage.Blob,
  },
  "go"
)
interface BlobClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  setExpiry is Blob.setExpiry;
}

@@alternateType(ExpiryTimeParameter.expiresOn, string, "go");
@@alternateType(KeyInfo.start, string, "go");
@@alternateType(KeyInfo.expiry, string, "go");
@@alternateType(UserDelegationKey.value, string, "go");
@@clientName(BlobExpiryOptions, "ExpiryOptions", "go");
@@clientName(ContainerItem, "FileSystemItem", "go");
@@clientName(ContainerProperties, "FileSystemProperties", "go");
@@clientName(KeyInfo.delegatedUserTid, "DelegatedUserTenantID", "go");
@@clientName(LeaseDuration, "LeaseDurationType", "go");
@@clientName(LeaseState, "LeaseStateType", "go");
@@clientName(LeaseStatus, "LeaseStatusType", "go");
@@clientName(ListContainersResponse, "ListFileSystemsSegmentResponse", "go");
@@clientName(ListContainersResponse.containerItems, "FileSystemItems", "go");
@@clientName(UserDelegationKey.signedOid, "SignedOID", "go");
@@clientName(UserDelegationKey.signedTid, "SignedTID", "go");
@@clientName(
  UserDelegationKey.signedDelegatedUserTid,
  "SignedDelegatedUserTenantID",
  "go"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Service.listContainers,
  "responseEnvelopeName",
  "ServiceClientListFileSystemsSegmentResponse",
  "go"
);
