# Using the Git Log

In this portion of the tutorial, we'll explore the `git` log and how to go
back to prior versions of a project.

> For this tutorial, all commands that you should type in your terminal will be
> prefaced with `$`.

## Create a Python Script to Output Analysis of 311 Calls


Let's get some data to work with using the


Let's create a directory for our data and transfer it into our project
If you are not in your project folder, `nyc_311` cd into it.

```
cd /nfshome/ckent/nyc_311
```
where `ckent` is replaced by your user name.

Then make a raw directory and copy the data.
```
> mkdir -v raw_data #if you already have a raw_data directory from Intro_CLI don't worry about this
> cp -v /projects/Demo/shared/AppliedDataAnalytics/notebooks/module_02-git_and_python_basics/basic_git_tutorial/data/311-service-requests.csv raw_data/

```

Now it is time for some analysis, which we will do in our analysis directory to keep
things organized.

First we need to change into the analysis directory
```
cd analysis
```


Fire up your favorite text editor (we'll use `nano`), and let's write a little
program called `descriptive_stats.py` to get *descriptive stats* on our data about
311 calls in NYC. The `.py` suffix indicates that this file is a program meant
to be run using Python.

```
$ nano descriptive_stats.py
```

Once we're inside the text editor, we can write the program:

```
from __future__ import print_function
import pandas as pd

fname_data = '../raw_data/311-service-requests.csv'
df_311_calls = pd.read_csv(fname_data)
print( df_311_calls['Complaint Type'].value_counts()[:5] )
```

When we write a Python program, we can run it from the command line by
typing `python` and then the program name (here, `descriptive_stats.py`).
You should get the following output:
```
$ python descriptive_stats.py

HEATING                   14200
GENERAL CONSTRUCTION       7471
Street Light Condition     7117
DOF Literature Request     5797
PLUMBING                   5373
Name: Complaint Type, dtype: int64
```
Great! Now we have a working program that calculates descriptive
statistics. Let's commit it to the repo:
```
> git add descriptive_stats.py # to the staging area
> git commit -m "Checking in descriptive_stats.py, output top 5 311 complaints"
```
In this case, we used the `-m` option to make an *in-line commit message* (rather
than launching a text editor). This was a small commit, so it didn't require a
lengthy commit message.

Say that we changed our minds, and want our program to output the *top 10* 311
complaints rather than the top 5. No problem! We'll just use the text editor
to modify our program:

```
$ nano descriptive_stats.py
```
We should see the same thing we had before:
```
from __future__ import print_function
import pandas as pd

fname_data = '../raw_data/311-service-requests.csv'
df_311_calls = pd.read_csv(fname_data)
print( df_311_calls['Complaint Type'].value_counts()[:5] )
```
Now we just change the 5 to a 10, and we're done!
```
from __future__ import print_function
import pandas as pd

fname_data = '../raw_data/311-service-requests.csv'
df_311_calls = pd.read_csv(fname_data)
print( df_311_calls['Complaint Type'].value_counts()[:10] )
```
Let's commit that change:
```
$ git add descriptive_stats.py
$ git commit -m "Changed the top 5 results to the top 10 results in descriptive_stats.py"
```
If we look at our `git` log we should now see the history of our changes:
```
$ git log


commit 42c35933c4d52708c2562c1c05361b152a2b9230
Author: Clark Kent <clark.kent@dailyplanet.com>
Date:   Sat Nov 12 16:55:29 2016 -0600

    Changed the top 5 results to the top 10 results in descriptive_stats.py

commit ab85797b2c3d68fb0c97535080079138888b5556
Author: Clark Kent <clark.kent@dailyplanet.com>
Date:   Sat Nov 12 16:52:52 2016 -0600

    Checking-in descriptive_stats.py outputs the top 5 311 complaints

commit aaf89fd77e9b43d99fe32823843a7519b2108c90
Author: Clark Kent <clark.kent@dailyplanet.com>
Date:   Sat Nov 12 13:45:11 2016 -0600
        Checking in README file

    * Added short description of the project
    * Added python3 as a dependency
```
Now we can use the `git diff` command to see the difference between our past
two commits:
```
$ git diff HEAD~1

diff --git a/descriptive_stats.py b/descriptive_stats.py
index 09b7168..c38d3e3 100644
--- a/descriptive_stats.py
+++ b/descriptive_stats.py
@@ -3,4 +3,4 @@ import pandas as pd

 fname_data = '../raw_data/311-service-requests.csv'
  df_311_calls = pd.read_csv(fname_data)
  -print( df_311_calls['Complaint Type'].value_counts()[:5] )
  +print( df_311_calls['Complaint Type'].value_counts()[:10] )
```
`HEAD` is shorthand for the *latest commit* in the repository. `HEAD~1` is
a shorthand for the latest commit, *minus one*. You can replace 1 with any
number you like; for instance, `HEAD~20` refers to 20 commits ago.

The output of `git diff` is shown above. The first line looks similiar
to a diff command. The second line shows the *commit identifiers* of the two
commits being compared. The next two lines are *names* of the files being
compared.

The really interesting part is at the bottom. The line with the `-` sign is
the *prior* commit. The line with a `+` sign shows the current commit. From this we
can see that we changed *one line* of `descriptive_stats.py`, *removing* the
number 5 and *adding* the number 10.

We can *return* to the version of a file from a previous commit using the
`git checkout` command:
```
$ git checkout HEAD~1 descriptive_stats.py
```
If we look at the file `descriptive_stats.py`, it should have reverted
back to our old version (with 5 instead of 10).

> Note: If you are working in a file and make a mistake, and you want to
> return to the previous version of the file, you can use the command
> `git checkout HEAD` with the file name.

```
$ git checkout HEAD descriptive_stats.py
```

Another useful option for the `git diff` command is `--staged`, which allows
us to examine the changes that have been made in files that are *staged*
for commit:
```
$ git diff --staged
```

Next up, we'll go over how to host a project on GitHub.
