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
