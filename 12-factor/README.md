# 12 Factor
Notes about the 12 factor principles (https://12factor.net)

### 1. Codebase
https://12factor.net/codebase
One codebase/repo, one app. If you have several repos, you have several apps (and each can comply with the 12 factors)

### 2. Dependencies
https://12factor.net/dependencies
Dependencies of a project always have to be explicit. Use a `dependency declaration manifest` (e.g. Gemfile, Pipfile) to make sure that all the dependencies of your app are specified.

Also, use dependency isolation to make sure that dependencies from the system don't leak in. Some examples of this tools are `bundle exec` or `virtualenv`.

Not relying on dependencies also affects system tools that we may use ocasionally, like `curl`.

### 3. Config
https://12factor.net/config
Separate that is config from that is code. Code must be in the codebase, so config has to be somewhere else.

As config will probably change between deploy/environments, it's better to have it somewhere that makes it easy to change it, like env vars

### 4. Backing

### 5. Build, release, run
* Build: converting the repo into an executable
* Release: take the build output, combine it with the config, and move it to the execution environment
* Run: runs the app

Have strict separation between these 3 steps

Any change must create a new release

Make your releases have a unique ID, to allow you to reference them


### 6. Processes

### 7. Port binding

### 8. Concurrency 

### 9. Disposability
Processes should be disposable, you should be able to start or stop them at any moment. 

* **Start**: Minimize the time between the launch command until the process is ready to serve requests/jobs
* **Stop gracefully:** Don't accept more work, finish the one you have in progress, and exit.
* **Robust against sudden death:** Handle unexpected failures. Make the orchestrator return the job to the queue, prevent for any locks to be automatically released, etc.

### 10. Dev/prod parity
An app should make the gap between dev and prod almost non-existent.

A gap can have several dimensions:
- **Time gap:** take days/weeks/months from the coding starts until its deployed
- **Personnel gap:** a team (devs) code, another one deploys and monitor (ops/devops)
- **Tools:** the stack may be different (e.g. SQLite vs MySQL)

The tools gap is usually the biggest one, but nowadays tools like Homebrew/apt-get or Docker make it very easy to have matching stacks between prod and dev. We have to resist the urge to have different environments, even if the library we use (e.g. ActiveRecord) has adapters that expose the same interface.
### 11. Logs
An app shouldn't care about managing its logs. It just outputs everything to stdout and then the another process or app may take care of capturing them and doing any aggregation or processing that may be needed

### 12. Admin processes
One-off or maintenance tasks should also be included in the application. They should run against a release, be included in the codebase, and use the config. Examples: `rake db:migrate` in Rails or a script in the same repo (`script/deploy_prod.sh`)

