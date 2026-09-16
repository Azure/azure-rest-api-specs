import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using Microsoft.FileShares;

@@clientLocation(FileShareSnapshots.getFileShareSnapshot, "FileShareSnapshot");
@@clientName(FileShareSnapshots.getFileShareSnapshot, "get");
@@clientLocation(
  FileShareSnapshots.createOrUpdateFileShareSnapshot,
  "FileShareSnapshot"
);
@@clientName(
  FileShareSnapshots.createOrUpdateFileShareSnapshot,
  "createOrUpdate"
);
@@clientLocation(
  FileShareSnapshots.updateFileShareSnapshot,
  "FileShareSnapshot"
);
@@clientName(FileShareSnapshots.updateFileShareSnapshot, "update");
@@clientLocation(
  FileShareSnapshots.deleteFileShareSnapshot,
  "FileShareSnapshot"
);
@@clientName(FileShareSnapshots.deleteFileShareSnapshot, "delete");
@@clientLocation(FileShareSnapshots.listByFileShare, "FileShareSnapshot");
@@clientName(FileShareSnapshots.listByFileShare, "list");
@@clientLocation(InformationalOperations.getUsageData, "FileShare");
@@clientLocation(InformationalOperations.getLimits, "FileShare");
@@clientLocation(
  InformationalOperations.getProvisioningRecommendation,
  "FileShare"
);
