# Real World Rails

> Real World Rails applications and their open source codebases for developers to learn from

Learn from Rails apps written by experienced developers.

You&rsquo;ll find the source code for the Real World Rails apps in the [`apps/`](apps/) subdirectory.

## How to install on your computer

```bash
# Clone this git repo:
git clone git@github.com:eliotsykes/real-world-rails.git

cd real-world-rails/

# The Rails apps are linked to as git submodules.
# This will take some time...
git submodule update --init  

# To run the `bin/rwr` inspectors, install gems:
bundle install

echo "All done! Why not run some inspections? Run bin/rwr"
```

## Analyze Real World Rails apps using the Inspectors!

The [inspectors](lib/real_world_rails/inspectors) are responsible for the analysis of the Rails apps.

As and when I need them for research, I'm adding inspectors.

If you've got an idea for something that'd be interesting or fun to find out about these Real World Rails apps, contribute your idea on the issue tracker and maybe someone will write an inspector to match your request.

All contributions welcome!


### List models from *every* Real World Rails application

Interested in seeing how your fellow developers name their models? Run:

```bash
bin/rwr models | sort -f | uniq -c | sort -k 1nr -k 2f
```

### Show constants of every Real World Rails app

```bash
bin/rwr constants
```
(this helped when researching [Magic Numbers in Ruby & How You Make Them Disappear](https://eliotsykes.com/magic-numbers))

### Analyzing directories outside of `apps/`

Prefix the `bin/rwr` command with the `FILES_PATTERN` environment variable:

```bash
FILES_PATTERN=~/dev/my-rails-app/**/*.rb bin/rwr
```

## How to add a Real World Rails app

Given a GitHub repo for a Rails app `githubuser/foo`:

```bash
# Inside real-world-rails root:
git submodule add -b master git@github.com:githubuser/foo.git apps/foo
```

## Updating the Rails apps submodules to latest

The Rails apps in `apps/` are git submodules. Git submodules are locked to a revision and don't stay in sync with the latest revision.

To update the revisions, run:

```bash
# This will take some time:
git pull --recurse-submodules
```

## Writing an Inspector? Some docs to help understand AST, Parser&hellip;

Review the existing [inspectors](lib/real_world_rails/inspectors) if you're looking for some info on how to write a new one, and see these API docs:

- http://whitequark.github.io/ast/AST/Node.html
- http://www.rubydoc.info/github/whitequark/parser/master/Parser/AST/Processor
- http://whitequark.github.io/ast/AST/Processor.html
