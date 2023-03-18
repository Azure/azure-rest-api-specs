# Azure REST API Breaking Change And Oad Rules Mapping

## Overview
This specification describes the relationship between [oad rules](https://github.com/Azure/openapi-diff/tree/main/docs) and [breaking change policy](https://aka.ms/AzBreakingChangesPolicy).

## Mapping

| oad rule | breaking change category  
|---|---|
|[1002 - ProtocolNoLongerSupported](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1002.md) | breaking change |
|[1003 - RequestBodyFormatNoLongerSupported](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1003.md) | breaking change |
|[1004 - ResponseBodyFormatNowSupported](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1004.md) | breaking change |
|[1005 - RemovedPath](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1005.md) | breaking change |
|[1006 - RemovedDefinition](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1006.md) | breaking change |
|[1007 - RemovedClientParameter](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1007.md) | breaking change |
|[1008 - ModifiedOperationId](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1008.md) | breaking change |
|[1009 - RemovedRequiredParameter](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1009.md) | breaking change |
|[1010 - AddingRequiredParameter](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1010.md) | breaking change |
|[1011 - AddingResponseCode](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1011.md) | breaking change |
|[1012 - RemovedResponseCode](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1012.md) | breaking change |
|[1013 - AddingHeader](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1013.md) | breaking change |
|[1014 - RemovingHeader](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1014.md) | breaking change |
|[1015 - ParameterInHasChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1015.md) | breaking change |
|[1016 - ConstantStatusHasChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1016.md) | breaking change |
|[1017 - ReferenceRedirection](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1017.md) | breaking change |
|[1019 - RemovedEnumValue](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1019.md) | breaking change |
|[1020 - AddedEnumValue](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1020.md) |change allowed in a new api-version|
|[1021 - AddedAdditionalProperties](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1021.md) | breaking change |
|[1022 - RemovedAdditionalProperties](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1022.md) | breaking change |
|[1023 - TypeFormatChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1023.md) | breaking change |
|[1024 - ConstraintIsStronger](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1024.md) | breaking change |
|[1025 - RequiredStatusChange](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1025.md) | breaking change |
|[1026 - TypeChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1026.md) | breaking change |
|[1027 - DefaultValueChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1027.md) | breaking change |
|[1028 - ArrayCollectionFormatChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1028.md) | breaking change |
|[1029 - ReadonlyPropertyChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1029.md) | breaking change (exception: non if from 'true' to 'false')|
|[1030 - DifferentDiscriminator](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1030.md) | breaking change |
|[1031 - DifferentExtends](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1031.md) | breaking change |
|[1032 - DifferentAllOf](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1032.md) | breaking change |
|[1033 - RemovedProperty](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1033.md) | breaking change |
|[1034 - AddedRequiredProperty](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1034.md) | breaking change |
|[1035 - RemovedOperation](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1035.md) | breaking change |
|[1036 - ConstraintChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1036.md) | breaking change |
|[1037 - ConstraintIsWeaker](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1037.md) | breaking change (exception：non if applies to request parameter) |
|[1038 - AddedPath](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1038.md) |change allowed in a new api-version|
|[1039 - AddedOperation](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1039.md) |change allowed in a new api-version|
|[1040 - AddedReadOnlyPropertyInResponse](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1040.md) |change allowed in a new api-version |
|[1041 - AddedPropertyInResponse](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1041.md) | change allowed in a new api-version |
|[1042 - ChangedParameterOrder](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1042.md) | breaking change |
|[1043 - AddingOptionalParameter](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1043.md) | breaking change |
|[1044 - XmsLongRunningOperationChanged](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1044.md) | breaking change |
|[1045 - AddedOptionalProperty](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1045.md) | breaking change |
|[1046 - RemovedOptionalParameter](https://github.com/Azure/openapi-diff/blob/main/docs/rules/1046.md) | breaking change |

