import * as coreClient from "@azure/core-client";

export const PhraselistCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhraselistCreateObject",
    modelProperties: {
      phrases: {
        serializedName: "phrases",
        type: {
          name: "String"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      isExchangeable: {
        defaultValue: true,
        serializedName: "isExchangeable",
        type: {
          name: "Boolean"
        }
      },
      enabledForAllModels: {
        defaultValue: true,
        serializedName: "enabledForAllModels",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const ErrorResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ErrorResponse",
    additionalProperties: { type: { name: "Object" } },
    modelProperties: {
      errorType: {
        serializedName: "errorType",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const FeatureInfoObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FeatureInfoObject",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Number"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      isActive: {
        serializedName: "isActive",
        type: {
          name: "Boolean"
        }
      },
      enabledForAllModels: {
        serializedName: "enabledForAllModels",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const FeaturesResponseObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FeaturesResponseObject",
    modelProperties: {
      phraselistFeatures: {
        serializedName: "phraselistFeatures",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PhraseListFeatureInfo"
            }
          }
        }
      },
      patternFeatures: {
        serializedName: "patternFeatures",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PatternFeatureInfo"
            }
          }
        }
      }
    }
  }
};

export const PhraselistUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhraselistUpdateObject",
    modelProperties: {
      phrases: {
        serializedName: "phrases",
        type: {
          name: "String"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      isActive: {
        defaultValue: true,
        serializedName: "isActive",
        type: {
          name: "Boolean"
        }
      },
      isExchangeable: {
        defaultValue: true,
        serializedName: "isExchangeable",
        type: {
          name: "Boolean"
        }
      },
      enabledForAllModels: {
        defaultValue: true,
        serializedName: "enabledForAllModels",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const OperationStatus: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "OperationStatus",
    modelProperties: {
      code: {
        serializedName: "code",
        type: {
          name: "String"
        }
      },
      message: {
        serializedName: "message",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ExampleLabelObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ExampleLabelObject",
    modelProperties: {
      text: {
        serializedName: "text",
        type: {
          name: "String"
        }
      },
      entityLabels: {
        serializedName: "entityLabels",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityLabelObject"
            }
          }
        }
      },
      intentName: {
        serializedName: "intentName",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const EntityLabelObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityLabelObject",
    modelProperties: {
      entityName: {
        serializedName: "entityName",
        required: true,
        type: {
          name: "String"
        }
      },
      startCharIndex: {
        serializedName: "startCharIndex",
        required: true,
        type: {
          name: "Number"
        }
      },
      endCharIndex: {
        serializedName: "endCharIndex",
        required: true,
        type: {
          name: "Number"
        }
      },
      role: {
        serializedName: "role",
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityLabelObject"
            }
          }
        }
      }
    }
  }
};

export const LabelExampleResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LabelExampleResponse",
    modelProperties: {
      utteranceText: {
        serializedName: "UtteranceText",
        type: {
          name: "String"
        }
      },
      exampleId: {
        serializedName: "ExampleId",
        type: {
          name: "Number"
        }
      }
    }
  }
};

export const BatchLabelExample: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "BatchLabelExample",
    modelProperties: {
      value: {
        serializedName: "value",
        type: {
          name: "Composite",
          className: "LabelExampleResponse"
        }
      },
      hasError: {
        serializedName: "hasError",
        type: {
          name: "Boolean"
        }
      },
      error: {
        serializedName: "error",
        type: {
          name: "Composite",
          className: "OperationStatus"
        }
      }
    }
  }
};

export const LabeledUtterance: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LabeledUtterance",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Number"
        }
      },
      text: {
        serializedName: "text",
        type: {
          name: "String"
        }
      },
      tokenizedText: {
        serializedName: "tokenizedText",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      intentLabel: {
        serializedName: "intentLabel",
        type: {
          name: "String"
        }
      },
      entityLabels: {
        serializedName: "entityLabels",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityLabel"
            }
          }
        }
      },
      intentPredictions: {
        serializedName: "intentPredictions",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "IntentPrediction"
            }
          }
        }
      },
      entityPredictions: {
        serializedName: "entityPredictions",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityPrediction"
            }
          }
        }
      }
    }
  }
};

