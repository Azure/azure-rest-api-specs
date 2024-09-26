import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplicationUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplicationVersionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImageUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImageVersionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PirSharedGalleryResource.identifier);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PirCommunityGalleryResource.identifier);

@@clientName(Galleries.update,
  "Galleries.update::parameters.properties",
  "gallery"
);
@@clientName(Galleries.gallerySharingProfileUpdate,
  "Galleries.gallerySharingProfileUpdate::parameters.body",
  "sharingUpdate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Gallery.properties);

@@clientName(GalleryApplications.update,
  "GalleryApplications.update::parameters.properties",
  "galleryApplication"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplication.properties);

@@clientName(GalleryApplicationVersions.update,
  "GalleryApplicationVersions.update::parameters.properties",
  "galleryApplicationVersion"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryApplicationVersion.properties);

@@clientName(GalleryImages.update,
  "GalleryImages.update::parameters.properties",
  "galleryImage"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImage.properties);

@@clientName(GalleryImageVersions.update,
  "GalleryImageVersions.update::parameters.properties",
  "galleryImageVersion"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GalleryImageVersion.properties);

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
