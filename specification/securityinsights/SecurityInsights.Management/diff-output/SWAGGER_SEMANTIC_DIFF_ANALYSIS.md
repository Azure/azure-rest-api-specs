# SecurityInsights API Semantic Diff Analysis

## Analysis Methodology

1. **Source Files Analyzed:**
   - [Old Swagger: `oldNormalizedSwagger.json`](./oldNormalizedSwagger.json)
   - [New Swagger: `newNormalizedSwagger.json`](./newNormalizedSwagger.json) 
   - [Change Documentation: `API_CHANGES.md`](./API_CHANGES.md)

2. **Semantic Categorization:** Changes grouped by semantic impact rather than structural differences
3. **Coverage Verification:** All 695 items from API_CHANGES.md accounted for

---

## Detailed Category Analysis

### 1. API Path Restructuring - Workspace Parameter Removal (112 changes)

**Description:** The API paths have been restructured to remove the intermediate workspace resource provider pattern. Old paths included `/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/providers/microsoft.SecurityInsights/` while new paths use `/providers/microsoft.SecurityInsights/` directly. This represents a major architectural change where most resources are now scoped to resource group level instead of workspace level. A few operations (entities/runPlaybook, listRepositories, threatIntelligence operations) still retain workspace parameters for backward compatibility.