export const EntityLabel: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityLabel",
    modelProperties: {
      entityName: {
        serializedName: "entityName",
        required: true,
        type: {
          name: "String"
        }
      },
      startTokenIndex: {
        serializedName: "startTokenIndex",
        required: true,
        type: {
          name: "Number"
        }
      },
      endTokenIndex: {
        serializedName: "endTokenIndex",
        required: true,
        type: {
          name: "Number"
        }
      },
      role: {
        serializedName: "role",
        type: {
          name: "String"
        }
      },
      roleId: {
        serializedName: "roleId",
        type: {
          name: "Uuid"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityLabel"
            }
          }
        }
      }
    }
  }
};

export const IntentPrediction: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "IntentPrediction",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      score: {
        serializedName: "score",
        type: {
          name: "Number"
        }
      }
    }
  }
};

export const EntityPrediction: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityPrediction",
    modelProperties: {
      entityName: {
        serializedName: "entityName",
        required: true,
        type: {
          name: "String"
        }
      },
      startTokenIndex: {
        serializedName: "startTokenIndex",
        required: true,
        type: {
          name: "Number"
        }
      },
      endTokenIndex: {
        serializedName: "endTokenIndex",
        required: true,
        type: {
          name: "Number"
        }
      },
      phrase: {
        serializedName: "phrase",
        required: true,
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityPrediction"
            }
          }
        }
      }
    }
  }
};

export const ModelCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ModelCreateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ModelInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ModelInfo",
    modelProperties: {
      id: {
        serializedName: "id",
        required: true,
        type: {
          name: "Uuid"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      typeId: {
        serializedName: "typeId",
        type: {
          name: "Number"
        }
      },
      readableType: {
        serializedName: "readableType",
        required: true,
        type: {
          name: "String"
        }
      }
    }
  }
};

export const EntityModelCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityModelCreateObject",
    modelProperties: {
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ChildEntityModelCreateObject"
            }
          }
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ChildEntityModelCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ChildEntityModelCreateObject",
    modelProperties: {
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ChildEntityModelCreateObject"
            }
          }
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      instanceOf: {
        serializedName: "instanceOf",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ChildEntity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ChildEntity",
    modelProperties: {
      id: {
        serializedName: "id",
        required: true,
        type: {
          name: "Uuid"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      instanceOf: {
        serializedName: "instanceOf",
        type: {
          name: "String"
        }
      },
      typeId: {
        serializedName: "typeId",
        type: {
          name: "Number"
        }
      },
      readableType: {
        serializedName: "readableType",
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ChildEntity"
            }
          }
        }
      }
    }
  }
};

export const SubClosedList: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SubClosedList",
    modelProperties: {
      canonicalForm: {
        serializedName: "canonicalForm",
        type: {
          name: "String"
        }
      },
      list: {
        serializedName: "list",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const ClosedListModelCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ClosedListModelCreateObject",
    modelProperties: {
      subLists: {
        serializedName: "subLists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "WordListObject"
            }
          }
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const WordListObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "WordListObject",
    modelProperties: {
      canonicalForm: {
        serializedName: "canonicalForm",
        type: {
          name: "String"
        }
      },
      list: {
        serializedName: "list",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const AvailablePrebuiltEntityModel: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "AvailablePrebuiltEntityModel",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      description: {
        serializedName: "description",
        type: {
          name: "String"
        }
      },
      examples: {
        serializedName: "examples",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ExplicitListItem: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ExplicitListItem",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Number"
        }
      },
      explicitListItem: {
        serializedName: "explicitListItem",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const LabelTextObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LabelTextObject",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Number"
        }
      },
      text: {
        serializedName: "text",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ModelUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ModelUpdateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const EntityModelUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityModelUpdateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      instanceOf: {
        serializedName: "instanceOf",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ModelFeatureInformation: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ModelFeatureInformation",
    modelProperties: {
      modelName: {
        serializedName: "modelName",
        type: {
          name: "String"
        }
      },
      featureName: {
        serializedName: "featureName",
        type: {
          name: "String"
        }
      },
      isRequired: {
        serializedName: "isRequired",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const CompositeEntityModel: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "CompositeEntityModel",
    modelProperties: {
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ClosedListModelUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ClosedListModelUpdateObject",
    modelProperties: {
      subLists: {
        serializedName: "subLists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "WordListObject"
            }
          }
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ClosedListModelPatchObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ClosedListModelPatchObject",
    modelProperties: {
      subLists: {
        serializedName: "subLists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "WordListObject"
            }
          }
        }
      }
    }
  }
};

export const WordListBaseUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "WordListBaseUpdateObject",
    modelProperties: {
      canonicalForm: {
        serializedName: "canonicalForm",
        type: {
          name: "String"
        }
      },
      list: {
        serializedName: "list",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const IntentsSuggestionExample: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "IntentsSuggestionExample",
    modelProperties: {
      text: {
        serializedName: "text",
        type: {
          name: "String"
        }
      },
      tokenizedText: {
        serializedName: "tokenizedText",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      intentPredictions: {
        serializedName: "intentPredictions",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "IntentPrediction"
            }
          }
        }
      },
      entityPredictions: {
        serializedName: "entityPredictions",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityPrediction"
            }
          }
        }
      }
    }
  }
};

