# HOMEBREW CONFIG

IPATH=/goinfre/$USER

# Add brew to path
export PATH=$IPATH/.brew/bin:$PATH

# Set Homebrew temporary folders
export HOMEBREW_CACHE=/tmp/\$USER/Homebrew/Caches
export HOMEBREW_TEMP=/tmp/\$USER/Homebrew/Temp

mkdir -p \$HOMEBREW_CACHE
mkdir -p \$HOMEBREW_TEMP

# If NFS session
# Symlink Locks folder in /tmp
if df -T autofs,nfs $IPATH 1>/dev/null
then
HOMEBREW_LOCKS_TARGET=/tmp/\$HOME/Homebrew/Locks
HOMEBREW_LOCKS_FOLDER=$IPATH/.brew/var/homebrew

mkdir -p \$HOMEBREW_LOCKS_TARGET
mkdir -p \$HOMEBREW_LOCKS_FOLDER

# Symlink to Locks target folders
# If not already a symlink
if ! [[ -L \$HOMEBREW_LOCKS_FOLDER && -d \$HOMEBREW_LOCKS_FOLDER ]]
then
	echo "Creating symlink for Locks folder"
	rm -rf \$HOMEBREW_LOCKS_FOLDER
	ln -s \$HOMEBREW_LOCKS_TARGET \$HOMEBREW_LOCKS_FOLDER
fi
fi
