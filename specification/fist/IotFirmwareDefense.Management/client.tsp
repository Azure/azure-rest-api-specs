import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.IoTFirmwareDefense, "IoTFirmwareDefenseMgmt", "python");

@@clientName(Microsoft.IoTFirmwareDefense,
  "IoTFirmwareDefenseMgmtClient",
  "java"
);

// flatten
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.BinaryHardeningResource.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.CryptoCertificateResource.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.CryptoKeyResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.CveResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.Firmware.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.PasswordHashResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.SbomComponentResource.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.UsageMetric.properties);