export const EntitiesSuggestionExample: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntitiesSuggestionExample",
    modelProperties: {
      text: {
        serializedName: "text",
        type: {
          name: "String"
        }
      },
      tokenizedText: {
        serializedName: "tokenizedText",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      intentPredictions: {
        serializedName: "intentPredictions",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "IntentPrediction"
            }
          }
        }
      },
      entityPredictions: {
        serializedName: "entityPredictions",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityPrediction"
            }
          }
        }
      }
    }
  }
};

export const ApplicationCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApplicationCreateObject",
    modelProperties: {
      culture: {
        serializedName: "culture",
        required: true,
        type: {
          name: "String"
        }
      },
      domain: {
        serializedName: "domain",
        type: {
          name: "String"
        }
      },
      description: {
        serializedName: "description",
        type: {
          name: "String"
        }
      },
      initialVersionId: {
        serializedName: "initialVersionId",
        type: {
          name: "String"
        }
      },
      usageScenario: {
        serializedName: "usageScenario",
        type: {
          name: "String"
        }
      },
      name: {
        serializedName: "name",
        required: true,
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ApplicationInfoResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApplicationInfoResponse",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Uuid"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      description: {
        serializedName: "description",
        type: {
          name: "String"
        }
      },
      culture: {
        serializedName: "culture",
        type: {
          name: "String"
        }
      },
      usageScenario: {
        serializedName: "usageScenario",
        type: {
          name: "String"
        }
      },
      domain: {
        serializedName: "domain",
        type: {
          name: "String"
        }
      },
      versionsCount: {
        serializedName: "versionsCount",
        type: {
          name: "Number"
        }
      },
      createdDateTime: {
        serializedName: "createdDateTime",
        type: {
          name: "String"
        }
      },
      endpoints: {
        serializedName: "endpoints",
        type: {
          name: "Dictionary",
          value: { type: { name: "any" } }
        }
      },
      endpointHitsCount: {
        serializedName: "endpointHitsCount",
        type: {
          name: "Number"
        }
      },
      activeVersion: {
        serializedName: "activeVersion",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const LuisApp: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LuisApp",
    additionalProperties: { type: { name: "Object" } },
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      versionId: {
        serializedName: "versionId",
        type: {
          name: "String"
        }
      },
      desc: {
        serializedName: "desc",
        type: {
          name: "String"
        }
      },
      culture: {
        serializedName: "culture",
        type: {
          name: "String"
        }
      },
      intents: {
        serializedName: "intents",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalModel"
            }
          }
        }
      },
      entities: {
        serializedName: "entities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalModel"
            }
          }
        }
      },
      closedLists: {
        serializedName: "closedLists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ClosedList"
            }
          }
        }
      },
      composites: {
        serializedName: "composites",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalModel"
            }
          }
        }
      },
      hierarchicals: {
        serializedName: "hierarchicals",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalModel"
            }
          }
        }
      },
      patternAnyEntities: {
        serializedName: "patternAnyEntities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PatternAny"
            }
          }
        }
      },
      regexEntities: {
        serializedName: "regex_entities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "RegexEntity"
            }
          }
        }
      },
      prebuiltEntities: {
        serializedName: "prebuiltEntities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PrebuiltEntity"
            }
          }
        }
      },
      regexFeatures: {
        serializedName: "regex_features",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonRegexFeature"
            }
          }
        }
      },
      phraselists: {
        serializedName: "phraselists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonModelFeature"
            }
          }
        }
      },
      patterns: {
        serializedName: "patterns",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PatternRule"
            }
          }
        }
      },
      utterances: {
        serializedName: "utterances",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonUtterance"
            }
          }
        }
      }
    }
  }
};

