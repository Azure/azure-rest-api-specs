import {
  OperationParameter,
  OperationURLParameter,
  OperationQueryParameter
} from "@azure/core-client";
import {
  PhoneNumberSearchRequest as PhoneNumberSearchRequestMapper,
  PhoneNumberPurchaseRequest as PhoneNumberPurchaseRequestMapper,
  PhoneNumberCapabilitiesRequest as PhoneNumberCapabilitiesRequestMapper
} from "../models/mappers";

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
    serializedName: "endpoint",
    required: true,
    type: {
      name: "String"
    }
  },
  skipEncoding: true
};

export const countryCode: OperationURLParameter = {
  parameterPath: "countryCode",
  mapper: {
    serializedName: "countryCode",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const phoneNumberType: OperationQueryParameter = {
  parameterPath: "phoneNumberType",
  mapper: {
    serializedName: "phoneNumberType",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const skip: OperationQueryParameter = {
  parameterPath: ["options", "skip"],
  mapper: {
    defaultValue: 0,
    serializedName: "skip",
    type: {
      name: "Number"
    }
  }
};

export const maxPageSize: OperationQueryParameter = {
  parameterPath: ["options", "maxPageSize"],
  mapper: {
    defaultValue: 100,
    serializedName: "maxPageSize",
    type: {
      name: "Number"
    }
  }
};

export const assignmentType: OperationQueryParameter = {
  parameterPath: ["options", "assignmentType"],
  mapper: {
    serializedName: "assignmentType",
    type: {
      name: "String"
    }
  }
};

export const locality: OperationQueryParameter = {
  parameterPath: ["options", "locality"],
  mapper: {
    serializedName: "locality",
    type: {
      name: "String"
    }
  }
};

export const administrativeDivision: OperationQueryParameter = {
  parameterPath: ["options", "administrativeDivision"],
  mapper: {
    serializedName: "administrativeDivision",
    type: {
      name: "String"
    }
  }
};

export const apiVersion: OperationQueryParameter = {
  parameterPath: "apiVersion",
  mapper: {
    defaultValue: "2022-12-01",
    isConstant: true,
    serializedName: "api-version",
    type: {
      name: "String"
    }
  }
};

export const acceptLanguage: OperationParameter = {
  parameterPath: ["options", "acceptLanguage"],
  mapper: {
    serializedName: "accept-language",
    type: {
      name: "String"
    }
  }
};

export const phoneNumberType1: OperationQueryParameter = {
  parameterPath: ["options", "phoneNumberType"],
  mapper: {
    serializedName: "phoneNumberType",
    type: {
      name: "String"
    }
  }
};

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

export const body: OperationParameter = {
  parameterPath: "body",
  mapper: PhoneNumberSearchRequestMapper
};

export const searchId: OperationURLParameter = {
  parameterPath: "searchId",
  mapper: {
    serializedName: "searchId",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const body1: OperationParameter = {
  parameterPath: "body",
  mapper: PhoneNumberPurchaseRequestMapper
};

export const operationId: OperationURLParameter = {
  parameterPath: "operationId",
  mapper: {
    serializedName: "operationId",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const contentType1: OperationParameter = {
  parameterPath: ["options", "contentType"],
  mapper: {
    defaultValue: "application/merge-patch+json",
    isConstant: true,
    serializedName: "Content-Type",
    type: {
      name: "String"
    }
  }
};

export const body2: OperationParameter = {
  parameterPath: ["options", "body"],
  mapper: PhoneNumberCapabilitiesRequestMapper
};

export const phoneNumber: OperationURLParameter = {
  parameterPath: "phoneNumber",
  mapper: {
    serializedName: "phoneNumber",
    required: true,
    type: {
      name: "String"
    }
  }
};

export const top: OperationQueryParameter = {
  parameterPath: ["options", "top"],
  mapper: {
    defaultValue: 100,
    serializedName: "top",
    type: {
      name: "Number"
    }
  }
};

export const nextLink: OperationURLParameter = {
  parameterPath: "nextLink",
  mapper: {
    serializedName: "nextLink",
    required: true,
    type: {
      name: "String"
    }
  },
  skipEncoding: true
};
