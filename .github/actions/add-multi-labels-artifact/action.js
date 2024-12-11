
/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context, core }, args) => {
    core.info(`actionjs result: ${args.labels}`);

    const { DefaultArtifactClient } = require('@actions/artifact')
    const fs = require('fs');
    const path = require('path');

    /** @type {string[]} */
    const labels = JSON.parse(args.labels);

    try {
        const artifactClient = new DefaultArtifactClient()
        // const artifactClient = artifact.create();
    
        for (const label of labels) {
          const filePath = path.join(__dirname, `empty-${label}.txt`);
    
          fs.writeFileSync(filePath, `Artifact for label: ${label}`);
    
          core.info(`Uploading artifact: ${label}`);
          const uploadResponse = await artifactClient.uploadArtifact(
            label,
            [filePath],
            __dirname,
            { overwrite: true }
          );
    
          core.info(`Upload complete for ${label}: ${uploadResponse}`);
          
          fs.unlinkSync(filePath);
        }
      } catch (error) {
        core.error('Error uploading artifact:', error);
        core.setFailed(error.message);
      }
};
