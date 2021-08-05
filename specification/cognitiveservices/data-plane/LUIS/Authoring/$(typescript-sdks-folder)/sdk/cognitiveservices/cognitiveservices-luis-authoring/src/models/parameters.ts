import {
  OperationParameter,
  OperationURLParameter,
  OperationQueryParameter
} from "@azure/core-client";
import {
  PhraselistCreateObject as PhraselistCreateObjectMapper,
  PhraselistUpdateObject as PhraselistUpdateObjectMapper,
  ModelFeatureInformation as ModelFeatureInformationMapper,
  ExampleLabelObject as ExampleLabelObjectMapper,
  ModelCreateObject as ModelCreateObjectMapper,
  EntityModelCreateObject as EntityModelCreateObjectMapper,
  ClosedListModelCreateObject as ClosedListModelCreateObjectMapper,
  ModelUpdateObject as ModelUpdateObjectMapper,
  EntityModelUpdateObject as EntityModelUpdateObjectMapper,
  CompositeEntityModel as CompositeEntityModelMapper,
  ClosedListModelUpdateObject as ClosedListModelUpdateObjectMapper,
  ClosedListModelPatchObject as ClosedListModelPatchObjectMapper,
  WordListBaseUpdateObject as WordListBaseUpdateObjectMapper,
  WordListObject as WordListObjectMapper,
  PrebuiltDomainCreateBaseObject as PrebuiltDomainCreateBaseObjectMapper,
  PrebuiltDomainModelCreateObject as PrebuiltDomainModelCreateObjectMapper,
  ChildEntityModelCreateObject as ChildEntityModelCreateObjectMapper,
  Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchema as Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchemaMapper,
  PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchema as PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchemaMapper,
  RegexModelCreateObject as RegexModelCreateObjectMapper,
  PatternAnyModelCreateObject as PatternAnyModelCreateObjectMapper,
  EntityRoleCreateObject as EntityRoleCreateObjectMapper,
  ExplicitListItemCreateObject as ExplicitListItemCreateObjectMapper,
  RegexModelUpdateObject as RegexModelUpdateObjectMapper,
  PatternAnyModelUpdateObject as PatternAnyModelUpdateObjectMapper,
  EntityRoleUpdateObject as EntityRoleUpdateObjectMapper,
  ExplicitListItemUpdateObject as ExplicitListItemUpdateObjectMapper,
  ApplicationCreateObject as ApplicationCreateObjectMapper,
  LuisApp as LuisAppMapper,
  ApplicationUpdateObject as ApplicationUpdateObjectMapper,
  ApplicationPublishObject as ApplicationPublishObjectMapper,
  ApplicationSettingUpdateObject as ApplicationSettingUpdateObjectMapper,
  PublishSettingUpdateObject as PublishSettingUpdateObjectMapper,
  PrebuiltDomainCreateObject as PrebuiltDomainCreateObjectMapper,
  LuisAppV2 as LuisAppV2Mapper,
  TaskUpdateObject as TaskUpdateObjectMapper,
  PatternRuleCreateObject as PatternRuleCreateObjectMapper,
  PatternRuleUpdateObject as PatternRuleUpdateObjectMapper,
  AzureAccountInfoObject as AzureAccountInfoObjectMapper
} from "../models/mappers";

export const contentType: OperationParameter = {
  parameterPath: ["options", "contentType"],
  mapper: {
    defaultValue: "application/json",
    isConstant: true,
    serializedName: "Content-Type",
    type: {
      name: "String"
    }
  }
};

export const phraselistCreateObject: OperationParameter = {
  parameterPath: "phraselistCreateObject",
  mapper: PhraselistCreateObjectMapper
};

export const accept: OperationParameter = {
  parameterPath: "accept",
  mapper: {
    defaultValue: "application/json",
    isConstant: true,
    serializedName: "Accept",
    type: {
      name: "String"
    }
  }
};

export const endpoint: OperationURLParameter = {
  parameterPath: "endpoint",
  mapper: {
    serializedName: "Endpoint",
    required: true,
    type: {
      name: "String"
    }
  },
  skipEncoding: true
};

