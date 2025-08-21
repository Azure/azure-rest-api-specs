import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager.Legacy;

namespace Microsoft.Compute;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(ApiError,
  "../../../common-types/v1/common.json#/definitions/ApiError"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(ApiErrorBase,
  "../../../common-types/v1/common.json#/definitions/ApiErrorBase"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(CloudError,
  "../../../common-types/v1/common.json#/definitions/CloudError"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(InnerError,
  "../../../common-types/v1/common.json#/definitions/InnerError"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(SubResource,
  "../../../common-types/v1/common.json#/definitions/SubResource"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(SubResourceReadOnly,
  "../../../common-types/v1/common.json#/definitions/SubResourceReadOnly"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(ExtendedLocation,
  "../../../common-types/v1/common.json#/definitions/ExtendedLocation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(ExtendedLocationTypes,
  "../../../common-types/v1/common.json#/definitions/ExtendedLocationTypes"
);