export const HierarchicalModel: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "HierarchicalModel",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonChild"
            }
          }
        }
      },
      features: {
        serializedName: "features",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonModelFeatureInformation"
            }
          }
        }
      },
      roles: {
        serializedName: "roles",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      inherits: {
        serializedName: "inherits",
        type: {
          name: "Composite",
          className: "PrebuiltDomainObject"
        }
      }
    }
  }
};

export const JsonChild: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "JsonChild",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      instanceOf: {
        serializedName: "instanceOf",
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonChild"
            }
          }
        }
      },
      features: {
        serializedName: "features",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonModelFeatureInformation"
            }
          }
        }
      }
    }
  }
};

export const JsonModelFeatureInformation: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "JsonModelFeatureInformation",
    modelProperties: {
      modelName: {
        serializedName: "modelName",
        type: {
          name: "String"
        }
      },
      featureName: {
        serializedName: "featureName",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PrebuiltDomainObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PrebuiltDomainObject",
    modelProperties: {
      domainName: {
        serializedName: "domain_name",
        type: {
          name: "String"
        }
      },
      modelName: {
        serializedName: "model_name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ClosedList: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ClosedList",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      subLists: {
        serializedName: "subLists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "SubClosedList"
            }
          }
        }
      },
      roles: {
        serializedName: "roles",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const PatternAny: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternAny",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      explicitList: {
        serializedName: "explicitList",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      roles: {
        serializedName: "roles",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const RegexEntity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "RegexEntity",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      regexPattern: {
        serializedName: "regexPattern",
        type: {
          name: "String"
        }
      },
      roles: {
        serializedName: "roles",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const PrebuiltEntity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PrebuiltEntity",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      roles: {
        serializedName: "roles",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const JsonRegexFeature: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "JsonRegexFeature",
    modelProperties: {
      pattern: {
        serializedName: "pattern",
        type: {
          name: "String"
        }
      },
      activated: {
        serializedName: "activated",
        type: {
          name: "Boolean"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const JsonModelFeature: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "JsonModelFeature",
    modelProperties: {
      activated: {
        serializedName: "activated",
        type: {
          name: "Boolean"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      words: {
        serializedName: "words",
        type: {
          name: "String"
        }
      },
      mode: {
        serializedName: "mode",
        type: {
          name: "Boolean"
        }
      },
      enabledForAllModels: {
        defaultValue: true,
        serializedName: "enabledForAllModels",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const PatternRule: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternRule",
    modelProperties: {
      pattern: {
        serializedName: "pattern",
        type: {
          name: "String"
        }
      },
      intent: {
        serializedName: "intent",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const JsonUtterance: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "JsonUtterance",
    modelProperties: {
      text: {
        serializedName: "text",
        type: {
          name: "String"
        }
      },
      intent: {
        serializedName: "intent",
        type: {
          name: "String"
        }
      },
      entities: {
        serializedName: "entities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonEntity"
            }
          }
        }
      }
    }
  }
};

export const JsonEntity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "JsonEntity",
    modelProperties: {
      startPos: {
        serializedName: "startPos",
        required: true,
        type: {
          name: "Number"
        }
      },
      endPos: {
        serializedName: "endPos",
        required: true,
        type: {
          name: "Number"
        }
      },
      entity: {
        serializedName: "entity",
        required: true,
        type: {
          name: "String"
        }
      },
      role: {
        serializedName: "role",
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonEntity"
            }
          }
        }
      }
    }
  }
};

export const PersonalAssistantsResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PersonalAssistantsResponse",
    modelProperties: {
      endpointKeys: {
        serializedName: "endpointKeys",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Uuid"
            }
          }
        }
      },
      endpointUrls: {
        serializedName: "endpointUrls",
        type: {
          name: "Dictionary",
          value: { type: { name: "String" } }
        }
      }
    }
  }
};

