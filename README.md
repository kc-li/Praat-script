# Praat-script

This repository is mostly to backup my personal Praat scripts. Many of the scripts are tailored to specific project needs so might not be universally applicable. You are welcome to adapt them to your needs.

Here are some scripts that can be readily used without further ado (you might still need to specify some parameters in the script):

`save multiple files-universal.praat`: This script can save all selected files in the Praat Object window. I make it a button in the fixed menu.

`Reorganize in order-step1.praat`: This script will 'explode' the sound file into individual files based on the boundaries marked in the textgrid. It is useful for isolating 'target speech' and exclude the irrelevant part.

`Reorganize in order-step2.praat`: This script will do the opposite of the previous step, that is to assemble all the files in the folder into one file. Sometimes I need to use both step1 and step2 script, to make use of the ordering function of the system, so that the randomised target speech can be reorganized following the alphabetical order.

`Editor_extract and rename selected sound and textgird.praat`: This script can extract the selected period as Sound and Textgrid object respectively, and rename the files using the annotation in the selected tier in the textgrid. Useful when you need to select 'examples' from a long recording file. I make it a button in the dynamic menu.

`Editor_remove_boundaries_in_selected_period.praat`: This script can remove all the boudary markings in the selected period and the annotation texts. Useful when you need to 'correct' cascading errors is segmentation.



Scripts with 'Editor' prefix means they need to be opened in the TextGrid Editor.



