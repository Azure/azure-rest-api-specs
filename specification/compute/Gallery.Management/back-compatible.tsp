import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImageUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImageVersionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplicationUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplicationVersionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GallerySoftDeletedResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryInVMAccessControlProfileVersionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PirSharedGalleryResource.identifier);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PirCommunityGalleryResource.identifier);

@@clientName(Galleries.createOrUpdate::parameters.resource, "gallery");
@@clientName(Galleries.update::parameters.properties, "gallery");
@@clientName(Galleries.gallerySharingProfileUpdate::parameters.body,
  "sharingUpdate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Gallery.properties);

@@clientName(GalleryImages.createOrUpdate::parameters.resource, "galleryImage");
@@clientName(GalleryImages.update::parameters.properties, "galleryImage");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImage.properties);

@@clientName(GalleryImageVersions.createOrUpdate::parameters.resource,
  "galleryImageVersion"
);
@@clientName(GalleryImageVersions.update::parameters.properties,
  "galleryImageVersion"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImageVersion.properties);

@@clientName(GalleryApplications.createOrUpdate::parameters.resource,
  "galleryApplication"
);
@@clientName(GalleryApplications.update::parameters.properties,
  "galleryApplication"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplication.properties);

@@clientName(GalleryApplicationVersions.createOrUpdate::parameters.resource,
  "galleryApplicationVersion"
);
@@clientName(GalleryApplicationVersions.update::parameters.properties,
  "galleryApplicationVersion"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplicationVersion.properties);

@@clientName(GalleryInVMAccessControlProfiles.createOrUpdate::parameters.resource,
  "galleryInVMAccessControlProfile"
);
@@clientName(GalleryInVMAccessControlProfiles.update::parameters.properties,
  "galleryInVMAccessControlProfile"
);

@@clientName(GalleryInVMAccessControlProfileVersions.createOrUpdate::parameters.resource,
  "galleryInVMAccessControlProfileVersion"
);
@@clientName(GalleryInVMAccessControlProfileVersions.update::parameters.properties,
  "galleryInVMAccessControlProfileVersion"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryInVMAccessControlProfileVersion.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SharedGallery.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SharedGalleryImage.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SharedGalleryImageVersion.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommunityGallery.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommunityGalleryImage.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommunityGalleryImageVersion.properties);