export const AvailableCulture: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "AvailableCulture",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      code: {
        serializedName: "code",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ApplicationUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApplicationUpdateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      description: {
        serializedName: "description",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const TaskUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "TaskUpdateObject",
    modelProperties: {
      version: {
        serializedName: "version",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ApplicationPublishObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApplicationPublishObject",
    modelProperties: {
      versionId: {
        serializedName: "versionId",
        type: {
          name: "String"
        }
      },
      isStaging: {
        serializedName: "isStaging",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const EndpointInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EndpointInfo",
    modelProperties: {
      versionId: {
        serializedName: "versionId",
        type: {
          name: "String"
        }
      },
      isStaging: {
        serializedName: "isStaging",
        type: {
          name: "Boolean"
        }
      },
      endpointUrl: {
        serializedName: "endpointUrl",
        type: {
          name: "String"
        }
      },
      region: {
        serializedName: "region",
        type: {
          name: "String"
        }
      },
      assignedEndpointKey: {
        serializedName: "assignedEndpointKey",
        type: {
          name: "String"
        }
      },
      endpointRegion: {
        serializedName: "endpointRegion",
        type: {
          name: "String"
        }
      },
      failedRegions: {
        serializedName: "failedRegions",
        type: {
          name: "String"
        }
      },
      publishedDateTime: {
        serializedName: "publishedDateTime",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const VersionInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VersionInfo",
    modelProperties: {
      version: {
        serializedName: "version",
        required: true,
        type: {
          name: "String"
        }
      },
      createdDateTime: {
        serializedName: "createdDateTime",
        type: {
          name: "DateTime"
        }
      },
      lastModifiedDateTime: {
        serializedName: "lastModifiedDateTime",
        type: {
          name: "DateTime"
        }
      },
      lastTrainedDateTime: {
        serializedName: "lastTrainedDateTime",
        type: {
          name: "DateTime"
        }
      },
      lastPublishedDateTime: {
        serializedName: "lastPublishedDateTime",
        type: {
          name: "DateTime"
        }
      },
      endpointUrl: {
        serializedName: "endpointUrl",
        type: {
          name: "String"
        }
      },
      assignedEndpointKey: {
        serializedName: "assignedEndpointKey",
        type: {
          name: "Dictionary",
          value: { type: { name: "String" } }
        }
      },
      externalApiKeys: {
        serializedName: "externalApiKeys",
        type: {
          name: "Dictionary",
          value: { type: { name: "any" } }
        }
      },
      intentsCount: {
        serializedName: "intentsCount",
        type: {
          name: "Number"
        }
      },
      entitiesCount: {
        serializedName: "entitiesCount",
        type: {
          name: "Number"
        }
      },
      endpointHitsCount: {
        serializedName: "endpointHitsCount",
        type: {
          name: "Number"
        }
      },
      trainingStatus: {
        serializedName: "trainingStatus",
        required: true,
        type: {
          name: "Enum",
          allowedValues: [
            "NeedsTraining",
            "InProgress",
            "Trained",
            "Queued",
            "UpToDate",
            "Fail",
            "Success"
          ]
        }
      }
    }
  }
};

export const EnqueueTrainingResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EnqueueTrainingResponse",
    modelProperties: {
      statusId: {
        serializedName: "statusId",
        type: {
          name: "Number"
        }
      },
      status: {
        serializedName: "status",
        type: {
          name: "Enum",
          allowedValues: [
            "NeedsTraining",
            "InProgress",
            "Trained",
            "Queued",
            "UpToDate",
            "Fail",
            "Success"
          ]
        }
      }
    }
  }
};

export const ModelTrainingInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ModelTrainingInfo",
    modelProperties: {
      modelId: {
        serializedName: "modelId",
        type: {
          name: "Uuid"
        }
      },
      details: {
        serializedName: "details",
        type: {
          name: "Composite",
          className: "ModelTrainingDetails"
        }
      }
    }
  }
};

export const ModelTrainingDetails: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ModelTrainingDetails",
    modelProperties: {
      statusId: {
        serializedName: "statusId",
        type: {
          name: "Number"
        }
      },
      status: {
        serializedName: "status",
        type: {
          name: "Enum",
          allowedValues: [
            "NeedsTraining",
            "InProgress",
            "Trained",
            "Queued",
            "UpToDate",
            "Fail",
            "Success"
          ]
        }
      },
      exampleCount: {
        serializedName: "exampleCount",
        type: {
          name: "Number"
        }
      },
      trainingDateTime: {
        serializedName: "trainingDateTime",
        type: {
          name: "DateTime"
        }
      },
      failureReason: {
        serializedName: "failureReason",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ApplicationSettings: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApplicationSettings",
    modelProperties: {
      id: {
        serializedName: "id",
        required: true,
        type: {
          name: "Uuid"
        }
      },
      isPublic: {
        serializedName: "public",
        required: true,
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const ApplicationSettingUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApplicationSettingUpdateObject",
    modelProperties: {
      isPublic: {
        serializedName: "public",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const PublishSettings: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PublishSettings",
    modelProperties: {
      id: {
        serializedName: "id",
        required: true,
        type: {
          name: "Uuid"
        }
      },
      isSentimentAnalysisEnabled: {
        serializedName: "sentimentAnalysis",
        required: true,
        type: {
          name: "Boolean"
        }
      },
      isSpeechEnabled: {
        serializedName: "speech",
        required: true,
        type: {
          name: "Boolean"
        }
      },
      isSpellCheckerEnabled: {
        serializedName: "spellChecker",
        required: true,
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const PublishSettingUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PublishSettingUpdateObject",
    modelProperties: {
      sentimentAnalysis: {
        serializedName: "sentimentAnalysis",
        type: {
          name: "Boolean"
        }
      },
      speech: {
        serializedName: "speech",
        type: {
          name: "Boolean"
        }
      },
      spellChecker: {
        serializedName: "spellChecker",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const PrebuiltDomainCreateBaseObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PrebuiltDomainCreateBaseObject",
    modelProperties: {
      domainName: {
        serializedName: "domainName",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PrebuiltDomainModelCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PrebuiltDomainModelCreateObject",
    modelProperties: {
      domainName: {
        serializedName: "domainName",
        type: {
          name: "String"
        }
      },
      modelName: {
        serializedName: "modelName",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PrebuiltDomain: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PrebuiltDomain",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      culture: {
        serializedName: "culture",
        type: {
          name: "String"
        }
      },
      description: {
        serializedName: "description",
        type: {
          name: "String"
        }
      },
      examples: {
        serializedName: "examples",
        type: {
          name: "String"
        }
      },
      intents: {
        serializedName: "intents",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PrebuiltDomainItem"
            }
          }
        }
      },
      entities: {
        serializedName: "entities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PrebuiltDomainItem"
            }
          }
        }
      }
    }
  }
};

export const PrebuiltDomainItem: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PrebuiltDomainItem",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      description: {
        serializedName: "description",
        type: {
          name: "String"
        }
      },
      examples: {
        serializedName: "examples",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PrebuiltDomainCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PrebuiltDomainCreateObject",
    modelProperties: {
      domainName: {
        serializedName: "domainName",
        type: {
          name: "String"
        }
      },
      culture: {
        serializedName: "culture",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchema: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className:
      "Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchema",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchema: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className:
      "PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchema",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const RegexModelCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "RegexModelCreateObject",
    modelProperties: {
      regexPattern: {
        serializedName: "regexPattern",
        type: {
          name: "String"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PatternAnyModelCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternAnyModelCreateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      explicitList: {
        serializedName: "explicitList",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const EntityRole: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityRole",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Uuid"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const EntityRoleCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityRoleCreateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ExplicitListItemCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ExplicitListItemCreateObject",
    modelProperties: {
      explicitListItem: {
        serializedName: "explicitListItem",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const RegexModelUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "RegexModelUpdateObject",
    modelProperties: {
      regexPattern: {
        serializedName: "regexPattern",
        type: {
          name: "String"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PatternAnyModelUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternAnyModelUpdateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      explicitList: {
        serializedName: "explicitList",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const EntityRoleUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityRoleUpdateObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const ExplicitListItemUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ExplicitListItemUpdateObject",
    modelProperties: {
      explicitListItem: {
        serializedName: "explicitListItem",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PatternRuleCreateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternRuleCreateObject",
    modelProperties: {
      pattern: {
        serializedName: "pattern",
        type: {
          name: "String"
        }
      },
      intent: {
        serializedName: "intent",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PatternRuleInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternRuleInfo",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Uuid"
        }
      },
      pattern: {
        serializedName: "pattern",
        type: {
          name: "String"
        }
      },
      intent: {
        serializedName: "intent",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PatternRuleUpdateObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternRuleUpdateObject",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "Uuid"
        }
      },
      pattern: {
        serializedName: "pattern",
        type: {
          name: "String"
        }
      },
      intent: {
        serializedName: "intent",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const AppVersionSettingObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "AppVersionSettingObject",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      value: {
        serializedName: "value",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const AzureAccountInfoObject: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "AzureAccountInfoObject",
    modelProperties: {
      azureSubscriptionId: {
        serializedName: "azureSubscriptionId",
        required: true,
        type: {
          name: "String"
        }
      },
      resourceGroup: {
        serializedName: "resourceGroup",
        required: true,
        type: {
          name: "String"
        }
      },
      accountName: {
        serializedName: "accountName",
        required: true,
        type: {
          name: "String"
        }
      }
    }
  }
};

export const LuisAppV2: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LuisAppV2",
    additionalProperties: { type: { name: "Object" } },
    modelProperties: {
      luisSchemaVersion: {
        serializedName: "luis_schema_version",
        type: {
          name: "String"
        }
      },
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      versionId: {
        serializedName: "versionId",
        type: {
          name: "String"
        }
      },
      desc: {
        serializedName: "desc",
        type: {
          name: "String"
        }
      },
      culture: {
        serializedName: "culture",
        type: {
          name: "String"
        }
      },
      intents: {
        serializedName: "intents",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalModelV2"
            }
          }
        }
      },
      entities: {
        serializedName: "entities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalModelV2"
            }
          }
        }
      },
      closedLists: {
        serializedName: "closedLists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ClosedList"
            }
          }
        }
      },
      composites: {
        serializedName: "composites",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalModelV2"
            }
          }
        }
      },
      patternAnyEntities: {
        serializedName: "patternAnyEntities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PatternAny"
            }
          }
        }
      },
      regexEntities: {
        serializedName: "regex_entities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "RegexEntity"
            }
          }
        }
      },
      prebuiltEntities: {
        serializedName: "prebuiltEntities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PrebuiltEntity"
            }
          }
        }
      },
      regexFeatures: {
        serializedName: "regex_features",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonRegexFeature"
            }
          }
        }
      },
      modelFeatures: {
        serializedName: "model_features",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonModelFeature"
            }
          }
        }
      },
      patterns: {
        serializedName: "patterns",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PatternRule"
            }
          }
        }
      },
      utterances: {
        serializedName: "utterances",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "JsonUtterance"
            }
          }
        }
      }
    }
  }
};

