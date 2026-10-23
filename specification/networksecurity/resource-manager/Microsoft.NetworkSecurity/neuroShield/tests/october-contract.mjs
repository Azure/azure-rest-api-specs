export default {
  version: "2026-10-01-preview",
  swaggerCanonicalSha256:
    "c82571bbcd7b51ce39d867e1ab35ec501c8b65e41c655d633639399c67b07bf8",
  operationCount: 25,
  definitionCount: 32,
  parameterCount: 3,
  operations: {
    Operations_List: {
      path: "/providers/Microsoft.NetworkSecurity/operations",
      method: "get",
      operationSha256:
        "789c023a793aa40a810c1fcc2cf0b0e2f9c48a5746e65b398c32d7a5e24711d2",
    },
    NeuroShieldOperationStatuses_Get: {
      path: "/subscriptions/{subscriptionId}/providers/Microsoft.NetworkSecurity/locations/{location}/neuroShieldOperationStatuses/{operationId}",
      method: "get",
      operationSha256:
        "dd14f4f03b4b8c8ce6c724612d3c5356e00d6868833ba3c72b0c64178a7b744d",
    },
    NeuroShields_ListBySubscription: {
      path: "/subscriptions/{subscriptionId}/providers/Microsoft.NetworkSecurity/neuroShields",
      method: "get",
      operationSha256:
        "7edd2d974f29b60b0e0d4a71c880bbf0e1355e9818f07a683acf1194595d26b0",
    },
    NeuroShields_ListByResourceGroup: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields",
      method: "get",
      operationSha256:
        "296e10b3b24b35195379b41cf9dc955bcb537c28c293bd6ef319d6a0ea6f0dd9",
    },
    NeuroShields_Get: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}",
      method: "get",
      operationSha256:
        "896d44d3f2dfd0311a2af97b572cc8ed1f876395bc6b2be250f31720720a2dcf",
    },
    NeuroShields_CreateOrUpdate: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}",
      method: "put",
      operationSha256:
        "10d2d78df1f2dcd5ffbd3952d804577baeefb63f67b04c18ee27920b1d83b1c3",
    },
    NeuroShields_Update: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}",
      method: "patch",
      operationSha256:
        "985ae3be7740b8f9034d771db62cabebb85fda442258f3b3905879fe32de72c3",
    },
    NeuroShields_Delete: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}",
      method: "delete",
      operationSha256:
        "c62c21497bb87781e736700d1989107110d3de3c74dd274296a25bcf2ba0f2d4",
    },
    NeuroShieldFindings_ListByNeuroShield: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/findings",
      method: "get",
      operationSha256:
        "8dae35dd90b7d898fb586ed00cf851bef4179ada37cb8b674b08246bb6bbaaa9",
    },
    NeuroShieldMitigations_ListByNeuroShield: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/mitigations",
      method: "get",
      operationSha256:
        "ee7cda56dd7cf5d54e2dca39f2f1cc5a51a2b895136452f1f0ddc498b31bd97b",
    },
    NeuroShieldProtectedResources_List: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources",
      method: "get",
      operationSha256:
        "f3f5d321e4f3d05b0fad228997c88bfe576cab34a58657d371318b72e273cbae",
    },
    NeuroShieldProtectedResources_Get: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}",
      method: "get",
      operationSha256:
        "7da70ba7c25bd257f14dd1a54d9ba083395764ad82c37b40ba288effc165c666",
    },
    NeuroShieldProtectedResources_CreateOrUpdate: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}",
      method: "put",
      operationSha256:
        "60e900be9e1d44db70ad6ced5e027fd0ef115f730a614464d210336d215a9c76",
    },
    NeuroShieldProtectedResources_Delete: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}",
      method: "delete",
      operationSha256:
        "bf72f32373360eefd805843e75d51504592075bcf346a6539b6baa9a7a5a202e",
    },
    NeuroShieldFindings_List: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/findings",
      method: "get",
      operationSha256:
        "236605e43ac80fb23854aef741df1d47681259b35bf1aaa6f7c9d83226d84e3a",
    },
    NeuroShieldFindings_Get: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/findings/{findingId}",
      method: "get",
      operationSha256:
        "103f3caf994c2756c1f7e53ce230b84106867010d8c600771fb1aa7f0eebda13",
    },
    NeuroShieldFindings_Mitigate: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/findings/{findingId}/mitigate",
      method: "post",
      operationSha256:
        "bf525c699b4684bcff027f97031e8d5f127836697484b960fb010db6959d02af",
    },
    NeuroShieldFindings_Rollback: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/findings/{findingId}/rollback",
      method: "post",
      operationSha256:
        "bb1ab210130a2ddb35bd29623ae740267e396faf5186d2e59f45317cd18bd34c",
    },
    NeuroShieldMitigations_List: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/mitigations",
      method: "get",
      operationSha256:
        "44aa3f12b262cb70aef7507ed1bfac5fb1db2159770fb5ae36adf64e230cc96e",
    },
    NeuroShieldMitigations_Get: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/mitigations/{mitigationId}",
      method: "get",
      operationSha256:
        "f634f9f5ff0f8e34800ddce8c43058f0d3b05d7038cf3d85f02d6091a3da9b68",
    },
    NeuroShieldMitigations_Execute: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/mitigations/{mitigationId}/execute",
      method: "post",
      operationSha256:
        "5a84ca35d0f360cd5c6ad68427065d08bc3f3eae580073c62d6399bf69ce9144",
    },
    NeuroShieldMitigations_Rollback: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/mitigations/{mitigationId}/rollback",
      method: "post",
      operationSha256:
        "d200e1ceeef63b767859d9642fbe7c3366ea95298fab0215dbfa2e6b0dabb2f8",
    },
    NeuroShieldProtectedResources_TriggerInventoryUpload: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/triggerInventoryUpload",
      method: "post",
      operationSha256:
        "fb184d6f18971b04c50d3decb1b3cada62efc5c1d930e738d012d793f28f3e84",
    },
    NeuroShieldSummaries_List: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/summary",
      method: "get",
      operationSha256:
        "a5f6f48b6ca780a2b019b9f4fc9fd5ef608f23876757fb05d8d9fc6012862607",
    },
    NeuroShieldSummaries_Get: {
      path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/summary/default",
      method: "get",
      operationSha256:
        "1bfa60b08590fba44f6b4c58c17cb4037c6557c449bfb760e84e517142d2bfe9",
    },
  },
  definitionHashes: {
    NeuroShieldAgentHealth:
      "3ec675a76f29957f9c433acdad31f7f2beaaac5c95a431cbb0407d779e9a75d0",
    NeuroShieldDescription:
      "c1302a154cb0338e60578d4e501c1eaf12481e378c20489d40c16bd10b03e357",
    NeuroShieldFinding:
      "40331809d31b4e1a0147cd2d9965538290a251e5b4d02d992934c8607168cfa0",
    NeuroShieldFindingListResult:
      "5f00279663425cd7573e8163cafa9d6c60895252423f5fd63b09b0a10c15f2f5",
    NeuroShieldFindingProperties:
      "bb5f24357cfd501fdd9084b31c4f6f29d52d18b30ddd3bd33aacac1378256d3b",
    NeuroShieldFindingStatus:
      "a8498b8b11fc85a83b340bb2a030750febcf06882e39fa998cfcbca701946e24",
    NeuroShieldGuid:
      "2828114a343e5c97eba832711422f1ccb66031bac4c41f01b656ebf53f7c43c2",
    NeuroShieldInventoryUploadRequestMetadata:
      "bfce550aa408108029d5fbf8e8c7b4c0e956618729c15b9bf47e213a34084c49",
    NeuroShieldInventoryUploadRequestResult:
      "b92ee09c492958638704835afde856a7dc935536fcad0188d5733c531c00e454",
    NeuroShieldMitigation:
      "89f8a587b7ea95959b2e62253fb967741eecc40fc7de98e4359539393634cc31",
    NeuroShieldMitigationActionResult:
      "55788795eff4bf08ee36d4a5649d3cb5b035166f3296b5a1adde8fa645d6db75",
    NeuroShieldMitigationListResult:
      "346554c53f42126ae365f5a96bcc1753ff4c5313872329f22049c5d398aee17d",
    NeuroShieldMitigationProperties:
      "7a2651bddb8c0f8f00f50c2765f7a8823f087ef6a734183336696cfa5156b399",
    NeuroShieldMitigationStatus:
      "d79b1acaa3eb5cf50febc93f42b639883b62503347102521ac00f9c399b96edf",
    NeuroShieldPatch:
      "e10889be56c58853495159672430a473ceaec900d97e3c4d89352d82edf550a2",
    NeuroShieldPatchProperties:
      "7ed17e1f67e6c611f1cf8702363a73515b6343e639ce041ad5f60c0367cfd182",
    NeuroShieldProperties:
      "64dc04813d47a0b5a9218b7a7b5282621ea91b1fe4e9d57a14c0bfc73b6e7451",
    NeuroShieldProtectedResource:
      "d297f3dc4a258c187fd0ca108bd06baaf08341b611804e57a384d808acb74377",
    NeuroShieldProtectedResourceIdentity:
      "6d9a59b31450eda5846591f3381e2545880e9a832cbfde9037e49a1407c3f5b4",
    NeuroShieldProtectedResourceListResult:
      "43328490e559eb2dac5e80d5a59d91e4d2e0f16a9199ec3d67eeace943c23a76",
    NeuroShieldProtectedResourceProperties:
      "bd3009c712f9540db1603765a4f0dd7be15b356382729f2c6f9b0a4bb079e21a",
    NeuroShieldProtectedResourceUserAssignedIdentity:
      "26769bec2d32e19c9e5042946696e7d606a36987bfbbe3ed721865727b837913",
    NeuroShieldResource:
      "ece74efef672ce46f5390a7fb6e0e4afaad8412dc14b1d79b5efde51b86990ce",
    NeuroShieldResourceListResult:
      "44e149653e4804e206265eefa33b66f0fbaf8a3a8b79a96e1cdfd7abc210d8d8",
    NeuroShieldResponseMode:
      "07a7408d2b5679b51b7e838dd9f0630d590f9665be6c3083751ade524b1bd5e6",
    NeuroShieldSeverityThreshold:
      "cfb080a8e2e68c45322b97343218f5f7afaf3ccefecf2af653fc89435bd574bb",
    NeuroShieldSummary:
      "3b7c34136bcf946ad9963c08f514828448786aa6b7f55a63f98d20e96fdde013",
    NeuroShieldSummaryListResult:
      "ffea426ececfdae3e8a130877506a72a2abb265cff6e9adcfe7b465baa523207",
    NeuroShieldSummaryProperties:
      "bb3c8000437021fc67a371cdbbc415f81066e036a651630ac6920469aa2bdeea",
    NeuroShieldTagValue:
      "0c22c43785bc28304e632ed262e0c1574c56c31a05179bc1ab778d6ce8b514c1",
    NeuroShieldTargetIdentityId:
      "17803209b1f15f25b3027f73316e03e720ce6c882110b97d5c78ca2f593ea1ed",
    ProvisioningStateNeuroShield:
      "c1d2d4280fc626723d46e84531d7f0d311aff78a0c4e2c03d63d5df35b92811e",
  },
  parameterHashes: {
    "NeuroShieldPaginationParameters.skipToken":
      "0d74e2520fea9f0a172532a50e137ba8e12f0ba29dc6182f8bed946155382aef",
    "NeuroShieldPaginationParameters.top":
      "ab3cbc859d9574f941e60d7d204723b45c5ea5b4c2f775eaadb112148ec52488",
    NeuroShieldSummaryListParameters:
      "ab3cbc859d9574f941e60d7d204723b45c5ea5b4c2f775eaadb112148ec52488",
  },
  sourceExampleHashes: {
    "NeuroShieldFindings_Get.json":
      "b80fdff661505b055098950f31947e6ce4ee0dc9b7e187bd0ee565f3897ee9d7",
    "NeuroShieldFindings_List.json":
      "5a082c0cfe63b77b0af3f92a28224e87377b8f9839f5c74d5f5cf2b081df4da8",
    "NeuroShieldFindings_ListByNeuroShield.json":
      "ee85e1e4f8368a0f720cb97fa6a7c09d726849ee2e3a791e425a15e0da946b94",
    "NeuroShieldFindings_Mitigate.json":
      "cc0f616f8b60e7d705ae982b073844f70e2c96f0f92cd0b39035df4a2845d806",
    "NeuroShieldFindings_Rollback.json":
      "22c26ff2c0affd542c2efadaa6c8a39959aa4c4293f18161656a1da71ca760ed",
    "NeuroShieldMitigations_Execute.json":
      "5d5cd7abe8703d907fc513abbd7c60228a8eb1411eba26894bf230786b7d3549",
    "NeuroShieldMitigations_Get.json":
      "28105d75acbc1af886bc78ecda8f58a74afd7fbb3ed411af61a37ef72c92aa3a",
    "NeuroShieldMitigations_Get_Failed.json":
      "5d81e56a71a1a8731be1aed943aedc66400b265c1606634b5c721e9d5a5bc303",
    "NeuroShieldMitigations_Get_InProgress.json":
      "5825de22686f8423a1968217b015add9657c2a7ddb56ef6c80992ac11b157d0a",
    "NeuroShieldMitigations_Get_Queued.json":
      "51df7c0096a480bf707c919a94140c0d083262eab9cc4d1c34275c814adf9b4f",
    "NeuroShieldMitigations_Get_Succeeded.json":
      "7276e884c10755a20300ba8305ba630ad43c3f454533b020cfe0fdb5101c3aa9",
    "NeuroShieldMitigations_List.json":
      "0689f748e16f747c2af4830cc634ea227613f68ecd2b1c1e7d05875807b8c0ae",
    "NeuroShieldMitigations_ListByNeuroShield.json":
      "25f689c6a171a84ebfe8a0963edd9f6e866988437b9833112b2f70f8312d9efa",
    "NeuroShieldMitigations_Rollback.json":
      "444db903c8e713b4367a0abc8613ba226a965d9cc4e76c9667e7ffd73aeffdb8",
    "NeuroShieldOperationStatuses_Get.json":
      "ed1fc4775d6f4457be36bc1c30db3d0160e474b36385dad8c31dc3e50c850657",
    "NeuroShieldProtectedResources_CreateOrUpdate.json":
      "e640ce90bb3caf4bea4394c7b6e153a0f66a1db48b50db6a8aff855af599f512",
    "NeuroShieldProtectedResources_CreateOrUpdate_NoneIdentity.json":
      "070c0ca9b69bbac820b8658f8686071b2b95da0d0394c4c4a25c88291a32e33d",
    "NeuroShieldProtectedResources_CreateOrUpdate_SystemAssigned.json":
      "7c6175c013b65da9d4ca19f334b218e3b149310944a890faa7c04509a732bfc2",
    "NeuroShieldProtectedResources_CreateOrUpdate_WithoutIdentity.json":
      "dd3caa1d5a6bc49a239cce785eaa02294006a0870b88e09d6c073a272d5c1cc8",
    "NeuroShieldProtectedResources_Delete.json":
      "bb3ef4f5bde499e893813e1953c3d1a5f93f59241504ed7d7c858034a8241b51",
    "NeuroShieldProtectedResources_Get.json":
      "664cc76e9360ec8d898c0b3552900a67ba2c55c69fc3e964237427f03e28e2b7",
    "NeuroShieldProtectedResources_List.json":
      "6c981216879d37971bd05fe8417b1ed528b1d1f02c9a1954a62bd4e58e966238",
    "NeuroShieldProtectedResources_TriggerInventoryUpload.json":
      "c8dda476b23c8a14bc56c3cd2ee85d8d0950acc0cdf739762e7ab81b2ae09d7e",
    "NeuroShieldSummaries_Get.json":
      "4ec7594889dc8e2b33f05566e50da4e632e1769d6306334acf5ec53a5bbb6363",
    "NeuroShieldSummaries_List.json":
      "6252d12459a31bbf032f1d29ab1bb43a2241e76b2da1dda4c58fe7b149dedac4",
    "NeuroShields_CreateOrUpdate.json":
      "379cbdad241ff512899ccc038940c4328dc49e13310150755d308fc2788560b4",
    "NeuroShields_CreateOrUpdate_OmittedOptionalProperties.json":
      "d8e4d1ada9097809963b4f2805c16fbfb8aa2e0057c8433f2c14ef29f56fb9c6",
    "NeuroShields_Delete.json":
      "6dc6785bb8d87ecd9e15e2e0d062e73cf6f979d631a816f2a3473f118fe954d9",
    "NeuroShields_Get.json":
      "3e89eea16d5afcef8edfe1c5ad9ca2e14a6fcd0eee83982bfea6914783a812ab",
    "NeuroShields_ListByResourceGroup.json":
      "6734cdb09c736389491d404dacdfcabde70429f226e382dd84cff59f98c789a6",
    "NeuroShields_ListBySubscription.json":
      "7020a35c2c7f2eb5a01b5f684a15ce9b53aece3486dae0619f253f71ff7007ae",
    "NeuroShields_Update.json":
      "75b72dd168219f775c4fe00d9b5f241bcd3e458f3582c0344632fbc5c5f0c9f9",
    "NeuroShields_Update_OmittedProperties.json":
      "de46cdfbcbdca4f1af711d5921dcd38be9b2755b7d776e7f9d83d11209b23253",
    "Operations_List.json":
      "2bf598ccf79ee6374dd1f77764037ae898a3dade6eedaf6d28cf5245650aeef4",
  },
  publicOperationsExample: {
    name: "Operations_List_Public.json",
    key: "List provider operations",
    sha256: "810c5522b3d5ec316437866c8c8ea9a89dc62280d9ea55f560cfc092da2ee3fc",
    binding: {
      $ref: "./examples/Operations_List_Public.json",
    },
  },
};
