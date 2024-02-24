# Real World Rails

> Real World Rails applications and their open source codebases for developers to learn from

This project brings 100+ (and growing) active, open source Rails apps and engines together in one repository, making it easier for developers to download the collected codebases and learn from Rails apps written by experienced developers. Reading open source code can be an invaluable learning aid. You&rsquo;ll find the source code in the [`apps/`](apps/) and [`engines/`](engines/) subdirectories.

Real World Rails was begun to help teach newer developers and to research and write about Rails development practices:

- Find example usage of a method you&rsquo;re unsure of
- Learn how other developers use a gem you&rsquo;d like to use
- Discover how to write tests
- See how Rails engines are built
- &hellip;and much, much more.

## How to install on your computer

Ensure you have git-lfs installed: https://git-lfs.com

```bash
# Clone this git repo:
git clone git@github.com:eliotsykes/real-world-rails.git

cd real-world-rails/

# The Rails apps are linked to as git submodules.
GIT_LFS_SKIP_SMUDGE=1 git submodule update --init --single-branch --jobs 4

# To run the `bin/rwr` inspectors, install gems:
bundle install

echo "All done! Why not run some inspections? Run bin/rwr"
```

## Other Real World Codebase Collections

- Real World Sinatra https://github.com/jeromedalbert/real-world-sinatra
- Real World Ember https://github.com/eliotsykes/real-world-ember
- Real World Ruby Apps https://github.com/jeromedalbert/real-world-ruby-apps
- Real World React https://github.com/jeromedalbert/real-world-react

## How you can analyze Real World Rails apps

#### Find job subclasses

This will find most, but not all job subclasses (requires [ag](https://github.com/ggreer/the_silver_searcher#installing)):

```bash
# Outputs jobs source in terminal
ag --ruby '< [A-Za-z]+Job\b'

# Open each job in your editor (e.g. atom)
ag --ruby -l '< [A-Za-z]+Job\b' | xargs atom
```

(used to research [Real World Rails Background Jobs](https://www.eliotsykes.com/real-world-rails-background-jobs))

#### List models from *every* Real World Rails application

Interested in seeing how your fellow developers name their models? Run:

```bash
bin/rwr models | sort -f | uniq -c | sort -k 1nr -k 2f
```

#### Show constants of every Real World Rails app

```bash
bin/rwr constants
```
(this helped when researching [Magic Numbers in Ruby & How You Make Them Disappear](https://eliotsykes.com/magic-numbers))

#### Show view specs

See the file path and source of every view spec in every app:
```bash
bin/rwr view-specs
```
(this will show 250+ view specs, see them in [The Big List of View Specs](https://eliotsykes.com/view-specs))

#### Show model methods

See just the model method names and file paths:
```bash
bin/rwr model-method-names
```

See the model method source and file paths:
```bash
bin/rwr model-methods
```

#### Find projects using gem

```bash
find apps/ -name Gemfile.lock | xargs grep GEM_NAME_GOES_HERE

# e.g. Find all projects using doorkeeper gem
find apps/ -name Gemfile.lock | xargs grep doorkeeper
```

#### Analyze view naming practices

```bash
bin/rwr shared-view-dirs
bin/rwr view-naming
```

#### Find ideas on how to configure your foreman processes

```bash
# Outputs contents from all Procfiles
find apps/ -name 'Procfile*' | xargs cat
```


## Settings

#### Analyzing directories outside of `apps/`

Prefix the `bin/rwr` command with the `FILES_PATTERN` environment variable:

```bash
FILES_PATTERN=~/dev/my-rails-app/**/*.rb bin/rwr
```

#### Change source output format to markdown

Prefix `bin/rwr` with the `SOURCE_OUTPUT_FORMAT` environment variable:
```bash
SOURCE_OUTPUT_FORMAT=markdown bin/rwr view-specs
```

## Information for Contributors

#### How to add a Real World Rails app

Given a GitHub repo for a Rails app `githubuser/foo`:

```bash
# Inside real-world-rails root:
# Replace <DEFAULT_BRANCH> with correct branch (probably 'main').
GIT_LFS_SKIP_SMUDGE=1 git submodule add -b <DEFAULT_BRANCH> git@github.com:githubuser/foo.git apps/foo
```

Regenerate [`repos.md`](repos.md):

```bash
# Requires valid GITHUB_TOKEN
bin/get_project_data > repos.md

# OR, if GitHub GraphQL API v4 schema has changed, update cached copy of schema:
FETCH_LATEST_SCHEMA=true bin/get_project_data > repos.md
```

#### Updating the Rails apps submodules to latest

The Rails apps in `apps/` are git submodules. Git submodules are locked to a revision and don't stay in sync with the latest revision.

To update the revisions, run:

```bash
# This will take some time:

# Which of these is faster?
GIT_LFS_SKIP_SMUDGE=1 git submodule update --remote --checkout --jobs 4
GIT_LFS_SKIP_SMUDGE=1 git submodule foreach git pull
```

#### How to remove a git submodule

Only use this if a previously public repo has been removed:

```bash
# Remove the submodule from .git/config
git submodule deinit -f path/to/submodule

# Remove the submodule from .git/modules
rm -rf .git/modules/path/to/submodule

# Remove from .gitmodules and remove the submodule directory
git rm -f path/to/submodule
```

#### Writing an Inspector? Some docs to help understand AST, Parser&hellip;

The [inspectors](lib/real_world_rails/inspectors) are responsible for the analysis of the Rails apps.

Review the existing [inspectors](lib/real_world_rails/inspectors) if you're looking for some info on how to write a new one, and see these API docs:

- http://whitequark.github.io/ast/AST/Node.html
- http://www.rubydoc.info/github/whitequark/parser/master/Parser/AST/Processor
- http://whitequark.github.io/ast/AST/Processor.html
