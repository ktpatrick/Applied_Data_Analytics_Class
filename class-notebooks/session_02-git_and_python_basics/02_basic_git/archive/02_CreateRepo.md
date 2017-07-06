# Create a Repository

Let's work on creating our first `git` repository.

In this tutorial, all shell commands that you should type in the terminal will be prefixed with `>`
not the $ we used in Introduction to CLI.

> For this tutorial, all commands that you should type in your terminal will be
> prefaced with `>`.

## Create a git repository
Let's say our project is to analyze 311 data from New York City.

> If you already have a nyc_311 directory then ignore the instruction above.

First we'll *make a directory* for our project called `nyc_311` and then
*change directories* to our new `nyc_311` directory:
```
> mkdir -v nyc_311
> cd nyc_311
```
The `-v` flag after `mkdir` produces *verbose* output, which means that you'll see the results of the command displayed.
You should see `mkdir: created directory 'nyc_311'`, so you know that the command did what you intended.



Now let's *initialize* the git repository using the command `git init`. (You'll notice that
all `git` commands have the format `git <verb>`.)
```
> git init
```
One of the things `git init` does is create a `.git` directory. To see this, we can
*list* all the files in this directory using the `ls` command. We include the `-a`
flag to tell the command to display *hidden* files, or those that begin with a `.`,
in the list.
```
> ls -a
.  ..  .git/
```

We see that there is now a `.git` directory in the `nyc_311` directory.
*Unless you really know what you are doing* **DO NOT EVER** *modify anything in this
directory. If you delete this directory, the entire history of your project will be gone.*

## Make our first commit!!

All good projects should have a "README" describing the purpose and organization of the
project, so let's start with that. Fire up your favorite text editor and create
a file named `README.md`. The `.md` means this file will be read as `markdown`, which
allows us to format the text programmatically. Here's a basic example of a `README.md`:
```
# Exploring 311 Calls in NYC

## Description

This repo is for an analysis of 311 calls in NYC using Python 2.7.
```
When you're first starting a project, there's a good chance you won't have much more to add,
and that's OK. Notice that we *do* have a title, a short description of the project, and a
list of the software the project required, also known as the *dependencies*. It's a good idea
to keep updating both the description and dependencies as your project grows and evolves.

The `#` here don't signify hashtags or comments - they are part of
[`markdown` syntax](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet), and
they designate headings.

Now let's look at the *status* of our repo using `git status`:
```
> git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

          README.md

          nothing added to commit but untracked files present (use "git add" to track)
```
`git status` tells us which *branch* we are on, which files are being tracked, and which
files are present that *aren't* being tracked. We see our new file `README.md` listed
under `Untracked files` - `git` sees that we've added something, but doesn't know whether
it should be logged as part of our project. When we create a new file, we need to *tell*
`git` to start tracking it. Like the command suggests, let's use `git add` to track
`README.md`.
```
> git add README.md
```
Now let's invoke the command `git status` again.

```
> git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

          new file:   README.md
```
Now that we have added the file, it has been "staged" to be committed. We can now make
our first commit!

```
> git commit
```
When you invoke the `git commit` command, an editor should pop up. This is for you to
write your **commit message**, a message that provides the context of
*what you did* and *why you did it*. Anyone can look at a commit and examine
what was changed; you might look at a commit message to find where you changed a
certain file, or your collaborator might read it before incorporating your changes
into the shared version of the project.

Give some thought to what you write here - good commit messages lead to a usable `git` log,
and separate novice `git` users from competent practitioners. Generally, you should follow
these guidelines in a commit message:

1. **First line** is a one-line summary (fewer than 80 characters) of the commit. It should
be in [title case](https://en.wikipedia.org/wiki/Letter_case#Title_case) and written in
the [imperative voice](https://en.wikipedia.org/wiki/Imperative_mood). A good rule of thumb:
*If applied this commit will, <insert title of git message here>*.

2. **Second line** should be blank.

3. **Third (and subsequent) lines** should include more details of the commit.

My commit message is the following:
```
Check in README file

* Added short description of the project
* Added python2.7 as a dependency
```
Now that we have made our first commit we can examine our log using `git log`!
```
> git log

* commit aaf89fd77e9b43d99fe32823843a7519b2108c90
  Author: Clark Kent <clark.kent@dailyplanet.com>
  Date:   Sat Nov 05 13:45:11 2016 -0600

          Check in README file

          * Added short description of the project
          * Added python3 as a dependency
```
The long string of characters in the first line is a unique identifier for your commit.
You can use this identifier to switch back to this specific version of your project in
the future. The second line is who made the commit. The third line gives the date
and time. Everthing that follows is the commit message.

To see only the *titles* of commit messages, you can use `git log` with the
`--oneline` option:
```
> git log --oneline
```
There are many other options to the `git log` command; explore the documentation to find
which ones suit your needs. Here's one combination we recommend (check it out!):
```
> git log --oneline --graph --all --decorate
```

## Moving and removing files
Now you know how to *add* a file to your project using `git`. What if you want to get
rid of something? You can **remove** files from your repo using `git rm`:
```
> git rm FILENAME
> git rm -r DIRECTORY
```
Note that when you remove a file using `git`, you can still go back to a *previous* commit
before you removed the file and **recover** that file. This is different than simply using
the command `rm`, which permanently erases the file.

You'll also have to tell `git` if you want to *rename* a file using the `git mv` command,
because *renaming* a file is basically *moving* it to a new location. For
example, to change the name of a file from `OLD` to `NEW`:
```
> git mv OLD NEW
```
`git rm` and `git mv` will stage the changes, so after invoking one of these commands, you can
just `commit` your changes without using `git add` again.

We have our first commit and repo! Now we're ready to write some code!
