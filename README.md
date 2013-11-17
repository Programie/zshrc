# zshrc

My zshrc files

## How to use

Simply source the files in your .zshrc:

```sh
for FILE in <path to the repository checkout>/*.sh; do
  source $FILE
done
```

Or just source the files you want:

```sh
source <path to the repository checkout>/exports.sh
source <path to the repository checkout>/aliases.sh
```
