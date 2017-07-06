# GitLab

This part of the tutorial will go over how to host your project on GitLab,
including:
* The virtues of using a `.gitignore` file
* The GitLab workflow
* How to solve a merge conflict

Before starting this tutorial, you should have a Gitlab username and password.

> For this tutorial, all commands that you should type in your terminal will be
> prefaced with `> `.

## What is GitLab?

There are several popular providers for hosting `git` repositories; the most widely
used is [GitHub](https://github.com/). These services maintain a *remote* version
of your repository that corresponds to the *local* version you have saved on your own
computer. The remotely hosted version serves as a backup and allows you to easily
share your work and collaborate with others. For this course, we'll be using [GitLab](https://about.gitlab.com/).


## Getting Started on GitLab
1. Log in to GitLab with your username and password and navigate to your
GitLab page.

2. Create a new repository called *NYC-311*. The repository URL will be
*https://insert-path-to-gitlab/username/NYC-311*.

3. Add the remote repository to your local repository:

```
> git remote add origin https://insert-path-to-gitlab/username/nyc-311.git
```

You can then see the remote repository with the `git remote` command:

```
> git remote -v
```

The remote repository is named "origin," which is a common choice of
name for the primary repository for a project.

The remote version of your repository doesn't automatically sync with your
local version (or vice versa). To sync up the remote and local versions,
you have to **push** your local changes *to* the remote repository, or
**pull** any changes *from* the remote repository into your local repository.
To push changes, we use the `git push` command:

```
> git push --set-upstream origin master
```

What we have done is taken a copy of our repository and *pushed* it
to GitLab. The `--set-upstream` option specifies the remote branch
that corresponds to your local branch, so when you push changes to GitLab in the
future, you just need to use the command:

```
> git push origin master
```

To *pull* in changes from the remote repository to your repository,
you can use the following command:

```
> git pull origin master
```

Why do we need to keep two versions of the same project? Let's try out
an example. Grab a friend and have them `clone` your
repo using the command below. (You'll have to make sure they also have a GitLab
account and add them as a collaborator to your repository).

```
> git clone https://insert-path-to-gitlab/username/nyc-311.git
```

Now your friend has a local copy of your repository. Now `cd` into
the project folder and add a special file called `.gitignore`.
The `.gitignore` file is a special file that tells `git` what it
should **ignore** when you make a commit - that is, anything that
you *don't* want to end up in your repository.

Open up the `.gitignore` file in a text editor (for this example
we're using `nano`):
```
> nano .gitignore
```

Then add the following:

```
#Ignore pyc files
*.pyc
```

The first line (which starts with a `#`) is a comment, which `git`
will ignore. The second line is the first entry: `*.pyc`. The `*` is
shorthand for "anything," so including `*.pyc` instructs `git` **not**
to commit files whose names match the pattern `(anything).pyc`. Files that end in
`.pyc` are Python bytecode files that will appear when you run your Python code;
they are not necessary or useful for you, so you don't want them
cluttering up your repo. Using the `*` is useful so you don't have to list
out all possible `.pyc` files exhaustively.

It's also a good habit to put the names of any files that contain passwords
or database configurations in your `.gitignore`, so that you don't
inadvertently commit sensitive information to the repo. Remember that `git`
keeps a record of files even after they're deleted, so if you accidentally
commit sensitive information, it can be hard to make sure all traces of
this information have been erased.

Now let's add the `.gitignore` file to our repository:
```
> git add .gitignore
> git commit -m "Added .gitignore"
```

And push our changes to the repository:

```
> git push origin master
```

Now on your machine `git pull` the new state of the repository
```
> git pull origin master
```

If you use the command `ls -a`, you should see the `.gitignore` file.
If you look at the log (using `git log`) you should see the new commit.

```
> ls -a
> git log
```

## GitHub Flow

In this portion of the tutorial, we'll go over *branching* and the
general GitHub workflow.

So far we have been doing the "solo" workflow, which looks something
like the following:
```
 > mkdir my_working_directory
 > cd my_working_directory
 > git init
 > touch some_file.py
  # hack, do some work, hack
  # hack
 > git add some_file.py
 > git commit -m "Working with some awesome idea"
 > git push origin master
  # hack
  # more hacking
```

As you might have guessed, this workflow is just fine when you are
working by yourself. When you're working in a team, it's useful to
have a more structured workflow. Here we'll talk about the Github flow.

In the GitHub flow, *we never code anything unless there is a need to.*
When something needs to be done, we create an **issue** on the GitHub repository
for it. *Good* issues:
- Are clear
- Have a defined output
- Are actionable (written in the imperative voice)
- Can be completed in a few days (at most)

Here are some examples:
- *Good*: /Fix the bug in .../
- *Good*: /Add a method that does .../
- *Bad*:  /Solve the project/
- *Bad*:  /Some error happen/

[Here is how to create a GitLab issue.](https://docs.gitlab.com/ee/gitlab-basics/create-issue.html)

Once an issue exists, we'll pull from the repo and create a *branch*.
A *branch* is a copy of the code base separate from the main master branch
where we can work on our issue (e.g, fixing a bug, adding a feature) without
affecting the master branch during our work and then ultimately merge our
change into the master branch.

The flow goes something like this:
```
##Pull from the repo
> git pull
##Decide what you want to do and create an issue
> git checkout -b a-meaningful-name
```
The command `git checkout -b` creates a new branch (in this case
called "a-meaningful-name") and switches to that branch. We can see what
branch we are on by using the command `git branch`, which displays all
the branches in the local repository with a `*` next to the branch we are
currently on.
```
##
##hack, hack, hack, make some changes, add/rm files, commit
##
##Push to the repo and create a remote branch
> git push
##Create a pull request and describe your work (Suggest/add a reviewer)
##Someone then reviews your code
##The pull-request is closed and the remote branch is destroyed
##Switch to master locally
> git checkout master
##Pull the most recent changes (including yours)
> git pull
##Delete your local branch
> git branch -d a-meaningful-name
```
[Here is how to create a GitLab pull request.](https://docs.gitlab.com/ee/gitlab-basics/add-merge-request.html)

## Solving a Merge Conflict

As you work on projects with others, you will inevitably run into
merge conflicts. A **merge conflict** occurs when you and another
person have edited the same line of a file, and `git` doesn't know which
line is the correct one.

Let's make a conflict!
```
#create a branch called "drama"
> git checkout -b drama
#now modify the descriptive_stats.py file and change the top 10
#values to top 13
#commit your changes
> git add descriptive_stats.py
> git commit -m "Changed top 10 to top 13 in descriptive_stats.py"
#switch back to master branch
> git checkout master
#now modify the descriptive_stats.py file and change the top 10
#values to top 3
#commit your changes
> git add descriptive_stats.py
> git commit -m "Changed the top 10 to the top 3 in descriptive_stats.py"
```

Now we merge the `drama` branch into the `master` branch:
```
> git merge drama

Auto-merging descriptive_stats.py
CONFLICT (content): Merge conflict in descriptive_stats.py
Automatic merge failed; fix conflicts and then commit the result.
```
Our arbitrary drama has caused a conflict! If we check the status, we should
see the following:
```
> git status
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")

  Unmerged paths:
    (use "git add <file>..." to mark resolution)

            both modified:      descriptive_stats.py
```

Examining the conflicting file `descriptive_stats.py`, you should
see the following:

```
from __future__ import print_function
import pandas

fname_data = '311-service-requests.csv'
df_311_calls = pd.read_csv(fname_data)
<<<<<<< HEAD
print(df_311_calls['Complaint Type'].value_counts()[:3])
=======
print(df_311_calls['Complaint Type'].value_counts()[:13])
>>>>>>> drama
```
`<<<<<<<` and `>>>>>>>` denote the section of the code containing
the conflict. At the beginning and end of the section, respectively,
you see `HEAD` and `drama`. That means that the first section (before the
`=======`) comes from the version of the file on the `master`, or `HEAD`,
branch, while the section after the divider comes from that
the preceding line is from the drama branch.

The lines of the two branches are separated by `=======`. In the event of a merge
conflict, we have three choices: (1) keep the line from the `master` branch,
(2) keep the line from the `drama` branch, or (3) create an entirely new line.
In this case, we want to keep the line from the master branch (the line with 3
instead of 13), so we'll **delete** the merge conflict markers and the line
from the `drama` branch:

```
from __future__ import print_function
import pandas

fname_data = '../raw_data/311-service-requests.csv'
df_311_calls = pd.read_csv(fname_data)
print(df_311_calls['Complaint Type'].value_counts()[:3])
```
Now we save `descriptive_stats.py` and commit:

```
> git commit -m "resolve drama"
```

Our merge conflict is now solved.

## Acknowledgements, References and Further Resources

This tutorial was derived from tutorials created by Eduardo Blancas Reyes,
Benedict Kuester, Adolfo De Unanue, [Software Carpentry](swcarpentry.github.io/git-novice/),
and [ASU PHY-494](asu-compmethodsphysics-phy494.github.io/ASU-PHY494/2016/01/21/git_basics/).

Further resources for becoming a `git` master are:
* [Software Carpentry](swcarpentry.github.io/git-novice/) - A more in-depth intro `git` tutorial.

* [15 minute tutorial to learn git](https://try.github.io/levels/1/challenges/1) - Intro tutorial.

* [git - the simple guide](http://rogerdudler.github.io/git-guide/) - A simple guide to get to know
the most important concepts.

* [A successful git branching model](http://nvie.com/posts/a-successful-git-branching-model/) - A
model to work with git using branches. This model is widely used in the open source community.

* [Learn Git Branching](http://learngitbranching.js.org/) - Understanding what branches and rebases
are, in an amazing interactive tutorial.

* [Reset Demystified](https://git-scm.com/blog/2011/07/11/reset.html) - A blog post on `git reset`
which develops some useful concepts along the way.

* [Understanding git for real by exploring the .git
directory](https://medium.freecodecamp.com/understanding-git-for-real-by-exploring-the-git-directory
-1e079c15b807#.5pe75gc07) - A blog post on what's inside a commit.

* [Pro Git](https://git-scm.com/book/en/v2) -- An in-depth discussion written by `git` masters.
