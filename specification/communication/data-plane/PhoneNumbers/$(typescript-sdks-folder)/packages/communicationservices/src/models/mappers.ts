import * as coreClient from "@azure/core-client";

export const PhoneNumberAreaCodes: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberAreaCodes",
    modelProperties: {
      areaCodes: {
        serializedName: "areaCodes",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PhoneNumberAreaCode"
            }
          }
        }
      },
      nextLink: {
        serializedName: "nextLink",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberAreaCode: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberAreaCode",
    modelProperties: {
      areaCode: {
        serializedName: "areaCode",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const CommunicationErrorResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "CommunicationErrorResponse",
    modelProperties: {
      error: {
        serializedName: "error",
        type: {
          name: "Composite",
          className: "CommunicationError"
        }
      }
    }
  }
};

export const CommunicationError: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "CommunicationError",
    modelProperties: {
      code: {
        serializedName: "code",
        required: true,
        type: {
          name: "String"
        }
      },
      message: {
        serializedName: "message",
        required: true,
        type: {
          name: "String"
        }
      },
      target: {
        serializedName: "target",
        readOnly: true,
        type: {
          name: "String"
        }
      },
      details: {
        serializedName: "details",
        readOnly: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "CommunicationError"
            }
          }
        }
      },
      innerError: {
        serializedName: "innererror",
        type: {
          name: "Composite",
          className: "CommunicationError"
        }
      }
    }
  }
};

export const PhoneNumberCountries: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberCountries",
    modelProperties: {
      countries: {
        serializedName: "countries",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PhoneNumberCountry"
            }
          }
        }
      },
      nextLink: {
        serializedName: "nextLink",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberCountry: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberCountry",
    modelProperties: {
      localizedName: {
        serializedName: "localizedName",
        required: true,
        type: {
          name: "String"
        }
      },
      countryCode: {
        serializedName: "countryCode",
        required: true,
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberLocalities: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberLocalities",
    modelProperties: {
      phoneNumberLocalities: {
        serializedName: "phoneNumberLocalities",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PhoneNumberLocality"
            }
          }
        }
      },
      nextLink: {
        serializedName: "nextLink",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberLocality: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberLocality",
    modelProperties: {
      localizedName: {
        serializedName: "localizedName",
        required: true,
        type: {
          name: "String"
        }
      },
      administrativeDivision: {
        serializedName: "administrativeDivision",
        type: {
          name: "Composite",
          className: "PhoneNumberAdministrativeDivision"
        }
      }
    }
  }
};

export const PhoneNumberAdministrativeDivision: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberAdministrativeDivision",
    modelProperties: {
      localizedName: {
        serializedName: "localizedName",
        required: true,
        type: {
          name: "String"
        }
      },
      abbreviatedName: {
        serializedName: "abbreviatedName",
        required: true,
        type: {
          name: "String"
        }
      }
    }
  }
};

export const OfferingsResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "OfferingsResponse",
    modelProperties: {
      phoneNumberOfferings: {
        serializedName: "phoneNumberOfferings",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PhoneNumberOffering"
            }
          }
        }
      },
      nextLink: {
        serializedName: "nextLink",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberOffering: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberOffering",
    modelProperties: {
      phoneNumberType: {
        serializedName: "phoneNumberType",
        type: {
          name: "String"
        }
      },
      assignmentType: {
        serializedName: "assignmentType",
        type: {
          name: "String"
        }
      },
      availableCapabilities: {
        serializedName: "availableCapabilities",
        type: {
          name: "Composite",
          className: "PhoneNumberCapabilities"
        }
      },
      cost: {
        serializedName: "cost",
        type: {
          name: "Composite",
          className: "PhoneNumberCost"
        }
      }
    }
  }
};

