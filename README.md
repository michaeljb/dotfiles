dotfiles
========

My configurations

### Installation
Copy the files to your home directory, or create symlinks from your home directory to these files.

.git-completion.bash
--------------------
The standard git completion script with only one addition; completion only of modified files for  `git checkout -- `. I would like to add similar completion for `git diff`, but since `diff` also accepts a branch as an argument this is more complicated.

.slate
------
Apart from SizeUp functionality, my .slate just allows fast application switching for my most frequently used apps. I also bound the Slate command `relaunch` to quickly try out new changes.

.sizeup.slate
-------------
[Slate](https://github.com/jigish/slate) configurations for most of [SizeUp's](http://www.irradiatedsoftware.com/sizeup/) functionality.

What SizeUp can do that .sizeup.slate doesn't do yet:
- Slate currently does not support actions to drag windows to different spaces.
- SizeUp's "SnapBack" command undoes all SizeUp actions you've done to a window since the last time it was moved/resized by hand. The "SnapBack" in .sizeup.slate currently only undoes one command.
- When moving monitors from one window to another, SizeUp allows the option of having the window be resized proportionally to the screen size.
- SizeUp's "Center" command has different configuration options; the window may be resized relatively to the screen, to an absolute size, or not at all. Currently, .sizeup.slate resizes relatively to the screen.
- SizeUp offers a few "best effort" options for windows that it cannot resize.

Resolving most of these differences is probably doable with Slate's [JavaScript configs](https://github.com/jigish/slate/wiki/JavaScript-Configs).

SizeUp's preferences window contains three preference panes that are emulated here by particular aliases.

### Shortcuts
These are found at the end of .sizeup.slate, under the commented line that just reads "bindings." The names given to the commands (Left, Right, PrevMontior, FullScreen, etc) are taken from SizeUp's menu bar list of commands. (see Slate's documentation for help on the binding syntax)

This is also the section of the SizeUp preferences where the behavior of the "Center" action is defined. My .sizeup.slate's behavior uses Relative Screen Size of 75% width and 75% height, dictated by aliases **center[Width/Height]**.

### Margins
SizeUp allows setting of Screen Edge Margins, aliases **ScreenEdge[Left/Right/Up/Down]**, and Partition (Between Window) Margins, aliases **Partition[X/Y]**. If PartitionX is set to 50, and ScreenEdgeTop is 25, then windows positioned with the Left and Right commands will be separated by 50 pixels, and there will be 25 pixels between the top of the windows and the menu bar. It should be noted that if your Dock is visible, Slate will automatically treat the Dock as a margin so that windows don't end up behind it.

### Partitions
SizeUp's partitions let you dictate the size of the "halves" of the screen that the Left/Right commands get. In SizeUp's preferences, this is represented by sliders with a representation of the Desktop to visualize the divide. If the left/right slider is at 65%, then then a window moved with Left will have a width equal to 65% of the screen space (after accounting for the margins), and Right will have the remaining 35%. The up/down slider works similarly. In .sizeup.slate, these values are captured in the aliases **Split[X/Y]**.

SizeUp has a separate setting for the Quarter Scren Partitions, allowing your "halves" and "quarters" behave differently. The setting still works the same way, and is handled in .sizeup.slate with the aliases **Quarter[X/Y]**.

### Installation
Make sure your .slate has this line:

`source .sizeup.slate`


### Known Issues
- sometimes the `Down` command doesn't give the window the proper width
