# Procession

Runs a [child process](https://github.com/jarib/childprocess) and blocks until it writes something specific to stdout. Terminates the child process at exit time.

The following example blocks until __Server Started__ comes out of STDOUT as a result of executing __PORT=3455 /home/me/my\_project/bin/server__

```ruby
require 'procession'

Procession::Process.new(
  working_dir: '/home/me/my_project/bin',
  command:     './server',
  environment: { PORT: 3455 },
  await:       /Server Started/
).start
```