export const PhoneNumberCapabilities: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberCapabilities",
    modelProperties: {
      calling: {
        serializedName: "calling",
        required: true,
        type: {
          name: "String"
        }
      },
      sms: {
        serializedName: "sms",
        required: true,
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberCost: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberCost",
    modelProperties: {
      amount: {
        serializedName: "amount",
        required: true,
        type: {
          name: "Number"
        }
      },
      currencyCode: {
        serializedName: "currencyCode",
        required: true,
        type: {
          name: "String"
        }
      },
      billingFrequency: {
        serializedName: "billingFrequency",
        required: true,
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberSearchRequest: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberSearchRequest",
    modelProperties: {
      phoneNumberType: {
        serializedName: "phoneNumberType",
        required: true,
        type: {
          name: "String"
        }
      },
      assignmentType: {
        serializedName: "assignmentType",
        required: true,
        type: {
          name: "String"
        }
      },
      capabilities: {
        serializedName: "capabilities",
        type: {
          name: "Composite",
          className: "PhoneNumberCapabilities"
        }
      },
      areaCode: {
        serializedName: "areaCode",
        type: {
          name: "String"
        }
      },
      quantity: {
        defaultValue: 1,
        constraints: {
          InclusiveMaximum: 2147483647,
          InclusiveMinimum: 1
        },
        serializedName: "quantity",
        type: {
          name: "Number"
        }
      }
    }
  }
};

export const PhoneNumberSearchResult: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberSearchResult",
    modelProperties: {
      searchId: {
        serializedName: "searchId",
        required: true,
        type: {
          name: "String"
        }
      },
      phoneNumbers: {
        serializedName: "phoneNumbers",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String"
            }
          }
        }
      },
      phoneNumberType: {
        serializedName: "phoneNumberType",
        required: true,
        type: {
          name: "String"
        }
      },
      assignmentType: {
        serializedName: "assignmentType",
        required: true,
        type: {
          name: "String"
        }
      },
      capabilities: {
        serializedName: "capabilities",
        type: {
          name: "Composite",
          className: "PhoneNumberCapabilities"
        }
      },
      cost: {
        serializedName: "cost",
        type: {
          name: "Composite",
          className: "PhoneNumberCost"
        }
      },
      searchExpiresBy: {
        serializedName: "searchExpiresBy",
        required: true,
        type: {
          name: "DateTime"
        }
      },
      errorCode: {
        serializedName: "errorCode",
        type: {
          name: "Number"
        }
      },
      error: {
        serializedName: "error",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberPurchaseRequest: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberPurchaseRequest",
    modelProperties: {
      searchId: {
        serializedName: "searchId",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumberOperation: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberOperation",
    modelProperties: {
      operationType: {
        serializedName: "operationType",
        required: true,
        type: {
          name: "String"
        }
      },
      status: {
        serializedName: "status",
        required: true,
        type: {
          name: "String"
        }
      },
      resourceLocation: {
        serializedName: "resourceLocation",
        type: {
          name: "String"
        }
      },
      createdDateTime: {
        serializedName: "createdDateTime",
        required: true,
        type: {
          name: "DateTime"
        }
      },
      error: {
        serializedName: "error",
        type: {
          name: "Composite",
          className: "CommunicationError"
        }
      },
      id: {
        serializedName: "id",
        required: true,
        type: {
          name: "String"
        }
      },
      lastActionDateTime: {
        serializedName: "lastActionDateTime",
        readOnly: true,
        type: {
          name: "DateTime"
        }
      }
    }
  }
};

export const PhoneNumberCapabilitiesRequest: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumberCapabilitiesRequest",
    modelProperties: {
      calling: {
        serializedName: "calling",
        type: {
          name: "String"
        }
      },
      sms: {
        serializedName: "sms",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PurchasedPhoneNumber: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PurchasedPhoneNumber",
    modelProperties: {
      id: {
        serializedName: "id",
        required: true,
        type: {
          name: "String"
        }
      },
      phoneNumber: {
        serializedName: "phoneNumber",
        required: true,
        type: {
          name: "String"
        }
      },
      countryCode: {
        serializedName: "countryCode",
        required: true,
        type: {
          name: "String"
        }
      },
      phoneNumberType: {
        serializedName: "phoneNumberType",
        required: true,
        type: {
          name: "String"
        }
      },
      capabilities: {
        serializedName: "capabilities",
        type: {
          name: "Composite",
          className: "PhoneNumberCapabilities"
        }
      },
      assignmentType: {
        serializedName: "assignmentType",
        required: true,
        type: {
          name: "String"
        }
      },
      purchaseDate: {
        serializedName: "purchaseDate",
        required: true,
        type: {
          name: "DateTime"
        }
      },
      cost: {
        serializedName: "cost",
        type: {
          name: "Composite",
          className: "PhoneNumberCost"
        }
      }
    }
  }
};

export const PurchasedPhoneNumbers: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PurchasedPhoneNumbers",
    modelProperties: {
      phoneNumbers: {
        serializedName: "phoneNumbers",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "PurchasedPhoneNumber"
            }
          }
        }
      },
      nextLink: {
        serializedName: "nextLink",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumbersSearchAvailablePhoneNumbersHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumbersSearchAvailablePhoneNumbersHeaders",
    modelProperties: {
      location: {
        serializedName: "location",
        type: {
          name: "String"
        }
      },
      operationLocation: {
        serializedName: "operation-location",
        type: {
          name: "String"
        }
      },
      operationId: {
        serializedName: "operation-id",
        type: {
          name: "String"
        }
      },
      searchId: {
        serializedName: "search-id",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumbersPurchasePhoneNumbersHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumbersPurchasePhoneNumbersHeaders",
    modelProperties: {
      operationLocation: {
        serializedName: "operation-location",
        type: {
          name: "String"
        }
      },
      operationId: {
        serializedName: "operation-id",
        type: {
          name: "String"
        }
      },
      purchaseId: {
        serializedName: "purchase-id",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumbersGetOperationHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumbersGetOperationHeaders",
    modelProperties: {
      location: {
        serializedName: "location",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumbersUpdateCapabilitiesHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumbersUpdateCapabilitiesHeaders",
    modelProperties: {
      location: {
        serializedName: "location",
        type: {
          name: "String"
        }
      },
      operationLocation: {
        serializedName: "operation-location",
        type: {
          name: "String"
        }
      },
      operationId: {
        serializedName: "operation-id",
        type: {
          name: "String"
        }
      },
      capabilitiesId: {
        serializedName: "capabilities-id",
        type: {
          name: "String"
        }
      }
    }
  }
};

export const PhoneNumbersReleasePhoneNumberHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PhoneNumbersReleasePhoneNumberHeaders",
    modelProperties: {
      operationLocation: {
        serializedName: "operation-location",
        type: {
          name: "String"
        }
      },
      operationId: {
        serializedName: "operation-id",
        type: {
          name: "String"
        }
      },
      releaseId: {
        serializedName: "release-id",
        type: {
          name: "String"
        }
      }
    }
  }
};
