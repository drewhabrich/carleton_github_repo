# carleton_github_practice
## Practice github repo for Carleton Workshop
### This has similar formatting as RMarkdown

- readme best practices: Include package version information and any external software used

- Describe files in a logical order

- Describe any column/variable names (especially units)

- Include which scripts outputs come from (helpful for new users and future you)

### The ideal project organization: Folders and subfolders
Raw Data: Data imported into your project. 

Metadata includes date of download or collection, original source and re-use info

(Derived) Data: Data you have altered e.g., merging databases, cleaning up data, subsets, etc. 

Scripts: Code (can separate by language)

Output: Figures, tables, results

Every folder should contain a README to explain what it contains

### NAMING CONVENTIONS
File naming best practices: Be as descriptive as possible

Can add leading numbers to scripts that indicate order they should be run e.g.
- 01-data_processing.R
- 02-model_fitting.R

Avoid dates/overly generic names

Name output similarly to script that generated it

Use hyphens and underscores, not spaces
