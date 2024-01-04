TypeSpec compiler v0.51.0

Diagnostics were reported during compilation:

[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/Factory.tsp[39m:[33m162[39m:[33m11[39m - [31merror[39m[90m duplicate-symbol[39m: Duplicate name: "Triggers"
> 162 | interface Triggers {
      |           ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/TriggerResource.tsp[39m:[33m26[39m:[33m11[39m - [31merror[39m[90m duplicate-symbol[39m: Duplicate name: "Triggers"
> 26 | interface Triggers {
     |           ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/Factory.tsp[39m:[33m172[39m:[33m11[39m - [31merror[39m[90m duplicate-symbol[39m: Duplicate name: "TriggerRuns"
> 172 | interface TriggerRuns {
      |           ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/TriggerResource.tsp[39m:[33m78[39m:[33m11[39m - [31merror[39m[90m duplicate-symbol[39m: Duplicate name: "TriggerRuns"
> 78 | interface TriggerRuns {
     |           ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2293[39m:[33m7[39m - [31merror[39m[90m duplicate-symbol[39m: Duplicate name: "ChangeDataCapture"
> 2293 | model ChangeDataCapture {
       |       ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/ChangeDataCaptureResource.tsp[39m:[33m26[39m:[33m11[39m - [31merror[39m[90m duplicate-symbol[39m: Duplicate name: "ChangeDataCapture"
> 26 | interface ChangeDataCapture {
     |           ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1125[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1125 |   description?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1171[39m:[33m21[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1171 |   dataFactoryName?: string;
       |                     ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1175[39m:[33m11[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeState' is not assignable to type 'Record<unknown>'
> 1175 |   state?: IntegrationRuntimeState;
       |           ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1212[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1212 |   serviceToken?: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1216[39m:[33m28[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1216 |   identityCertThumbprint?: string;
       |                            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1220[39m:[33m20[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1220 |   hostServiceUri?: string;
       |                    ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1224[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1224 |   version?: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1228[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1228 |   publicKey?: string;
       |               ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1232[39m:[33m28[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 1232 |   isIdentityCertExprired?: boolean;
       |                            ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1263[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1263 |   nodeName?: string;
       |              ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1267[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1267 |   availableMemoryInMB?: int32;
       |                         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1271[39m:[33m20[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1271 |   cpuUtilization?: int32;
       |                    ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1275[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1275 |   concurrentJobsLimit?: int32;
       |                         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1279[39m:[33m27[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1279 |   concurrentJobsRunning?: int32;
       |                           ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1283[39m:[33m23[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1283 |   maxConcurrentJobs?: int32;
       |                       ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1287[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'float32' is not assignable to type 'Record<unknown>'
> 1287 |   sentBytes?: float32;
       |               ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1291[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'float32' is not assignable to type 'Record<unknown>'
> 1291 |   receivedBytes?: float32;
       |                   ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1363[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1363 |   nodeName?: string;
       |              ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1367[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1367 |   machineName?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1371[39m:[33m20[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1371 |   hostServiceUri?: string;
       |                    ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1375[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.SelfHostedIntegrationRuntimeNodeStatus' is not assignable to type 'Record<unknown>'
> 1375 |   status?: SelfHostedIntegrationRuntimeNodeStatus;
       |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1383[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1383 |   versionStatus?: string;
       |                   ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1387[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1387 |   version?: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1392[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1392 |   registerTime?: utcDateTime;
       |                  ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1397[39m:[33m21[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1397 |   lastConnectTime?: utcDateTime;
       |                     ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1402[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1402 |   expiryTime?: utcDateTime;
       |                ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1407[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1407 |   lastStartTime?: utcDateTime;
       |                   ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1412[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1412 |   lastStopTime?: utcDateTime;
       |                  ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1416[39m:[33m22[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeUpdateResult' is not assignable to type 'Record<unknown>'
> 1416 |   lastUpdateResult?: IntegrationRuntimeUpdateResult;
       |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1421[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1421 |   lastStartUpdateTime?: utcDateTime;
       |                         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1426[39m:[33m23[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1426 |   lastEndUpdateTime?: utcDateTime;
       |                       ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1430[39m:[33m24[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 1430 |   isActiveDispatcher?: boolean;
       |                        ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1434[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1434 |   concurrentJobsLimit?: int32;
       |                         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1438[39m:[33m23[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1438 |   maxConcurrentJobs?: int32;
       |                       ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1459[39m:[33m16[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeReference'.
> 1459 |   connectVia?: IntegrationRuntimeReference;
       |                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1462[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1462 |   description?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1468[39m:[33m17[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Record<unknown>[]'.
> 1468 |   annotations?: Record<unknown>[];
       |                 ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1496[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1496 |   description?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1505[39m:[33m22[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LinkedServiceReference'.
> 1505 |   linkedServiceName: LinkedServiceReference;
       |                      ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1511[39m:[33m17[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Record<unknown>[]'.
> 1511 |   annotations?: Record<unknown>[];
       |                 ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1514[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DatasetFolder'.
> 1514 |   folder?: DatasetFolder;
       |            ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1570[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1570 |   name: string;
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1573[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1573 |   description?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1576[39m:[33m11[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.ActivityState' is not assignable to type 'Record<unknown>'
> 1576 |   state?: ActivityState;
       |           ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1579[39m:[33m22[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.ActivityOnInactiveMarkAs' is not assignable to type 'Record<unknown>'
> 1579 |   onInactiveMarkAs?: ActivityOnInactiveMarkAs;
       |                      ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1591[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1591 |   activity: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1594[39m:[33m25[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DependencyCondition[]'.
> 1594 |   dependencyConditions: DependencyCondition[];
       |                         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1582[39m:[33m15[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ActivityDependency[]'.
> 1582 |   dependsOn?: ActivityDependency[];
       |               ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1585[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.UserProperty[]'.
> 1585 |   userProperties?: UserProperty[];
       |                    ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1693[39m:[33m11[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1693 |   runId?: string;
       |           ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1697[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1697 |   runGroupId?: string;
       |                ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1701[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 1701 |   isLatest?: boolean;
       |              ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1705[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1705 |   pipelineName?: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1717[39m:[33m15[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PipelineRunInvokedBy'.
> 1717 |   invokedBy?: PipelineRunInvokedBy;
       |               ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1722[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1722 |   lastUpdated?: utcDateTime;
       |                 ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1727[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1727 |   runStart?: utcDateTime;
       |              ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1732[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1732 |   runEnd?: utcDateTime;
       |            ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1736[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1736 |   durationInMs?: int32;
       |                  ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1740[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1740 |   status?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1744[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1744 |   message?: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1783[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1783 |   pipelineName?: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1787[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1787 |   pipelineRunId?: string;
       |                   ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1791[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1791 |   activityName?: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1795[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1795 |   activityType?: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1799[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1799 |   activityRunId?: string;
       |                   ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1803[39m:[33m23[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1803 |   linkedServiceName?: string;
       |                       ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1807[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1807 |   status?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1812[39m:[33m22[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1812 |   activityRunStart?: utcDateTime;
       |                      ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1817[39m:[33m20[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1817 |   activityRunEnd?: utcDateTime;
       |                    ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1821[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 1821 |   durationInMs?: int32;
       |                  ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1840[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1840 |   description?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1844[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.TriggerRuntimeState' is not assignable to type 'Record<unknown>'
> 1844 |   runtimeState?: TriggerRuntimeState;
       |                  ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1847[39m:[33m17[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Record<unknown>[]'.
> 1847 |   annotations?: Record<unknown>[];
       |                 ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1892[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1892 |   triggerRunId?: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1896[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1896 |   triggerName?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1900[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1900 |   triggerType?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1905[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 1905 |   triggerRunTimestamp?: utcDateTime;
       |                         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1909[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.TriggerRunStatus' is not assignable to type 'Record<unknown>'
> 1909 |   status?: TriggerRunStatus;
       |            ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1913[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1913 |   message?: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1994[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1994 |   dataFlowName?: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m1997[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1997 |   computeType?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2000[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 2000 |   coreCount?: int32;
       |               ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2003[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 2003 |   nodeCount?: int32;
       |               ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2006[39m:[33m28[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2006 |   integrationRuntimeName?: string;
       |                            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2009[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2009 |   sessionId?: string;
       |               ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2012[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2012 |   startTime?: string;
       |               ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2015[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 2015 |   timeToLiveInMinutes?: int32;
       |                         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2018[39m:[33m22[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2018 |   lastActivityTime?: string;
       |                      ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2024[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2024 |   sessionId?: string;
       |               ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2027[39m:[33m14[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DataFlowDebugResource'.
> 2027 |   dataFlow?: DataFlowDebugResource;
       |              ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2030[39m:[33m15[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DataFlowDebugResource[]'.
> 2030 |   dataFlows?: DataFlowDebugResource[];
       |               ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2033[39m:[33m14[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DatasetDebugResource[]'.
> 2033 |   datasets?: DatasetDebugResource[];
       |              ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2036[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LinkedServiceDebugResource[]'.
> 2036 |   linkedServices?: LinkedServiceDebugResource[];
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2039[39m:[33m13[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DataFlowStagingInfo'.
> 2039 |   staging?: DataFlowStagingInfo;
       |             ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2087[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2087 |   sourceName?: string;
       |                ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2090[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 2090 |   rowLimit?: int32;
       |              ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2042[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DataFlowDebugPackageDebugSettings'.
> 2042 |   debugSettings?: DataFlowDebugPackageDebugSettings;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2145[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2145 |   vNetId?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2149[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2149 |   `alias`?: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2155[39m:[33m21[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ConnectionStateProperties'.
> 2155 |   connectionState?: ConnectionStateProperties;
       |                     ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2158[39m:[33m11[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'string[]'.
> 2158 |   fqdns?: string[];
       |           ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2161[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2161 |   groupId?: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2165[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 2165 |   isReserved?: boolean;
       |                ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2168[39m:[33m27[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2168 |   privateLinkResourceId?: string;
       |                           ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2172[39m:[33m23[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2172 |   provisioningState?: string;
       |                       ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2209[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2209 |   description?: string;
       |                 ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2212[39m:[33m17[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Record<unknown>[]'.
> 2212 |   annotations?: Record<unknown>[];
       |                 ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2193[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ManagedIdentityTypeProperties'.
> 2193 |   typeProperties?: ManagedIdentityTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2196[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ManagedIdentity' is not assignable to type 'Record<unknown>'
> 2196 |   type: "ManagedIdentity";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2593[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2593 |   status?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2599[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.DataFlowReferenceType' is not assignable to type 'Record<unknown>'
> 2599 |   type: DataFlowReferenceType;
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2602[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2602 |   referenceName: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2623[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.CredentialReferenceType' is not assignable to type 'Record<unknown>'
> 2623 |   type: CredentialReferenceType;
       |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2626[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 2626 |   referenceName: string;
       |                  ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2771[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobStorageLocation' is not assignable to type 'Record<unknown>'
> 2771 |   type: "AzureBlobStorageLocation";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2780[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobFSLocation' is not assignable to type 'Record<unknown>'
> 2780 |   type: "AzureBlobFSLocation";
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2786[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeStoreLocation' is not assignable to type 'Record<unknown>'
> 2786 |   type: "AzureDataLakeStoreLocation";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2798[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonS3Location' is not assignable to type 'Record<unknown>'
> 2798 |   type: "AmazonS3Location";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2804[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FileServerLocation' is not assignable to type 'Record<unknown>'
> 2804 |   type: "FileServerLocation";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2810[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureFileStorageLocation' is not assignable to type 'Record<unknown>'
> 2810 |   type: "AzureFileStorageLocation";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2822[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonS3CompatibleLocation' is not assignable to type 'Record<unknown>'
> 2822 |   type: "AmazonS3CompatibleLocation";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2834[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleCloudStorageLocation' is not assignable to type 'Record<unknown>'
> 2834 |   type: "OracleCloudStorageLocation";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2846[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleCloudStorageLocation' is not assignable to type 'Record<unknown>'
> 2846 |   type: "GoogleCloudStorageLocation";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2852[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FtpServerLocation' is not assignable to type 'Record<unknown>'
> 2852 |   type: "FtpServerLocation";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2858[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SftpLocation' is not assignable to type 'Record<unknown>'
> 2858 |   type: "SftpLocation";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2867[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HttpServerLocation' is not assignable to type 'Record<unknown>'
> 2867 |   type: "HttpServerLocation";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2873[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HdfsLocation' is not assignable to type 'Record<unknown>'
> 2873 |   type: "HdfsLocation";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2879[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'LakeHouseLocation' is not assignable to type 'Record<unknown>'
> 2879 |   type: "LakeHouseLocation";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2940[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TextFormat' is not assignable to type 'Record<unknown>'
> 2940 |   type: "TextFormat";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2961[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'JsonFormat' is not assignable to type 'Record<unknown>'
> 2961 |   type: "JsonFormat";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2967[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AvroFormat' is not assignable to type 'Record<unknown>'
> 2967 |   type: "AvroFormat";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2973[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OrcFormat' is not assignable to type 'Record<unknown>'
> 2973 |   type: "OrcFormat";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2979[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ParquetFormat' is not assignable to type 'Record<unknown>'
> 2979 |   type: "ParquetFormat";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2994[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonS3DatasetTypeProperties'.
> 2994 |   typeProperties: AmazonS3DatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m2997[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonS3Object' is not assignable to type 'Record<unknown>'
> 2997 |   type: "AmazonS3Object";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3030[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AvroDatasetTypeProperties'.
> 3030 |   typeProperties?: AvroDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3033[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Avro' is not assignable to type 'Record<unknown>'
> 3033 |   type: "Avro";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3052[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ExcelDatasetTypeProperties'.
> 3052 |   typeProperties?: ExcelDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3055[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Excel' is not assignable to type 'Record<unknown>'
> 3055 |   type: "Excel";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3085[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ParquetDatasetTypeProperties'.
> 3085 |   typeProperties?: ParquetDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3088[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Parquet' is not assignable to type 'Record<unknown>'
> 3088 |   type: "Parquet";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3103[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DelimitedTextDatasetTypeProperties'.
> 3103 |   typeProperties?: DelimitedTextDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3106[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DelimitedText' is not assignable to type 'Record<unknown>'
> 3106 |   type: "DelimitedText";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3145[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.JsonDatasetTypeProperties'.
> 3145 |   typeProperties?: JsonDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3148[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Json' is not assignable to type 'Record<unknown>'
> 3148 |   type: "Json";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3166[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.XmlDatasetTypeProperties'.
> 3166 |   typeProperties?: XmlDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3169[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Xml' is not assignable to type 'Record<unknown>'
> 3169 |   type: "Xml";
       |         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3190[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OrcDatasetTypeProperties'.
> 3190 |   typeProperties?: OrcDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3193[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Orc' is not assignable to type 'Record<unknown>'
> 3193 |   type: "Orc";
       |         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3208[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.BinaryDatasetTypeProperties'.
> 3208 |   typeProperties?: BinaryDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3211[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Binary' is not assignable to type 'Record<unknown>'
> 3211 |   type: "Binary";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3226[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureBlobDatasetTypeProperties'.
> 3226 |   typeProperties?: AzureBlobDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3229[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlob' is not assignable to type 'Record<unknown>'
> 3229 |   type: "AzureBlob";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3259[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureTableDatasetTypeProperties'.
> 3259 |   typeProperties: AzureTableDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3262[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureTable' is not assignable to type 'Record<unknown>'
> 3262 |   type: "AzureTable";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3274[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSqlTableDatasetTypeProperties'.
> 3274 |   typeProperties?: AzureSqlTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3277[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlTable' is not assignable to type 'Record<unknown>'
> 3277 |   type: "AzureSqlTable";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3295[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSqlMITableDatasetTypeProperties'.
> 3295 |   typeProperties?: AzureSqlMITableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3298[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlMITable' is not assignable to type 'Record<unknown>'
> 3298 |   type: "AzureSqlMITable";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3316[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSqlDWTableDatasetTypeProperties'.
> 3316 |   typeProperties?: AzureSqlDWTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3319[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlDWTable' is not assignable to type 'Record<unknown>'
> 3319 |   type: "AzureSqlDWTable";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3337[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CassandraTableDatasetTypeProperties'.
> 3337 |   typeProperties?: CassandraTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3340[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CassandraTable' is not assignable to type 'Record<unknown>'
> 3340 |   type: "CassandraTable";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3358[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CustomDataset' is not assignable to type 'Record<unknown>'
> 3358 |   type: "CustomDataset";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3364[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CosmosDbSqlApiCollectionDatasetTypeProperties'.
> 3364 |   typeProperties: CosmosDbSqlApiCollectionDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3367[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDbSqlApiCollection' is not assignable to type 'Record<unknown>'
> 3367 |   type: "CosmosDbSqlApiCollection";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3379[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DocumentDbCollectionDatasetTypeProperties'.
> 3379 |   typeProperties: DocumentDbCollectionDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3382[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DocumentDbCollection' is not assignable to type 'Record<unknown>'
> 3382 |   type: "DocumentDbCollection";
       |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3394[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DynamicsEntityDatasetTypeProperties'.
> 3394 |   typeProperties?: DynamicsEntityDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3397[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsEntity' is not assignable to type 'Record<unknown>'
> 3397 |   type: "DynamicsEntity";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3409[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DynamicsCrmEntityDatasetTypeProperties'.
> 3409 |   typeProperties?: DynamicsCrmEntityDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3412[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsCrmEntity' is not assignable to type 'Record<unknown>'
> 3412 |   type: "DynamicsCrmEntity";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3424[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CommonDataServiceForAppsEntityDatasetTypeProperties'.
> 3424 |   typeProperties?: CommonDataServiceForAppsEntityDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3427[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CommonDataServiceForAppsEntity' is not assignable to type 'Record<unknown>'
> 3427 |   type: "CommonDataServiceForAppsEntity";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3439[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDataLakeStoreDatasetTypeProperties'.
> 3439 |   typeProperties?: AzureDataLakeStoreDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3442[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeStoreFile' is not assignable to type 'Record<unknown>'
> 3442 |   type: "AzureDataLakeStoreFile";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3463[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureBlobFSDatasetTypeProperties'.
> 3463 |   typeProperties?: AzureBlobFSDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3466[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobFSFile' is not assignable to type 'Record<unknown>'
> 3466 |   type: "AzureBlobFSFile";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3487[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.Office365DatasetTypeProperties'.
> 3487 |   typeProperties: Office365DatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3490[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Office365Table' is not assignable to type 'Record<unknown>'
> 3490 |   type: "Office365Table";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3505[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.FileShareDatasetTypeProperties'.
> 3505 |   typeProperties?: FileShareDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3508[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FileShare' is not assignable to type 'Record<unknown>'
> 3508 |   type: "FileShare";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3538[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbCollectionDatasetTypeProperties'.
> 3538 |   typeProperties: MongoDbCollectionDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3541[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbCollection' is not assignable to type 'Record<unknown>'
> 3541 |   type: "MongoDbCollection";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3553[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbAtlasCollectionDatasetTypeProperties'.
> 3553 |   typeProperties: MongoDbAtlasCollectionDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3556[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbAtlasCollection' is not assignable to type 'Record<unknown>'
> 3556 |   type: "MongoDbAtlasCollection";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3568[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbV2CollectionDatasetTypeProperties'.
> 3568 |   typeProperties: MongoDbV2CollectionDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3571[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbV2Collection' is not assignable to type 'Record<unknown>'
> 3571 |   type: "MongoDbV2Collection";
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3583[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CosmosDbMongoDbApiCollectionDatasetTypeProperties'.
> 3583 |   typeProperties: CosmosDbMongoDbApiCollectionDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3586[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDbMongoDbApiCollection' is not assignable to type 'Record<unknown>'
> 3586 |   type: "CosmosDbMongoDbApiCollection";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3598[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ODataResourceDatasetTypeProperties'.
> 3598 |   typeProperties?: ODataResourceDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3601[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ODataResource' is not assignable to type 'Record<unknown>'
> 3601 |   type: "ODataResource";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3613[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OracleTableDatasetTypeProperties'.
> 3613 |   typeProperties?: OracleTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3616[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleTable' is not assignable to type 'Record<unknown>'
> 3616 |   type: "OracleTable";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3634[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonRdsForOracleTableDatasetTypeProperties'.
> 3634 |   typeProperties?: AmazonRdsForOracleTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3637[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRdsForOracleTable' is not assignable to type 'Record<unknown>'
> 3637 |   type: "AmazonRdsForOracleTable";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3652[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TeradataTableDatasetTypeProperties'.
> 3652 |   typeProperties?: TeradataTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3655[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TeradataTable' is not assignable to type 'Record<unknown>'
> 3655 |   type: "TeradataTable";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3670[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMySqlTableDatasetTypeProperties'.
> 3670 |   typeProperties: AzureMySqlTableDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3673[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMySqlTable' is not assignable to type 'Record<unknown>'
> 3673 |   type: "AzureMySqlTable";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3688[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonRedshiftTableDatasetTypeProperties'.
> 3688 |   typeProperties?: AmazonRedshiftTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3691[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRedshiftTable' is not assignable to type 'Record<unknown>'
> 3691 |   type: "AmazonRedshiftTable";
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3709[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.Db2TableDatasetTypeProperties'.
> 3709 |   typeProperties?: Db2TableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3712[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Db2Table' is not assignable to type 'Record<unknown>'
> 3712 |   type: "Db2Table";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3730[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.RelationalTableDatasetTypeProperties'.
> 3730 |   typeProperties?: RelationalTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3733[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'RelationalTable' is not assignable to type 'Record<unknown>'
> 3733 |   type: "RelationalTable";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3745[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.InformixTableDatasetTypeProperties'.
> 3745 |   typeProperties?: InformixTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3748[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'InformixTable' is not assignable to type 'Record<unknown>'
> 3748 |   type: "InformixTable";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3760[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OdbcTableDatasetTypeProperties'.
> 3760 |   typeProperties?: OdbcTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3763[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OdbcTable' is not assignable to type 'Record<unknown>'
> 3763 |   type: "OdbcTable";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3775[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MySqlTableDatasetTypeProperties'.
> 3775 |   typeProperties?: MySqlTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3778[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MySqlTable' is not assignable to type 'Record<unknown>'
> 3778 |   type: "MySqlTable";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3790[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PostgreSqlTableDatasetTypeProperties'.
> 3790 |   typeProperties?: PostgreSqlTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3793[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PostgreSqlTable' is not assignable to type 'Record<unknown>'
> 3793 |   type: "PostgreSqlTable";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3811[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MicrosoftAccessTableDatasetTypeProperties'.
> 3811 |   typeProperties?: MicrosoftAccessTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3814[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MicrosoftAccessTable' is not assignable to type 'Record<unknown>'
> 3814 |   type: "MicrosoftAccessTable";
       |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3826[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SalesforceObjectDatasetTypeProperties'.
> 3826 |   typeProperties?: SalesforceObjectDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3829[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceObject' is not assignable to type 'Record<unknown>'
> 3829 |   type: "SalesforceObject";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3841[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SalesforceServiceCloudObjectDatasetTypeProperties'.
> 3841 |   typeProperties?: SalesforceServiceCloudObjectDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3844[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceServiceCloudObject' is not assignable to type 'Record<unknown>'
> 3844 |   type: "SalesforceServiceCloudObject";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3856[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SybaseTableDatasetTypeProperties'.
> 3856 |   typeProperties?: SybaseTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3859[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SybaseTable' is not assignable to type 'Record<unknown>'
> 3859 |   type: "SybaseTable";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3871[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapBwCube' is not assignable to type 'Record<unknown>'
> 3871 |   type: "SapBwCube";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3877[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapCloudForCustomerResourceDatasetTypeProperties'.
> 3877 |   typeProperties: SapCloudForCustomerResourceDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3880[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapCloudForCustomerResource' is not assignable to type 'Record<unknown>'
> 3880 |   type: "SapCloudForCustomerResource";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3892[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapEccResourceDatasetTypeProperties'.
> 3892 |   typeProperties: SapEccResourceDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3895[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapEccResource' is not assignable to type 'Record<unknown>'
> 3895 |   type: "SapEccResource";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3907[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapHanaTableDatasetTypeProperties'.
> 3907 |   typeProperties?: SapHanaTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3910[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapHanaTable' is not assignable to type 'Record<unknown>'
> 3910 |   type: "SapHanaTable";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3925[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapOpenHubTableDatasetTypeProperties'.
> 3925 |   typeProperties: SapOpenHubTableDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3928[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapOpenHubTable' is not assignable to type 'Record<unknown>'
> 3928 |   type: "SapOpenHubTable";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3946[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlServerTableDatasetTypeProperties'.
> 3946 |   typeProperties?: SqlServerTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3949[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlServerTable' is not assignable to type 'Record<unknown>'
> 3949 |   type: "SqlServerTable";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3967[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonRdsForSqlServerTableDatasetTypeProperties'.
> 3967 |   typeProperties?: AmazonRdsForSqlServerTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3970[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRdsForSqlServerTable' is not assignable to type 'Record<unknown>'
> 3970 |   type: "AmazonRdsForSqlServerTable";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3985[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.RestResourceDatasetTypeProperties'.
> 3985 |   typeProperties?: RestResourceDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m3988[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'RestResource' is not assignable to type 'Record<unknown>'
> 3988 |   type: "RestResource";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4012[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapTableResourceDatasetTypeProperties'.
> 4012 |   typeProperties: SapTableResourceDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4015[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapTableResource' is not assignable to type 'Record<unknown>'
> 4015 |   type: "SapTableResource";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4027[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapOdpResourceDatasetTypeProperties'.
> 4027 |   typeProperties: SapOdpResourceDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4030[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapOdpResource' is not assignable to type 'Record<unknown>'
> 4030 |   type: "SapOdpResource";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4045[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.WebTableDatasetTypeProperties'.
> 4045 |   typeProperties: WebTableDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4048[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'WebTable' is not assignable to type 'Record<unknown>'
> 4048 |   type: "WebTable";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4063[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSearchIndexDatasetTypeProperties'.
> 4063 |   typeProperties: AzureSearchIndexDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4066[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSearchIndex' is not assignable to type 'Record<unknown>'
> 4066 |   type: "AzureSearchIndex";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4078[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HttpDatasetTypeProperties'.
> 4078 |   typeProperties?: HttpDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4081[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HttpFile' is not assignable to type 'Record<unknown>'
> 4081 |   type: "HttpFile";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4118[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4118 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4121[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonMWSObject' is not assignable to type 'Record<unknown>'
> 4121 |   type: "AmazonMWSObject";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4127[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzurePostgreSqlTableDatasetTypeProperties'.
> 4127 |   typeProperties?: AzurePostgreSqlTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4130[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzurePostgreSqlTable' is not assignable to type 'Record<unknown>'
> 4130 |   type: "AzurePostgreSqlTable";
       |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4148[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4148 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4151[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ConcurObject' is not assignable to type 'Record<unknown>'
> 4151 |   type: "ConcurObject";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4157[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4157 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4160[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CouchbaseTable' is not assignable to type 'Record<unknown>'
> 4160 |   type: "CouchbaseTable";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4166[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DrillDatasetTypeProperties'.
> 4166 |   typeProperties?: DrillDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4169[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DrillTable' is not assignable to type 'Record<unknown>'
> 4169 |   type: "DrillTable";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4187[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4187 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4190[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'EloquaObject' is not assignable to type 'Record<unknown>'
> 4190 |   type: "EloquaObject";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4196[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GoogleBigQueryDatasetTypeProperties'.
> 4196 |   typeProperties?: GoogleBigQueryDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4199[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleBigQueryObject' is not assignable to type 'Record<unknown>'
> 4199 |   type: "GoogleBigQueryObject";
       |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4217[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GreenplumDatasetTypeProperties'.
> 4217 |   typeProperties?: GreenplumDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4220[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GreenplumTable' is not assignable to type 'Record<unknown>'
> 4220 |   type: "GreenplumTable";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4238[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4238 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4241[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HBaseObject' is not assignable to type 'Record<unknown>'
> 4241 |   type: "HBaseObject";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4247[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HiveDatasetTypeProperties'.
> 4247 |   typeProperties?: HiveDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4250[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HiveObject' is not assignable to type 'Record<unknown>'
> 4250 |   type: "HiveObject";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4268[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4268 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4271[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HubspotObject' is not assignable to type 'Record<unknown>'
> 4271 |   type: "HubspotObject";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4277[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ImpalaDatasetTypeProperties'.
> 4277 |   typeProperties?: ImpalaDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4280[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ImpalaObject' is not assignable to type 'Record<unknown>'
> 4280 |   type: "ImpalaObject";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4298[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4298 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4301[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'JiraObject' is not assignable to type 'Record<unknown>'
> 4301 |   type: "JiraObject";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4307[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4307 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4310[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MagentoObject' is not assignable to type 'Record<unknown>'
> 4310 |   type: "MagentoObject";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4316[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4316 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4319[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MariaDBTable' is not assignable to type 'Record<unknown>'
> 4319 |   type: "MariaDBTable";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4325[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4325 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4328[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMariaDBTable' is not assignable to type 'Record<unknown>'
> 4328 |   type: "AzureMariaDBTable";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4334[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4334 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4337[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MarketoObject' is not assignable to type 'Record<unknown>'
> 4337 |   type: "MarketoObject";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4343[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4343 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4346[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PaypalObject' is not assignable to type 'Record<unknown>'
> 4346 |   type: "PaypalObject";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4352[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PhoenixDatasetTypeProperties'.
> 4352 |   typeProperties?: PhoenixDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4355[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PhoenixObject' is not assignable to type 'Record<unknown>'
> 4355 |   type: "PhoenixObject";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4373[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PrestoDatasetTypeProperties'.
> 4373 |   typeProperties?: PrestoDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4376[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PrestoObject' is not assignable to type 'Record<unknown>'
> 4376 |   type: "PrestoObject";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4394[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4394 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4397[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'QuickBooksObject' is not assignable to type 'Record<unknown>'
> 4397 |   type: "QuickBooksObject";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4403[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4403 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4406[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ServiceNowObject' is not assignable to type 'Record<unknown>'
> 4406 |   type: "ServiceNowObject";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4412[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4412 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4415[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ShopifyObject' is not assignable to type 'Record<unknown>'
> 4415 |   type: "ShopifyObject";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4421[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SparkDatasetTypeProperties'.
> 4421 |   typeProperties?: SparkDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4424[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SparkObject' is not assignable to type 'Record<unknown>'
> 4424 |   type: "SparkObject";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4442[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4442 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4445[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SquareObject' is not assignable to type 'Record<unknown>'
> 4445 |   type: "SquareObject";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4451[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4451 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4454[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'XeroObject' is not assignable to type 'Record<unknown>'
> 4454 |   type: "XeroObject";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4460[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4460 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4463[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ZohoObject' is not assignable to type 'Record<unknown>'
> 4463 |   type: "ZohoObject";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4469[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.NetezzaTableDatasetTypeProperties'.
> 4469 |   typeProperties?: NetezzaTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4472[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'NetezzaTable' is not assignable to type 'Record<unknown>'
> 4472 |   type: "NetezzaTable";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4490[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.VerticaDatasetTypeProperties'.
> 4490 |   typeProperties?: VerticaDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4493[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'VerticaTable' is not assignable to type 'Record<unknown>'
> 4493 |   type: "VerticaTable";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4511[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4511 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4514[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceMarketingCloudObject' is not assignable to type 'Record<unknown>'
> 4514 |   type: "SalesforceMarketingCloudObject";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4520[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4520 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4523[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ResponsysObject' is not assignable to type 'Record<unknown>'
> 4523 |   type: "ResponsysObject";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4529[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DynamicsAXResourceDatasetTypeProperties'.
> 4529 |   typeProperties: DynamicsAXResourceDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4532[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsAXResource' is not assignable to type 'Record<unknown>'
> 4532 |   type: "DynamicsAXResource";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4544[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4544 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4547[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleServiceCloudObject' is not assignable to type 'Record<unknown>'
> 4547 |   type: "OracleServiceCloudObject";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4553[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDataExplorerDatasetTypeProperties'.
> 4553 |   typeProperties: AzureDataExplorerDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4556[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataExplorerTable' is not assignable to type 'Record<unknown>'
> 4556 |   type: "AzureDataExplorerTable";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4568[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GenericDatasetTypeProperties'.
> 4568 |   typeProperties?: GenericDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4571[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleAdWordsObject' is not assignable to type 'Record<unknown>'
> 4571 |   type: "GoogleAdWordsObject";
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4577[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SnowflakeDatasetTypeProperties'.
> 4577 |   typeProperties: SnowflakeDatasetTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4580[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SnowflakeTable' is not assignable to type 'Record<unknown>'
> 4580 |   type: "SnowflakeTable";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4595[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SharePointOnlineListDatasetTypeProperties'.
> 4595 |   typeProperties?: SharePointOnlineListDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4598[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SharePointOnlineListResource' is not assignable to type 'Record<unknown>'
> 4598 |   type: "SharePointOnlineListResource";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4610[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDatabricksDeltaLakeDatasetTypeProperties'.
> 4610 |   typeProperties?: AzureDatabricksDeltaLakeDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4613[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDatabricksDeltaLakeDataset' is not assignable to type 'Record<unknown>'
> 4613 |   type: "AzureDatabricksDeltaLakeDataset";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4628[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LakeHouseTableDatasetTypeProperties'.
> 4628 |   typeProperties?: LakeHouseTableDatasetTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4631[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'LakeHouseTable' is not assignable to type 'Record<unknown>'
> 4631 |   type: "LakeHouseTable";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4644[39m:[33m11[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeState' is not assignable to type 'Record<unknown>'
> 4644 |   state?: IntegrationRuntimeState;
       |           ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4671[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4671 |   location?: string;
       |              ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4674[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4674 |   nodeSize?: string;
       |              ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4678[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4678 |   numberOfNodes?: int32;
       |                   ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4682[39m:[33m34[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4682 |   maxParallelExecutionsPerNode?: int32;
       |                                  ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4700[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.DataFlowComputeType' is not assignable to type 'Record<unknown>'
> 4700 |   computeType?: DataFlowComputeType;
       |                 ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4703[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4703 |   coreCount?: int32;
       |               ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4706[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4706 |   timeToLive?: int32;
       |                ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4709[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 4709 |   cleanup?: boolean;
       |             ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4712[39m:[33m22[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem[]'.
> 4712 |   customProperties?: IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem[];
       |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4685[39m:[33m24[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeDataFlowProperties'.
> 4685 |   dataFlowProperties?: IntegrationRuntimeDataFlowProperties;
       |                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4726[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4726 |   vNetId?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4729[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4729 |   subnet?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4732[39m:[33m15[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'string[]'.
> 4732 |   publicIPs?: string[];
       |               ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4735[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4735 |   subnetId?: string;
       |              ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4688[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeVNetProperties'.
> 4688 |   vNetProperties?: IntegrationRuntimeVNetProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4742[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4742 |   dataIntegrationUnit?: int32;
       |                         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4746[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4746 |   timeToLive?: int32;
       |                ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4691[39m:[33m32[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CopyComputeScaleProperties'.
> 4691 |   copyComputeScaleProperties?: CopyComputeScaleProperties;
       |                                ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4753[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4753 |   timeToLive?: int32;
       |                ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4758[39m:[33m27[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4758 |   numberOfPipelineNodes?: int32;
       |                           ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4763[39m:[33m27[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 4763 |   numberOfExternalNodes?: int32;
       |                           ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4694[39m:[33m44[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PipelineExternalComputeScaleProperties'.
> 4694 |   pipelineExternalComputeScaleProperties?: PipelineExternalComputeScaleProperties;
       |                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4796[39m:[33m27[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4796 |   catalogServerEndpoint?: string;
       |                           ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4801[39m:[33m26[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4801 |   catalogAdminUserName?: string;
       |                          ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4804[39m:[33m26[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SecureString'.
> 4804 |   catalogAdminPassword?: SecureString;
       |                          ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4807[39m:[33m24[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeSsisCatalogPricingTier' is not assignable to type 'Record<unknown>'
> 4807 |   catalogPricingTier?: IntegrationRuntimeSsisCatalogPricingTier;
       |                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4810[39m:[33m25[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 4810 |   dualStandbyPairName?: string;
       |                         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4769[39m:[33m17[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeSsisCatalogInfo'.
> 4769 |   catalogInfo?: IntegrationRuntimeSsisCatalogInfo;
       |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4772[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeLicenseType' is not assignable to type 'Record<unknown>'
> 4772 |   licenseType?: IntegrationRuntimeLicenseType;
       |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4775[39m:[33m33[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeCustomSetupScriptProperties'.
> 4775 |   customSetupScriptProperties?: IntegrationRuntimeCustomSetupScriptProperties;
       |                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4778[39m:[33m25[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeDataProxyProperties'.
> 4778 |   dataProxyProperties?: IntegrationRuntimeDataProxyProperties;
       |                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4781[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.IntegrationRuntimeEdition' is not assignable to type 'Record<unknown>'
> 4781 |   edition?: IntegrationRuntimeEdition;
       |             ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4784[39m:[33m34[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CustomSetupBase[]'.
> 4784 |   expressCustomSetupProperties?: CustomSetupBase[];
       |                                  ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4787[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PackageStore[]'.
> 4787 |   packageStores?: PackageStore[];
       |                   ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4790[39m:[33m16[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CredentialReference'.
> 4790 |   credential?: CredentialReference;
       |                ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4647[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ManagedIntegrationRuntimeTypeProperties'.
> 4647 |   typeProperties: ManagedIntegrationRuntimeTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4650[39m:[33m27[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ManagedVirtualNetworkReference'.
> 4650 |   managedVirtualNetwork?: ManagedVirtualNetworkReference;
       |                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4653[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Managed' is not assignable to type 'Record<unknown>'
> 4653 |   type: "Managed";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4937[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SelfHostedIntegrationRuntimeTypeProperties'.
> 4937 |   typeProperties?: SelfHostedIntegrationRuntimeTypeProperties;
       |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4940[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SelfHosted' is not assignable to type 'Record<unknown>'
> 4940 |   type: "SelfHosted";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5012[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 5012 |   nodeId?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5016[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.ManagedIntegrationRuntimeNodeStatus' is not assignable to type 'Record<unknown>'
> 5016 |   status?: ManagedIntegrationRuntimeNodeStatus;
       |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5027[39m:[33m10[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 5027 |   time?: utcDateTime;
       |          ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5031[39m:[33m10[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 5031 |   code?: string;
       |          ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5035[39m:[33m16[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'string[]'.
> 5035 |   parameters?: string[];
       |                ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5039[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 5039 |   message?: string;
       |             ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5019[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ManagedIntegrationRuntimeError[]'.
> 5019 |   errors?: ManagedIntegrationRuntimeError[];
       |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5046[39m:[33m10[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 5046 |   type?: string;
       |          ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5051[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 5051 |   startTime?: utcDateTime;
       |               ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5055[39m:[33m12[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 5055 |   result?: string;
       |            ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5059[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 5059 |   errorCode?: string;
       |               ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5063[39m:[33m16[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'string[]'.
> 5063 |   parameters?: string[];
       |                ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5067[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 5067 |   activityId?: string;
       |                ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4982[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ManagedIntegrationRuntimeStatusTypeProperties'.
> 4982 |   typeProperties: ManagedIntegrationRuntimeStatusTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m4985[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Managed' is not assignable to type 'Record<unknown>'
> 4985 |   type: "Managed";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5073[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SelfHostedIntegrationRuntimeStatusTypeProperties'.
> 5073 |   typeProperties: SelfHostedIntegrationRuntimeStatusTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5076[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SelfHosted' is not assignable to type 'Record<unknown>'
> 5076 |   type: "SelfHosted";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5310[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureStorageLinkedServiceTypeProperties'.
> 5310 |   typeProperties: AzureStorageLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5313[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureStorage' is not assignable to type 'Record<unknown>'
> 5313 |   type: "AzureStorage";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5337[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureBlobStorageLinkedServiceTypeProperties'.
> 5337 |   typeProperties: AzureBlobStorageLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5340[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobStorage' is not assignable to type 'Record<unknown>'
> 5340 |   type: "AzureBlobStorage";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5391[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureStorageLinkedServiceTypeProperties'.
> 5391 |   typeProperties: AzureStorageLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5394[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureTableStorage' is not assignable to type 'Record<unknown>'
> 5394 |   type: "AzureTableStorage";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5400[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSqlDWLinkedServiceTypeProperties'.
> 5400 |   typeProperties: AzureSqlDWLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5403[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlDW' is not assignable to type 'Record<unknown>'
> 5403 |   type: "AzureSqlDW";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5436[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlServerLinkedServiceTypeProperties'.
> 5436 |   typeProperties: SqlServerLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5439[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlServer' is not assignable to type 'Record<unknown>'
> 5439 |   type: "SqlServer";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5478[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonRdsForSqlServerLinkedServiceTypeProperties'.
> 5478 |   typeProperties: AmazonRdsForSqlServerLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5481[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRdsForSqlServer' is not assignable to type 'Record<unknown>'
> 5481 |   type: "AmazonRdsForSqlServer";
       |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5505[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSqlDatabaseLinkedServiceTypeProperties'.
> 5505 |   typeProperties: AzureSqlDatabaseLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5508[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlDatabase' is not assignable to type 'Record<unknown>'
> 5508 |   type: "AzureSqlDatabase";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5544[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSqlMILinkedServiceTypeProperties'.
> 5544 |   typeProperties: AzureSqlMILinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5547[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlMI' is not assignable to type 'Record<unknown>'
> 5547 |   type: "AzureSqlMI";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5583[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureBatchLinkedServiceTypeProperties'.
> 5583 |   typeProperties: AzureBatchLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5586[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBatch' is not assignable to type 'Record<unknown>'
> 5586 |   type: "AzureBatch";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5616[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureKeyVaultLinkedServiceTypeProperties'.
> 5616 |   typeProperties: AzureKeyVaultLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5619[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureKeyVault' is not assignable to type 'Record<unknown>'
> 5619 |   type: "AzureKeyVault";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5634[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CosmosDbLinkedServiceTypeProperties'.
> 5634 |   typeProperties: CosmosDbLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5637[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDb' is not assignable to type 'Record<unknown>'
> 5637 |   type: "CosmosDb";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5682[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DynamicsLinkedServiceTypeProperties'.
> 5682 |   typeProperties: DynamicsLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5685[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Dynamics' is not assignable to type 'Record<unknown>'
> 5685 |   type: "Dynamics";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5733[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DynamicsCrmLinkedServiceTypeProperties'.
> 5733 |   typeProperties: DynamicsCrmLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5736[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsCrm' is not assignable to type 'Record<unknown>'
> 5736 |   type: "DynamicsCrm";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5781[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CommonDataServiceForAppsLinkedServiceTypeProperties'.
> 5781 |   typeProperties: CommonDataServiceForAppsLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5784[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CommonDataServiceForApps' is not assignable to type 'Record<unknown>'
> 5784 |   type: "CommonDataServiceForApps";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5829[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HDInsightLinkedServiceTypeProperties'.
> 5829 |   typeProperties: HDInsightLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5832[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HDInsight' is not assignable to type 'Record<unknown>'
> 5832 |   type: "HDInsight";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5865[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.FileServerLinkedServiceTypeProperties'.
> 5865 |   typeProperties: FileServerLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5868[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FileServer' is not assignable to type 'Record<unknown>'
> 5868 |   type: "FileServer";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5889[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureFileStorageLinkedServiceTypeProperties'.
> 5889 |   typeProperties: AzureFileStorageLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5892[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureFileStorage' is not assignable to type 'Record<unknown>'
> 5892 |   type: "AzureFileStorage";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5931[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonS3CompatibleLinkedServiceTypeProperties'.
> 5931 |   typeProperties: AmazonS3CompatibleLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5934[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonS3Compatible' is not assignable to type 'Record<unknown>'
> 5934 |   type: "AmazonS3Compatible";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5958[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OracleCloudStorageLinkedServiceTypeProperties'.
> 5958 |   typeProperties: OracleCloudStorageLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5961[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleCloudStorage' is not assignable to type 'Record<unknown>'
> 5961 |   type: "OracleCloudStorage";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5982[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GoogleCloudStorageLinkedServiceTypeProperties'.
> 5982 |   typeProperties: GoogleCloudStorageLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m5985[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleCloudStorage' is not assignable to type 'Record<unknown>'
> 5985 |   type: "GoogleCloudStorage";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6006[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OracleLinkedServiceTypeProperties'.
> 6006 |   typeProperties: OracleLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6009[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Oracle' is not assignable to type 'Record<unknown>'
> 6009 |   type: "Oracle";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6027[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonRdsForLinkedServiceTypeProperties'.
> 6027 |   typeProperties: AmazonRdsForLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6030[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRdsForOracle' is not assignable to type 'Record<unknown>'
> 6030 |   type: "AmazonRdsForOracle";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6048[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMySqlLinkedServiceTypeProperties'.
> 6048 |   typeProperties: AzureMySqlLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6051[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMySql' is not assignable to type 'Record<unknown>'
> 6051 |   type: "AzureMySql";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6069[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MySqlLinkedServiceTypeProperties'.
> 6069 |   typeProperties: MySqlLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6072[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MySql' is not assignable to type 'Record<unknown>'
> 6072 |   type: "MySql";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6090[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PostgreSqlLinkedServiceTypeProperties'.
> 6090 |   typeProperties: PostgreSqlLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6093[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PostgreSql' is not assignable to type 'Record<unknown>'
> 6093 |   type: "PostgreSql";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6111[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SybaseLinkedServiceTypeProperties'.
> 6111 |   typeProperties: SybaseLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6114[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Sybase' is not assignable to type 'Record<unknown>'
> 6114 |   type: "Sybase";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6144[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.Db2LinkedServiceTypeProperties'.
> 6144 |   typeProperties: Db2LinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6147[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Db2' is not assignable to type 'Record<unknown>'
> 6147 |   type: "Db2";
       |         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6183[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TeradataLinkedServiceTypeProperties'.
> 6183 |   typeProperties: TeradataLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6186[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Teradata' is not assignable to type 'Record<unknown>'
> 6186 |   type: "Teradata";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6213[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMLLinkedServiceTypeProperties'.
> 6213 |   typeProperties: AzureMLLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6216[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureML' is not assignable to type 'Record<unknown>'
> 6216 |   type: "AzureML";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6249[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMLServiceLinkedServiceTypeProperties'.
> 6249 |   typeProperties: AzureMLServiceLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6252[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMLService' is not assignable to type 'Record<unknown>'
> 6252 |   type: "AzureMLService";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6285[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OdbcLinkedServiceTypeProperties'.
> 6285 |   typeProperties: OdbcLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6288[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Odbc' is not assignable to type 'Record<unknown>'
> 6288 |   type: "Odbc";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6315[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.InformixLinkedServiceTypeProperties'.
> 6315 |   typeProperties: InformixLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6318[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Informix' is not assignable to type 'Record<unknown>'
> 6318 |   type: "Informix";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6345[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MicrosoftAccessLinkedServiceTypeProperties'.
> 6345 |   typeProperties: MicrosoftAccessLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6348[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MicrosoftAccess' is not assignable to type 'Record<unknown>'
> 6348 |   type: "MicrosoftAccess";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6375[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HdfsLinkedServiceTypeProperties'.
> 6375 |   typeProperties: HdfsLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6378[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Hdfs' is not assignable to type 'Record<unknown>'
> 6378 |   type: "Hdfs";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6402[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ODataLinkedServiceTypeProperties'.
> 6402 |   typeProperties: ODataLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6405[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OData' is not assignable to type 'Record<unknown>'
> 6405 |   type: "OData";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6456[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.WebLinkedServiceTypeProperties'.
> 6456 |   typeProperties: WebLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6459[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Web' is not assignable to type 'Record<unknown>'
> 6459 |   type: "Web";
       |         ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6503[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CassandraLinkedServiceTypeProperties'.
> 6503 |   typeProperties: CassandraLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6506[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Cassandra' is not assignable to type 'Record<unknown>'
> 6506 |   type: "Cassandra";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6533[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbLinkedServiceTypeProperties'.
> 6533 |   typeProperties: MongoDbLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6536[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDb' is not assignable to type 'Record<unknown>'
> 6536 |   type: "MongoDb";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6575[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbAtlasLinkedServiceTypeProperties'.
> 6575 |   typeProperties: MongoDbAtlasLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6578[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbAtlas' is not assignable to type 'Record<unknown>'
> 6578 |   type: "MongoDbAtlas";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6596[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbV2LinkedServiceTypeProperties'.
> 6596 |   typeProperties: MongoDbV2LinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6599[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbV2' is not assignable to type 'Record<unknown>'
> 6599 |   type: "MongoDbV2";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6614[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CosmosDbMongoDbApiLinkedServiceTypeProperties'.
> 6614 |   typeProperties: CosmosDbMongoDbApiLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6617[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDbMongoDbApi' is not assignable to type 'Record<unknown>'
> 6617 |   type: "CosmosDbMongoDbApi";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6635[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDataLakeStoreLinkedServiceTypeProperties'.
> 6635 |   typeProperties: AzureDataLakeStoreLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6638[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeStore' is not assignable to type 'Record<unknown>'
> 6638 |   type: "AzureDataLakeStore";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6677[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureBlobFSLinkedServiceTypeProperties'.
> 6677 |   typeProperties: AzureBlobFSLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6680[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobFS' is not assignable to type 'Record<unknown>'
> 6680 |   type: "AzureBlobFS";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6725[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.Office365LinkedServiceTypeProperties'.
> 6725 |   typeProperties: Office365LinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6728[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Office365' is not assignable to type 'Record<unknown>'
> 6728 |   type: "Office365";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6752[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SalesforceLinkedServiceTypeProperties'.
> 6752 |   typeProperties: SalesforceLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6755[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Salesforce' is not assignable to type 'Record<unknown>'
> 6755 |   type: "Salesforce";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6782[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SalesforceServiceCloudLinkedServiceTypeProperties'.
> 6782 |   typeProperties: SalesforceServiceCloudLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6785[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceServiceCloud' is not assignable to type 'Record<unknown>'
> 6785 |   type: "SalesforceServiceCloud";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6815[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapCloudForCustomerLinkedServiceTypeProperties'.
> 6815 |   typeProperties: SapCloudForCustomerLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6818[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapCloudForCustomer' is not assignable to type 'Record<unknown>'
> 6818 |   type: "SapCloudForCustomer";
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6839[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapEccLinkedServiceTypeProperties'.
> 6839 |   typeProperties: SapEccLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6842[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapEcc' is not assignable to type 'Record<unknown>'
> 6842 |   type: "SapEcc";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6863[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapOpenHubLinkedServiceTypeProperties'.
> 6863 |   typeProperties: SapOpenHubLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6866[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapOpenHub' is not assignable to type 'Record<unknown>'
> 6866 |   type: "SapOpenHub";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6908[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapOdpLinkedServiceTypeProperties'.
> 6908 |   typeProperties: SapOdpLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6911[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapOdp' is not assignable to type 'Record<unknown>'
> 6911 |   type: "SapOdp";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6974[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.RestServiceLinkedServiceTypeProperties'.
> 6974 |   typeProperties: RestServiceLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m6977[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'RestService' is not assignable to type 'Record<unknown>'
> 6977 |   type: "RestService";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7040[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TeamDeskLinkedServiceTypeProperties'.
> 7040 |   typeProperties: TeamDeskLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7043[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TeamDesk' is not assignable to type 'Record<unknown>'
> 7043 |   type: "TeamDesk";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7070[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.QuickbaseLinkedServiceTypeProperties'.
> 7070 |   typeProperties: QuickbaseLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7073[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Quickbase' is not assignable to type 'Record<unknown>'
> 7073 |   type: "Quickbase";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7091[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SmartsheetLinkedServiceTypeProperties'.
> 7091 |   typeProperties: SmartsheetLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7094[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Smartsheet' is not assignable to type 'Record<unknown>'
> 7094 |   type: "Smartsheet";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7109[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ZendeskLinkedServiceTypeProperties'.
> 7109 |   typeProperties: ZendeskLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7112[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Zendesk' is not assignable to type 'Record<unknown>'
> 7112 |   type: "Zendesk";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7139[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DataworldLinkedServiceTypeProperties'.
> 7139 |   typeProperties: DataworldLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7142[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Dataworld' is not assignable to type 'Record<unknown>'
> 7142 |   type: "Dataworld";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7157[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AppFiguresLinkedServiceTypeProperties'.
> 7157 |   typeProperties: AppFiguresLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7160[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AppFigures' is not assignable to type 'Record<unknown>'
> 7160 |   type: "AppFigures";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7178[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AsanaLinkedServiceTypeProperties'.
> 7178 |   typeProperties: AsanaLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7181[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Asana' is not assignable to type 'Record<unknown>'
> 7181 |   type: "Asana";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7196[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TwilioLinkedServiceTypeProperties'.
> 7196 |   typeProperties: TwilioLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7199[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Twilio' is not assignable to type 'Record<unknown>'
> 7199 |   type: "Twilio";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7214[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GoogleSheetsLinkedServiceTypeProperties'.
> 7214 |   typeProperties: GoogleSheetsLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7217[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleSheets' is not assignable to type 'Record<unknown>'
> 7217 |   type: "GoogleSheets";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7232[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonS3LinkedServiceTypeProperties'.
> 7232 |   typeProperties: AmazonS3LinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7235[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonS3' is not assignable to type 'Record<unknown>'
> 7235 |   type: "AmazonS3";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7262[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonRedshiftLinkedServiceTypeProperties'.
> 7262 |   typeProperties: AmazonRedshiftLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7265[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRedshift' is not assignable to type 'Record<unknown>'
> 7265 |   type: "AmazonRedshift";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7295[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CustomDataSource' is not assignable to type 'Record<unknown>'
> 7295 |   type: "CustomDataSource";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7301[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSearchLinkedServiceTypeProperties'.
> 7301 |   typeProperties: AzureSearchLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7304[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSearch' is not assignable to type 'Record<unknown>'
> 7304 |   type: "AzureSearch";
       |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7322[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HttpLinkedServiceTypeProperties'.
> 7322 |   typeProperties: HttpLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7325[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HttpServer' is not assignable to type 'Record<unknown>'
> 7325 |   type: "HttpServer";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7361[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.FtpServerLinkedServiceTypeProperties'.
> 7361 |   typeProperties: FtpServerLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7364[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FtpServer' is not assignable to type 'Record<unknown>'
> 7364 |   type: "FtpServer";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7397[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SftpServerLinkedServiceTypeProperties'.
> 7397 |   typeProperties: SftpServerLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7400[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Sftp' is not assignable to type 'Record<unknown>'
> 7400 |   type: "Sftp";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7442[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapBWLinkedServiceTypeProperties'.
> 7442 |   typeProperties: SapBWLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7445[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapBW' is not assignable to type 'Record<unknown>'
> 7445 |   type: "SapBW";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7472[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapHanaLinkedServiceProperties'.
> 7472 |   typeProperties: SapHanaLinkedServiceProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7475[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapHana' is not assignable to type 'Record<unknown>'
> 7475 |   type: "SapHana";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7502[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonMWSLinkedServiceTypeProperties'.
> 7502 |   typeProperties: AmazonMWSLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7505[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonMWS' is not assignable to type 'Record<unknown>'
> 7505 |   type: "AmazonMWS";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7544[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzurePostgreSqlLinkedServiceTypeProperties'.
> 7544 |   typeProperties: AzurePostgreSqlLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7547[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzurePostgreSql' is not assignable to type 'Record<unknown>'
> 7547 |   type: "AzurePostgreSql";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7565[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ConcurLinkedServiceTypeProperties'.
> 7565 |   typeProperties: ConcurLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7568[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Concur' is not assignable to type 'Record<unknown>'
> 7568 |   type: "Concur";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7601[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CouchbaseLinkedServiceTypeProperties'.
> 7601 |   typeProperties: CouchbaseLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7604[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Couchbase' is not assignable to type 'Record<unknown>'
> 7604 |   type: "Couchbase";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7622[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DrillLinkedServiceTypeProperties'.
> 7622 |   typeProperties: DrillLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7625[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Drill' is not assignable to type 'Record<unknown>'
> 7625 |   type: "Drill";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7643[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.EloquaLinkedServiceTypeProperties'.
> 7643 |   typeProperties: EloquaLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7646[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Eloqua' is not assignable to type 'Record<unknown>'
> 7646 |   type: "Eloqua";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7676[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GoogleBigQueryLinkedServiceTypeProperties'.
> 7676 |   typeProperties: GoogleBigQueryLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7679[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleBigQuery' is not assignable to type 'Record<unknown>'
> 7679 |   type: "GoogleBigQuery";
       |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7724[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GreenplumLinkedServiceTypeProperties'.
> 7724 |   typeProperties: GreenplumLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7727[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Greenplum' is not assignable to type 'Record<unknown>'
> 7727 |   type: "Greenplum";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7745[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HBaseLinkedServiceTypeProperties'.
> 7745 |   typeProperties: HBaseLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7748[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HBase' is not assignable to type 'Record<unknown>'
> 7748 |   type: "HBase";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7790[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HiveLinkedServiceTypeProperties'.
> 7790 |   typeProperties: HiveLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7793[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Hive' is not assignable to type 'Record<unknown>'
> 7793 |   type: "Hive";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7853[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HubspotLinkedServiceTypeProperties'.
> 7853 |   typeProperties: HubspotLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7856[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Hubspot' is not assignable to type 'Record<unknown>'
> 7856 |   type: "Hubspot";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7889[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ImpalaLinkedServiceTypeProperties'.
> 7889 |   typeProperties: ImpalaLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7892[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Impala' is not assignable to type 'Record<unknown>'
> 7892 |   type: "Impala";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7934[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.JiraLinkedServiceTypeProperties'.
> 7934 |   typeProperties: JiraLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7937[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Jira' is not assignable to type 'Record<unknown>'
> 7937 |   type: "Jira";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7970[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MagentoLinkedServiceTypeProperties'.
> 7970 |   typeProperties: MagentoLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m7973[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Magento' is not assignable to type 'Record<unknown>'
> 7973 |   type: "Magento";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8000[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MariaDBLinkedServiceTypeProperties'.
> 8000 |   typeProperties: MariaDBLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8003[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MariaDB' is not assignable to type 'Record<unknown>'
> 8003 |   type: "MariaDB";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8021[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMariaDBLinkedServiceTypeProperties'.
> 8021 |   typeProperties: AzureMariaDBLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8024[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMariaDB' is not assignable to type 'Record<unknown>'
> 8024 |   type: "AzureMariaDB";
       |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8042[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MarketoLinkedServiceTypeProperties'.
> 8042 |   typeProperties: MarketoLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8045[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Marketo' is not assignable to type 'Record<unknown>'
> 8045 |   type: "Marketo";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8075[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PaypalLinkedServiceTypeProperties'.
> 8075 |   typeProperties: PaypalLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8078[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Paypal' is not assignable to type 'Record<unknown>'
> 8078 |   type: "Paypal";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8108[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PhoenixLinkedServiceTypeProperties'.
> 8108 |   typeProperties: PhoenixLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8111[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Phoenix' is not assignable to type 'Record<unknown>'
> 8111 |   type: "Phoenix";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8156[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PrestoLinkedServiceTypeProperties'.
> 8156 |   typeProperties: PrestoLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8159[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Presto' is not assignable to type 'Record<unknown>'
> 8159 |   type: "Presto";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8210[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.QuickBooksLinkedServiceTypeProperties'.
> 8210 |   typeProperties: QuickBooksLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8213[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'QuickBooks' is not assignable to type 'Record<unknown>'
> 8213 |   type: "QuickBooks";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8249[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ServiceNowLinkedServiceTypeProperties'.
> 8249 |   typeProperties: ServiceNowLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8252[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ServiceNow' is not assignable to type 'Record<unknown>'
> 8252 |   type: "ServiceNow";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8291[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ShopifyLinkedServiceTypeProperties'.
> 8291 |   typeProperties: ShopifyLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8294[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Shopify' is not assignable to type 'Record<unknown>'
> 8294 |   type: "Shopify";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8321[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SparkLinkedServiceTypeProperties'.
> 8321 |   typeProperties: SparkLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8324[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Spark' is not assignable to type 'Record<unknown>'
> 8324 |   type: "Spark";
       |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8375[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SquareLinkedServiceTypeProperties'.
> 8375 |   typeProperties: SquareLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8378[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Square' is not assignable to type 'Record<unknown>'
> 8378 |   type: "Square";
       |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8414[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.XeroLinkedServiceTypeProperties'.
> 8414 |   typeProperties: XeroLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8417[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Xero' is not assignable to type 'Record<unknown>'
> 8417 |   type: "Xero";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8453[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ZohoLinkedServiceTypeProperties'.
> 8453 |   typeProperties: ZohoLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8456[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Zoho' is not assignable to type 'Record<unknown>'
> 8456 |   type: "Zoho";
       |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8486[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.VerticaLinkedServiceTypeProperties'.
> 8486 |   typeProperties: VerticaLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8489[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Vertica' is not assignable to type 'Record<unknown>'
> 8489 |   type: "Vertica";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8507[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.NetezzaLinkedServiceTypeProperties'.
> 8507 |   typeProperties: NetezzaLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8510[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Netezza' is not assignable to type 'Record<unknown>'
> 8510 |   type: "Netezza";
       |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8528[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SalesforceMarketingCloudLinkedServiceTypeProperties'.
> 8528 |   typeProperties: SalesforceMarketingCloudLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8531[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceMarketingCloud' is not assignable to type 'Record<unknown>'
> 8531 |   type: "SalesforceMarketingCloud";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8561[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HDInsightOnDemandLinkedServiceTypeProperties'.
> 8561 |   typeProperties: HDInsightOnDemandLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8564[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HDInsightOnDemand' is not assignable to type 'Record<unknown>'
> 8564 |   type: "HDInsightOnDemand";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8690[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDataLakeAnalyticsLinkedServiceTypeProperties'.
> 8690 |   typeProperties: AzureDataLakeAnalyticsLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8693[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeAnalytics' is not assignable to type 'Record<unknown>'
> 8693 |   type: "AzureDataLakeAnalytics";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8726[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDatabricksLinkedServiceTypeProperties'.
> 8726 |   typeProperties: AzureDatabricksLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8729[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDatabricks' is not assignable to type 'Record<unknown>'
> 8729 |   type: "AzureDatabricks";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8795[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDatabricksDetltaLakeLinkedServiceTypeProperties'.
> 8795 |   typeProperties: AzureDatabricksDetltaLakeLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8798[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDatabricksDeltaLake' is not assignable to type 'Record<unknown>'
> 8798 |   type: "AzureDatabricksDeltaLake";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8825[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ResponsysLinkedServiceTypeProperties'.
> 8825 |   typeProperties: ResponsysLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8828[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Responsys' is not assignable to type 'Record<unknown>'
> 8828 |   type: "Responsys";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8858[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DynamicsAXLinkedServiceTypeProperties'.
> 8858 |   typeProperties: DynamicsAXLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8861[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsAX' is not assignable to type 'Record<unknown>'
> 8861 |   type: "DynamicsAX";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8888[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OracleServiceCloudLinkedServiceTypeProperties'.
> 8888 |   typeProperties: OracleServiceCloudLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8891[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleServiceCloud' is not assignable to type 'Record<unknown>'
> 8891 |   type: "OracleServiceCloud";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8921[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GoogleAdWordsLinkedServiceTypeProperties'.
> 8921 |   typeProperties: GoogleAdWordsLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8924[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleAdWords' is not assignable to type 'Record<unknown>'
> 8924 |   type: "GoogleAdWords";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8981[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapTableLinkedServiceTypeProperties'.
> 8981 |   typeProperties: SapTableLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m8984[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapTable' is not assignable to type 'Record<unknown>'
> 8984 |   type: "SapTable";
       |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9041[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDataExplorerLinkedServiceTypeProperties'.
> 9041 |   typeProperties: AzureDataExplorerLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9044[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataExplorer' is not assignable to type 'Record<unknown>'
> 9044 |   type: "AzureDataExplorer";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9071[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureFunctionLinkedServiceTypeProperties'.
> 9071 |   typeProperties: AzureFunctionLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9074[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureFunction' is not assignable to type 'Record<unknown>'
> 9074 |   type: "AzureFunction";
       |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9101[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SnowflakeLinkedServiceTypeProperties'.
> 9101 |   typeProperties: SnowflakeLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9104[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Snowflake' is not assignable to type 'Record<unknown>'
> 9104 |   type: "Snowflake";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9122[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SharePointOnlineListLinkedServiceTypeProperties'.
> 9122 |   typeProperties: SharePointOnlineListLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9125[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SharePointOnlineList' is not assignable to type 'Record<unknown>'
> 9125 |   type: "SharePointOnlineList";
       |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9149[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureSynapseArtifactsLinkedServiceTypeProperties'.
> 9149 |   typeProperties: AzureSynapseArtifactsLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9152[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSynapseArtifacts' is not assignable to type 'Record<unknown>'
> 9152 |   type: "AzureSynapseArtifacts";
       |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9170[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LakeHouseLinkedServiceTypeProperties'.
> 9170 |   typeProperties: LakeHouseLinkedServiceTypeProperties;
       |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9173[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'LakeHouse' is not assignable to type 'Record<unknown>'
> 9173 |   type: "LakeHouse";
       |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9211[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LinkedServiceReference'.
> 9211 |   linkedServiceName?: LinkedServiceReference;
       |                       ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9228[39m:[33m28[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 9228 |   retryIntervalInSeconds?: int32;
       |                            ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9231[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 9231 |   secureInput?: boolean;
       |                 ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9234[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 9234 |   secureOutput?: boolean;
       |                  ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9214[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ActivityPolicy'.
> 9214 |   policy?: ActivityPolicy;
       |            ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9280[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobStorageReadSettings' is not assignable to type 'Record<unknown>'
> 9280 |   type: "AzureBlobStorageReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9313[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobFSReadSettings' is not assignable to type 'Record<unknown>'
> 9313 |   type: "AzureBlobFSReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9352[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeStoreReadSettings' is not assignable to type 'Record<unknown>'
> 9352 |   type: "AzureDataLakeStoreReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9388[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonS3ReadSettings' is not assignable to type 'Record<unknown>'
> 9388 |   type: "AmazonS3ReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9424[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FileServerReadSettings' is not assignable to type 'Record<unknown>'
> 9424 |   type: "FileServerReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9460[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureFileStorageReadSettings' is not assignable to type 'Record<unknown>'
> 9460 |   type: "AzureFileStorageReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9472[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SftpWriteSettings' is not assignable to type 'Record<unknown>'
> 9472 |   type: "SftpWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9521[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonS3CompatibleReadSettings' is not assignable to type 'Record<unknown>'
> 9521 |   type: "AmazonS3CompatibleReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9557[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleCloudStorageReadSettings' is not assignable to type 'Record<unknown>'
> 9557 |   type: "OracleCloudStorageReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9593[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleCloudStorageReadSettings' is not assignable to type 'Record<unknown>'
> 9593 |   type: "GoogleCloudStorageReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9626[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FtpReadSettings' is not assignable to type 'Record<unknown>'
> 9626 |   type: "FtpReadSettings";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9662[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SftpReadSettings' is not assignable to type 'Record<unknown>'
> 9662 |   type: "SftpReadSettings";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9683[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HttpReadSettings' is not assignable to type 'Record<unknown>'
> 9683 |   type: "HttpReadSettings";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9713[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DistcpSettings'.
> 9713 |   distcpSettings?: DistcpSettings;
       |                    ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9719[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HdfsReadSettings' is not assignable to type 'Record<unknown>'
> 9719 |   type: "HdfsReadSettings";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9764[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'LakeHouseReadSettings' is not assignable to type 'Record<unknown>'
> 9764 |   type: "LakeHouseReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9773[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobStorageWriteSettings' is not assignable to type 'Record<unknown>'
> 9773 |   type: "AzureBlobStorageWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9782[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobFSWriteSettings' is not assignable to type 'Record<unknown>'
> 9782 |   type: "AzureBlobFSWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9791[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeStoreWriteSettings' is not assignable to type 'Record<unknown>'
> 9791 |   type: "AzureDataLakeStoreWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9797[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FileServerWriteSettings' is not assignable to type 'Record<unknown>'
> 9797 |   type: "FileServerWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9803[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureFileStorageWriteSettings' is not assignable to type 'Record<unknown>'
> 9803 |   type: "AzureFileStorageWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9809[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'LakeHouseWriteSettings' is not assignable to type 'Record<unknown>'
> 9809 |   type: "LakeHouseWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9826[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ZipDeflateReadSettings' is not assignable to type 'Record<unknown>'
> 9826 |   type: "ZipDeflateReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9835[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TarReadSettings' is not assignable to type 'Record<unknown>'
> 9835 |   type: "TarReadSettings";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9844[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TarGZipReadSettings' is not assignable to type 'Record<unknown>'
> 9844 |   type: "TarGZipReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9850[39m:[33m27[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CompressionReadSettings'.
> 9850 |   compressionProperties?: CompressionReadSettings;
       |                           ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9853[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ParquetReadSettings' is not assignable to type 'Record<unknown>'
> 9853 |   type: "ParquetReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9862[39m:[33m27[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CompressionReadSettings'.
> 9862 |   compressionProperties?: CompressionReadSettings;
       |                           ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9865[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DelimitedTextReadSettings' is not assignable to type 'Record<unknown>'
> 9865 |   type: "DelimitedTextReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9871[39m:[33m27[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CompressionReadSettings'.
> 9871 |   compressionProperties?: CompressionReadSettings;
       |                           ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9874[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'JsonReadSettings' is not assignable to type 'Record<unknown>'
> 9874 |   type: "JsonReadSettings";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9880[39m:[33m27[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CompressionReadSettings'.
> 9880 |   compressionProperties?: CompressionReadSettings;
       |                           ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9895[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'XmlReadSettings' is not assignable to type 'Record<unknown>'
> 9895 |   type: "XmlReadSettings";
       |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9901[39m:[33m27[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CompressionReadSettings'.
> 9901 |   compressionProperties?: CompressionReadSettings;
       |                           ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9904[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'BinaryReadSettings' is not assignable to type 'Record<unknown>'
> 9904 |   type: "BinaryReadSettings";
       |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9914[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 9914 |   recordName?: string;
       |                ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9917[39m:[33m21[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 9917 |   recordNamespace?: string;
       |                     ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9926[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AvroWriteSettings' is not assignable to type 'Record<unknown>'
> 9926 |   type: "AvroWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9938[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OrcWriteSettings' is not assignable to type 'Record<unknown>'
> 9938 |   type: "OrcWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9950[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ParquetWriteSettings' is not assignable to type 'Record<unknown>'
> 9950 |   type: "ParquetWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9968[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DelimitedTextWriteSettings' is not assignable to type 'Record<unknown>'
> 9968 |   type: "DelimitedTextWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9977[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'JsonWriteSettings' is not assignable to type 'Record<unknown>'
> 9977 |   type: "JsonWriteSettings";
       |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9983[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 9983 |   storeSettings?: StoreReadSettings;
       |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m9989[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AvroSource' is not assignable to type 'Record<unknown>'
> 9989 |   type: "AvroSource";
       |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10011[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 10011 |   storeSettings?: StoreReadSettings;
        |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10017[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ExcelSource' is not assignable to type 'Record<unknown>'
> 10017 |   type: "ExcelSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10023[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 10023 |   storeSettings?: StoreReadSettings;
        |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10026[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ParquetReadSettings'.
> 10026 |   formatSettings?: ParquetReadSettings;
        |                    ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10032[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ParquetSource' is not assignable to type 'Record<unknown>'
> 10032 |   type: "ParquetSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10038[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 10038 |   storeSettings?: StoreReadSettings;
        |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10041[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DelimitedTextReadSettings'.
> 10041 |   formatSettings?: DelimitedTextReadSettings;
        |                    ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10047[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DelimitedTextSource' is not assignable to type 'Record<unknown>'
> 10047 |   type: "DelimitedTextSource";
        |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10053[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 10053 |   storeSettings?: StoreReadSettings;
        |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10056[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.JsonReadSettings'.
> 10056 |   formatSettings?: JsonReadSettings;
        |                    ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10062[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'JsonSource' is not assignable to type 'Record<unknown>'
> 10062 |   type: "JsonSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10068[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 10068 |   storeSettings?: StoreReadSettings;
        |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10071[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.XmlReadSettings'.
> 10071 |   formatSettings?: XmlReadSettings;
        |                    ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10077[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'XmlSource' is not assignable to type 'Record<unknown>'
> 10077 |   type: "XmlSource";
        |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10083[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 10083 |   storeSettings?: StoreReadSettings;
        |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10089[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OrcSource' is not assignable to type 'Record<unknown>'
> 10089 |   type: "OrcSource";
        |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10095[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreWriteSettings'.
> 10095 |   storeSettings?: StoreWriteSettings;
        |                   ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10098[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DelimitedTextWriteSettings'.
> 10098 |   formatSettings?: DelimitedTextWriteSettings;
        |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10101[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DelimitedTextSink' is not assignable to type 'Record<unknown>'
> 10101 |   type: "DelimitedTextSink";
        |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10129[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreWriteSettings'.
> 10129 |   storeSettings?: StoreWriteSettings;
        |                   ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10132[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.JsonWriteSettings'.
> 10132 |   formatSettings?: JsonWriteSettings;
        |                    ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10135[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'JsonSink' is not assignable to type 'Record<unknown>'
> 10135 |   type: "JsonSink";
        |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10141[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreWriteSettings'.
> 10141 |   storeSettings?: StoreWriteSettings;
        |                   ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10144[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OrcWriteSettings'.
> 10144 |   formatSettings?: OrcWriteSettings;
        |                    ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10147[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OrcSink' is not assignable to type 'Record<unknown>'
> 10147 |   type: "OrcSink";
        |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10216[39m:[33m22[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LinkedServiceReference'.
> 10216 |   linkedServiceName: LinkedServiceReference;
        |                      ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10237[39m:[33m22[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LinkedServiceReference'.
> 10237 |   linkedServiceName: LinkedServiceReference;
        |                      ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10153[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CopyActivityTypeProperties'.
> 10153 |   typeProperties: CopyActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10156[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DatasetReference[]'.
> 10156 |   inputs?: DatasetReference[];
        |            ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10159[39m:[33m13[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DatasetReference[]'.
> 10159 |   outputs?: DatasetReference[];
        |             ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10162[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Copy' is not assignable to type 'Record<unknown>'
> 10162 |   type: "Copy";
        |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10291[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreReadSettings'.
> 10291 |   storeSettings?: StoreReadSettings;
        |                   ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10294[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.BinaryReadSettings'.
> 10294 |   formatSettings?: BinaryReadSettings;
        |                    ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10297[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'BinarySource' is not assignable to type 'Record<unknown>'
> 10297 |   type: "BinarySource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10319[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureTableSource' is not assignable to type 'Record<unknown>'
> 10319 |   type: "AzureTableSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10334[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'BlobSource' is not assignable to type 'Record<unknown>'
> 10334 |   type: "BlobSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10352[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DocumentDbCollectionSource' is not assignable to type 'Record<unknown>'
> 10352 |   type: "DocumentDbCollectionSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10373[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDbSqlApiSource' is not assignable to type 'Record<unknown>'
> 10373 |   type: "CosmosDbSqlApiSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10385[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsSource' is not assignable to type 'Record<unknown>'
> 10385 |   type: "DynamicsSource";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10397[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsCrmSource' is not assignable to type 'Record<unknown>'
> 10397 |   type: "DynamicsCrmSource";
        |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10409[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CommonDataServiceForAppsSource' is not assignable to type 'Record<unknown>'
> 10409 |   type: "CommonDataServiceForAppsSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10421[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'RelationalSource' is not assignable to type 'Record<unknown>'
> 10421 |   type: "RelationalSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10430[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'InformixSource' is not assignable to type 'Record<unknown>'
> 10430 |   type: "InformixSource";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10442[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MicrosoftAccessSource' is not assignable to type 'Record<unknown>'
> 10442 |   type: "MicrosoftAccessSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10451[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Db2Source' is not assignable to type 'Record<unknown>'
> 10451 |   type: "Db2Source";
        |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10460[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OdbcSource' is not assignable to type 'Record<unknown>'
> 10460 |   type: "OdbcSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10469[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MySqlSource' is not assignable to type 'Record<unknown>'
> 10469 |   type: "MySqlSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10478[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PostgreSqlSource' is not assignable to type 'Record<unknown>'
> 10478 |   type: "PostgreSqlSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10487[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SybaseSource' is not assignable to type 'Record<unknown>'
> 10487 |   type: "SybaseSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10496[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapBwSource' is not assignable to type 'Record<unknown>'
> 10496 |   type: "SapBwSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10511[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ODataSource' is not assignable to type 'Record<unknown>'
> 10511 |   type: "ODataSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10523[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceSource' is not assignable to type 'Record<unknown>'
> 10523 |   type: "SalesforceSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10538[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceServiceCloudSource' is not assignable to type 'Record<unknown>'
> 10538 |   type: "SalesforceServiceCloudSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10550[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapCloudForCustomerSource' is not assignable to type 'Record<unknown>'
> 10550 |   type: "SapCloudForCustomerSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10562[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapEccSource' is not assignable to type 'Record<unknown>'
> 10562 |   type: "SapEccSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10577[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapHanaPartitionSettings'.
> 10577 |   partitionSettings?: SapHanaPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10580[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapHanaSource' is not assignable to type 'Record<unknown>'
> 10580 |   type: "SapHanaSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10604[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapOpenHubSource' is not assignable to type 'Record<unknown>'
> 10604 |   type: "SapOpenHubSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10622[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapOdpSource' is not assignable to type 'Record<unknown>'
> 10622 |   type: "SapOdpSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10652[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SapTablePartitionSettings'.
> 10652 |   partitionSettings?: SapTablePartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10655[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapTableSource' is not assignable to type 'Record<unknown>'
> 10655 |   type: "SapTableSource";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10691[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'RestSink' is not assignable to type 'Record<unknown>'
> 10691 |   type: "RestSink";
        |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10718[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'RestSource' is not assignable to type 'Record<unknown>'
> 10718 |   type: "RestSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10739[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlPartitionSettings'.
> 10739 |   partitionSettings?: SqlPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10742[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlSource' is not assignable to type 'Record<unknown>'
> 10742 |   type: "SqlSource";
        |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10778[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlPartitionSettings'.
> 10778 |   partitionSettings?: SqlPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10781[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlServerSource' is not assignable to type 'Record<unknown>'
> 10781 |   type: "SqlServerSource";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10805[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlPartitionSettings'.
> 10805 |   partitionSettings?: SqlPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10808[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRdsForSqlServerSource' is not assignable to type 'Record<unknown>'
> 10808 |   type: "AmazonRdsForSqlServerSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10832[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlPartitionSettings'.
> 10832 |   partitionSettings?: SqlPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10835[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlSource' is not assignable to type 'Record<unknown>'
> 10835 |   type: "AzureSqlSource";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10859[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlPartitionSettings'.
> 10859 |   partitionSettings?: SqlPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10862[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlMISource' is not assignable to type 'Record<unknown>'
> 10862 |   type: "SqlMISource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10883[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlPartitionSettings'.
> 10883 |   partitionSettings?: SqlPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10886[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlDWSource' is not assignable to type 'Record<unknown>'
> 10886 |   type: "SqlDWSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10898[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FileSystemSource' is not assignable to type 'Record<unknown>'
> 10898 |   type: "FileSystemSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10907[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DistcpSettings'.
> 10907 |   distcpSettings?: DistcpSettings;
        |                    ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10910[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HdfsSource' is not assignable to type 'Record<unknown>'
> 10910 |   type: "HdfsSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10919[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMySqlSource' is not assignable to type 'Record<unknown>'
> 10919 |   type: "AzureMySqlSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10937[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataExplorerSource' is not assignable to type 'Record<unknown>'
> 10937 |   type: "AzureDataExplorerSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10952[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.OraclePartitionSettings'.
> 10952 |   partitionSettings?: OraclePartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10958[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleSource' is not assignable to type 'Record<unknown>'
> 10958 |   type: "OracleSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10988[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AmazonRdsForOraclePartitionSettings'.
> 10988 |   partitionSettings?: AmazonRdsForOraclePartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m10994[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRdsForOracleSource' is not assignable to type 'Record<unknown>'
> 10994 |   type: "AmazonRdsForOracleSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11021[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TeradataPartitionSettings'.
> 11021 |   partitionSettings?: TeradataPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11024[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TeradataSource' is not assignable to type 'Record<unknown>'
> 11024 |   type: "TeradataSource";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11045[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'WebSource' is not assignable to type 'Record<unknown>'
> 11045 |   type: "WebSource";
        |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11054[39m:[33m22[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.CassandraSourceReadConsistencyLevels' is not assignable to type 'Record<unknown>'
> 11054 |   consistencyLevel?: CassandraSourceReadConsistencyLevels;
        |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11057[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CassandraSource' is not assignable to type 'Record<unknown>'
> 11057 |   type: "CassandraSource";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11069[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbSource' is not assignable to type 'Record<unknown>'
> 11069 |   type: "MongoDbSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11078[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbCursorMethodsProperties'.
> 11078 |   cursorMethods?: MongoDbCursorMethodsProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11090[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbAtlasSource' is not assignable to type 'Record<unknown>'
> 11090 |   type: "MongoDbAtlasSource";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11114[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbCursorMethodsProperties'.
> 11114 |   cursorMethods?: MongoDbCursorMethodsProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11126[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbV2Source' is not assignable to type 'Record<unknown>'
> 11126 |   type: "MongoDbV2Source";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11135[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MongoDbCursorMethodsProperties'.
> 11135 |   cursorMethods?: MongoDbCursorMethodsProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11147[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDbMongoDbApiSource' is not assignable to type 'Record<unknown>'
> 11147 |   type: "CosmosDbMongoDbApiSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11171[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Office365Source' is not assignable to type 'Record<unknown>'
> 11171 |   type: "Office365Source";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11186[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeStoreSource' is not assignable to type 'Record<unknown>'
> 11186 |   type: "AzureDataLakeStoreSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11201[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobFSSource' is not assignable to type 'Record<unknown>'
> 11201 |   type: "AzureBlobFSSource";
        |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11210[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HttpSource' is not assignable to type 'Record<unknown>'
> 11210 |   type: "HttpSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11219[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonMWSSource' is not assignable to type 'Record<unknown>'
> 11219 |   type: "AmazonMWSSource";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11228[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzurePostgreSqlSource' is not assignable to type 'Record<unknown>'
> 11228 |   type: "AzurePostgreSqlSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11237[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzurePostgreSqlSink' is not assignable to type 'Record<unknown>'
> 11237 |   type: "AzurePostgreSqlSink";
        |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11246[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMySqlSink' is not assignable to type 'Record<unknown>'
> 11246 |   type: "AzureMySqlSink";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11255[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ConcurSource' is not assignable to type 'Record<unknown>'
> 11255 |   type: "ConcurSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11264[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CouchbaseSource' is not assignable to type 'Record<unknown>'
> 11264 |   type: "CouchbaseSource";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11273[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DrillSource' is not assignable to type 'Record<unknown>'
> 11273 |   type: "DrillSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11282[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'EloquaSource' is not assignable to type 'Record<unknown>'
> 11282 |   type: "EloquaSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11291[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleBigQuerySource' is not assignable to type 'Record<unknown>'
> 11291 |   type: "GoogleBigQuerySource";
        |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11300[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GreenplumSource' is not assignable to type 'Record<unknown>'
> 11300 |   type: "GreenplumSource";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11309[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HBaseSource' is not assignable to type 'Record<unknown>'
> 11309 |   type: "HBaseSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11318[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HiveSource' is not assignable to type 'Record<unknown>'
> 11318 |   type: "HiveSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11327[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HubspotSource' is not assignable to type 'Record<unknown>'
> 11327 |   type: "HubspotSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11336[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ImpalaSource' is not assignable to type 'Record<unknown>'
> 11336 |   type: "ImpalaSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11345[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'JiraSource' is not assignable to type 'Record<unknown>'
> 11345 |   type: "JiraSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11354[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MagentoSource' is not assignable to type 'Record<unknown>'
> 11354 |   type: "MagentoSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11363[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MariaDBSource' is not assignable to type 'Record<unknown>'
> 11363 |   type: "MariaDBSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11372[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMariaDBSource' is not assignable to type 'Record<unknown>'
> 11372 |   type: "AzureMariaDBSource";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11381[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MarketoSource' is not assignable to type 'Record<unknown>'
> 11381 |   type: "MarketoSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11390[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PaypalSource' is not assignable to type 'Record<unknown>'
> 11390 |   type: "PaypalSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11399[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PhoenixSource' is not assignable to type 'Record<unknown>'
> 11399 |   type: "PhoenixSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11408[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'PrestoSource' is not assignable to type 'Record<unknown>'
> 11408 |   type: "PrestoSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11417[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'QuickBooksSource' is not assignable to type 'Record<unknown>'
> 11417 |   type: "QuickBooksSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11426[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ServiceNowSource' is not assignable to type 'Record<unknown>'
> 11426 |   type: "ServiceNowSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11435[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ShopifySource' is not assignable to type 'Record<unknown>'
> 11435 |   type: "ShopifySource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11444[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SparkSource' is not assignable to type 'Record<unknown>'
> 11444 |   type: "SparkSource";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11453[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SquareSource' is not assignable to type 'Record<unknown>'
> 11453 |   type: "SquareSource";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11462[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'XeroSource' is not assignable to type 'Record<unknown>'
> 11462 |   type: "XeroSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11471[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ZohoSource' is not assignable to type 'Record<unknown>'
> 11471 |   type: "ZohoSource";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11483[39m:[33m23[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.NetezzaPartitionSettings'.
> 11483 |   partitionSettings?: NetezzaPartitionSettings;
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11486[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'NetezzaSource' is not assignable to type 'Record<unknown>'
> 11486 |   type: "NetezzaSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11507[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'VerticaSource' is not assignable to type 'Record<unknown>'
> 11507 |   type: "VerticaSource";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11516[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceMarketingCloudSource' is not assignable to type 'Record<unknown>'
> 11516 |   type: "SalesforceMarketingCloudSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11525[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ResponsysSource' is not assignable to type 'Record<unknown>'
> 11525 |   type: "ResponsysSource";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11537[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsAXSource' is not assignable to type 'Record<unknown>'
> 11537 |   type: "DynamicsAXSource";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11546[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleServiceCloudSource' is not assignable to type 'Record<unknown>'
> 11546 |   type: "OracleServiceCloudSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11555[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GoogleAdWordsSource' is not assignable to type 'Record<unknown>'
> 11555 |   type: "GoogleAdWordsSource";
        |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11564[39m:[33m28[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.RedshiftUnloadSettings'.
> 11564 |   redshiftUnloadSettings?: RedshiftUnloadSettings;
        |                            ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11567[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AmazonRedshiftSource' is not assignable to type 'Record<unknown>'
> 11567 |   type: "AmazonRedshiftSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11591[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'LakeHouseTableSource' is not assignable to type 'Record<unknown>'
> 11591 |   type: "LakeHouseTableSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11615[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SnowflakeExportCopyCommand' is not assignable to type 'Record<unknown>'
> 11615 |   type: "SnowflakeExportCopyCommand";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11600[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SnowflakeExportCopyCommand'.
> 11600 |   exportSettings: SnowflakeExportCopyCommand;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11603[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SnowflakeSource' is not assignable to type 'Record<unknown>'
> 11603 |   type: "SnowflakeSource";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11643[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDatabricksDeltaLakeExportCommand' is not assignable to type 'Record<unknown>'
> 11643 |   type: "AzureDatabricksDeltaLakeExportCommand";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11628[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDatabricksDeltaLakeExportCommand'.
> 11628 |   exportSettings?: AzureDatabricksDeltaLakeExportCommand;
        |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11631[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDatabricksDeltaLakeSource' is not assignable to type 'Record<unknown>'
> 11631 |   type: "AzureDatabricksDeltaLakeSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11667[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDatabricksDeltaLakeImportCommand' is not assignable to type 'Record<unknown>'
> 11667 |   type: "AzureDatabricksDeltaLakeImportCommand";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11652[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDatabricksDeltaLakeImportCommand'.
> 11652 |   importSettings?: AzureDatabricksDeltaLakeImportCommand;
        |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11655[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDatabricksDeltaLakeSink' is not assignable to type 'Record<unknown>'
> 11655 |   type: "AzureDatabricksDeltaLakeSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11686[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.SapCloudForCustomerSinkWriteBehavior' is not assignable to type 'Record<unknown>'
> 11686 |   writeBehavior?: SapCloudForCustomerSinkWriteBehavior;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11692[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SapCloudForCustomerSink' is not assignable to type 'Record<unknown>'
> 11692 |   type: "SapCloudForCustomerSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11698[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureQueueSink' is not assignable to type 'Record<unknown>'
> 11698 |   type: "AzureQueueSink";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11716[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureTableSink' is not assignable to type 'Record<unknown>'
> 11716 |   type: "AzureTableSink";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11722[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreWriteSettings'.
> 11722 |   storeSettings?: StoreWriteSettings;
        |                   ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11725[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AvroWriteSettings'.
> 11725 |   formatSettings?: AvroWriteSettings;
        |                    ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11728[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AvroSink' is not assignable to type 'Record<unknown>'
> 11728 |   type: "AvroSink";
        |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11734[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreWriteSettings'.
> 11734 |   storeSettings?: StoreWriteSettings;
        |                   ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11737[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ParquetWriteSettings'.
> 11737 |   formatSettings?: ParquetWriteSettings;
        |                    ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11740[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ParquetSink' is not assignable to type 'Record<unknown>'
> 11740 |   type: "ParquetSink";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11746[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.StoreWriteSettings'.
> 11746 |   storeSettings?: StoreWriteSettings;
        |                   ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11749[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'BinarySink' is not assignable to type 'Record<unknown>'
> 11749 |   type: "BinarySink";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11767[39m:[33m14[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MetadataItem[]'.
> 11767 |   metadata?: MetadataItem[];
        |              ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11770[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'BlobSink' is not assignable to type 'Record<unknown>'
> 11770 |   type: "BlobSink";
        |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11788[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'FileSystemSink' is not assignable to type 'Record<unknown>'
> 11788 |   type: "FileSystemSink";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11800[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DocumentDbCollectionSink' is not assignable to type 'Record<unknown>'
> 11800 |   type: "DocumentDbCollectionSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11809[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDbSqlApiSink' is not assignable to type 'Record<unknown>'
> 11809 |   type: "CosmosDbSqlApiSink";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11839[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlUpsertSettings'.
> 11839 |   upsertSettings?: SqlUpsertSettings;
        |                    ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11842[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlSink' is not assignable to type 'Record<unknown>'
> 11842 |   type: "SqlSink";
        |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11884[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlUpsertSettings'.
> 11884 |   upsertSettings?: SqlUpsertSettings;
        |                    ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11887[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlServerSink' is not assignable to type 'Record<unknown>'
> 11887 |   type: "SqlServerSink";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11917[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlUpsertSettings'.
> 11917 |   upsertSettings?: SqlUpsertSettings;
        |                    ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11920[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSqlSink' is not assignable to type 'Record<unknown>'
> 11920 |   type: "AzureSqlSink";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11950[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlUpsertSettings'.
> 11950 |   upsertSettings?: SqlUpsertSettings;
        |                    ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11953[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlMISink' is not assignable to type 'Record<unknown>'
> 11953 |   type: "SqlMISink";
        |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11992[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.PolybaseSettingsRejectType' is not assignable to type 'Record<unknown>'
> 11992 |   rejectType?: PolybaseSettingsRejectType;
        |                ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11965[39m:[33m22[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.PolybaseSettings'.
> 11965 |   polyBaseSettings?: PolybaseSettings;
        |                      ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11971[39m:[33m25[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DWCopyCommandSettings'.
> 11971 |   copyCommandSettings?: DWCopyCommandSettings;
        |                         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11983[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlDWUpsertSettings'.
> 11983 |   upsertSettings?: SqlDWUpsertSettings;
        |                    ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m11986[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlDWSink' is not assignable to type 'Record<unknown>'
> 11986 |   type: "SqlDWSink";
        |         ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12052[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SnowflakeImportCopyCommand' is not assignable to type 'Record<unknown>'
> 12052 |   type: "SnowflakeImportCopyCommand";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12037[39m:[33m20[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SnowflakeImportCopyCommand'.
> 12037 |   importSettings?: SnowflakeImportCopyCommand;
        |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12040[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SnowflakeSink' is not assignable to type 'Record<unknown>'
> 12040 |   type: "SnowflakeSink";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12070[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OracleSink' is not assignable to type 'Record<unknown>'
> 12070 |   type: "OracleSink";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12082[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataLakeStoreSink' is not assignable to type 'Record<unknown>'
> 12082 |   type: "AzureDataLakeStoreSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12091[39m:[33m14[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.MetadataItem[]'.
> 12091 |   metadata?: MetadataItem[];
        |              ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12094[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureBlobFSSink' is not assignable to type 'Record<unknown>'
> 12094 |   type: "AzureBlobFSSink";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12100[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.AzureSearchIndexWriteBehaviorType' is not assignable to type 'Record<unknown>'
> 12100 |   writeBehavior?: AzureSearchIndexWriteBehaviorType;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12103[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureSearchIndexSink' is not assignable to type 'Record<unknown>'
> 12103 |   type: "AzureSearchIndexSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12112[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'OdbcSink' is not assignable to type 'Record<unknown>'
> 12112 |   type: "OdbcSink";
        |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12121[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'InformixSink' is not assignable to type 'Record<unknown>'
> 12121 |   type: "InformixSink";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12130[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MicrosoftAccessSink' is not assignable to type 'Record<unknown>'
> 12130 |   type: "MicrosoftAccessSink";
        |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12136[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.DynamicsSinkWriteBehavior' is not assignable to type 'Record<unknown>'
> 12136 |   writeBehavior: DynamicsSinkWriteBehavior;
        |                  ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12145[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsSink' is not assignable to type 'Record<unknown>'
> 12145 |   type: "DynamicsSink";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12151[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.DynamicsSinkWriteBehavior' is not assignable to type 'Record<unknown>'
> 12151 |   writeBehavior: DynamicsSinkWriteBehavior;
        |                  ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12160[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DynamicsCrmSink' is not assignable to type 'Record<unknown>'
> 12160 |   type: "DynamicsCrmSink";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12166[39m:[33m18[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.DynamicsSinkWriteBehavior' is not assignable to type 'Record<unknown>'
> 12166 |   writeBehavior: DynamicsSinkWriteBehavior;
        |                  ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12175[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CommonDataServiceForAppsSink' is not assignable to type 'Record<unknown>'
> 12175 |   type: "CommonDataServiceForAppsSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12190[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataExplorerSink' is not assignable to type 'Record<unknown>'
> 12190 |   type: "AzureDataExplorerSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12196[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.SalesforceSinkWriteBehavior' is not assignable to type 'Record<unknown>'
> 12196 |   writeBehavior?: SalesforceSinkWriteBehavior;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12205[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceSink' is not assignable to type 'Record<unknown>'
> 12205 |   type: "SalesforceSink";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12211[39m:[33m19[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.SalesforceSinkWriteBehavior' is not assignable to type 'Record<unknown>'
> 12211 |   writeBehavior?: SalesforceSinkWriteBehavior;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12220[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SalesforceServiceCloudSink' is not assignable to type 'Record<unknown>'
> 12220 |   type: "SalesforceServiceCloudSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12229[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbAtlasSink' is not assignable to type 'Record<unknown>'
> 12229 |   type: "MongoDbAtlasSink";
        |         ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12238[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'MongoDbV2Sink' is not assignable to type 'Record<unknown>'
> 12238 |   type: "MongoDbV2Sink";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12247[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CosmosDbMongoDbApiSink' is not assignable to type 'Record<unknown>'
> 12247 |   type: "CosmosDbMongoDbApiSink";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12262[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'LakeHouseTableSink' is not assignable to type 'Record<unknown>'
> 12262 |   type: "LakeHouseTableSink";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12290[39m:[33m28[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TypeConversionSettings'.
> 12290 |   typeConversionSettings?: TypeConversionSettings;
        |                            ^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12293[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TabularTranslator' is not assignable to type 'Record<unknown>'
> 12293 |   type: "TabularTranslator";
        |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12320[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HDInsightHiveActivityTypeProperties'.
> 12320 |   typeProperties: HDInsightHiveActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12323[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HDInsightHive' is not assignable to type 'Record<unknown>'
> 12323 |   type: "HDInsightHive";
        |         ^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12356[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HDInsightPigActivityTypeProperties'.
> 12356 |   typeProperties: HDInsightPigActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12359[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HDInsightPig' is not assignable to type 'Record<unknown>'
> 12359 |   type: "HDInsightPig";
        |         ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12386[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HDInsightMapReduceActivityTypeProperties'.
> 12386 |   typeProperties: HDInsightMapReduceActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12389[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HDInsightMapReduce' is not assignable to type 'Record<unknown>'
> 12389 |   type: "HDInsightMapReduce";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12422[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HDInsightStreamingActivityTypeProperties'.
> 12422 |   typeProperties: HDInsightStreamingActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12425[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HDInsightStreaming' is not assignable to type 'Record<unknown>'
> 12425 |   type: "HDInsightStreaming";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12470[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.HDInsightSparkActivityTypeProperties'.
> 12470 |   typeProperties: HDInsightSparkActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12473[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'HDInsightSpark' is not assignable to type 'Record<unknown>'
> 12473 |   type: "HDInsightSpark";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12506[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ExecuteSsisPackageActivityTypeProperties'.
> 12506 |   typeProperties: ExecuteSsisPackageActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12509[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ExecuteSSISPackage' is not assignable to type 'Record<unknown>'
> 12509 |   type: "ExecuteSSISPackage";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12668[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CustomActivityTypeProperties'.
> 12668 |   typeProperties: CustomActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12671[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Custom' is not assignable to type 'Record<unknown>'
> 12671 |   type: "Custom";
        |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12710[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SqlServerStoredProcedureActivityTypeProperties'.
> 12710 |   typeProperties: SqlServerStoredProcedureActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12713[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SqlServerStoredProcedure' is not assignable to type 'Record<unknown>'
> 12713 |   type: "SqlServerStoredProcedure";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12740[39m:[33m17[39m - [31merror[39m[90m unassignable[39m: Type 'boolean' is not assignable to type 'Record<unknown>'
> 12740 |   secureInput?: boolean;
        |                 ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12728[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ExecutePipelineActivityPolicy'.
> 12728 |   policy?: ExecutePipelineActivityPolicy;
        |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12731[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ExecutePipelineActivityTypeProperties'.
> 12731 |   typeProperties: ExecutePipelineActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12734[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ExecutePipeline' is not assignable to type 'Record<unknown>'
> 12734 |   type: "ExecutePipeline";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12758[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DeleteActivityTypeProperties'.
> 12758 |   typeProperties: DeleteActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12761[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Delete' is not assignable to type 'Record<unknown>'
> 12761 |   type: "Delete";
        |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12789[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureDataExplorerCommandActivityTypeProperties'.
> 12789 |   typeProperties: AzureDataExplorerCommandActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12792[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureDataExplorerCommand' is not assignable to type 'Record<unknown>'
> 12792 |   type: "AzureDataExplorerCommand";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12807[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.LookupActivityTypeProperties'.
> 12807 |   typeProperties: LookupActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12810[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Lookup' is not assignable to type 'Record<unknown>'
> 12810 |   type: "Lookup";
        |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12828[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.WebActivityTypeProperties'.
> 12828 |   typeProperties: WebActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12831[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'WebActivity' is not assignable to type 'Record<unknown>'
> 12831 |   type: "WebActivity";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12891[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.GetMetadataActivityTypeProperties'.
> 12891 |   typeProperties: GetMetadataActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12894[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'GetMetadata' is not assignable to type 'Record<unknown>'
> 12894 |   type: "GetMetadata";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12915[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.IfConditionActivityTypeProperties'.
> 12915 |   typeProperties: IfConditionActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12918[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'IfCondition' is not assignable to type 'Record<unknown>'
> 12918 |   type: "IfCondition";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12936[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SwitchActivityTypeProperties'.
> 12936 |   typeProperties: SwitchActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12939[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Switch' is not assignable to type 'Record<unknown>'
> 12939 |   type: "Switch";
        |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12966[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ForEachActivityTypeProperties'.
> 12966 |   typeProperties: ForEachActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12969[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ForEach' is not assignable to type 'Record<unknown>'
> 12969 |   type: "ForEach";
        |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12991[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMLBatchExecutionActivityTypeProperties'.
> 12991 |   typeProperties: AzureMLBatchExecutionActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m12994[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMLBatchExecution' is not assignable to type 'Record<unknown>'
> 12994 |   type: "AzureMLBatchExecution";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13021[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMLUpdateResourceActivityTypeProperties'.
> 13021 |   typeProperties: AzureMLUpdateResourceActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13024[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMLUpdateResource' is not assignable to type 'Record<unknown>'
> 13024 |   type: "AzureMLUpdateResource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13042[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureMLExecutePipelineActivityTypeProperties'.
> 13042 |   typeProperties: AzureMLExecutePipelineActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13045[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureMLExecutePipeline' is not assignable to type 'Record<unknown>'
> 13045 |   type: "AzureMLExecutePipeline";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13078[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DataLakeAnalyticsUsqlActivityTypeProperties'.
> 13078 |   typeProperties: DataLakeAnalyticsUsqlActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13081[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DataLakeAnalyticsU-SQL' is not assignable to type 'Record<unknown>'
> 13081 |   type: "DataLakeAnalyticsU-SQL";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13111[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.WaitActivityTypeProperties'.
> 13111 |   typeProperties: WaitActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13114[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Wait' is not assignable to type 'Record<unknown>'
> 13114 |   type: "Wait";
        |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13126[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.FailActivityTypeProperties'.
> 13126 |   typeProperties: FailActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13129[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Fail' is not assignable to type 'Record<unknown>'
> 13129 |   type: "Fail";
        |         ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13144[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.UntilActivityTypeProperties'.
> 13144 |   typeProperties: UntilActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13147[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Until' is not assignable to type 'Record<unknown>'
> 13147 |   type: "Until";
        |         ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13165[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ValidationActivityTypeProperties'.
> 13165 |   typeProperties: ValidationActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13168[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Validation' is not assignable to type 'Record<unknown>'
> 13168 |   type: "Validation";
        |         ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13192[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.FilterActivityTypeProperties'.
> 13192 |   typeProperties: FilterActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13195[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Filter' is not assignable to type 'Record<unknown>'
> 13195 |   type: "Filter";
        |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13210[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DatabricksNotebookActivityTypeProperties'.
> 13210 |   typeProperties: DatabricksNotebookActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13213[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DatabricksNotebook' is not assignable to type 'Record<unknown>'
> 13213 |   type: "DatabricksNotebook";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13231[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DatabricksSparkJarActivityTypeProperties'.
> 13231 |   typeProperties: DatabricksSparkJarActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13234[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DatabricksSparkJar' is not assignable to type 'Record<unknown>'
> 13234 |   type: "DatabricksSparkJar";
        |         ^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13252[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DatabricksSparkPythonActivityTypeProperties'.
> 13252 |   typeProperties: DatabricksSparkPythonActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13255[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'DatabricksSparkPython' is not assignable to type 'Record<unknown>'
> 13255 |   type: "DatabricksSparkPython";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13273[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SetVariableActivityTypeProperties'.
> 13273 |   typeProperties: SetVariableActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13276[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SecureInputOutputPolicy'.
> 13276 |   policy?: SecureInputOutputPolicy;
        |            ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13279[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SetVariable' is not assignable to type 'Record<unknown>'
> 13279 |   type: "SetVariable";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13306[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AppendVariableActivityTypeProperties'.
> 13306 |   typeProperties: AppendVariableActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13309[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AppendVariable' is not assignable to type 'Record<unknown>'
> 13309 |   type: "AppendVariable";
        |         ^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13324[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.AzureFunctionActivityTypeProperties'.
> 13324 |   typeProperties: AzureFunctionActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13327[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'AzureFunctionActivity' is not assignable to type 'Record<unknown>'
> 13327 |   type: "AzureFunctionActivity";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13348[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.WebHookActivityTypeProperties'.
> 13348 |   typeProperties: WebHookActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13351[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SecureInputOutputPolicy'.
> 13351 |   policy?: SecureInputOutputPolicy;
        |            ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13354[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'WebHook' is not assignable to type 'Record<unknown>'
> 13354 |   type: "WebHook";
        |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13384[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ExecuteDataFlowActivityTypeProperties'.
> 13384 |   typeProperties: ExecuteDataFlowActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13387[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ExecuteDataFlow' is not assignable to type 'Record<unknown>'
> 13387 |   type: "ExecuteDataFlow";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13429[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ExecutePowerQueryActivityTypeProperties'.
> 13429 |   typeProperties: ExecutePowerQueryActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13432[39m:[33m12[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ActivityPolicy'.
> 13432 |   policy?: ActivityPolicy;
        |            ^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13435[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ExecuteWranglingDataflow' is not assignable to type 'Record<unknown>'
> 13435 |   type: "ExecuteWranglingDataflow";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13460[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ScriptActivityTypeProperties'.
> 13460 |   typeProperties: ScriptActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13463[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Script' is not assignable to type 'Record<unknown>'
> 13463 |   type: "Script";
        |         ^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13526[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SharePointOnlineListSource' is not assignable to type 'Record<unknown>'
> 13526 |   type: "SharePointOnlineListSource";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13532[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SynapseNotebookActivityTypeProperties'.
> 13532 |   typeProperties: SynapseNotebookActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13535[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SynapseNotebook' is not assignable to type 'Record<unknown>'
> 13535 |   type: "SynapseNotebook";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13610[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.SynapseSparkJobActivityTypeProperties'.
> 13610 |   typeProperties: SynapseSparkJobActivityTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13613[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'SparkJob' is not assignable to type 'Record<unknown>'
> 13613 |   type: "SparkJob";
        |         ^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13681[39m:[33m15[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TriggerPipelineReference[]'.
> 13681 |   pipelines?: TriggerPipelineReference[];
        |               ^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13702[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.RecurrenceFrequency' is not assignable to type 'Record<unknown>'
> 13702 |   frequency?: RecurrenceFrequency;
        |               ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13705[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 13705 |   interval?: int32;
        |              ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13709[39m:[33m15[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 13709 |   startTime?: utcDateTime;
        |               ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13713[39m:[33m13[39m - [31merror[39m[90m unassignable[39m: Type 'utcDateTime' is not assignable to type 'Record<unknown>'
> 13713 |   endTime?: utcDateTime;
        |             ^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13716[39m:[33m14[39m - [31merror[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 13716 |   timeZone?: string;
        |              ^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13725[39m:[33m13[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'int32[]'.
> 13725 |   minutes?: int32[];
        |             ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13728[39m:[33m11[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'int32[]'.
> 13728 |   hours?: int32[];
        |           ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13731[39m:[33m14[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.DaysOfWeek[]'.
> 13731 |   weekDays?: DaysOfWeek[];
        |              ^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13734[39m:[33m15[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'int32[]'.
> 13734 |   monthDays?: int32[];
        |               ^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13743[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'Azure.ResourceManager.DataFactory.DayOfWeek' is not assignable to type 'Record<unknown>'
> 13743 |   day?: DayOfWeek;
        |         ^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13746[39m:[33m16[39m - [31merror[39m[90m unassignable[39m: Type 'int32' is not assignable to type 'Record<unknown>'
> 13746 |   occurrence?: int32;
        |                ^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13737[39m:[33m24[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.RecurrenceScheduleOccurrence[]'.
> 13737 |   monthlyOccurrences?: RecurrenceScheduleOccurrence[];
        |                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13719[39m:[33m14[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.RecurrenceSchedule'.
> 13719 |   schedule?: RecurrenceSchedule;
        |              ^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13687[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ScheduleTriggerTypeProperties'.
> 13687 |   typeProperties: ScheduleTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13690[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ScheduleTrigger' is not assignable to type 'Record<unknown>'
> 13690 |   type: "ScheduleTrigger";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13752[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.BlobTriggerTypeProperties'.
> 13752 |   typeProperties: BlobTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13755[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'BlobTrigger' is not assignable to type 'Record<unknown>'
> 13755 |   type: "BlobTrigger";
        |         ^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13773[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.BlobEventsTriggerTypeProperties'.
> 13773 |   typeProperties: BlobEventsTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13776[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'BlobEventsTrigger' is not assignable to type 'Record<unknown>'
> 13776 |   type: "BlobEventsTrigger";
        |         ^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13800[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.CustomEventsTriggerTypeProperties'.
> 13800 |   typeProperties: CustomEventsTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13803[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'CustomEventsTrigger' is not assignable to type 'Record<unknown>'
> 13803 |   type: "CustomEventsTrigger";
        |         ^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13824[39m:[33m13[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TriggerPipelineReference'.
> 13824 |   pipeline: TriggerPipelineReference;
        |             ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13827[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TumblingWindowTriggerTypeProperties'.
> 13827 |   typeProperties: TumblingWindowTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13830[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'TumblingWindowTrigger' is not assignable to type 'Record<unknown>'
> 13830 |   type: "TumblingWindowTrigger";
        |         ^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13935[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.RerunTumblingWindowTriggerTypeProperties'.
> 13935 |   typeProperties: RerunTumblingWindowTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13938[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'RerunTumblingWindowTrigger' is not assignable to type 'Record<unknown>'
> 13938 |   type: "RerunTumblingWindowTrigger";
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13963[39m:[33m13[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.TriggerPipelineReference'.
> 13963 |   pipeline: TriggerPipelineReference;
        |             ^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13966[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ChainingTriggerTypeProperties'.
> 13966 |   typeProperties: ChainingTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13969[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ChainingTrigger' is not assignable to type 'Record<unknown>'
> 13969 |   type: "ChainingTrigger";
        |         ^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13984[39m:[33m19[39m - [31merror[39m[90m missing-index[39m: Index signature for type 'string' is missing in type 'Azure.ResourceManager.DataFactory.ServicePrincipalCredentialTypeProperties'.
> 13984 |   typeProperties: ServicePrincipalCredentialTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[36mC:/Users/v-cruan/Documents/GitHub/azure-rest-api-specs/specification/datafactory/Datafactory.Management/tsp-output/models.tsp[39m:[33m13987[39m:[33m9[39m - [31merror[39m[90m unassignable[39m: Type 'ServicePrincipal' is not assignable to type 'Record<unknown>'
> 13987 |   type: "ServicePrincipal";
        |         ^^^^^^^^^^^^^^^^^^

Found 987 errors.