export const HierarchicalModelV2: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "HierarchicalModelV2",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      inherits: {
        serializedName: "inherits",
        type: {
          name: "Composite",
          className: "PrebuiltDomainObject"
        }
      },
      roles: {
        serializedName: "roles",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const UserAccessList: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "UserAccessList",
    modelProperties: {
      owner: {
        serializedName: "owner",
        type: {
          name: "String"
        }
      },
      emails: {
        serializedName: "emails",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const UserCollaborator: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "UserCollaborator",
    modelProperties: {
      email: {
        serializedName: "email",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const CollaboratorsArray: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "CollaboratorsArray",
    modelProperties: {
      emails: {
        serializedName: "emails",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      }
    }
  }
};

export const OperationError: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "OperationError",
    modelProperties: {
      code: {
        serializedName: "code",
        type: {
          name: "String"
        }
      },
      message: {
        serializedName: "message",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhraseListFeatureInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhraseListFeatureInfo",
    modelProperties: {
      ...FeatureInfoObject.type.modelProperties,
      phrases: {
        serializedName: "phrases",
        type: {
          name: "String"
        }
      },
      isExchangeable: {
        serializedName: "isExchangeable",
        type: {
          name: "Boolean"
        }
      }
    }
  }
};

export const PatternFeatureInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatternFeatureInfo",
    modelProperties: {
      ...FeatureInfoObject.type.modelProperties,
      pattern: {
        serializedName: "pattern",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const IntentClassifier: coreClient.CompositeMapper = {
  serializedName: "Intent Classifier",
  type: {
    name: "Composite",
    className: "IntentClassifier",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      customPrebuiltDomainName: {
        serializedName: "customPrebuiltDomainName",
        type: {
          name: "String"
        }
      },
      customPrebuiltModelName: {
        serializedName: "customPrebuiltModelName",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const NDepthEntityExtractor: coreClient.CompositeMapper = {
  serializedName: "N-Depth Entity Extractor",
  type: {
    name: "Composite",
    className: "NDepthEntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      customPrebuiltDomainName: {
        serializedName: "customPrebuiltDomainName",
        type: {
          name: "String"
        }
      },
      customPrebuiltModelName: {
        serializedName: "customPrebuiltModelName",
        type: {
          name: "String"
        }
      },
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ChildEntity"
            }
          }
        }
      }
    }
  }
};

export const HierarchicalEntityExtractor: coreClient.CompositeMapper = {
  serializedName: "Hierarchical Entity Extractor",
  type: {
    name: "Composite",
    className: "HierarchicalEntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ChildEntity"
            }
          }
        }
      }
    }
  }
};

