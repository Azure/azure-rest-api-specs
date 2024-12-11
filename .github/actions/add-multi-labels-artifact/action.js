
/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context, core, artifact }, args) => {
    core.info(`actionjs result: ${args.labels}`);
    // core.info('actionjs result', JSON.parse(args.labels));

    const artifact = require('@actions/artifact');
    const fs = require('fs');

    // const path = `${process.env.RUNNER_TEMP}/test-file.txt`;
    /** @type {string[]} */
    // const labels = JSON.parse(args.labels);
    const labels = ['label-aaa=true', 'label-bbb=false'];

    try {
        const artifactClient = artifact.create();
    
        for (const label of labels) {
          const filePath = path.join(__dirname, `empty-${label}.txt`);
    
          fs.writeFileSync(filePath, `Artifact for label: ${label}`);
    
          core.log(`Uploading artifact: ${label}`);
          const uploadResponse = await artifactClient.uploadArtifact(
            label,
            [filePath],
            __dirname,
            { overwrite: true }
          );
    
          core.log(`Upload complete for ${label}: ${uploadResponse}`);
          
          fs.unlinkSync(filePath);
        }
      } catch (error) {
        core.error('Error uploading artifact:', error);
        core.setFailed(error.message);
      }
};