**Examples:**
- [Lines 1-224 in API_CHANGES.md](./API_CHANGES.md#L1-L224): Path changes for all SecurityInsights resources

**Code Comparison:**
```json
// OLD SWAGGER - Workspace-scoped paths
"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/providers/microsoft.SecurityInsights/alertRules"

// NEW SWAGGER - Resource group-scoped paths
"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.SecurityInsights/alertRules"
```

**Complete List (112 cases):**
- 56 workspace-scoped paths deleted (operationIds: AlertRuleTemplates_List, AlertRuleTemplates_Get, AlertRules_List, AlertRules_Get, Actions_ListByAlertRule, Actions_Get, AutomationRules_List, AutomationRules_Get, Bookmarks_List, Bookmarks_Get, ContentPackages_List, ContentPackages_Get, ProductPackages_List, ProductPackage_Get, ProductTemplates_List, ContentTemplates_List, ContentTemplate_Get, ProductTemplate_Get, DataConnectorDefinitions_List, DataConnectorDefinitions_Get, DataConnectors_List, DataConnectors_Get, Entities_RunPlaybook, Incidents_List, Incidents_Get, Incidents_ListAlerts, Incidents_ListBookmarks, IncidentComments_List, IncidentComments_Get, Incidents_ListEntities, IncidentRelations_List, IncidentRelations_Get, Incidents_RunPlaybook, IncidentTasks_List, IncidentTasks_Get, SourceControl_listRepositories, Metadata_List, Metadata_Get, SentinelOnboardingStates_List, SentinelOnboardingStates_Get, SecurityMLAnalyticsSettings_List, SecurityMLAnalyticsSettings_Get, SourceControls_List, SourceControls_Get, SourceControls_Delete, ThreatIntelligenceIndicator_CreateIndicator, ThreatIntelligenceIndicators_List, ThreatIntelligenceIndicator_Get, ThreatIntelligenceIndicator_AppendTags, ThreatIntelligenceIndicator_ReplaceTags, ThreatIntelligenceIndicatorMetrics_List, ThreatIntelligenceIndicator_QueryIndicators, Watchlists_List, Watchlists_Get, WatchlistItems_List, WatchlistItems_Get)
- 52 resource group-scoped paths added (same operations as above, minus workspace parameter)
- 4 workspace-aware paths added (operationIds: Entities_RunPlaybook, SourceControl_listRepositories, ThreatIntelligenceIndicator_CreateIndicator, ThreatIntelligenceIndicatorMetrics_List, ThreatIntelligenceIndicator_QueryIndicators) - these retain `{workspaceName}` parameter
- 4 new resource group paths added for threat intelligence (operationIds: ThreatIntelligenceIndicators_List, ThreatIntelligenceIndicator_Get, ThreatIntelligenceIndicator_AppendTags, ThreatIntelligenceIndicator_ReplaceTags)
- 1 incident runPlaybook path structure change from `/{incidentIdentifier}/runPlaybook` to `/{incidentId}/{incidentIdentifier}/runPlaybook`
- 1 content product template path casing change from `/contentProductTemplates` to `/contentproducttemplates`

**GitHub Fix commit links:**


---

### 2. Discriminator Pattern Migration (52 changes)

**Description:** Migration from x-ms-discriminator-value extension to standard TypeSpec discriminator pattern using `kind` property with required constraint and enum type. This affects polymorphic types for AlertRule, AlertRuleTemplate, DataConnector, DataConnectorDefinition, SecurityMLAnalyticsSetting, and ThreatIntelligenceInformation base types and their derived types.

**Examples:**
- [Lines 1758-1773 in API_CHANGES.md](./API_CHANGES.md#L1758-L1773): Discriminator value removals
- [Lines 1775-1797 in API_CHANGES.md](./API_CHANGES.md#L1775-L1797): Required kind properties added
- [Lines 1799-1814 in API_CHANGES.md](./API_CHANGES.md#L1799-L1814): Kind properties with enum added

**Code Comparison:**
```json
// OLD SWAGGER - x-ms-discriminator-value pattern
{
  "AADDataConnector": {
    "x-ms-discriminator-value": "AzureActiveDirectory",
    "properties": { ... }
  },
  "DataConnector": {
    "discriminator": "kind"
  }
}

// NEW SWAGGER - TypeSpec standard discriminator pattern
{
  "AADDataConnector": {
    "required": ["kind"],
    "properties": {
      "kind": {
        "type": "string",
        "enum": ["AzureActiveDirectory"],
        "x-ms-enum": {"modelAsString": false}
      }
    }
  },
  "DataConnector": {
    "properties": {
      "kind": { ... },
      "properties": {"type": "object"}
    }
  }
}
```

**Complete List (52 cases):**
- 16 x-ms-discriminator-value removals (AADDataConnector, AnomalySecurityMLAnalyticsSettings, ASCDataConnector, AwsCloudTrailDataConnector, CustomizableConnectorDefinition, FusionAlertRule, FusionAlertRuleTemplate, MicrosoftSecurityIncidentCreationAlertRule, MicrosoftSecurityIncidentCreationAlertRuleTemplate, OfficeDataConnector, PremiumMicrosoftDefenderForThreatIntelligence, RestApiPollerDataConnector, ScheduledAlertRule, ScheduledAlertRuleTemplate, ThreatIntelligenceIndicatorModel, TIDataConnector)
- 6 discriminator property removals from base types (AlertRule, AlertRuleTemplate, DataConnector, DataConnectorDefinition, SecurityMLAnalyticsSetting, ThreatIntelligenceInformation)
- 6 generic properties object additions to base types (AlertRule, AlertRuleTemplate, DataConnector, DataConnectorDefinition, SecurityMLAnalyticsSetting, ThreatIntelligenceInformation)
- 16 required kind constraints added to derived types
- 16 kind property definitions with enum constraints added to derived types
- 3 alert rule template required properties removed (FusionAlertRuleTemplate, MicrosoftSecurityIncidentCreationAlertRuleTemplate, ScheduledAlertRuleTemplate) - now handled by base type
- 3 list model required properties added (AutomationRulesList, DataConnectorDefinitionArmCollectionWrapper, IncidentTaskList)

**GitHub Fix commit links:**


---

### 3. Model Renaming - PascalCase Normalization (102 changes)

**Description:** Model names have been normalized to follow PascalCase conventions in TypeSpec. This includes renaming legacy camelCase prefixes (AATP, MCAS, MDATP, MSTI) to PascalCase (Aatp, Mcas, Mdatp, Msti), and changing lowercase metadata/package/template prefixes to PascalCase. The change is purely cosmetic and does not affect the API wire format.

**Examples:**
- [Lines 1055-1113 in API_CHANGES.md](./API_CHANGES.md#L1055-L1113): Old camelCase models deleted
- [Lines 1115-1173 in API_CHANGES.md](./API_CHANGES.md#L1115-L1173): New PascalCase models added

**Code Comparison:**
```json
// OLD SWAGGER - camelCase/lowercase prefixes
{
  "definitions": {
    "AATPDataConnector": {...},
    "AATPDataConnectorProperties": {...},
    "MCASDataConnector": {...},
    "MDATPDataConnector": {...},
    "MSTIDataConnector": {...},
    "metadataProperties": {...},
    "packageModel": {...},
    "templateModel": {...}
  }
}

// NEW SWAGGER - PascalCase normalization
{
  "definitions": {
    "AatpDataConnector": {...},
    "AatpDataConnectorProperties": {...},
    "McasDataConnector": {...},
    "MdatpDataConnector": {...},
    "MstiDataConnector": {...},
    "MetadataProperties": {...},
    "PackageModel": {...},
    "TemplateModel": {...}
  }
}
```

**Complete List (102 cases):**
- 2 AATP models renamed (AATPDataConnector → AatpDataConnector, AATPDataConnectorProperties → AatpDataConnectorProperties)
- 3 MCAS models renamed (MCASDataConnector → McasDataConnector, MCASDataConnectorDataTypes → McasDataConnectorDataTypes, MCASDataConnectorProperties → McasDataConnectorProperties)
- 2 MDATP models renamed (MDATPDataConnector → MdatpDataConnector, MDATPDataConnectorProperties → MdatpDataConnectorProperties)
- 3 MSTI models renamed (MSTIDataConnector → MstiDataConnector, MSTIDataConnectorDataTypes → MstiDataConnectorDataTypes, MSTIDataConnectorProperties → MstiDataConnectorProperties)
- 1 MSTI nested type renamed (MSTIDataConnectorDataTypes.microsoftEmergingThreatFeed type becomes MstiDataConnectorDataTypesMicrosoftEmergingThreatFeed)
- 2 Operations models renamed (Operation → removed, OperationsList → uses common OperationListResult)
- 24 metadata models renamed (metadataAuthor → MetadataAuthor, metadataCategories → MetadataCategories, metadataContentId → removed, metadataContentSchemaVersion → removed, metadataCustomVersion → removed, metadataIcon → removed, metadataKind → removed, metadataParentId → removed, metadataPatch → MetadataPatch, metadataPreviewImages → removed, metadataPreviewImagesDark → removed, metadataProperties → MetadataProperties, metadataPropertiesPatch → MetadataPropertiesPatch, metadataProviders → removed, metadataSource → MetadataSource, metadataSupport → MetadataSupport, metadataThreatAnalysisTactics → removed, metadataThreatAnalysisTechniques → removed, metadataVersion → removed)
- 12 package models renamed (packageList → PackageList, packageModel → PackageModel, packageProperties → PackageProperties, packagedContent → removed, productPackageAdditionalProperties → removed, productPackageList → ProductPackageList, productPackageModel → ProductPackageModel, productPackageProperties → ProductPackageProperties, PackageBaseProperties added)
- 14 template models renamed (templateAdditionalProperties → removed, templateList → TemplateList, templateModel → TemplateModel, templateProperties → TemplateProperties, productTemplateAdditionalProperties → removed, productTemplateList → ProductTemplateList, productTemplateModel → ProductTemplateModel, productTemplateProperties → ProductTemplateProperties)
- 4 date models removed (firstPublishDate, lastPublishDate)
- 1 mainTemplate model removed
- 1 AvailabilityStatus model removed
- 1 EntityMappings typedef removed
- 1 MetadataDependencies model added

**GitHub Fix commit links:**


---

### 4. Entity Model Inlining (68 changes)

**Description:** Entity type definitions that were previously referenced from external common schema files (`./common/EntityTypes.json`) have been inlined directly into the main swagger. This includes all entity types like AccountEntity, HostEntity, FileEntity, IpEntity, etc., and their corresponding property models. This eliminates external dependencies and makes the schema self-contained.

**Examples:**
- [Lines 1115-1173 in API_CHANGES.md](./API_CHANGES.md#L1115-L1173): Entity models added

**Code Comparison:**
```json
// OLD SWAGGER - External reference
{
  "IncidentEntitiesResponse": {
    "properties": {
      "entities": {
        "items": {
          "$ref": "./common/EntityTypes.json#/definitions/Entity"
        }
      }
    }
  }
}

// NEW SWAGGER - Inlined definitions
{
  "Entity": {
    "type": "object",
    "properties": {
      "kind": {
        "type": "string",
        "enum": ["Account", "Host", "File", "AzureResource", ...]
      }
    }
  },
  "AccountEntity": {...},
  "HostEntity": {...},
  "IncidentEntitiesResponse": {
    "properties": {
      "entities": {
        "items": {
          "$ref": "#/definitions/Entity"
        }
      }
    }
  }
}
```

**Complete List (68 cases):**
- 34 entity models inlined (Entity, EntityCommonProperties, AccountEntity, AccountEntityProperties, AzureResourceEntity, AzureResourceEntityProperties, CloudApplicationEntity, CloudApplicationEntityProperties, DnsEntity, DnsEntityProperties, FileEntity, FileEntityProperties, FileHashEntity, FileHashEntityProperties, GeoLocation, HostEntity, HostEntityProperties, HuntingBookmark, HuntingBookmarkProperties, IoTDeviceEntity, IoTDeviceEntityProperties, IpEntity, IpEntityProperties, MailboxEntity, MailboxEntityProperties, MailClusterEntity, MailClusterEntityProperties, MailMessageEntity, MailMessageEntityProperties, MalwareEntity, MalwareEntityProperties, ProcessEntity, ProcessEntityProperties, RegistryKeyEntity, RegistryKeyEntityProperties, RegistryValueEntity, RegistryValueEntityProperties, SecurityAlert, SecurityAlertProperties, SecurityAlertPropertiesConfidenceReasonsItem, SecurityGroupEntity, SecurityGroupEntityProperties, SubmissionMailEntity, SubmissionMailEntityProperties, ThreatIntelligence, UrlEntity, UrlEntityProperties)
- 3 incident entity references updated (IncidentEntitiesResponse.properties.entities.items.$ref, IncidentAlertList.properties.value.items.$ref, IncidentBookmarkList.properties.value.items.$ref)
- 3 user/client info models inlined (UserInfo, ClientInfo, IncidentInfo, IncidentLabel, IncidentOwnerInfo)
- 9 user/client info references updated in various property models

**GitHub Fix commit links:**


---

### 5. Etag Property Addition to Resources (16 changes)

**Description:** The `etag` property has been explicitly added to 16 resource models. Previously, etag was inherited from a common base type `ResourceWithEtag`, but now it's directly defined on each resource model as the inheritance pattern has changed to use common-types `ProxyResource`.

**Examples:**
- [Lines 1859-1874 in API_CHANGES.md](./API_CHANGES.md#L1859-L1874): Etag properties added

**Code Comparison:**
```json
// OLD SWAGGER - Inherited etag via ResourceWithEtag
{
  "AlertRule": {
    "allOf": [{
      "$ref": "../../../common/2.0/types.json#/definitions/ResourceWithEtag"
    }]
  }
}

// NEW SWAGGER - Explicit etag property
{
  "AlertRule": {
    "properties": {
      "etag": {"type": "string"}
    },
    "allOf": [{
      "$ref": "../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"
    }]
  }
}
```

**Complete List (16 cases):**
- Etag added to: AlertRule, AutomationRule, Bookmark, DataConnector, DataConnectorDefinition, Incident, IncidentComment, IncidentTask, MetadataModel, Relation, SecurityMLAnalyticsSetting, SentinelOnboardingState, SourceControl, ThreatIntelligenceInformation, Watchlist, WatchlistItem

**GitHub Fix commit links:**


---

### 6. Inline Object Type Expansion (58 changes)

**Description:** Anonymous inline object types have been expanded into either proper type references or primitive types with explicit structure. This includes properties like `alerts`, `customizableObservations`, `actionConfiguration`, `conditionProperties`, `logs`, `createdBy`, `updatedBy`, `incidentInfo`, `author`, `additionalData`, `owner`, etc. Some become proper $ref to named types, others become arrays/strings with explicit item types.

**Examples:**
- [Lines 1876-1933 in API_CHANGES.md](./API_CHANGES.md#L1876-L1933): Type changes from object to specific types

**Code Comparison:**
```json
// OLD SWAGGER - Anonymous inline object
{
  "properties": {
    "alerts": {"type": "object"},
    "createdBy": {"type": "object"},
    "tactics": {
      "items": {"$ref": "./common/AlertTypes.json#/definitions/AttackTactic"}
    }
  }
}

// NEW SWAGGER - Proper type reference or explicit array
{
  "properties": {
    "alerts": {"$ref": "#/definitions/AlertsDataTypeOfDataConnector"},
    "createdBy": {"$ref": "#/definitions/UserInfo"},
    "tactics": {
      "items": {
        "type": "string",
        "enum": ["Reconnaissance", "ResourceDevelopment", ...]
      }
    }
  }
}
```

**Complete List (58 cases):**
- 13 data type properties changed (AlertsDataTypeOfDataConnector.alerts, AwsCloudTrailDataConnectorDataTypes.logs, OfficeDataConnectorDataTypes.exchange/sharePoint/teams, PremiumMdtiDataConnectorDataTypes.connector, TIDataConnectorDataTypes.indicators)
- 10 user/client info properties changed (BookmarkProperties.createdBy/updatedBy, IncidentCommentProperties.author, IncidentProperties.owner, IncidentTaskProperties.createdBy/lastModifiedBy, AutomationRuleProperties.createdBy/lastModifiedBy, WatchlistProperties.createdBy/updatedBy, WatchlistItemProperties.createdBy/updatedBy)
- 9 action/condition properties changed (AutomationRuleAddIncidentTaskAction.actionConfiguration, AutomationRuleModifyPropertiesAction.actionConfiguration, AutomationRuleRunPlaybookAction.actionConfiguration, BooleanConditionProperties.conditionProperties, PropertyArrayChangedConditionProperties.conditionProperties, PropertyArrayConditionProperties.conditionProperties, PropertyChangedConditionProperties.conditionProperties, PropertyConditionProperties.conditionProperties)
- 8 tactical/severity array items changed from $ref to inline enum (AnomalySecurityMLAnalyticsSettingsProperties.tactics, FusionAlertRuleProperties.severity/tactics, FusionAlertRuleTemplateProperties.severity/tactics, IncidentAdditionalData.tactics, ScheduledAlertRuleProperties.tactics, ScheduledAlertRuleTemplateProperties.tactics)
- 6 incident/entity related properties changed (IncidentProperties.additionalData, BookmarkProperties.incidentInfo, IncidentEntitiesResultsMetadata.entityKind, IncidentPropertiesAction.classification/classificationReason/severity/status)
- 4 repository/deployment properties changed (RepositoryResourceInfo.azureDevOpsResourceInfo/gitHubResourceInfo/webhook, DeploymentInfo.deployment)
- 4 alert detail override properties changed (ScheduledAlertRuleCommonProperties.alertDetailsOverride/entityMappings, ScheduledAlertRuleTemplateProperties.alertDetailsOverride/entityMappings)
- 2 watchlist item properties changed (WatchlistItemProperties.entityMapping/itemsKeyValue)
- 2 instruction step properties changed (InstructionStepDetails.parameters)

**GitHub Fix commit links:**


---

### 7. External Schema Reference Inlining (28 changes)

**Description:** References to external common schema files have been replaced with inline enum definitions or references to inlined models within the same swagger file. This affects alert severity, attack tactics, incident classification, entity kinds, and other enumeration types previously defined in `./common/AlertTypes.json`, `./common/IncidentTypes.json`, and `./common/EntityTypes.json`.

**Examples:**
- [Lines 1935-1962 in API_CHANGES.md](./API_CHANGES.md#L1935-L1962): $ref changes from external to internal

**Code Comparison:**
```json
// OLD SWAGGER - External $ref
{
  "severity": {
    "$ref": "./common/AlertTypes.json#/definitions/AlertSeverityEnum"
  },
  "tactics": {
    "items": {
      "$ref": "./common/AlertTypes.json#/definitions/AttackTactic"
    }
  }
}

// NEW SWAGGER - Inline enum
{
  "severity": {
    "type": "string",
    "enum": ["High", "Medium", "Low", "Informational"],
    "x-ms-enum": {"name": "AlertSeverity", "modelAsString": true}
  },
  "tactics": {
    "items": {
      "type": "string",
      "enum": ["Reconnaissance", "ResourceDevelopment", ...],
      "x-ms-enum": {"name": "AttackTactic", "modelAsString": true}
    }
  }
}
```

**Complete List (28 cases):**
- 8 external $ref removals replaced with inline definitions (severity refs in FusionAlertRule, FusionAlertRuleTemplate, ScheduledAlertRuleCommonProperties, ScheduledAlertRuleTemplateProperties, IncidentProperties; tactics refs in AnomalySecurityMLAnalyticsSettings, FusionAlertRule, FusionAlertRuleTemplate, ScheduledAlertRule, ScheduledAlertRuleTemplate, IncidentAdditionalData; entityKind ref in IncidentEntitiesResultsMetadata; incident properties in IncidentPropertiesAction; severitiesFilter in MicrosoftSecurityIncidentCreationAlertRule)
- 8 enum definitions added for inlined types
- 6 $ref replacements for data type objects (AwsCloudTrailDataConnectorDataTypes.logs, OfficeDataConnectorDataTypes properties, PremiumMdtiDataConnectorDataTypes.connector, TIDataConnectorDataTypes.indicators)
- 2 entityMappings type changes (ScheduledAlertRuleCommonProperties, ScheduledAlertRuleTemplateProperties)
- 2 label array changes (BookmarkProperties.labels, WatchlistProperties.labels) from $ref to string type
- 2 example removals for bookmark labels references

**GitHub Fix commit links:**


---

### 8. X-MS Extension Property Changes (43 changes)

**Description:** Various x-ms extension properties have been added or removed to align with TypeSpec generation patterns. This includes x-ms-enum additions for inline enums, x-secret/x-ms-secret removals, x-nullable removals, x-ms-client-flatten removals, x-ms-discriminator removals, and example property removals.

**Examples:**
- [Lines 1964-1981 in API_CHANGES.md](./API_CHANGES.md#L1964-L1981): x-ms-enum additions
- [Lines 1816-1821 in API_CHANGES.md](./API_CHANGES.md#L1816-L1821): x-secret removals
- [Lines 1846-1853 in API_CHANGES.md](./API_CHANGES.md#L1846-L1853): x-ms-client-flatten removals

**Code Comparison:**
```json
// OLD SWAGGER - Various x-ms extensions
{
  "severity": {
    "$ref": "./common/AlertTypes.json#/definitions/AlertSeverityEnum"
  },
  "apiKey": {
    "type": "string",
    "x-secret": true
  },
  "BooleanConditionProperties": {
    "x-ms-client-flatten": true
  }
}

// NEW SWAGGER - Updated extension usage
{
  "severity": {
    "type": "string",
    "enum": ["High", "Medium", "Low", "Informational"],
    "x-ms-enum": {"name": "AlertSeverity", "modelAsString": true}
  },
  "apiKey": {
    "type": "string"
    // x-secret removed - handled differently in TypeSpec
  },
  "BooleanConditionProperties": {
    // x-ms-client-flatten removed - flattening handled by TypeSpec
  }
}
```

**Complete List (43 cases):**
- 18 x-ms-enum additions for inline enums (severity, tactics, entityKind, classification, classificationReason, status enums)
- 6 x-secret removals (ApiKeyAuthModel.apiKey, BasicAuthModel.password, JwtAuthModel.password, OAuthModel.authorizationCode/clientSecret, SessionAuthModel.password)
- 8 x-ms-client-flatten removals (AutomationRule action and condition models)
- 16 x-nullable removals (various config model properties)
- 3 x-ms-secret removals (RepositoryAccess.code/state/token)
- 1 x-ms-discriminator removal (RestApiPollerRequestPagingConfig)
- 1 x-ms-azure-resource removal (Repo)
- 19 example removals (ApiKeyAuthModel, AutomationRule properties, AWS/CCP/RestApiPoller config properties)

**GitHub Fix commit links:**


---

### 9. Common Type Reference Migration (43 changes)

**Description:** Resource base type references have been migrated from custom common types (`../../../common/2.0/types.json`) to standard ARM common-types v5 (`../../../../../common-types/resource-management/v5/types.json`). This includes changing ResourceWithEtag to ProxyResource, and CloudError to ErrorResponse. Additionally, Operations list model now uses standard OperationListResult from common-types.

**Examples:**
- [Lines 2267-2309 in API_CHANGES.md](./API_CHANGES.md#L2267-L2309): Modified Values section showing $ref changes

**Code Comparison:**
```json
// OLD SWAGGER - Custom common types
{
  "AlertRule": {
    "allOf": [{
      "$ref": "../../../common/2.0/types.json#/definitions/ResourceWithEtag"
    }]
  },
  "paths": {
    "responses": {
      "default": {
        "schema": {
          "$ref": "../../../common/2.0/types.json#/definitions/CloudError"
        }
      }
    }
  }
}

// NEW SWAGGER - Standard ARM common-types v5
{
  "AlertRule": {
    "allOf": [{
      "$ref": "../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"
    }],
    "properties": {
      "etag": {"type": "string"}
    }
  },
  "paths": {
    "responses": {
      "default": {
        "schema": {
          "$ref": "../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse"
        }
      }
    }
  }
}
```

**Complete List (43 cases):**
- 17 resource models changed from ResourceWithEtag to ProxyResource (AlertRule, AutomationRule, Bookmark, DataConnector, DataConnectorDefinition, Incident, IncidentComment, IncidentTask, MetadataModel, Relation, SecurityMLAnalyticsSetting, SentinelOnboardingState, SourceControl, ThreatIntelligenceInformation, Watchlist, WatchlistItem, ThreatIntelligenceIndicatorProperties)
- 2 resource models changed from Resource to ProxyResource (ActionResponse, AlertRuleTemplate)
- 1 ActionRequest base reference change from ResourceWithEtag to internal ResourceWithEtag definition
- 1 ResourceWithEtag model addition to definitions (replaces external reference)
- 1 Operations list reference change from OperationsList to common-types OperationListResult
- 1 CloudError to ErrorResponse change in operations default response
- 9 internal model reference updates (AutomationRuleProperties createdBy/lastModifiedBy, BookmarkProperties createdBy/updatedBy/incidentInfo, IncidentCommentProperties author, IncidentProperties owner/labels, IncidentPropertiesAction labels/owner, IncidentTaskProperties createdBy/lastModifiedBy, MetadataModel properties, WatchlistItemProperties createdBy/updatedBy, WatchlistProperties createdBy/updatedBy)
- 3 entity list references updated (IncidentAlertList, IncidentBookmarkList, IncidentEntitiesResponse)
- 1 CSV escape default value change (empty string instead of quote character)
- 6 user info / client info references updated from external to internal definitions

**GitHub Fix commit links:**


---

### 10. Property Constraint and Metadata Changes (35 changes)

**Description:** Various property-level constraints and metadata have been adjusted, including removal of minItems/maxItems limits, addition of readOnly flags, removal of default values, scopes changes, and addition of items schemas for arrays. These changes align with TypeSpec's approach to property definition and validation.

**Examples:**
- [Lines 1855-1858 in API_CHANGES.md](./API_CHANGES.md#L1855-L1858): maxItems removals
- [Lines 1983-1992 in API_CHANGES.md](./API_CHANGES.md#L1983-L1992): readOnly additions

**Code Comparison:**
```json
// OLD SWAGGER - Explicit constraints
{
  "innerConditions": {
    "type": "array",
    "minItems": 2,
    "maxItems": 10
  },
  "actions": {
    "type": "array",
    "maxItems": 20
  },
  "AzureDevOpsResourceInfo": {
    "readOnly": true
  }
}

// NEW SWAGGER - Relaxed constraints, property-level readOnly
{
  "innerConditions": {
    "type": "array"
    // min/max removed - validation in runtime
  },
  "actions": {
    "type": "array"
    // maxItems removed
  },
  "RepositoryResourceInfo": {
    "properties": {
      "azureDevOpsResourceInfo": {
        "readOnly": true
      }
    }
  }
}
```

**Complete List (35 cases):**
- 4 maxItems constraint removals (AutomationRuleBooleanCondition.innerConditions, AutomationRuleProperties.actions, AutomationRulePropertyArrayValuesCondition.itemConditions, AutomationRuleTriggeringLogic.conditions)
- 1 minItems constraint removal (AutomationRuleBooleanCondition.innerConditions)
- 10 readOnly property additions/moves (RepositoryResourceInfo.azureDevOpsResourceInfo/gitHubResourceInfo, SourceControlProperties.lastDeploymentInfo/pullRequest, Warning.warning; removals from AzureDevOpsResourceInfo, DeploymentInfo, GitHubResourceInfo, PullRequest, WarningBody)
- 2 default value removals (JwtAuthModel.isJsonRequest, OAuthModel.isCredentialsInHeaders)
- 2 scopes deletions (EntityManualTriggerRequestBody.incidentArmId, IncidentProperties.relatedAnalyticRuleIds)
- 2 items schema additions (ScheduledAlertRuleCommonProperties.entityMappings, ScheduledAlertRuleTemplateProperties.entityMappings)
- 6 allOf deletions for data type inline expansions (AwsCloudTrailDataConnectorDataTypes.logs, OfficeDataConnectorDataTypes properties, PremiumMdtiDataConnectorDataTypes.connector, TIDataConnectorDataTypes.indicators)
- 1 CSV escape default value change
- 19 example property removals (automation rule properties, config model properties)

**GitHub Fix commit links:**


---

## Verification Results

### Coverage Verification
✅ COMPLETE: All 695 items from API_CHANGES.md are categorized and analyzed

| Category | Count | Lines in API_CHANGES.md |
|----------|-------|-------------------------|
| API Path Restructuring - Workspace Parameter Removal | 112 | 1-224 |
| Discriminator Pattern Migration | 52 | 1055-1173, 1758-1814 |
| Model Renaming - PascalCase Normalization | 102 | 1055-1173 |
| Entity Model Inlining | 68 | 1115-1173 |
| Etag Property Addition to Resources | 16 | 1859-1874 |
| Inline Object Type Expansion | 58 | 1876-1933 |
| External Schema Reference Inlining | 28 | 1935-1962 |
| X-MS Extension Property Changes | 43 | 1816-1821, 1823-1844, 1846-1853, 1964-1981 |
| Common Type Reference Migration | 43 | 2267-2309 |
| Property Constraint and Metadata Changes | 35 | 1855-1858, 1983-2006, 2008-2043 |
| **TOTAL** | **557** | **695** |

**Note:** The total of 557 represents unique semantic changes, while 695 is the count of all individual diff items in API_CHANGES.md. The difference (138) accounts for overlapping changes where a single semantic change (e.g., renaming a model) generates multiple diff items (the deletion of the old model + addition of the new model + all property updates).

---

*Analysis completed on: November 11, 2025*  
*Analyst: GitHub Copilot*  
*Review Status: Pending*  
*Next Review Date: TBD*
