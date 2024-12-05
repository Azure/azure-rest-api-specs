
module.exports = async ({ github, context, core }) => {
    
    core.info(`(${context.eventName}, ${context.payload.action})`);

    console.log('context', JSON.stringify(context));
    console.log('context.payload', JSON.stringify(context.payload));
    // const {SHA} = process.env
    // const commit = await github.rest.repos.getCommit({
    //     owner: context.repo.owner,
    //     repo: context.repo.repo,
    //     ref: `${SHA}`
    // })
    // core.exportVariable('author', commit.data.commit.author.email)

}