export const CompositeEntityExtractor: coreClient.CompositeMapper = {
  serializedName: "Composite Entity Extractor",
  type: {
    name: "Composite",
    className: "CompositeEntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      children: {
        serializedName: "children",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ChildEntity"
            }
          }
        }
      }
    }
  }
};

export const ClosedListEntityExtractor: coreClient.CompositeMapper = {
  serializedName: "List Entity Extractor",
  type: {
    name: "Composite",
    className: "ClosedListEntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      subLists: {
        serializedName: "subLists",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "SubClosedListResponse"
            }
          }
        }
      }
    }
  }
};

export const PrebuiltEntityExtractor: coreClient.CompositeMapper = {
  serializedName: "Prebuilt Entity Extractor",
  type: {
    name: "Composite",
    className: "PrebuiltEntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties
    }
  }
};

export const EntityExtractor: coreClient.CompositeMapper = {
  serializedName: "Entity Extractor",
  type: {
    name: "Composite",
    className: "EntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      customPrebuiltDomainName: {
        serializedName: "customPrebuiltDomainName",
        type: {
          name: "String"
        }
      },
      customPrebuiltModelName: {
        serializedName: "customPrebuiltModelName",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const RegexEntityExtractor: coreClient.CompositeMapper = {
  serializedName: "Regex Entity Extractor",
  type: {
    name: "Composite",
    className: "RegexEntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      regexPattern: {
        serializedName: "regexPattern",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PatternAnyEntityExtractor: coreClient.CompositeMapper = {
  serializedName: "Pattern.Any Entity Extractor",
  type: {
    name: "Composite",
    className: "PatternAnyEntityExtractor",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      explicitList: {
        serializedName: "explicitList",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ExplicitListItem"
            }
          }
        }
      }
    }
  }
};

