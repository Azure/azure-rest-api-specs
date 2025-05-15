import "./AVS.tsp";

namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftAVSPrivateCloudUpdatingExample: AvsPrivateCloudUpdatingEventData = #{
  operationId: "6dcd7db8-0679-40d9-bb8a-6f2a684395e2",
};

const MicrosoftAVSClusterUpdatedExample: AvsClusterUpdatedEventData = #{
  addedHostNames: #["esx17-r04.p01.431cc\\u00e2\\u20ac\\u00a6"],
  removedHostNames: #["esx15-r01.p01.431cc\\u00e2\\u20ac\\u00a6"],
  inMaintenanceHostNames: #["esx01-r03.p01.431cc\\u00e2\\u20ac\\u00a6"],
  operationId: "c8c0b304-2db3-402b-8a6b-06065e0e1755",
};

const MicrosoftAVSScriptExecutionFailedExample: AvsScriptExecutionFailedEventData = #{
  operationId: "fe1cb595-71c8-47d7-b505-60d39a44d53d",
  failureMessage: "05/04/2023 03:15:40 Get-SpbmStoragePolicy SpbmStoragePolicy with name ' RAID-5 FTT-1' was not found using the specified filter(s).",
  cmdletId: "Microsoft.AVS.Management@5.3.70/Set-LocationStoragePolicy",
  output: #[],
};