export const appId: OperationURLParameter = {
  parameterPath: "appId",
  mapper: {
    serializedName: "appId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const versionId: OperationURLParameter = {
  parameterPath: "versionId",
  mapper: {
    serializedName: "versionId",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const skip: OperationQueryParameter = {
  parameterPath: ["options", "skip"],
  mapper: {
    constraints: {
      InclusiveMinimum: 0
    },
    serializedName: "skip",
    type: {
      name: "Number"
    }
  }
};

export const take: OperationQueryParameter = {
  parameterPath: ["options", "take"],
  mapper: {
    defaultValue: 100,
    constraints: {
      InclusiveMaximum: 500,
      InclusiveMinimum: 0
    },
    serializedName: "take",
    type: {
      name: "Number"
    }
  }
};

export const phraselistId: OperationURLParameter = {
  parameterPath: "phraselistId",
  mapper: {
    serializedName: "phraselistId",
    required: true,
    type: {
      name: "Number"
    }
  }
};

export const phraselistUpdateObject: OperationParameter = {
  parameterPath: ["options", "phraselistUpdateObject"],
  mapper: PhraselistUpdateObjectMapper
};

export const featureRelationCreateObject: OperationParameter = {
  parameterPath: "featureRelationCreateObject",
  mapper: ModelFeatureInformationMapper
};

export const intentId: OperationURLParameter = {
  parameterPath: "intentId",
  mapper: {
    serializedName: "intentId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const entityId: OperationURLParameter = {
  parameterPath: "entityId",
  mapper: {
    serializedName: "entityId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const exampleLabelObject: OperationParameter = {
  parameterPath: "exampleLabelObject",
  mapper: ExampleLabelObjectMapper
};

export const enableNestedChildren: OperationQueryParameter = {
  parameterPath: ["options", "enableNestedChildren"],
  mapper: {
    serializedName: "enableNestedChildren",
    type: {
      name: "Boolean"
    }
  }
};

export const exampleLabelObjectArray: OperationParameter = {
  parameterPath: "exampleLabelObjectArray",
  mapper: {
    serializedName: "exampleLabelObjectArray",
    required: true,
    type: {
      name: "Sequence",
      element: {
        type: {
          name: "Composite",
          className: "ExampleLabelObject"
        }
      }
    }
  }
};

export const exampleId: OperationURLParameter = {
  parameterPath: "exampleId",
  mapper: {
    serializedName: "exampleId",
    required: true,
    type: {
      name: "Number"
    }
  }
};

export const intentCreateObject: OperationParameter = {
  parameterPath: "intentCreateObject",
  mapper: ModelCreateObjectMapper
};

export const entityModelCreateObject: OperationParameter = {
  parameterPath: "entityModelCreateObject",
  mapper: EntityModelCreateObjectMapper
};

export const closedListModelCreateObject: OperationParameter = {
  parameterPath: "closedListModelCreateObject",
  mapper: ClosedListModelCreateObjectMapper
};

export const prebuiltExtractorNames: OperationParameter = {
  parameterPath: "prebuiltExtractorNames",
  mapper: {
    serializedName: "prebuiltExtractorNames",
    required: true,
    type: {
      name: "Sequence",
      element: {
        type: {
          name: "String"
        }
      }
    }
  }
};

export const modelId: OperationURLParameter = {
  parameterPath: "modelId",
  mapper: {
    serializedName: "modelId",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const modelUpdateObject: OperationParameter = {
  parameterPath: "modelUpdateObject",
  mapper: ModelUpdateObjectMapper
};

export const deleteUtterances: OperationQueryParameter = {
  parameterPath: ["options", "deleteUtterances"],
  mapper: {
    serializedName: "deleteUtterances",
    type: {
      name: "Boolean"
    }
  }
};

export const entityModelUpdateObject: OperationParameter = {
  parameterPath: "entityModelUpdateObject",
  mapper: EntityModelUpdateObjectMapper
};

export const featureRelationsUpdateObject: OperationParameter = {
  parameterPath: "featureRelationsUpdateObject",
  mapper: {
    serializedName: "featureRelationsUpdateObject",
    required: true,
    type: {
      name: "Sequence",
      element: {
        type: {
          name: "Composite",
          className: "ModelFeatureInformation"
        }
      }
    }
  }
};

export const featureRelationDeleteObject: OperationParameter = {
  parameterPath: "featureRelationDeleteObject",
  mapper: ModelFeatureInformationMapper
};

export const hEntityId: OperationURLParameter = {
  parameterPath: "hEntityId",
  mapper: {
    serializedName: "hEntityId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const cEntityId: OperationURLParameter = {
  parameterPath: "cEntityId",
  mapper: {
    serializedName: "cEntityId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const compositeModelUpdateObject: OperationParameter = {
  parameterPath: "compositeModelUpdateObject",
  mapper: CompositeEntityModelMapper
};

export const clEntityId: OperationURLParameter = {
  parameterPath: "clEntityId",
  mapper: {
    serializedName: "clEntityId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const closedListModelUpdateObject: OperationParameter = {
  parameterPath: "closedListModelUpdateObject",
  mapper: ClosedListModelUpdateObjectMapper
};

export const closedListModelPatchObject: OperationParameter = {
  parameterPath: "closedListModelPatchObject",
  mapper: ClosedListModelPatchObjectMapper
};

export const prebuiltId: OperationURLParameter = {
  parameterPath: "prebuiltId",
  mapper: {
    serializedName: "prebuiltId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const subListId: OperationURLParameter = {
  parameterPath: "subListId",
  mapper: {
    serializedName: "subListId",
    required: true,
    type: {
      name: "Number"
    }
  }
};

export const wordListBaseUpdateObject: OperationParameter = {
  parameterPath: "wordListBaseUpdateObject",
  mapper: WordListBaseUpdateObjectMapper
};

export const wordListCreateObject: OperationParameter = {
  parameterPath: "wordListCreateObject",
  mapper: WordListObjectMapper
};

export const prebuiltDomainObject: OperationParameter = {
  parameterPath: "prebuiltDomainObject",
  mapper: PrebuiltDomainCreateBaseObjectMapper
};

export const prebuiltDomainModelCreateObject: OperationParameter = {
  parameterPath: "prebuiltDomainModelCreateObject",
  mapper: PrebuiltDomainModelCreateObjectMapper
};

export const domainName: OperationURLParameter = {
  parameterPath: "domainName",
  mapper: {
    serializedName: "domainName",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const childEntityModelCreateObject: OperationParameter = {
  parameterPath: "childEntityModelCreateObject",
  mapper: ChildEntityModelCreateObjectMapper
};

export const hChildId: OperationURLParameter = {
  parameterPath: "hChildId",
  mapper: {
    serializedName: "hChildId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const hierarchicalChildModelUpdateObject: OperationParameter = {
  parameterPath: "hierarchicalChildModelUpdateObject",
  mapper: Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchemaMapper
};

export const compositeChildModelCreateObject: OperationParameter = {
  parameterPath: "compositeChildModelCreateObject",
  mapper: PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchemaMapper
};

export const cChildId: OperationURLParameter = {
  parameterPath: "cChildId",
  mapper: {
    serializedName: "cChildId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const regexEntityExtractorCreateObj: OperationParameter = {
  parameterPath: "regexEntityExtractorCreateObj",
  mapper: RegexModelCreateObjectMapper
};

export const extractorCreateObject: OperationParameter = {
  parameterPath: "extractorCreateObject",
  mapper: PatternAnyModelCreateObjectMapper
};

export const entityRoleCreateObject: OperationParameter = {
  parameterPath: "entityRoleCreateObject",
  mapper: EntityRoleCreateObjectMapper
};

export const item: OperationParameter = {
  parameterPath: "item",
  mapper: ExplicitListItemCreateObjectMapper
};

export const regexEntityId: OperationURLParameter = {
  parameterPath: "regexEntityId",
  mapper: {
    serializedName: "regexEntityId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const regexEntityUpdateObject: OperationParameter = {
  parameterPath: "regexEntityUpdateObject",
  mapper: RegexModelUpdateObjectMapper
};

export const patternAnyUpdateObject: OperationParameter = {
  parameterPath: "patternAnyUpdateObject",
  mapper: PatternAnyModelUpdateObjectMapper
};

export const roleId: OperationURLParameter = {
  parameterPath: "roleId",
  mapper: {
    serializedName: "roleId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const entityRoleUpdateObject: OperationParameter = {
  parameterPath: "entityRoleUpdateObject",
  mapper: EntityRoleUpdateObjectMapper
};

export const itemId: OperationURLParameter = {
  parameterPath: "itemId",
  mapper: {
    serializedName: "itemId",
    required: true,
    type: {
      name: "Number"
    }
  }
};

export const item1: OperationParameter = {
  parameterPath: "item",
  mapper: ExplicitListItemUpdateObjectMapper
};

export const applicationCreateObject: OperationParameter = {
  parameterPath: "applicationCreateObject",
  mapper: ApplicationCreateObjectMapper
};

export const luisApp: OperationParameter = {
  parameterPath: "luisApp",
  mapper: LuisAppMapper
};

export const appName: OperationQueryParameter = {
  parameterPath: ["options", "appName"],
  mapper: {
    serializedName: "appName",
    type: {
      name: "String"
    }
  }
};

export const accept1: OperationParameter = {
  parameterPath: "accept",
  mapper: {
    defaultValue: "application/octet-stream",
    isConstant: true,
    serializedName: "Accept",
    type: {
      name: "String"
    }
  }
};

export const applicationUpdateObject: OperationParameter = {
  parameterPath: "applicationUpdateObject",
  mapper: ApplicationUpdateObjectMapper
};

export const force: OperationQueryParameter = {
  parameterPath: ["options", "force"],
  mapper: {
    serializedName: "force",
    type: {
      name: "Boolean"
    }
  }
};

export const applicationPublishObject: OperationParameter = {
  parameterPath: "applicationPublishObject",
  mapper: ApplicationPublishObjectMapper
};

export const applicationSettingUpdateObject: OperationParameter = {
  parameterPath: "applicationSettingUpdateObject",
  mapper: ApplicationSettingUpdateObjectMapper
};

export const publishSettingUpdateObject: OperationParameter = {
  parameterPath: "publishSettingUpdateObject",
  mapper: PublishSettingUpdateObjectMapper
};

export const prebuiltDomainCreateObject: OperationParameter = {
  parameterPath: "prebuiltDomainCreateObject",
  mapper: PrebuiltDomainCreateObjectMapper
};

export const culture: OperationURLParameter = {
  parameterPath: "culture",
  mapper: {
    serializedName: "culture",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const accept2: OperationParameter = {
  parameterPath: "accept",
  mapper: {
    defaultValue: "application/octet-stream, application/json",
    isConstant: true,
    serializedName: "Accept",
    type: {
      name: "String"
    }
  }
};

export const slotName: OperationURLParameter = {
  parameterPath: "slotName",
  mapper: {
    serializedName: "slotName",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const luisAppV2: OperationParameter = {
  parameterPath: "luisAppV2",
  mapper: LuisAppV2Mapper
};

export const contentType1: OperationParameter = {
  parameterPath: ["options", "contentType"],
  mapper: {
    defaultValue: "text/plain",
    isConstant: true,
    serializedName: "Content-Type",
    type: {
      name: "String"
    }
  }
};

export const luisAppLu: OperationParameter = {
  parameterPath: "luisAppLu",
  mapper: {
    serializedName: "luisAppLu",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const accept3: OperationParameter = {
  parameterPath: "accept",
  mapper: {
    defaultValue: "application/json",
    isConstant: true,
    serializedName: "Accept",
    type: {
      name: "String"
    }
  }
};

export const versionCloneObject: OperationParameter = {
  parameterPath: "versionCloneObject",
  mapper: TaskUpdateObjectMapper
};

export const versionUpdateObject: OperationParameter = {
  parameterPath: "versionUpdateObject",
  mapper: TaskUpdateObjectMapper
};

export const versionId1: OperationQueryParameter = {
  parameterPath: ["options", "versionId"],
  mapper: {
    serializedName: "versionId",
    type: {
      name: "String"
    }
  }
};

export const utterance: OperationParameter = {
  parameterPath: "utterance",
  mapper: {
    serializedName: "utterance",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const format: OperationQueryParameter = {
  parameterPath: "format",
  mapper: {
    defaultValue: "lu",
    isConstant: true,
    serializedName: "format",
    type: {
      name: "String"
    }
  }
};

export const mode: OperationQueryParameter = {
  parameterPath: ["options", "mode"],
  mapper: {
    serializedName: "mode",
    type: {
      name: "String"
    }
  }
};

export const pattern: OperationParameter = {
  parameterPath: "pattern",
  mapper: PatternRuleCreateObjectMapper
};

export const patterns: OperationParameter = {
  parameterPath: "patterns",
  mapper: {
    serializedName: "patterns",
    required: true,
    type: {
      name: "Sequence",
      element: {
        type: {
          name: "Composite",
          className: "PatternRuleUpdateObject"
        }
      }
    }
  }
};

export const patterns1: OperationParameter = {
  parameterPath: "patterns",
  mapper: {
    serializedName: "patterns",
    required: true,
    type: {
      name: "Sequence",
      element: {
        type: {
          name: "Composite",
          className: "PatternRuleCreateObject"
        }
      }
    }
  }
};

export const patternIds: OperationParameter = {
  parameterPath: "patternIds",
  mapper: {
    serializedName: "patternIds",
    required: true,
    type: {
      name: "Sequence",
      element: {
        type: {
          name: "Uuid"
        }
      }
    }
  }
};

export const pattern1: OperationParameter = {
  parameterPath: "pattern",
  mapper: PatternRuleUpdateObjectMapper
};

export const patternId: OperationURLParameter = {
  parameterPath: "patternId",
  mapper: {
    serializedName: "patternId",
    required: true,
    type: {
      name: "Uuid"
    }
  }
};

export const listOfAppVersionSettingObject: OperationParameter = {
  parameterPath: "listOfAppVersionSettingObject",
  mapper: {
    serializedName: "listOfAppVersionSettingObject",
    required: true,
    type: {
      name: "Sequence",
      element: {
        type: {
          name: "Composite",
          className: "AppVersionSettingObject"
        }
      }
    }
  }
};

export const azureAccountInfoObject: OperationParameter = {
  parameterPath: ["options", "azureAccountInfoObject"],
  mapper: AzureAccountInfoObjectMapper
};

export const authorization: OperationParameter = {
  parameterPath: "authorization",
  mapper: {
    serializedName: "Authorization",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const armToken: OperationParameter = {
  parameterPath: ["options", "armToken"],
  mapper: {
    serializedName: "ArmToken",
    type: {
      name: "String"
    }
  }
};