export const CustomPrebuiltModel: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "CustomPrebuiltModel",
    modelProperties: {
      ...ModelInfo.type.modelProperties
    }
  }
};

export const EntityModelInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EntityModelInfo",
    modelProperties: {
      ...ModelInfo.type.modelProperties,
      roles: {
        serializedName: "roles",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "EntityRole"
            }
          }
        }
      }
    }
  }
};

export const HierarchicalChildEntity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "HierarchicalChildEntity",
    modelProperties: {
      ...ChildEntity.type.modelProperties
    }
  }
};

export const SubClosedListResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SubClosedListResponse",
    modelProperties: {
      ...SubClosedList.type.modelProperties,
      id: {
        serializedName: "id",
        type: {
          name: "Number"
        }
      }
    }
  }
};

export const ProductionOrStagingEndpointInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ProductionOrStagingEndpointInfo",
    modelProperties: {
      ...EndpointInfo.type.modelProperties
    }
  }
};

export const ModelInfoResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ModelInfoResponse",
    modelProperties: {
      ...HierarchicalEntityExtractor.type.modelProperties,
      ...CompositeEntityExtractor.type.modelProperties,
      ...ClosedListEntityExtractor.type.modelProperties,
      ...IntentClassifier.type.modelProperties,
      ...EntityExtractor.type.modelProperties,
      ...RegexEntityExtractor.type.modelProperties,
      ...PatternAnyEntityExtractor.type.modelProperties,
      ...NDepthEntityExtractor.type.modelProperties
    }
  }
};
